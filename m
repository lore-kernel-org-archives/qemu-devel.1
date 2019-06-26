Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0BEC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3589820644
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3589820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgAzT-0005Zi-GN
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59150)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hgAt7-0006v9-VS
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hgAt5-0002Z5-PH
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:35:13 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:59306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hgAt0-00027J-CX
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:35:07 -0400
Received: from player792.ha.ovh.net (unknown [10.108.35.103])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2F2266E97A
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 18:34:56 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id CF6DE75CB61F;
 Wed, 26 Jun 2019 16:34:48 +0000 (UTC)
Date: Wed, 26 Jun 2019 18:34:47 +0200
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190626183447.1c4cb4c3@bahia.lan>
In-Reply-To: <ca73d533-644b-a366-2927-4163f9aa2ce9@vivier.eu>
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
 <20190529125926.GD2126@perard.uk.xensource.com>
 <20190605121056.0e784daf@bahia.lab.toulouse-stg.fr.ibm.com>
 <c85d973ca2d444678e8fdc86a4cd6f4f@AMSPEX02CL03.citrite.net>
 <20190614101621.098742e2@bahia.lan>
 <c2c63dd46c684b1bb0f2e342a085d93d@AMSPEX02CL03.citrite.net>
 <alpine.DEB.2.21.1906140844150.2072@sstabellini-ThinkPad-T480s>
 <20190614185054.6f12ab30@bahia.lan>
 <b40f16eb-5ae5-4b36-e0a8-02b10c3b7769@redhat.com>
 <ca73d533-644b-a366-2927-4163f9aa2ce9@vivier.eu>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 11434639454646016472
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.150
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] MAINTAINERS: Change
 maintership of Xen code under hw/9pfs
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 18:30:47 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 15/06/2019 =C3=A0 07:43, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
> > Cc'ing qemu-trivial@
> >=20
> > On 6/14/19 6:50 PM, Greg Kurz wrote:
> > [...] =20
> >> Markus, Xen maintainers,
> >>
> >> All needed Acked-by have been provided. I don't plan to send a 9pfs PR
> >> anytime soon. Can this go through someone else's tree please ?
> >>
> >> Cheers,
> >>
> >> --
> >> Greg
> >> =20
> >  =20
>=20
> Applied to my trivial-patches branch.
>=20
> Thanks,
> Laurent

Merci Laurent ! :)

Cheers,

--
Greg

