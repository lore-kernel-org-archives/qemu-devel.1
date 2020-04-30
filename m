Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88867C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527F82072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fP1tOKRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527F82072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAHQ-0007l1-EM
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUADO-0002V3-Bj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUADN-0004VZ-DJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:31:01 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:38910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUADM-0004VG-Rw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:31:00 -0400
Received: by mail-oi1-x236.google.com with SMTP id r66so5376984oie.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NHD91EekjA4FnySoclVbZTrHcjjYTAnxnQgllmLVEnU=;
 b=fP1tOKRYahbWS9fZACLPwrXVVJ1KY6bNz2m9S1AXzgkpn7VjPW5Hc/TogU08d17OiD
 LaqzziRFD3NPocDa+dGigaK6Xks7wSXkbup6NaCTPkh37M85pfC/9vw7qS1gGzc8mFHS
 CQikFxb4UMdHBoWgocUE3/1IhGU9xSlPwO5W5ykN+8zJPi++Fj7YKZmZoW3WKbU1kGN6
 2Swgtwf+VDm5RMai7suRWbSFeGQdskYLpzWK9iMgkLE88MZoOn7ibpvaVHM7n1Txck1s
 d/QymLc0BCYPVSH9+15F203IqKyO5lcAJKryVFJ7zAtRkLqVldDssHgd+u63L+QjmjcY
 A05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NHD91EekjA4FnySoclVbZTrHcjjYTAnxnQgllmLVEnU=;
 b=pZ/ZY3tkulLu0TQX792fxMw2c8+TytANs3hgTzQVHJ0ywaulpfOLkNUBPfKMPltL7b
 QLdu37RASrom60hwUTBNUPaiJKHFQRtsB4dhvEhvAMAhI6qgWWbJEkhrmPaEEUak0UvD
 /PVl7JNgVCuM2XF23r5t3lFlOBZ4MqdjxpJ9g3PENBYi0c93+9Aelix4c86Xx1DRHyFY
 xUle54HpneF3AfsXPg2StbifQmvvb1UG9BCJ48aFNbloGA9mrMnR0UcEzL6QL2UJT6G/
 Fu+7yjNezF8c8tM4RLoUqIXuND5tRXjyB/MoSI8CP0XEpn5EqiLUsVi9+ECqQJOGNABY
 9qMA==
X-Gm-Message-State: AGi0Pua42yNhTZ2ng5hnKkxr7YYyHqLYegE3CYoI+LQTUBG3Loidja+j
 ZUh5xbcdDQ5CS1EombSYidTFpy+Cr8Oro6PE8sOnUzpZHKw=
X-Google-Smtp-Source: APiQypL2+j6sW0ZB+kHDpnJ9pH2fuggc1HennsDQSM1YfWaawKRGrSZd+7t0sfddWgwvoMYrj8w+QQwzopFa4aKXhzk=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr1840680oia.48.1588257058293; 
 Thu, 30 Apr 2020 07:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200430115142.13430-1-peter.maydell@linaro.org>
 <20200430115142.13430-27-peter.maydell@linaro.org>
In-Reply-To: <20200430115142.13430-27-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 15:30:47 +0100
Message-ID: <CAFEAcA-q3dbGkrYF8CqZzjwX00oFkpUcXHHYwSwgBXMvQA35XQ@mail.gmail.com>
Subject: Re: [PULL 26/31] target/arm/cpu: Use ARRAY_SIZE() to iterate over
 ARMCPUInfo[]
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::236
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 12:52, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-id: 20200423073358.27155-4-philmd@redhat.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

This causes compile errors on configs where the array
ends up empty:

/home/pm/qemu/target/arm/cpu.c: In function =E2=80=98arm_cpu_register_types=
=E2=80=99:
/home/pm/qemu/target/arm/cpu.c:2903:19: error: comparison of unsigned
expression < 0 is always false [-Werror=3Dtype-limits]
     for (i =3D 0; i < ARRAY_SIZE(arm_cpus); ++i) {
                   ^

I've dropped the patch from the pullreq.

thanks
-- PMM

