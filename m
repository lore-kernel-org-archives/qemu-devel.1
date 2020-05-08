Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56163C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128572184D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWI/AHAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128572184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX6IM-00035E-7a
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX6Hl-0002Wy-51
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:55:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX6Hk-0004Ep-Cf
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:55:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id j5so2696012wrq.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aV3VTiQEVFUuEj8BgLu7tSmD3IFIS4sDXhKPNbCNXQ8=;
 b=DWI/AHAckTi3UDLva4fYaEnn6MCaPG8KZawLuy7AsXY+1KzSBhrcKv61j2Df237zpd
 UQw0OPzU/2XUshbfS8v/1TEqAS85n7OFfmgznBEeem4tNajNKzSB4FadsUhb3qLg0yhx
 40VrBIfQkj4eFUZ9hIuu5DOzcPV1RQ32bgX2nAqqfv8O7lriPNUMHXCI8NtTiajG2tP/
 oaSJbOLYh5xC0vHEDf1gQPqKZyCtGE+JzYhjjObQsKYXyQeuX9tsrmDlLHoAwcYWnfyo
 bZekToqkqSmSNm66dzT999mfg2pSnpV2++6HDIrO9sHK3cA5qGbkWkcOmsno12zJS9FW
 fN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aV3VTiQEVFUuEj8BgLu7tSmD3IFIS4sDXhKPNbCNXQ8=;
 b=PrWE+vkCHAS1mFhATq7vu7NXETFYRc3zJ2ippwPKOVA5eAth4ms2AU2+u9PhrsnTpu
 9siILblXCDiiEUQCeEZvNPG+6gN23KQLNelcrPA7AIgfA/ysRbHFXWC2VUhP6JrtTssI
 LUEjt+3ehPu0C8zTvowkTnBrLImXIVhx47cjeW37ByxkXR9o7BC62WuAjKN34jegIlnS
 I5Y/ke9N5nhP3aCs3HoL8XlQ/w7C8mNFsITDoWnfTuB9rZJVhqS/7TCD/PMHLrbVNEX2
 oTeGu8Ir0cbWOqRUiiCq8rO49AYd1aHaO0ONo13wS6rE5JQJDBCnUvYzWJCMJqYsQfJu
 qlfQ==
X-Gm-Message-State: AGi0PuaUR3GukrDKEA0q2clGaYkXS2wyWDWDAptkxS0qb3GLnCwxqcv+
 R1kSHfEByX1gkwqo34Nr387dk0Zzhx0iEyFik0A=
X-Google-Smtp-Source: APiQypKgByWuT62OzfwOrDwk18/RHHyWG4ZmGZ4fsP3gHiT3WzB/jy3LrDVGtHnqY9/H8onkvEf9KeVDuxtI0rVAZ7M=
X-Received: by 2002:adf:9793:: with SMTP id s19mr3683026wrb.147.1588956938352; 
 Fri, 08 May 2020 09:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 18:55:26 +0200
Message-ID: <CAHiYmc4GnBE7YWghRk9FUL93RBsbJ+QddNsqMZFOGsUQumhmSg@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:21 Huacai Chen <z=
ltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> others. To reduce complexity, in QEMU we just define two CPU types:
>
> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>    suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>    suitable for KVM because Loongson-3A R4 has the VZ ASE.
>

Hi, Huacei,

Just a couple of practicalities. As you know, we can't upstream this
series until correspondent kernel support is upstreamed into kernel.
This is my advice, timing-wise:

- I think it is too late (and not good from testing/risk perspective)
to shoot for integrating your kernel series into kernel 5.7;
- My advice is to try to upstream your kernel series at the beginning
of 5.8 development cycle (which should not be too far)
- Once this is done, it will open the door for integrating this series
into QEMU upstream
- This means that combination of kernel 5.8 and QEMU 5.1 will
hopefully be a working system from Loongson KVM point of view
- This will also mean we will have relatively sufficient time to test,
and possibly fix some new bugs before QEMU 5.1 release.

I hope this tentative plan sounds good to you.

Sincerely,
Aleksandar

