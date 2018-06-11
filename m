Received: from eggs.gnu.org ([2001:4830:134:3::10]:56485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSUrr-0001ww-Q4
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSUro-0003VQ-Mm
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:00:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fSUro-0003V2-Ht
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:00:48 -0400
References: <20180611202532.2334-1-ville.skytta@iki.fi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c04beb13-18f6-f5d9-6864-00206e7cbea0@redhat.com>
Date: Mon, 11 Jun 2018 17:00:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180611202532.2334-1-ville.skytta@iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Grammar and spelling fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Ville_Skytt=c3=a4?= <ville.skytta@iki.fi>, qemu-devel@nongnu.org

On 06/11/2018 03:25 PM, Ville Skytt=C3=A4 wrote:
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---

> +++ b/docs/config/mach-virt-graphical.cfg
> @@ -185,7 +185,7 @@
>   # attached to it.
>   #
>   # We also create an optical disk, mostly for installation
> -# purposes: once the guest OS has been succesfully
> +# purposes: once the guest OS has been successfully

Looks like this line was copy-and-pasted a few times :)

> +++ b/docs/interop/qcow2.txt
> @@ -326,7 +326,7 @@ in the image file.
>   It contains pointers to the second level structures which are called =
refcount
>   blocks and are exactly one cluster in size.
>  =20
> -Given a offset into the image file, the refcount of its cluster can be=
 obtained
> +Given an offset into the image file, the refcount of its cluster can b=
e obtained
>   as follows:

This line is now long; it might be better if you reflow 'obtained', more=20
like...

>  =20
>       refcount_block_entries =3D (cluster_size * 8 / refcount_bits)
> @@ -365,7 +365,7 @@ The L1 table has a variable size (stored in the hea=
der) and may use multiple
>   clusters, however it must be contiguous in the image file. L2 tables =
are
>   exactly one cluster in size.
>  =20
> -Given a offset into the virtual disk, the offset into the image file c=
an be
> +Given an offset into the virtual disk, the offset into the image file =
can be
>   obtained as follows:

...this line.

With or without the reflow,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
