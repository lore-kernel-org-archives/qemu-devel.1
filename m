Received: from eggs.gnu.org ([2001:4830:134:3::10]:38169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eo5tI-000448-5y
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eo5tF-0004sg-10
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:15:20 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eo5tE-0004s7-Oq
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:15:16 -0500
Received: by mail-wr0-f196.google.com with SMTP id k9so13224692wre.9
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 03:15:16 -0800 (PST)
Date: Tue, 20 Feb 2018 12:15:13 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180220121513.30352487@fiorina>
In-Reply-To: <9471BF09-A515-4D17-8D88-3514CC3B830B@oracle.com>
References: <cover.1512476043.git.tgolembi@redhat.com>
	<938dc32019864c9c19259bdddd64a53b6b99efef.1512476043.git.tgolembi@redhat.com>
	<20180205130824.79f570bc@fiorina>
	<1e6717d5-a1bc-3409-b01f-24ea761659fb@oracle.com>
	<20180214000454-mutt-send-email-mst@kernel.org>
	<20180219141139.14e0a9d9@fiorina>
	<9471BF09-A515-4D17-8D88-3514CC3B830B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] virtio-balloon: include statistics
 of disk/file caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathan Helman <jonathan.helman@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org

On Mon, 19 Feb 2018 21:11:27 -0800
Jonathan Helman <jonathan.helman@oracle.com> wrote:

> > On Feb 19, 2018, at 5:11 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com> wrote:
> >=20
> > On Wed, 14 Feb 2018 00:07:53 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> >> On Tue, Feb 13, 2018 at 12:29:39PM -0800, Jonathan Helman wrote: =20
> >>>=20
> >>>=20
> >>> On 02/05/2018 04:08 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:   =20
> >>>> ping
> >>>>=20
> >>>> On Tue,  5 Dec 2017 13:14:46 +0100
> >>>> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:
> >>>>  =20
> >>>=20
> >>> It would be good to include the corresponding upstream kernel change =
in the
> >>> commit message. This would be similar to a previous change:
> >>> https://lists.gnu.org/archive/html/qemu-devel/2016-02/msg05555.html  =
 =20
> >>=20
> >> good idea, but this has been merged by now. =20
> >=20
> > Maybe next time, sorry.
> >=20
> >  =20
> >>>>> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.c=
om>
> >>>>> ---
> >>>>>  hw/virtio/virtio-balloon.c                      | 1 +
> >>>>>  include/standard-headers/linux/virtio_balloon.h | 3 ++-
> >>>>>  2 files changed, 3 insertions(+), 1 deletion(-)
> >>>>>=20
> >>>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >>>>> index 37cde38982..8141326a51 100644
> >>>>> --- a/hw/virtio/virtio-balloon.c
> >>>>> +++ b/hw/virtio/virtio-balloon.c
> >>>>> @@ -50,6 +50,7 @@ static const char *balloon_stat_names[] =3D {
> >>>>>     [VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",
> >>>>>     [VIRTIO_BALLOON_S_MEMTOT] =3D "stat-total-memory",
> >>>>>     [VIRTIO_BALLOON_S_AVAIL] =3D "stat-available-memory",
> >>>>> +   [VIRTIO_BALLOON_S_CACHES] =3D "stat-disk-caches",
> >>>>>     [VIRTIO_BALLOON_S_NR] =3D NULL
> >>>>>  };
> >>>>> diff --git a/include/standard-headers/linux/virtio_balloon.h b/incl=
ude/standard-headers/linux/virtio_balloon.h
> >>>>> index 9d06ccd066..7b0a41b8fc 100644
> >>>>> --- a/include/standard-headers/linux/virtio_balloon.h
> >>>>> +++ b/include/standard-headers/linux/virtio_balloon.h
> >>>>> @@ -52,7 +52,8 @@ struct virtio_balloon_config {
> >>>>>  #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memo=
ry */
> >>>>>  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
> >>>>>  #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /p=
roc */
> >>>>> -#define VIRTIO_BALLOON_S_NR       7
> >>>>> +#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */   =20
> >>>=20
> >>> I've been wondering, VIRTIO_BALLOON_S_AVAIL is not in the virtio spec=
 (see
> >>> Section 5.5.6.3). It seems like this header file needs to be in sync =
with
> >>> the virtio spec in order to make this change.
> >>>=20
> >>> I have a similar change to add a new statistic and was wondering this=
.   =20
> >>=20
> >> Absolutely. Tom=C3=A1=C5=A1? =20
> >=20
> > Sent. I also included description for the VIRTIO_BALLOON_S_AVAIL that
> > was missing.
> >=20
> >  =20
> >>>>> +#define VIRTIO_BALLOON_S_NR       8
> >>>>>  /*
> >>>>>   * Memory statistics structure.
> >>>>> --=20
> >>>>> 2.15.1
> >>>>>  =20
> >>>>=20
> >>>>  =20
> >>>=20
> >>> You need to add your new stat to the list of stats in
> >>> docs/virtio-balloon-stats.txt.
> >>>=20
> >>> Jon   =20
> >>=20
> >> Can't hurt, I agree. =20
> >=20
> > Sent.
> >  =20
>=20
> Awesome, thank you.
>=20
> Do you also plan to make the commensurate changes in libvirt, or did I ju=
st miss the patch?

Yes, I do. I just didn't get to it yet.

    Tomas

>=20
> Jon
>=20
> >    Tomas
> >=20
> > --=20
> > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> =20
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
