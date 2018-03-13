Received: from eggs.gnu.org ([2001:4830:134:3::10]:60673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evmfK-0003OQ-3K
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evmfI-0005xL-UH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:20:42 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:45719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evmfI-0005wa-NX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:20:40 -0400
Received: by mail-ot0-x231.google.com with SMTP id w12-v6so160850ote.12
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 09:20:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312201305.16972-1-berrange@redhat.com>
References: <20180312201305.16972-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 16:20:19 +0000
Message-ID: <CAFEAcA-AHbzvbaxNeMRakB-gA_w3ZnD1x50dLx_hD+3-L9yuTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/9] Socket next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 12 March 2018 at 20:12, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> The following changes since commit 819fd4699c7b36d574292bcbd8bc25e9d716c8=
4b:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0309a' into staging (2018-03-12 13:21:53 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/socket-next-pull-request
>
> for you to fetch changes up to f4d2a296de2ccf5ff80ddd343c09f0075d10583a:
>
>   char: allow passing pre-opened socket file descriptor at startup (2018-=
03-12 17:50:52 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (9):
>   char: don't silently skip tn3270 protocol init when TLS is enabled
>   cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int
>     types
>   sockets: pull code for testing IP availability out of specific test
>   sockets: strengthen test suite IP protocol availability checks
>   sockets: move fd_is_socket() into common sockets code
>   sockets: check that the named file descriptor is a socket
>   sockets: allow SocketAddress 'fd' to reference numeric file
>     descriptors
>   char: refactor parsing of socket address information
>   char: allow passing pre-opened socket file descriptor at startup
>

Test failure, 32-bit arm:

MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
gtester -k --verbose -m=3Dquick tests/test-c
utils
TEST: tests/test-cutils... (pid=3D21029)
  /cutils/parse_uint/null:                                             OK
[etc]
  /cutils/parse_uint_full/trailing:                                    **
ERROR:/home/peter.maydell/qemu/tests/test-cutils.c:715:test_qemu_strtoui_un=
derflow:
assertion failed (err =3D
=3D -ERANGE): (0 =3D=3D -34)
OK
  /cutils/parse_uint_full/correct:                                     OK

Test failure, x86-64 Linux:

TEST: tests/boot-serial-test... (pid=3D11205)
  /sparc64/boot-serial/sun4u:                                          **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-serial-test.c:137:ch=
eck_guest_output:
assertion failed: (output_ok)
FAIL
GTester: last random seed: R02S99166ae475faeb3280608eeed6d61c4f
(pid=3D15216)

Test failure, 64-bit arm:

ERROR:/home/pm215/qemu/tests/test-aio-multithread.c:365:test_multi_fair_mut=
ex:
assertion failed (counter =3D=3D
 atomic_counter): (59827 =3D=3D 59828)

thanks
-- PMM
