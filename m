Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5AFC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BC3214AF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BC3214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibj9l-0000AN-0e
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ibj96-00088U-RW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ibj95-0003pU-KB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:41:36 -0500
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:38075)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ibj95-0003nu-Dm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:41:35 -0500
Received: from player737.ha.ovh.net (unknown [10.108.57.183])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id DB44D14DBE9
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 11:41:32 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id D11CD357766A;
 Mon,  2 Dec 2019 10:41:27 +0000 (UTC)
Date: Mon, 2 Dec 2019 11:41:25 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] ci: Use libcap-ng
Message-ID: <20191202114125.2ab5783d@bahia.w3ibm.bluemix.net>
In-Reply-To: <3297c897-69ab-c30f-98dd-dd3138e6325b@redhat.com>
References: <20191129142126.32967-1-dgilbert@redhat.com>
 <3297c897-69ab-c30f-98dd-dd3138e6325b@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 16887372706180733219
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejhedgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.79.46
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
Cc: pbonzini@redhat.com, thuth@redhat.com,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 16:51:29 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 11/29/19 3:21 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > We currently enable libcap-dev in build-clang to pick up the 9p proxy
> > helper.  Paolo's patch changes that to use libcap-ng, so switch to using
>=20
> It is not obvious you are referring to "virtfs-proxy-helper: switch from=
=20
> libcap to libcap-ng" he recently posted.
>=20
> Since Greg is going to take Paolo's patch, I'd suggest he also takes=20
> this one, so he can update the commit description with either "the=20
> previous patch" or the commit sha1.
>=20

I'm okay to take this one and to adapt the changelog if I get an ack from
Thomas.

> > it.  This also means we'll be testing the scsi pr manager and the bridge
> > helper.
>=20
> This is good news.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   .gitlab-ci.yml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index be57c6a454..62a9609798 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -59,7 +59,7 @@ build-user:
> >  =20
> >   build-clang:
> >    script:
> > - - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-dev
> > + - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-ng-dev
> >         xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev l=
ibrbd-dev
> >    - ./configure --cc=3Dclang --cxx=3Dclang++ --enable-werror
> >         --target-list=3D"alpha-softmmu arm-softmmu m68k-softmmu mips64-=
softmmu
> >=20
>=20


