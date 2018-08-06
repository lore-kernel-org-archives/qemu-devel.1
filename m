Received: from eggs.gnu.org ([2001:4830:134:3::10]:50172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmiqH-0008J3-Q9
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmiqE-0001qc-II
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:58:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fmiqE-0001qG-D6
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:58:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96C4587A76
	for <qemu-devel@nongnu.org>; Mon,  6 Aug 2018 16:58:45 +0000 (UTC)
References: <20180718120334.27138-1-berrange@redhat.com>
	<20180718120334.27138-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21544428-4494-da5c-41c6-e72056db2bca@redhat.com>
Date: Mon, 6 Aug 2018 11:58:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180718120334.27138-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] crypto: require gnutls >= 3.1.18 for
 building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 07/18/2018 07:03 AM, Daniel P. Berrang=C3=A9 wrote:
> gnutls 3.0.0 was released in 2011 and all the distros that are build
> target platforms for QEMU [1] include it:
>=20
>    RHEL-7: 3.1.18
>    Debian (Stretch): 3.5.8
>    Debian (Jessie): 3.3.8
>    OpenBSD (ports): 3.5.18
>    FreeBSD (ports): 3.5.18
>    OpenSUSE Leap 15: 3.6.2
>    Ubuntu (Xenial): 3.4.10
>    macOS (Homebrew): 3.5.19
>=20
> Based on this, it is reasonable to require gnutls >=3D 3.1.18 in QEMU
> which allows for all conditional version checks in the code to be
> removed.

Looks reasonable.

>=20
> [1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platform=
s
>=20

Any chance we can get http builds of the docs hosted directly on=20
qemu.org someday?  But unrelated to your patch.

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
> @@ -2675,79 +2674,28 @@ fi
>   ##########################################
>   # GNUTLS probe
>  =20
> -gnutls_works() {
> -    # Unfortunately some distros have bad pkg-config information for g=
nutls
> -    # such that it claims to exist but you get a compiler error if you=
 try
> -    # to use the options returned by --libs. Specifically, Ubuntu for =
--static
> -    # builds doesn't work:
> -    # https://bugs.launchpad.net/ubuntu/+source/gnutls26/+bug/1478035

This bug is still in state NEW, but targets Ubuntu 14.04 and "Package:=20
libgnutls-dev 2.12.23-12ubuntu2.2", so is probably indeed old enough=20
that it is hopefully a non-issue for gnutls > 3 in the versions of=20
Ubuntu we specifically support. However, I'm not enough of an Ubuntu=20
user myself to confirm whether things still work, so you'll probably=20
want to collect additional R-b or Tested-by before accepting this for=20
qemu 3.1.

Everything else looks clean to me, so

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
