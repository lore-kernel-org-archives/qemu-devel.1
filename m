Received: from eggs.gnu.org ([2001:4830:134:3::10]:51154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exzhM-00071i-Ps
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exzhJ-0002n8-KM
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:39:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exzhJ-0002mk-GR
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:39:53 -0400
References: <20180319175823.22111-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <272a2e2b-5a1f-d73c-8a74-6721ce9f63fc@redhat.com>
Date: Mon, 19 Mar 2018 13:39:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180319175823.22111-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, brijesh.singh@amd.com, dgilbert@redhat.com

On 03/19/2018 12:58 PM, Marc-Andr=C3=A9 Lureau wrote:
> Found thanks to ASAN:
>=20
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>      #0 0x7efe20417a38 in __interceptor_calloc (/lib64/libasan.so.4+0xd=
ea38)
>      #1 0x7efe1f7b2f75 in g_malloc0 ../glib/gmem.c:124
>      #2 0x7efe1f7b3249 in g_malloc0_n ../glib/gmem.c:355
>      #3 0x558272879162 in sev_get_info /home/elmarco/src/qemu/target/i3=
86/sev.c:414
>      #4 0x55827285113b in hmp_info_sev /home/elmarco/src/qemu/target/i3=
86/monitor.c:684
>      #5 0x5582724043b8 in handle_hmp_command /home/elmarco/src/qemu/mon=
itor.c:3333
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   target/i386/monitor.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

Worth mentioning in the commit message that this was introduced in=20
commit 63036314.

And safe for freeze, as it's fixing a memory usage bug in material new=20
to the 2.12 release.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
