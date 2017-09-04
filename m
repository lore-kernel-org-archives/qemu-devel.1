Received: from eggs.gnu.org ([2001:4830:134:3::10]:38234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dooCf-0001aI-Cg
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dooCa-0003bH-KU
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:02:01 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dooCa-0003ar-EG
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:01:56 -0400
Received: by mail-wr0-x234.google.com with SMTP id n33so75759wrn.4
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 03:01:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 11:01:34 +0100
Message-ID: <CAFEAcA84nwAN45ApZU5ATYMQTp7cmCWT+TumZrfe-Qsiq-A_Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/47] QAPI patches for 2017-09-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 September 2017 at 16:37, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 223cd0e13f2e46078d7b573f0b8402bfbee339=
be:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/tidy-pull-request' i=
nto staging (2017-08-31 15:52:43 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-09-01-v2
>
> for you to fetch changes up to fcff1e3146d4b7930f3b4a7a60091479d6652a5f:
>
>   qapi: drop the sentinel in enum array (2017-09-01 17:26:24 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-09-01
>
> ----------------------------------------------------------------

Hi -- I get some compile issues here:

PPC:

/home/pm215/qemu/tests/qmp-test.c: In function =E2=80=98query_error_class=
=E2=80=99:
/home/pm215/qemu/tests/qmp-test.c:141:9: error: missing braces around
initializer [-Werror=3Dmissing-braces]
         "query-spice", ERROR_CLASS_COMMAND_NOT_FOUND,
         ^
/home/pm215/qemu/tests/qmp-test.c:141:9: error: (near initialization
for =E2=80=98fails[0]=E2=80=99) [-Werror=3Dmissing-braces]

S390, aarch64:

/home/linux1/qemu/tests/qmp-test.c: In function =E2=80=98query_error_class=
=E2=80=99:
/home/linux1/qemu/tests/qmp-test.c:151:9: error: missing braces around
initializer [-Werror=3Dmissing-braces]
         { "query-acpi-ospm-status", ERROR_CLASS_GENERIC_ERROR },
         ^
/home/linux1/qemu/tests/qmp-test.c:151:9: note: (near initialization
for =E2=80=98fails[1]=E2=80=99)
/home/linux1/qemu/tests/qmp-test.c:152:9: error: missing braces around
initializer [-Werror=3Dmissing-braces]
         { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
         ^
/home/linux1/qemu/tests/qmp-test.c:152:9: note: (near initialization
for =E2=80=98fails[2]=E2=80=99)
/home/linux1/qemu/tests/qmp-test.c:153:9: error: missing braces around
initializer [-Werror=3Dmissing-braces]
         { "query-hotpluggable-cpus", ERROR_CLASS_GENERIC_ERROR },
         ^
/home/linux1/qemu/tests/qmp-test.c:153:9: note: (near initialization
for =E2=80=98fails[3]=E2=80=99)
/home/linux1/qemu/tests/qmp-test.c:154:9: error: missing braces around
initializer [-Werror=3Dmissing-braces]
         { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
         ^
/home/linux1/qemu/tests/qmp-test.c:154:9: note: (near initialization
for =E2=80=98fails[4]=E2=80=99)
/home/linux1/qemu/tests/qmp-test.c:155:9: error: missing braces around
initializer [-Werror=3Dmissing-braces]
         { NULL, -1 }
         ^
/home/linux1/qemu/tests/qmp-test.c:155:9: note: (near initialization
for =E2=80=98fails[5]=E2=80=99)
/home/linux1/qemu/tests/qmp-test.c:138:17: error: missing braces
around initializer [-Werror=3Dmissing-braces]
     } fails[] =3D {
                 ^
/home/linux1/qemu/tests/qmp-test.c:138:17: note: (near initialization
for =E2=80=98fails=E2=80=99)
cc1: all warnings being treated as errors


OSX, FreeBSD, OpenBSD:

/Users/pm215/src/qemu-for-merges/tests/qmp-test.c:141:9: error:
suggest braces around initialization of subobject
[-Werror,-Wmissing-braces]
        "query-spice", ERROR_CLASS_COMMAND_NOT_FOUND,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        {                                           }

thanks
-- PMM
