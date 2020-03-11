Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF4C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 04:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102A9208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 04:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Dne5RTzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102A9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBtQZ-0008EW-7H
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 00:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBtOh-0006Cx-FQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBtOZ-0004xU-LY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:55:11 -0400
Received: from ozlabs.org ([203.11.71.1]:49273)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBtOY-0004th-CS; Wed, 11 Mar 2020 00:55:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48cflQ0clQz9sPR; Wed, 11 Mar 2020 15:54:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583902498;
 bh=ZPTWwt7qT7b942QLqncasOVXjxFu2QMYQMvPQ/tLzqw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dne5RTzXCXQOXRqpMg25Vl7LGQMTr1mo+EAjsvPSTkBR2loeWeD7hrdgiCr6d/oqb
 5DCTpWYkkwrsV5dNH0et631fpCm6n834cu9s1+9ZM6vjXD/yyYPnnOCeRhUnxSr1pv
 CSEKWKGYkr7mjpmhsMIP2UWE9EtC2LrUlZ1djMaw=
Date: Wed, 11 Mar 2020 15:47:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: I am trying to fixes a issue with QEMU with VxWorks.
Message-ID: <20200311044721.GW660117@umbus.fritz.box>
References: <CAE2XoE-XeFmmPHsy6KT-zHtRcZqZnuWzaXR+SkMP60cCL2jx0w@mail.gmail.com>
 <20200310100418.GE140737@stefanha-x1.localdomain>
 <CAE2XoE_aFDLGCFZvsxV+Q2nPqdOeUfQS8KJ+bUs3wwch1auzMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L0mHLbha4YKvhGtu"
Content-Disposition: inline
In-Reply-To: <CAE2XoE_aFDLGCFZvsxV+Q2nPqdOeUfQS8KJ+bUs3wwch1auzMw@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--L0mHLbha4YKvhGtu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 08:48:49PM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Yongg=
ang Luo) wrote:
> I  have already debugging it. I have infinite interrupt after calling to
> motTsecGracefulStop,

What interrupt is it, and what instruction is triggering it?

> I am simulating wrSbc834x using etsec with PPC.

Unfortunately the freescale and other embedded ppc chips are only
barely maintained at present - there just aren't that many people with
both the interest and skills to do so.

So, I'll do what I can, but you'll probably have to do most of the
debugging here yourself.

