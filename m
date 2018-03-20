Received: from eggs.gnu.org ([2001:4830:134:3::10]:47574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyF80-0002s9-62
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyF7w-0001nS-2u
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:08:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyF7v-0001nA-V4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:08:24 -0400
Date: Tue, 20 Mar 2018 11:08:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180320110816.GB7665@work-vm>
References: <20180319175823.22111-1-marcandre.lureau@redhat.com>
	<272a2e2b-5a1f-d73c-8a74-6721ce9f63fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <272a2e2b-5a1f-d73c-8a74-6721ce9f63fc@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] hmp: free sev info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, brijesh.singh@amd.com

* Eric Blake (eblake@redhat.com) wrote:
> On 03/19/2018 12:58 PM, Marc-Andr=E9 Lureau wrote:
> > Found thanks to ASAN:
> >=20
> > Direct leak of 16 byte(s) in 1 object(s) allocated from:
> >      #0 0x7efe20417a38 in __interceptor_calloc (/lib64/libasan.so.4+0=
xdea38)
> >      #1 0x7efe1f7b2f75 in g_malloc0 ../glib/gmem.c:124
> >      #2 0x7efe1f7b3249 in g_malloc0_n ../glib/gmem.c:355
> >      #3 0x558272879162 in sev_get_info /home/elmarco/src/qemu/target/=
i386/sev.c:414
> >      #4 0x55827285113b in hmp_info_sev /home/elmarco/src/qemu/target/=
i386/monitor.c:684
> >      #5 0x5582724043b8 in handle_hmp_command /home/elmarco/src/qemu/m=
onitor.c:3333
> >=20
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   target/i386/monitor.c | 2 ++
> >   1 file changed, 2 insertions(+)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Worth mentioning in the commit message that this was introduced in comm=
it
> 63036314.

Queued.  I've added:
Fixes: 63036314

to the commit message.

Dave

> And safe for freeze, as it's fixing a memory usage bug in material new =
to
> the 2.12 release.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
