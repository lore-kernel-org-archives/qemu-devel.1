Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F0AC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316C920844
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDpa8yIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316C920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hknhG-0005hK-D4
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkngc-0005IU-TX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkngb-0000N9-Ej
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:49:26 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:37284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkngb-00009A-8E
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:49:25 -0400
Received: by mail-oi1-x232.google.com with SMTP id t76so15050365oih.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lNsVPfAiLN5QzSgV0aNPgbtsa25ULBg8wQdze/P0nY4=;
 b=iDpa8yIBcfg+EDKtAonrjzap5d3IBc7K3KfV6LUfJyWIL6Dt2QSxOKubn6Cwn8SEu1
 W4RR78lTRQQ4LyPToWm00S7DbbvjO3TKKn/XOjYofg9D679De5RIhveJcx6bkGROPhTa
 fC/WiALuzUkqVnPDUT6n/fBC3J8DKuWUrET+qsfeDe6kx0HZVBAbdnxcgQgcRbfpHjSR
 7kRyEEsGnn61/ppShP1BmhNS3ySwZR3Web3wJ4m3zquEU9dz8cSq1l+AmKN/aiEvKctM
 WkoZdYECbOQcpk1SinOAKIS6QoPQca5HQnAO0tXkA9x9G+lyG06ShPHLHiaZ0OkGJL6+
 sPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lNsVPfAiLN5QzSgV0aNPgbtsa25ULBg8wQdze/P0nY4=;
 b=V6H6Fwv4Z3L/RwLUEQUyKlmd4epFZg9dyetFt8mxOl1aVhCDcavYAs2ZXSioT+h22D
 LRN98k3KMcr68r6vG1z4WdaGo7x74bqbc/M71zQKP67jvSZndpGA5ejegCcGxDYUjytM
 BJSa4t3+OPTAtfxlTQNWefP8m6HqPYLsVZyuWem2oGsoBYf2rjGoad59VIwooMKwWmcB
 IRgF+Cz2y+mSukOWTDD7j+B64NQ/0gg+ca5r0p/QniWnd1eINdA0m4sZF04YuxZe+OJT
 7RDG8wNcQY//Y7H/tUU9L+QuVHiOl3Jvzs/Wssk5zK5Gp8JBHTgjZvo09IlnDQaxhwFH
 9alA==
X-Gm-Message-State: APjAAAXIpb0nS5S0bd02cdCNPcwcbyy/9qktnuga0XvvQ2xn5Jgg4BNt
 4qjWQ8cZwii2k6qsrN6g2ppbv9dPs6hZCrMdrHZ1TQ==
X-Google-Smtp-Source: APXvYqzTx9nqGbUm1TCAT3ZeCAc7p6+lA603fC/v57QqQ48+KQybBhbYHdsUFK4ZNEay/A+AiddQJK9r7y6hpW9+8ho=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr1237658oie.48.1562669351422; 
 Tue, 09 Jul 2019 03:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190708163610.513479-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20190708163610.513479-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2019 11:49:00 +0100
Message-ID: <CAFEAcA9V-kV_3kVQ_3hgfYxHT6KJ-7Eq7LfOqAPzK+zDK4nv4Q@mail.gmail.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PULL v1 0/1] Merge tpm 2019/07/08 v1
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jul 2019 at 17:36, Stefan Berger <stefanb@linux.vnet.ibm.com> wro=
te:
>
> The following changes since commit 506179e42112be77bfd071f050b15762d3b2cd=
43:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190702=
' into staging (2019-07-02 18:56:44 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2019-07-08-1
>
> for you to fetch changes up to 2bb086f779e079851dd2fd5edb87864893278fb6:
>
>   hw/tpm: Only build tpm_ppi.o if any of TPM_TIS/TPM_CRB is built (2019-0=
7-08 10:04:38 -0400)
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (1):
>       hw/tpm: Only build tpm_ppi.o if any of TPM_TIS/TPM_CRB is built
>
>  hw/tpm/Makefile.objs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

