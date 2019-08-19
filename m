Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C667C2086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C667C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhdX-00086r-Ph
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1hzhQW-0006Zv-5q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hzhQT-0000DI-Qv
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hzhQT-0000C6-If
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:10:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 964D780038D;
 Mon, 19 Aug 2019 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-60.rdu2.redhat.com
 [10.10.124.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2574F857BC;
 Mon, 19 Aug 2019 13:10:05 +0000 (UTC)
Date: Mon, 19 Aug 2019 09:10:03 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190819131003.GA29867@localhost.localdomain>
References: <20171108022828.7242-1-f4bug@amsat.org>
 <23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
 <791dd038-8811-6335-75f7-6dd309ff0ff7@amsat.org>
 <20180511135544.GH25013@localhost.localdomain>
 <4e72cde3-8475-2964-b834-f74d15d66cae@redhat.com>
 <fb3237cd-002b-528b-32cf-4e7675ef27f7@redhat.com>
 <e857bb21-ad12-7150-8fe3-ce86629accab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e857bb21-ad12-7150-8fe3-ce86629accab@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 19 Aug 2019 13:10:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Publishing binary images for testing
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 avocado-devel@redhat.com,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 16, 2019 at 12:51:06PM +0200, Philippe Mathieu-Daud=E9 wrote:
> ping? :)
>=20
> On 6/17/19 7:17 AM, Philippe Mathieu-Daud=E9 wrote:
> > Hi Cleber,
> >=20
> > On 5/11/18 4:27 PM, Cleber Rosa wrote:
> >> On 05/11/2018 09:55 AM, Eduardo Habkost wrote:
> >>> (CCing Cleber and avocado-devel in case they have suggestions)
> >>>
> >>> On Tue, May 08, 2018 at 12:47:52PM -0300, Philippe Mathieu-Daud=E9 =
wrote:
> >>> [...]
> >>>> Ironically I have been using the Gumstix machines quite a lot for =
the SD
> >>>> 'subsystem' refactor, using the MMC commands in U-Boot (I am unabl=
e to
> >>>> reach the Linux userland since the kernel crashes), and plan to ad=
d SD
> >>>> integration tests via Avocado.
> >>>>
> >>>> This raises:
> >>>>
> >>>> - What will happens if I add tests downloading running on their co=
mpiled
> >>>> u-boot
> >>>> (https://downloads.gumstix.com/images/angstrom/developer/2012-01-2=
2-1750/u-boot.bin)
> >>>> and the company decides to remove this old directory?
> >>>> Since sometimes old open-source software are hard to rebuild with =
recent
> >>>> compilers, should we consider to use a public storage to keep
> >>>> open-source (signed) blobs we can use for integration testing?
> >>>
> >>> I think a maintained repository of images for testing would be
> >>> nice to have.  We need to be careful to comply with the license
> >>> of the software being distributed, though.
> >>>
> >>> If the images are very small (like u-boot.bin above), it might be
> >>> OK to carry them in qemu.git, just like the images in pc-bios.
> >>>
> >>>>
> >>>> Avocado has a 'vmimage library' which could be extended, adding su=
pport
> >>>> for binary url + detached gpg signatures from some QEMU maintainer=
s?

Yes, although I believe a stronger distinction between the images
originally targeted by avocado.utils.vmimage and those other images
should probably exist.  One of the reasons that make me think so is
that the images obtained through vmimage *should* be configurable by
the accompanying avocado.utils.cloudinit library.

> >>>
> >>> Requiring a signature makes the binaries hard to replace.  Any
> >>> specific reason to suggest gpg signatures instead of just a
> >>> (e.g.) sha256 hash?
> >>>
> >>>>
> >>>> (I am also using old Gentoo/Debian packaged HPPA/Alpha Linux kerne=
l for
> >>>> Avocado SuperIO tests, which aren't guaranteed to stay downloadabl=
e
> >>>> forever).
> >>>
> >>> Question for the Avocado folks: how this is normally handled in
> >>> avocado/avocado-vt?  Do you maintain a repository for guest
> >>> images, or you always point to their original sources?
> >>>
> >>
> >> For pure Avocado, the vmimage library attempts to fetch, by default,=
 the
> >> latest version of a guest image directly from the original sources.
> >> Say, a Fedora image will be downloaded by default from the Fedora
> >> servers.  Because of that, we don't pay too much attention to the
> >> availability of specific (old?) versions of guest images.
> >>
> >> For Avocado-VT, there are the JeOS images[1], which we keep on a tes=
t
> >> "assets" directory.  We have a lot of storage/bandwidth availability=
, so
> >> it can be used for other assets proven to be necessary for tests.
> >>
> >> As long as distribution rights and licensing are not issues, we can
> >> definitely use the same server for kernels, u-boot images and what n=
ot.
> >>
> >> [1] - https://avocado-project.org/data/assets/
> >=20
> > 1/ How do we check for distribution rights?
> >=20
> > Is it OK for:
> > - a Debian/Fedora image
> > - a compiled Linux kernel (for a Debian/Fedora release)
> >

I think released images are just fine.

FIY, with regards to custom iamges: the Avocado-VT JeOS images are
based on Fedora, and can be recreated with the kickstart files that
are also in-tree.  Making the custom binary file reproducible is,
AFAICT good enough.

> > 2/ Who to ask to add files to this assets directory?
> >

I'd be happy to setup a secure upload mechanism, say, ftp+ssl, so that
"image maintainers" can upload new images.

> > 3/ Can we use a 'webarchive' directory structure?
> >=20
> > Such /site/date/original_site_path/file
> >

I don't see why not.

> > 4/ What are the chances that this website disappears? :S
> >=20
> > (Someone has to pay for it, and the bandwidth...)

Of course the best scenario would be to rely on some bigger
institution, say an University decides to host this archive of images,
and others decide to mirror them.  Until then, if it's decided to push
forward the use of the "avocado-project.org" site, the chances of it
going away are basically if I fail to have $5/month to keep it
running, so hopefully (I mean it) this won't be an issue :)

And thans for the ping, although I was really in need of a brick thrown
at my head to wake me up on this thread! :)

- Cleber.

> >=20
> > Thanks,
> >=20
> > Phil.

