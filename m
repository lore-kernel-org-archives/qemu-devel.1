Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6327CC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244BB20724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH9Be3x1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244BB20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEktw-0002QG-9H
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 22:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jEktI-0001nn-OA
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jEktH-0006PX-PC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:26:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jEktF-0006Hv-5G; Wed, 18 Mar 2020 22:26:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id l184so540230pfl.7;
 Wed, 18 Mar 2020 19:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=Sj0K9+9Fvh+zhCdmDXlRxzujyTsNq9yW97D/j4g6Hi4=;
 b=ZH9Be3x1cR1krdwMTvWuqQNKWyqi46JKVn1ZRsmCKob8+rCMIueSakzobQv9aHG+uW
 YHOQiSiNJEKORYAgbQoSTfl8mermVX9mazBF41cIieKr/Q4em3G1+cBAraJSt9HNtveH
 t3/8qz3rBY8qMDORJ5iVSGjPHsSVA8W9jXV9YIwxfAboGIBSnc7sNPpGV9Y8c4bEKNh7
 guojEQEWi4yboBrc8Ndj49BIiet+7/dlfjXYW/mwXtqT3PukMioZ5KCLkN4bXesHwIg3
 AHIivjhgeYZqktDndgT6DXMgcWC4EnusgRlRslQ42SkFO4h7VoG2Asjw7Sop9r8gXAWl
 GsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=Sj0K9+9Fvh+zhCdmDXlRxzujyTsNq9yW97D/j4g6Hi4=;
 b=GacgxPbOqa4NOkMukeHDBpzQW5V0DQEG9362OK9gLlop80zmRVKI0fELWLj09hMggd
 E3t8HGFjQf6b6FN0wyVLJ+5w5b01/zc/pe1eJlcD2lbZ8L3nj8YzBM9Iz0v/fnPOe+5f
 axSQgWj00KVycxJ04ECIsAAFiFh/cOCt+avQrPMH2oD8ZA9+rdRzR6bU/8p7b1Mscb/r
 FRhtmg2X9gHm9BPaTIvU2j3hUz6GEMUKNCRG7wWnys3AyY6ZVrE6JbfGfDvx0Wqjg5RE
 620QvSdrKyO5TNolW8ODm81sbtMx/Un4/kGPw87RR0XFe6IB1qzuuedBUQ5i/yf2tNiz
 2IhA==
X-Gm-Message-State: ANhLgQ13gI7I92d92JsK2z4dSoZsihTHv09U20+gyEuHGmp6yUZBRhhq
 KAfnRfPlOlLj2PYR6DTw0NU=
X-Google-Smtp-Source: ADFU+vvB4VWMBRkDkUzZIXfOOvwrWNhH4zsGdBvpQT0sauUVRQMce/pmR8g6z6BXDVMFhiwUJfYv1A==
X-Received: by 2002:a65:494f:: with SMTP id q15mr836085pgs.383.1584584791715; 
 Wed, 18 Mar 2020 19:26:31 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id q71sm273916pjb.5.2020.03.18.19.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 19:26:30 -0700 (PDT)
Date: Thu, 19 Mar 2020 12:24:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [EXTERNAL] [PATCH 1/2] target/ppc: Fix slbia TLB invalidation gap
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20200318044135.851716-1-npiggin@gmail.com>
 <b4a5674c-12b0-68c5-fc2b-94b8d5675ee3@kaod.org>
In-Reply-To: <b4a5674c-12b0-68c5-fc2b-94b8d5675ee3@kaod.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584584632.f0iyej012p.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater's on March 19, 2020 2:45 am:
> On 3/18/20 5:41 AM, Nicholas Piggin wrote:
>> slbia must invalidate TLBs even if it does not remove a valid SLB
>> entry, because slbmte can overwrite valid entries without removing
>> their TLBs.
>>=20
>> As the architecture says, slbia invalidates all lookaside information,
>> not conditionally based on if it removed valid entries.
>>=20
>> It does not seem possible for POWER8 or earlier Linux kernels to hit
>> this bug because it never changes its kernel SLB translations, and it
>> should always have valid entries if any accesses are made to usespace
>> regions. However other operating systems which may modify SLB entry 0
>> or do more fancy things with segments might be affected.
>=20
> Did you hit the bug on the other OS ?=20

No, hit it when fixing POWER9 hash.

> =20
>> When POWER9 slbia support is added in the next patch, this becomes a
>> real problem because some new slbia variants don't invalidate all
>> non-zero entries.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> Looks correct.
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,
Nick
=

