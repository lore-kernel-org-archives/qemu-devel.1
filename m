Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C84C282DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 01:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42419217FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 01:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNKVw+El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42419217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33986 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGw8k-0008Pz-He
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 21:47:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGw7Y-0007xJ-FL
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 21:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGw7U-0003CQ-Nc
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 21:45:46 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npiggin@gmail.com>)
	id 1hGw7N-00039U-9Y; Wed, 17 Apr 2019 21:45:39 -0400
Received: by mail-pf1-x441.google.com with SMTP id c8so315985pfd.10;
	Wed, 17 Apr 2019 18:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:subject:to:cc:references:in-reply-to:mime-version
	:user-agent:message-id:content-transfer-encoding;
	bh=V0p6hLRqWAwqxaxSnr3CHCAsENKQDj/IUZRtfXN0hkI=;
	b=bNKVw+ElE1lsIwDvWFCyH+sBvDAekKW/rQ9J4lIg7mb3083WKSHmNJPxKLwYcrbnY5
	BwTIubIWdM3MkVbabqyOf1hQukKiN5zWsfMMdDFoN4Ph9+XcxvJMwtz4MYZ6MosWMmTJ
	2CPrZn39bRvKINzrctJaT8wHLVfNuLW8/SVvJXjztiCwqO6ugtWKy/ihJuuD9IRei+gr
	NXSPGWosESdp7MSaC6sfKE20XPdZxbKF+0cex8Vr0FVflu5F+eSVnnBPLUb8+rJuxeO6
	67KN6Yr1D8pMopDVIVjJEGz9C+/uSUuSZ6KsnPqtCgmhQD5ek4elKZjNB8/MY3Vo3lrY
	6X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
	:mime-version:user-agent:message-id:content-transfer-encoding;
	bh=V0p6hLRqWAwqxaxSnr3CHCAsENKQDj/IUZRtfXN0hkI=;
	b=fT66KPK6ePnAhWk4b/f1QAV1w2X83om/836dVgGNg4rDQAPnXsUhInVK2NAc9cEbii
	+ilFTVPm2gi/OgsveM2Z+OB2O3eAY4IJepySmbcR0ZlwhzUDdMwJtJ/MxPpsJMOpzgcn
	IvlkFBU2tuz4b5F/Q+IcIda2F2mw9+1/dYz8n7KHGicIqAMZ9u4vNyXkJf3wr347tlXC
	4KUf9Z5vNLgcvyWCXORx8x6L3oeTKZ97tFzYYDATH5YkID54FSBcM6ew/ohwVS7wmPno
	kSWaV6TIJ+zTvsAgxLovmShc+ofVts2aehmuBKM7ASoRbhfMWBU+NVRrX5lWwln7ch+f
	RygA==
X-Gm-Message-State: APjAAAXjPzOS4VlEdVDlqSvPtr4757wdY/YYp7661Sidv4det9jEaM07
	pyT4nfhfiQ8aIwD0uj2vuY0=
X-Google-Smtp-Source: APXvYqw6uy0d1VygBU1lVIo7fy7osuNDUgUqwDD3I50VbnULT/zghXqUoOuev7r4cWZpkS5G2++Yqg==
X-Received: by 2002:a62:1a0d:: with SMTP id a13mr94448787pfa.198.1555551935677;
	Wed, 17 Apr 2019 18:45:35 -0700 (PDT)
Received: from localhost (14-202-58-58.tpgi.com.au. [14.202.58.58])
	by smtp.gmail.com with ESMTPSA id p7sm614733pfp.70.2019.04.17.18.45.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 18:45:34 -0700 (PDT)
Date: Thu, 18 Apr 2019 11:45:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
References: <20190416045552.24573-1-npiggin@gmail.com>
	<20190417015934.GH32705@umbus.fritz.box>
	<1555498879.055yucy998.astroid@bobo.none>
	<20190417140129.18980f0e@bahia.lan>
	<20190417124734.GT32705@umbus.fritz.box>
In-Reply-To: <20190417124734.GT32705@umbus.fritz.box>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555551876.gpgdiz67vs.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] spapr: add splpar hcalls
 H_PROD, H_CONFER
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418014529.Nl8qPmH1J-NnzzZOuY3iW0yaDDidBSe1Cz4WC8vKThA@z>

David Gibson's on April 17, 2019 10:47 pm:
> On Wed, Apr 17, 2019 at 02:01:29PM +0200, Greg Kurz wrote:
>> On Wed, 17 Apr 2019 21:20:00 +1000
>> Nicholas Piggin <npiggin@gmail.com> wrote:
>> > [...]
>> > >> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
>> > >>      /* hcall-splpar */
>> > >>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>> > >>      spapr_register_hypercall(H_CEDE, h_cede);
>> > >> +    spapr_register_hypercall(H_CONFER, h_confer);
>> > >> +    spapr_register_hypercall(H_PROD, h_prod);
>> > >> +
>> > >>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_rese=
t); =20
>> > >=20
>> > > You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
>> > > they enabled by default, or is that an intentional change? =20
>> >=20
>>=20
>> AFAICT they seem to be enabled by default in HV KVM.
>>=20
>> > Oh, it was not intentional, I must not understand how this works. Why
>> > is this no longer enabling the those hcalls?
>> >=20
>>=20
>> Since linux commit 699a0ea0823d ("KVM: PPC: Book3S: Controls for in-kern=
el=20
>> sPAPR hypercall handling"), in-kernel hypercalls are disabled by default
>> and must be explicitely enabled by userspace. QEMU does that for some
>> hypercalls already (search kvmppc_enable_set_mode_hcall() in QEMU for an
>> example).
>>=20
>> Since H_CONFER and H_PROD are listed in default_hcall_list[] in book3s_h=
v.c,
>> no need for QEMU to enable them in KVM.
>=20
> Ah, ok.  Oops, that means the guest environment has been visibly
> different for KVM and TCG all this time, which isn't great.
>=20
>> Not sure about David's "no longer" wording though.
>=20
>=20
> "no longer" meaning the previous patch version had some
> kvmppc_enable_hcall(), but this version doesn't.

Let me do one more iteration with the comment fixed up at least,
and I'll do a bit of testing with KVM vs TCG behaviour and see
if there are any problems around this.

Thanks,
Nick

=

