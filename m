Received: from eggs.gnu.org ([2001:4830:134:3::10]:35540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL45l-0000gn-Dw
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL45i-0003tb-9X
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:55:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dL45h-0003tK-U1
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:55:54 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <149742933433.960.4827367239827382038@4a9a010726c0>
	(no-reply@patchew.org's message of "Wed, 14 Jun 2017 01:35:35 -0700
	(PDT)")
References: <149742933433.960.4827367239827382038@4a9a010726c0>
Reply-To: quintela@redhat.com
Date: Wed, 14 Jun 2017 10:55:47 +0200
Message-ID: <87bmpreyng.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix incorrect enable return path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: peterx@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, lvivier@redhat.com, dgilbert@redhat.com

no-reply@patchew.org wrote:
> Hi,

> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path =
'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-ynbw5yjp/src/dtc'...
> Submodule path 'dtc': checked out '558cd81bdd432769b59bff01240c44f82cfb1a=
9d'
>   BUILD   fedora
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-ynbw5yjp/src'
>   ARCHIVE qemu.tgz
>   ARCHIVE dtc.tgz
>   COPY    RUNNER
>     RUN test-mingw in qemu:fedora=20
> Packages installed:
> PyYAML-3.11-13.fc25.x86_64
> SDL-devel-1.2.15-21.fc24.x86_64
> bc-1.06.95-16.fc24.x86_64
> bison-3.0.4-4.fc24.x86_64
> ccache-3.3.4-1.fc25.x86_64
> clang-3.9.1-2.fc25.x86_64
> findutils-4.6.0-8.fc25.x86_64
> flex-2.6.0-3.fc25.x86_64
> gcc-6.3.1-1.fc25.x86_64

(master)$ rpm -qa gcc
gcc-6.3.1-1.fc25.x86_64

I *am* using that compiler.

> gcc-c++-6.3.1-1.fc25.x86_64
> git-2.9.3-2.fc25.x86_64
> glib2-devel-2.50.3-1.fc25.x86_64
> libfdt-devel-1.4.2-1.fc25.x86_64
> make-4.1-5.fc24.x86_64
> mingw32-SDL-1.2.15-7.fc24.noarch
> mingw32-bzip2-1.0.6-7.fc24.noarch
> mingw32-curl-7.47.0-1.fc24.noarch
> mingw32-glib2-2.50.1-1.fc25.noarch
> mingw32-gmp-6.1.1-1.fc25.noarch
> mingw32-gnutls-3.5.5-2.fc25.noarch
> mingw32-gtk2-2.24.31-2.fc25.noarch
> mingw32-gtk3-3.22.2-1.fc25.noarch
> mingw32-libjpeg-turbo-1.5.1-1.fc25.noarch
> mingw32-libpng-1.6.27-1.fc25.noarch
> mingw32-libssh2-1.4.3-5.fc24.noarch
> mingw32-libtasn1-4.9-1.fc25.noarch
> mingw32-nettle-3.3-1.fc25.noarch
> mingw32-pixman-0.34.0-1.fc25.noarch
> mingw32-pkg-config-0.28-6.fc24.x86_64
> mingw64-SDL-1.2.15-7.fc24.noarch
> mingw64-bzip2-1.0.6-7.fc24.noarch
> mingw64-curl-7.47.0-1.fc24.noarch
> mingw64-glib2-2.50.1-1.fc25.noarch
> mingw64-gmp-6.1.1-1.fc25.noarch
> mingw64-gnutls-3.5.5-2.fc25.noarch
> mingw64-gtk2-2.24.31-2.fc25.noarch
> mingw64-gtk3-3.22.2-1.fc25.noarch
> mingw64-libjpeg-turbo-1.5.1-1.fc25.noarch
> mingw64-libpng-1.6.27-1.fc25.noarch
> mingw64-libssh2-1.4.3-5.fc24.noarch
> mingw64-libtasn1-4.9-1.fc25.noarch
> mingw64-nettle-3.3-1.fc25.noarch
> mingw64-pixman-0.34.0-1.fc25.noarch
> mingw64-pkg-config-0.28-6.fc24.x86_64

Oh, it is crosscompiling for windows32/64

But it don't put what complier they are using.  For me, it also
cross-compile without warning/errors (I have lastest F25 packages).


> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition o=
f typedef =E2=80=98LoadStateHandler=E2=80=99
> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous declara=
tion of =E2=80=98LoadStateHandler=E2=80=99 was here
> make: *** [hw/net/vmxnet3.o] Error 1
> make: *** Waiting for unfinished jobs....

Patch is on list to fix this.  The problem is not on this patch.

Later, Juan.
