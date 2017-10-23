Received: from eggs.gnu.org ([2001:4830:134:3::10]:36623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6azM-0006sw-Qu
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6azI-0003na-Ns
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:33:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6azI-0003mm-HU
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:33:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 015BC85A07
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 11:33:41 +0000 (UTC)
Date: Mon, 23 Oct 2017 12:33:34 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171023113334.GI16472@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171023095910.23202-1-marcandre.lureau@redhat.com>
	<20171023095910.23202-5-marcandre.lureau@redhat.com>
	<20171023102339.GF16472@redhat.com>
	<1938855984.30684033.1508758051014.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1938855984.30684033.1508758051014.JavaMail.zimbra@redhat.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com

On Mon, Oct 23, 2017 at 07:27:31AM -0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
> > On Mon, Oct 23, 2017 at 10:59:08AM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Linux commit 749df87bd7bee5a79cef073f5d032ddb2b211de8 (v4.14-rc1)
> > > added a new flag MFD_HUGETLB to memfd_create() that specify the fil=
e
> > > to be created resides in the hugetlbfs filesystem.  This is the
> > > generic hugetlbfs filesystem not associated with any specific mount
> > > point.
> >=20
> > How do you know and/or control what size huge pages are used,
> > when the platform supports many sizes ?
>=20
> From linux commit message:
> "As with other system calls that request hugetlbfs backed pages, there =
is
> the ability to encode huge page size in the flag arguments."
>=20
> I didn't add this option to memfd backend, as I don't know how generall=
y
> useful that is, and if there is already a similar option in qemu (proba=
bly
> not?). It could be easily added later.

For the existing  memory-backend-file, libvirt controls hugepage size
based on what's requested in guest XML. So if we were to support the
new memory-backend-memfd as an alternative, I think we need to be able
to choose huge page size for that too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
