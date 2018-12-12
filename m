Received: from eggs.gnu.org ([2001:4830:134:3::10]:41680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gX7BS-0003Fq-3m
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gX7BK-0002V4-Br
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:16:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gX7BJ-0002Sp-US
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:16:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F1962D7E3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 16:16:15 +0000 (UTC)
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <afe4f7e1-bc43-b384-a05d-678c78f65f3a@redhat.com>
Date: Wed, 12 Dec 2018 10:16:13 -0600
MIME-Version: 1.0
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/54] Misc patches for 2018-12-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

On 12/12/18 9:22 AM, Paolo Bonzini wrote:
> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af42=
2086:
>=20
>    Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pul=
l-request' into staging (2018-12-11 19:18:58 +0000)
>=20
> are available in the git repository at:
>=20
>=20
>    git://github.com/bonzini/qemu.git tags/for-upstream
>=20
> for you to fetch changes up to e2a9129b491fdb3be3661baf08a9fa4c2e19a028=
:
>=20
>    vhost-user-test: create a temporary directory per TestServer (2018-1=
2-12 13:49:31 +0100)
>=20
> This introduces a new dependency on perl's Test::Harness package.  This=
 is
> distributed in package perl-Test-Harness for Fedora, and libtest-harnes=
s-perl
> for Debian.  I couldn't find anything for BSD or macOS, but at least th=
e
> Patchew BSD images already have it so it is probably bundled with Perl.

> * add explicit checks for the compiler version and cleanup (Thomas)

Thomas sent a separate pull request for these. Git will probably do the=20
right thing if the two pull requests have identical commits, but I=20
didn't check if there were any minor variations in patch contents that=20
would cause a conflict.


> Marc-Andr=C3=A9 Lureau (5):
>        vhost-user-bridge: fix "unknown type name" compilation error
>        build-sys: don't include windows.h, osdep.h does it
>        build-sys: move windows defines in osdep.h header
>        build-sys: build with Vista API by default
>        RFC: qga: drop < Vista compatibility

As Dan pointed out, removing the RFC from the commit title would require=20
a v2 spin of the pull request - if you send a v2, then you can also sort=20
out whether to include the minimum compiler version patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