> ```
> Chain 0: 00000000088bad00 [00000000/00e0ccf0/0x2000] sysTimestamp64Set
> Trace 0: 0000000008a90940 [00000000/00e06358/0x2000] motTsecGracefulStop
> 32-bits write 0x00001039 to register 0x00000
> 32-bits write 0x00001002 to register 0x00000
> 32-bits write 0x62110180 to register 0x00000
> 32-bits write 0x00000935 to register 0x00000
> 32-bits write 0x00000937 to register 0x00000
> Chain 0: 00000000086f9c40 [00000000/00e2b51c/0x2000] intUnlock
> Stopped execution of TB chain before 00000000086f9c40 [00e2b51c] intUnlock
> Trace 0: 00000000086f9c40 [00000000/00e2b51c/0x2000] intUnlock
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Stopped execution of TB chain before 00000000087501c0 [00e7bb78] windExit
> Raise exception at 00e7bb78 =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Linking TBs 0000000008901480 [00e08168] index 0 -> 0000000008902600
> [00e08278]
> Trace 0: 0000000008902600 [00000000/00e08278/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Stopped execution of TB chain before 00000000087762c0 [00e00c74]
> quiccIntrDeMux
> Trace 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Stopped execution of TB chain before 00000000086b0c00 [00e2b52c] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Stopped execution of TB chain before 00000000087762c0 [00e00c74]
> quiccIntrDeMux
> Trace 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Stopped execution of TB chain before 0000000008772bc0 [00e00f48]
> quiccIvecToInum
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Stopped execution of TB chain before 0000000008752700 [00e050d8]
> timeMonitorCtxSwitchToTask2
> Trace 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Stopped execution of TB chain before 0000000008772200 [00e87294]
> excConnectCode
> Trace 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Stopped execution of TB chain before 0000000008748b00 [00e7c0b4] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Stopped execution of TB chain before 0000000008771f80 [00000500]
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Stopped execution of TB chain before 00000000086b0c00 [00e2b52c] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Stopped execution of TB chain before 0000000008776800 [00e872ac]
> excConnectCode
> Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchToTas=
k2
> Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> Raise exception at 00e2b52c =3D> 00000004 (00)
> Trace 0: 0000000008771f80 [00000000/00000500/0]
> Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> Stopped execution of TB chain before 00000000086b0c00 [00e2b52c] intUnlock
> Raise exception at 00e2b52c =3D> 0000000a (00)
> Trace 0: 0000000008747a40 [00000000/00000900/0]
> Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToIsr
> Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> ```
>=20
> On Tue, Mar 10, 2020 at 6:04 PM Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
>=20
> > On Mon, Mar 09, 2020 at 11:26:07AM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Y=
onggang Luo) wrote:
> > > When I am running QEMU to simulating PowerPC.
> > > And after running the following powerpc code:
> > > 00e2b5dc <intUnlock>:
> > > intUnlock():
> > >   e2b5dc: 54 63 04 20 rlwinm r3,r3,0,16,16
> > >   e2b5e0: 7c 80 00 a6 mfmsr r4
> > >   e2b5e4: 7c 83 1b 78 or r3,r4,r3
> > >   e2b5e8: 7c 60 01 24 mtmsr r3
> > >   e2b5ec: 4c 00 01 2c isync
> > >   e2b5f0: 4e 80 00 20 blr
> > >
> > > The QEMU are getting stuck and can not running the following
> > instructions,
> > > What I need to do to inspect which instruction are getting stuck and =
how
> > to
> > > fix it?
> > > Any means to debugging that.
> >
> > CCing ppc maintainers.
> >
> > You could begin debugging this using QEMU's GDB stub (the -s
> > command-line option), TCG debug output (the -d command-line option), and
> > the HMP "info status" command to check that the CPU is running.
> >
> > Good luck!
> >
> > Stefan
> >
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L0mHLbha4YKvhGtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5obVYACgkQbDjKyiDZ
s5LByw//ZSKG+Lj2Lwxoab35hfMsTLiKfNFb+uk0FYreO75ipSpYLgxwieCxmsij
4Al5S3aXcGeoAzXscH6ZlHoTMZHbs3YjfL27j6Q2j5UdYSKdZz+OcJCH23/ogAjY
DS81yItC7vYwfE3bdmtMU+T2zRrTlnnSHn/A/foBZg4HAsxwDrOX/C0rILKbhqG0
bZZiKFnHJzgsutDTISfCPiThGouHpweiGkUMz5KNtjH8N1RO6lgFcoCL4Jil2jQA
QT8OkVbRu5eP9sfpggMIjyJS0SlnVnYWIg7T+zHT7RquOFu1BxOFCMvk37LJ3IfG
k2sRKaK6y7NVVHaL1ToH92kO6X5Hp7ds0QaCOoUI3RF4PKx7xlLGYwFGxwnCIrxx
qql7s49HoNOfLYIV1oJXyEAtGd0IfGtQarkw53YN4UTkZl3lVYeIVpif04OtqXqV
rdzVZ6rWxBLSBzFFPVPvQ86WcU0mS/fgcSkVIFzbg7MUNmFEjJtG6z96YcTfLwMm
SrJjenTEADN4wgUgAuZodNSlF9TNbr2Wlwu2jAkJ3jykFbwZFdIOSHBZ8smhbaHZ
l6oUhob2vFj6PF1S2P8qngarUs6bg+LhfviHvVdqzwTfgLBXNWEoHtj6t+eWchiC
H/DPjr3KNGh1SAcZMbTmpz3WylQpB3SA71QvIFvieA+yhgIndEU=
=HP0N
-----END PGP SIGNATURE-----

--L0mHLbha4YKvhGtu--

