Received: from eggs.gnu.org ([2001:4830:134:3::10]:59494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGQgP-0001ZZ-2f
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGQgJ-0000iU-1R
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dGQgI-0000iN-Pj
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:02:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C978D80E7D
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 14:02:29 +0000 (UTC)
Date: Thu, 1 Jun 2017 15:02:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170601140218.GS2083@work-vm>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
	<b7f9de2d-e09c-bcf1-24c8-0d961989cd9c@redhat.com>
	<2687d5d9-9771-97dc-5a32-ac78006472f1@redhat.com>
	<20170530185713.GT2120@work-vm>
	<1b1b49c5-f949-9d29-bc36-1c482b4644f3@redhat.com>
	<4566aebb-4e6b-158a-4227-7bb6e35f737a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4566aebb-4e6b-158a-4227-7bb6e35f737a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: Introduce announce
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

* Vlad Yasevich (vyasevic@redhat.com) wrote:
> On 06/01/2017 03:02 AM, Jason Wang wrote:
> >=20
> >=20
> > On 2017=E5=B9=B405=E6=9C=8831=E6=97=A5 02:57, Dr. David Alan Gilbert =
wrote:
> >> * Vlad Yasevich (vyasevic@redhat.com) wrote:
> >>> On 05/26/2017 12:03 AM, Jason Wang wrote:
> >>>> On 2017=C3=A5=C2=B9=C2=B405=C3=A6=C5=93=CB=8625=C3=A6=E2=80=94=C2=A5=
 02:05, Vladislav Yasevich wrote:
> >>>>> Add parameters that control RARP/GARP announcement timeouts.
> >>>>> The parameters structure is added to the QAPI and a qmp command
> >>>>> is added to set/get the parameter data.
> >>>>>
> >>>>> Based on work by "Dr. David Alan Gilbert"<dgilbert@redhat.com>
> >>>>>
> >>>>> Signed-off-by: Vladislav Yasevich<vyasevic@redhat.com>
> >>>> I think it's better to explain e.g under which condition do we nee=
d to tweak such
> >>>> parameters.
> >>>>
> >>>> Thanks
> >>>>
> >>> OK.  I'll rip off what dgilbert wrote in his original series for th=
e description.
> >>>
> >>> Dave, if you have any text to add as to why migration might need to=
 tweak this, I'd
> >>> appreciate it.
> >> Pretty much what I originally said;  that the existing values
> >> are arbitrary and fixed, and for systems with complex/sluggish
> >> network reconfiguration systems they can be too slow.
> >>
> >> Dave
> >>
> >=20
> > I agree, but I'm not sure how much it can help in fact unless managem=
ent can set
> > configuration specific parameters. And what we did here is best effor=
t, there's no
> > guarantee that G(R)ARP packet can reach the destination.
> >=20
>=20
> So, that's what the series allows.  If management knows something new, =
it can set
> appropriate parameter values.  Additionally, the management is also fre=
e to trigger
> additional announcements through the new commands.
>=20
> I am starting to think that just for the sake of migration, exposing an=
nounce_self
> interface to management might be sufficient.  Management, when it deems=
 migration
> complete, may use the interface to trigger announcements in addition to=
 whatever
> best effort QEMU may attempt itself.
>=20
> Dave, would that be enough, or do the parameters still make sense?

I'd still like to be able to set the parameters to be able to work
around the very broken setups that are out there.
The way I got to this point was a hack for a user where I just
increased it so it was doing about 10 seconds of announce which was long
enough for the network to get it's act together.

Dave

> Thanks
> -vlad
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
