Received: from eggs.gnu.org ([209.51.188.92]:59369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmNJQ-0007AK-2M
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmNJP-0007vh-5N
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:31:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmNJO-0007qr-Vf
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:31:43 -0500
Date: Wed, 23 Jan 2019 18:31:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190123183134.GH2193@work-vm>
References: <20190122173111.29821-1-dgilbert@redhat.com>
	<20190123114448.GB5771@work-vm>
	<c3a45ef7-745c-5fc1-62a8-0e9060d5983e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c3a45ef7-745c-5fc1-62a8-0e9060d5983e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: unegister fd handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, jemmy858585@gmail.com, quintela@redhat.com, peterx@redhat.com

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 1/23/19 12:44 PM, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>
> >> Unregister the fd handler before we destroy the channel,
> >> otherwise we've got a race where we might land in the
> >> fd handler just as we're closing the device.
> >>
> >> (The race is quite data dependent, you just have to have
> >> the right set of devices for it to trigger).
> >>
> >> Corresponds to RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D=
1666601
> >>
> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >=20
> > Queued
>=20
> Did you fixed the patch subject typo? "un(r)egister"

Yes; fortunately I spotted it during building the pull :-)

Dave

> >> ---
> >>  migration/rdma.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/migration/rdma.c b/migration/rdma.c
> >> index 9b2e7e10aa..54a3c11540 100644
> >> --- a/migration/rdma.c
> >> +++ b/migration/rdma.c
> >> @@ -2321,6 +2321,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdm=
a)
> >>          rdma->connected =3D false;
> >>      }
> >> =20
> >> +    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
> >>      g_free(rdma->dest_blocks);
> >>      rdma->dest_blocks =3D NULL;
> >> =20
> >> --=20
> >> 2.20.1
> >>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
