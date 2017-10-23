Received: from eggs.gnu.org ([2001:4830:134:3::10]:34961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e6atN-0004xT-Gl
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e6atJ-0000pT-IV
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:27:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e6atJ-0000op-Cq
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:27:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 823437F7DA
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 11:27:31 +0000 (UTC)
Date: Mon, 23 Oct 2017 07:27:31 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1938855984.30684033.1508758051014.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171023102339.GF16472@redhat.com>
References: <20171023095910.23202-1-marcandre.lureau@redhat.com>
	<20171023095910.23202-5-marcandre.lureau@redhat.com>
	<20171023102339.GF16472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/6] memfd: add hugetlb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com

Hi

----- Original Message -----
> On Mon, Oct 23, 2017 at 10:59:08AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Linux commit 749df87bd7bee5a79cef073f5d032ddb2b211de8 (v4.14-rc1)
> > added a new flag MFD_HUGETLB to memfd_create() that specify the file
> > to be created resides in the hugetlbfs filesystem.  This is the
> > generic hugetlbfs filesystem not associated with any specific mount
> > point.
>=20
> How do you know and/or control what size huge pages are used,
> when the platform supports many sizes ?

>From linux commit message:
"As with other system calls that request hugetlbfs backed pages, there is
the ability to encode huge page size in the flag arguments."

I didn't add this option to memfd backend, as I don't know how generally us=
eful that is, and if there is already a similar option in qemu (probably no=
t?). It could be easily added later.

>=20
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge
> |:|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om
> |:|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge
> |:|
>=20
