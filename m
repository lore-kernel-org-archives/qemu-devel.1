Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA139C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B1920767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxOoW1sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B1920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuV3-00053e-JT
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtuTz-0004SG-T2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:58:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtuTy-0000Pf-3b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:58:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id j18so6488400wmi.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YA42+GguNg3+vUwUMkhPpOhXoSusEGT9DETqKr4nQmM=;
 b=sxOoW1skSoe/7GOnky99ShKmb01ra7KatMlYlmfAskz8QiH4GFswopeyNrOG0LBtEy
 7UHVYNCoU5g3ja/UARFLIQJMK9BAvRD9IXrGrbvFMoEbxXGIiI5QqLnNyhLSbakQCvsi
 /+pVzb665fIJBi8qhdFhKU506srM5HfsECvLdRpurGpSV3f3BMZ2suKpNtr6t4NmxsH5
 cLsxPAecsQDKL9COyYrHFEJq8h0aJtDfHb1YmQJeE5EYUQLFaSet2CT2yEo2FaU+aQdB
 yUKSKH+A482qXQKVCq6/bvO/Il1CK2FdNOmihfaUZVEIo/zTUVoqpSgeBa0YCS0sPP5d
 CK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YA42+GguNg3+vUwUMkhPpOhXoSusEGT9DETqKr4nQmM=;
 b=HFVwQuz12YWrwtkpSTQqT+vQ6q4DGZ8d+XyNwNotSd3DvLwFDzNRTIXKVYAbBl/UO6
 COCzykTGiVc/FDW4o5LFqtrzBiwLdMgKEh6D9c8ZQv+sqBcSAf3YnsCY7iXNHHqFiH+u
 o9q0z5HNx2dLjs0aNhZ4K7JC1oQVoZrkFl+GwvTAZM1oUiGl8HRkLUT4JUjWEf7Gdo2y
 jWBm72azhNiDMT1og6Y7IDq4farw+vJ2UlRsejV8M1t5wC13T4uQgR6xVWNlTzMeqWBl
 I35LP10YqRgPa7YXl0DuwzTK7pxxc9ngpZklh3D1gc5ImoGoDWlSdPnTFF9dYMTNxuJV
 +pxg==
X-Gm-Message-State: AOAM533fjx5KLtz8iccvvoQjB822g1m5ztyLahMK9dPzoShc/KNaPA1r
 RcNt8zuTqK/S7/y6UFR3uqPn2Q==
X-Google-Smtp-Source: ABdhPJwh4sZ1VOLv7HmM+3xm0XLOA5rTX7O4BTtYikfZe6Z1HOkuuarx5H5NAHMtR1iWI6BYDYnC6g==
X-Received: by 2002:a1c:9994:: with SMTP id b142mr5341317wme.141.1594393111985; 
 Fri, 10 Jul 2020 07:58:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m9sm9316840wml.45.2020.07.10.07.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 07:58:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 198321FF7E;
 Fri, 10 Jul 2020 15:58:29 +0100 (BST)
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-37-alex.bennee@linaro.org>
 <03ef8691-5839-12aa-4649-b4e04172a15c@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 36/40] gitlab: split build-disabled into two phases
In-reply-to: <03ef8691-5839-12aa-4649-b4e04172a15c@redhat.com>
Date: Fri, 10 Jul 2020 15:58:29 +0100
Message-ID: <87365zl8mi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 f4bug@amsat.org, cota@braap.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 01/07/2020 15.56, Alex Benn=C3=A9e wrote:
>> As we run check-qtest in "SLOW" mode this can timeout so split into
>> two jobs.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>  Hi Alex,
>
> I think you can drop this patch and use "[PATCH v2] tests: improve
> performance of device-introspect-test" instead.

As I'm re-rolling the PR sure...

>
>  Thanks,
>   Thomas


--=20
Alex Benn=C3=A9e

