Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32596C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B242467F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DB4CqfSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B242467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9Aa-0002FP-4z
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iw99o-0001ni-9S
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iw99m-0006Uj-4o
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:30:43 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iw99k-0006Ra-FJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:30:40 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so12696311wru.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=S3YXwoL82AsiK//EaxvVX9B5IwfKKfgSehznpT7Q2sE=;
 b=DB4CqfSOCSnhMn9m8oLHJCwkUAYqtVcySk6XWsANNBvkC9fVw7k2ONj+Zab+/Bzf98
 SNjXgf5gfLMfade96qrDuNSPN9tyJTs6nrVltq3nRa2atHoyWwkgWDvTlFZK6ibI5g99
 E6f9ZS+qtN0jX47omWTXG28tzO83teYWPTAHlY3cCxoTguPqtPvKngxw7TTwGf2zBsTs
 naOKJ4t3giSISicPyA2utl2aDHTUkUIT6k8KNOG+73ZuoTURl5CJFILC4pNsuGIQawRC
 Vn70LzNvMv2H5mYy159RQ3bMWQyf/en7NQzL55qdGtCwpKfvvmTCrWK9sx2yFvYjy4eH
 J8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=S3YXwoL82AsiK//EaxvVX9B5IwfKKfgSehznpT7Q2sE=;
 b=m5J3dwaOtKNZongD9Rsbs4MhQLrxMsKvdvZz4BDujz884VKqdKw2eqbXM+4uexT8BD
 kHSNMRtDytcePlpi+Fauv2WitSsyZMpwRWggKOPsyyxZqRasuDrRK7QXPbLO6GgZXE4z
 qupfk6rAUHtpqD7Pku9g2y04rgEFYLutIpVvrLtI6eQOqhRFt9NRm5SbP0oM3/hYX07w
 W4+ybct0IxsY6cemKWQcmP9kB8U2He+iBDNTRRCf5nckRIhI9y5QsvT2RgnZvpeUF3BG
 zATACuO5fUyJht5/Y5nwBdXEEUpC4DqZvfvMqN9qZ3liv4zW2c1QrJ0KPkG1JBOd+FRR
 KsBQ==
X-Gm-Message-State: APjAAAViWww0wrZbdCBegQH6DLMbXMmFMNfT8lKOq1le7wW0cB4Aq/ku
 qnmIxWfWoU7ItOnrmByabOkWGw==
X-Google-Smtp-Source: APXvYqw/JQNEbxTTGGNgozGHkMH+NWeW+Xf9GgyVB2zAFYhzByTuLptOSXj120FNB6a+jJ6cG6dFuA==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr22251734wrr.183.1580149838881; 
 Mon, 27 Jan 2020 10:30:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 60sm22984022wrn.86.2020.01.27.10.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 10:30:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A93381FF87;
 Mon, 27 Jan 2020 18:30:36 +0000 (GMT)
References: <20200124204026.2107-1-alex.bennee@linaro.org>
 <20200124204026.2107-13-alex.bennee@linaro.org>
 <7b3d8af5-0c37-9ba9-6503-0f15cba4d451@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 12/13] tests/docker: re-enable cross-compiling for
 x86_64 hosts
In-reply-to: <7b3d8af5-0c37-9ba9-6503-0f15cba4d451@linaro.org>
Date: Mon, 27 Jan 2020 18:30:36 +0000
Message-ID: <87ftg0g3ar.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 1/24/20 10:40 AM, Alex Benn=C3=A9e wrote:
>> +../dockerfiles.cross/fedora-i386-build-qemu.docker
>> \ No newline at end of file
>
> Lots of no trailing newlines.  Probably not intentional?

I think that's just a vagary of the git symlink representation.


--=20
Alex Benn=C3=A9e

