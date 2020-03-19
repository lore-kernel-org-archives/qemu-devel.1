Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34FBC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14052076C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u22shc+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14052076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEkxi-0004Rw-Tn
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 22:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jEkwV-0003aD-69
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jEkwT-00079w-5l
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:29:54 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jEkwS-00078E-W5; Wed, 18 Mar 2020 22:29:53 -0400
Received: by mail-pj1-x1042.google.com with SMTP id bo3so293650pjb.5;
 Wed, 18 Mar 2020 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=8z3RcR+r1Qc66HnyxRnPdtseV5BUwwlVcOMkU3fJQ3A=;
 b=u22shc+40YxptBh7DBtKOrgv4i4YQl3YE974m/mdn/xhm3iLmMTwDOLA1A7PQqWWIX
 Mg2WEUvcJNB5nbrTEMl+VpcTocagtvety/G/dgXzkk3pOu7SzNIfh6fqCAWCyPBLBLJ0
 bNFkRa0opZtrAF/pCsmhgToWbqVVoV5JIj3Q7zWE4wJRVuJ84u4Etmb/HTNfFQylnOHr
 V92vYzV86Sh9d9DmNYfDpIwS2hxMdpu2Xo1VLo/IfUwxQ94ekL25xDEJEOf/O2DjqDxx
 eoIi+I55pkyV93uWg/xVhdA3BIdZ6Uq9ZCptSPLcja/D1vel02paM2afseHohkVa0VkA
 46Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=8z3RcR+r1Qc66HnyxRnPdtseV5BUwwlVcOMkU3fJQ3A=;
 b=I1VeH9KhvXWrPW+2OWOinW84Q+FZm70r833kUSWr64gPf71W6bWYnX2CIENArEJOvP
 VPj58Msk8o04YWtYgvW25LceK7CZTAL//OvMFzv14fDvBuYfbvesuFoD6LeVgEhCscUb
 I7IxtVWHblaXlKwsXpkpNbtPDUtmXxVD7ZfbA14p7wPuKlj/qySIcSqD/ezzDoM2c9Ze
 7fvRh2ErUyPGfOq364R0YLSpwPBw5FxRPtitw6J7NZFmfFHzp3qKTHy76GjqVOnj/pMd
 AHrd70Yu4genBWN9U2dyBKKOl55DboYbU0h2igpMpEnATbOZG4ZNZE2AV6XXf3aKvjlf
 d8YQ==
X-Gm-Message-State: ANhLgQ0SZDnTgm+CfXGGl8Ef4HcfZfyuNU7CmpqR3PYuJ5MW4waPn05c
 QthnquGK9fSi4QBMIlcGWkA=
X-Google-Smtp-Source: ADFU+vuqrRnPzo2nZMO/42ir3hLjMOinKJVvg2yvbKshDklBoQ0LHBXpNz9r6ZdxSMpo9s3pLT7KBA==
X-Received: by 2002:a17:902:a701:: with SMTP id
 w1mr997065plq.165.1584584991983; 
 Wed, 18 Mar 2020 19:29:51 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id f8sm311815pfq.178.2020.03.18.19.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 19:29:51 -0700 (PDT)
Date: Thu, 19 Mar 2020 12:28:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] ppc/spapr: Add FWNMI machine check delivery warnings
To: Greg Kurz <groug@kaod.org>
References: <20200317050215.159334-1-npiggin@gmail.com>
 <20200317050215.159334-4-npiggin@gmail.com>
 <20200317132057.37296abc@bahia.lan>
In-Reply-To: <20200317132057.37296abc@bahia.lan>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584584864.6qmf6mxnxn.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?q?C=E9dric_Le=0A?= Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?q?David=0A?= Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz's on March 17, 2020 10:20 pm:
> On Tue, 17 Mar 2020 15:02:13 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> Add some messages which explain problems and guest misbehaviour that
>> may be difficult to diagnose in rare cases of machine checks.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ppc/spapr_events.c | 4 ++++
>>  hw/ppc/spapr_rtas.c   | 4 ++++
>>  2 files changed, 8 insertions(+)
>>=20
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 05337f0671..d35151eeb0 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -807,6 +807,8 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu,=
 bool recovered)
>>      /* get rtas addr from fdt */
>>      rtas_addr =3D spapr_get_rtas_addr();
>>      if (!rtas_addr) {
>> +        warn_report("FWNMI: Unable to deliver machine check to guest: "
>> +                    "rtas_addr not found.");
>=20
> Why a warning and not an error ?
>=20
> Also maybe change the string to fit on one line ?

Not sure, I guess it should be.

Thanks,
Nick
=

