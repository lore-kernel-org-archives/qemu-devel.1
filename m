Received: from eggs.gnu.org ([2001:4830:134:3::10]:52003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dx8NE-0002js-UW
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dx8N8-00041U-Tv
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dx8N8-00041B-OR
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:11:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAFE781E07
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 09:11:13 +0000 (UTC)
Message-ID: <1506503472.25036.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 27 Sep 2017 11:11:12 +0200
In-Reply-To: <7f50b7bb-bbf7-7e0e-754a-234d4244fb72@redhat.com>
References: <20170926111757.3628-1-kraxel@redhat.com>
	<7f50b7bb-bbf7-7e0e-754a-234d4244fb72@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/1] qemu-firmware repo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Wed, 2017-09-27 at 09:19 +0200, Paolo Bonzini wrote:
> On 26/09/2017 13:17, Gerd Hoffmann wrote:
> >=20
> > Ok, we want for varios reasons separate the firmware from the main
> > qemu repo.=C2=A0=C2=A0Here is my attempt to create such a repo.=C2=A0=
=C2=A0For starters
> > only seabios has been added here.
> >=20
> > You can find the repo with currently three patches here:
> > =C2=A0=C2=A0=C2=A0=C2=A0https://www.kraxel.org/cgit/qemu-firmware/
> >=20
> > This "series" is only patch #2 of the repo.=C2=A0=C2=A0Havn't found a=
 way to
> > convince git-format-patch to include the initial commit of a repo.
> > But patch #1 (the initial commit) only adds the seabios submodule,
> > patch #3 adds the binary blobs, so patch #2 actually is the most
> > interesting one.
>=20
> Are you planning to include only submodules, or also "QEMU-native"
> firmware such as linuxboot, kvmvapic, s390-ccw, spapr-rtas, etc.?

The submodules are my priority.

I think it makes sense for all firmware where we have pre-built
binaries committed to the qemu repo, even if the source is in the qemu
repo too.  But maybe it's easier to keep those in qemu.  They tend to
be small and they are also not problematic license-wise.

cheers,
  Gerd
