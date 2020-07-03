Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5AEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1965E208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxmouS08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1965E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLWi-0007RN-A6
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLVF-00064h-Bl
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:13:19 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:45093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLVC-0007Xj-MB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:13:17 -0400
Received: by mail-oo1-xc44.google.com with SMTP id v188so873258ooa.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EgSqWLYeZpGqWhb5mjrMupQ3jFx+d1qnxJiNpMWHGfw=;
 b=gxmouS08IdbIBAEKcVV7BB88N4ifs43Ug/0N2kVpJ9mXdz+8B7catkKdBzca8K20Ob
 Ka49xgQqkaYZwiP7j5B4GRRXYmNhovdxFV+5gbKBvppLIhgGqAvYHd+cpIwJVHNhQ458
 jHTM6OyShpE03DQ3ZXi8TwhQLeTOcH3TdpLzQtQJ7IiBEmMwsQtbQEARI/m/XiymK3Bf
 sR8Qdd8DilAyqVhsRWIzpBtDGS9spyN2HQfewSfLrcZwJh8gHPRrMGJMuZfMTu22NhU5
 8vjbJ7I163xsKmjQritlZFvadXVbhZwoh9s83pDAz83zuvsC6dcoABS9XS0guxslT//+
 cnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EgSqWLYeZpGqWhb5mjrMupQ3jFx+d1qnxJiNpMWHGfw=;
 b=rD5rS5Tv6xRFSaHkdtHTyAd5DMQ9JBTOPsgYYdkB/UXzwoyrUOvHUyN7RVGmW5n5Jq
 rdVn+CSe3+DlqU9qBKzSWPTFgOw6IxNrxsQ6vtK1uab6oQoYQiumSzkI+j4PI97stqZb
 7DKU/z/OuBlsZubk4BN8QVrz3WAwHO1XRgtG9Q3zD5YUqJW2sG4UL9+XygaHR/UqkPTl
 /OjLwI/WfMMmDjHc8VXMC3LsJEGUez8cVZdRdtUexAUgHb1AbQcpspES0oEn+1KMVqnK
 XLeZ6QxX/wOHXs2yyHu5Enb6lGZb9OHmU6hmXYsuCE3mvgoE4ZQPoX8kihR7GxcuGiur
 H0HQ==
X-Gm-Message-State: AOAM533MHPl29m2FnAQCP7ufPlD63KwOFiXU0LhovPF0Caz4EmvY8h7k
 adObBejCA+PnVDmYqYf7PgYb0SKV4+9TUVH2mh/vhKqh0Bg=
X-Google-Smtp-Source: ABdhPJyaaXDSQz16FnpqMvFHKVvtd7YSEac2WL/YKPAghU+PXwSRAI9apc8alhZq7vKIOfdCCYxGJZUyL1CPc0q76HU=
X-Received: by 2002:a05:6820:172:: with SMTP id
 k18mr23564025ood.69.1593781992443; 
 Fri, 03 Jul 2020 06:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-8-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:13:01 +0100
Message-ID: <CAFEAcA8x3akhiyqd6bj5QVrQdBcfpNsj2SPf3-yJDFH_zqnong@mail.gmail.com>
Subject: Re: [PATCH v7 07/17] hw/sd/sdcard: Move sd->size initialization
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Move sd->size initialization earlier to make the following
> patches easier to review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 4 ++--

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

