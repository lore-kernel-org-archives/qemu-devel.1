Received: from eggs.gnu.org ([2001:4830:134:3::10]:39379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVdo0-0007uj-T7
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVdnw-0005j0-5Q
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:09:52 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:40595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVdnv-0005ip-Sb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:09:48 -0400
Received: by mail-wm0-x234.google.com with SMTP id n5-v6so7168639wmc.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:09:47 -0700 (PDT)
References: <20180619154435.18898-1-alex.bennee@linaro.org>
	<CAFEAcA-4=X-ag+v56_C4PoYe17DHVgawKAdw7D5v1k=rmFwL3A@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-4=X-ag+v56_C4PoYe17DHVgawKAdw7D5v1k=rmFwL3A@mail.gmail.com>
Date: Wed, 20 Jun 2018 15:09:45 +0100
Message-ID: <87sh5hv9au.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/56] add check-tcg and associated machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 19 June 2018 at 16:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799=
fa2:
>>
>>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-201=
80615a' into staging (2018-06-15 18:13:35 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-tcg-testing-revivial-190=
618-1
>>
>> for you to fetch changes up to 03c79cb5825f2e930a39839e8375dc0feef6d57d:
>>
>>   .travis.yml: add check-tcg test (2018-06-19 16:38:54 +0100)
>>
>> ----------------------------------------------------------------
>> Add check-tcg machinary
>>
>> This restores the ability to run TCG smoke tests by using our docker
>> infrastructure to support cross building simple tests. It represents
>> the first step to making better cross-architecture testing available
>> straight from the source tree ;-)
>>
>> ----------------------------------------------------------------
>
> On x86-64/Linux I get:
>
> Doing build and test cycle...
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all=
dbg'
> Traceback (most recent call last):
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 523, in <module>
>     sys.exit(main())
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 520, in main
>     return args.cmdobj.run(args, argv)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 475, in run
>     dkr =3D Docker()
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 137, in __init__
>     self._command =3D _guess_docker_command()
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 62, in _guess_docker_command
>     commands_txt)
> Exception: Cannot find working docker command. Tried:
>   docker
>   sudo -n docker
> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/alld=
bg'
> make: *** Deleting file 'config-host.mak'
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all=
dbg'
> config-host.mak is out-of-date, running configure
> Traceback (most recent call last):
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 29, in <module>
>     from StringIO import StringIO
> ImportError: No module named 'StringIO'
> Install prefix    /usr/local
> BIOS directory    /usr/local/share/qemu
> firmware path     /usr/local/share/qemu-firmware
> [other configure output trimmed]
> VxHS block device no
> capstone          git
> docker

Hmm I'm sure I tested this. I'll go and find a box without docker to
double check.

>
> ERROR: configure test passed without -Werror but failed with -Werror.
>        This is probably a bug in the configure script. The failing command
>        will be at the bottom of config.log.
>        You can run configure with --disable-werror to bypass this check.
>
> Makefile:73: recipe for target 'config-host.mak' failed
> make: *** [config-host.mak] Error 1
>
> and the last part of config.log is
>
> =3D=3D=3D=3D=3D=3D
> ccache gcc -Werror -pthread -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
> -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -fstack-protector-strong -I/usr/include/p11-kit-1
> -I/usr/include/libpng12 -I/usr/include/spice-server
> -I/usr/include/spice-1 -I$(SRC_PATH)/capstone/include -c -o
> config-temp/qemu-conf.o config-temp/qemu-conf.c
> c++ -D__STDC_LIMIT_MACROS -Werror -pthread -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wall -Wundef
> -Wwrite-strings -fno-strict-aliasing -fno-common -fwrapv
> -Wendif-labels -Wno-missing-include-dirs -Wempty-body
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wtype-limits -fstack-protector-strong -I/usr/include/p11-kit-1
> -I/usr/include/libpng12 -I/usr/include/spice-server
> -I/usr/include/spice-1 -I$(SRC_PATH)/capstone/include -o
> config-temp/qemu-conf.exe config-temp/qemu-conf.cxx
> config-temp/qemu-conf.o -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie
> -m64 -g
> aarch64-linux-gnu-gcc -o config-temp/qemu-conf.exe
> config-temp/qemu-conf.c -static
> aarch64-linux-gnu-gcc -Werror -o config-temp/qemu-conf.exe
> config-temp/qemu-conf.c -static
> arm-linux-gnueabihf-gcc -o config-temp/qemu-conf.exe
> config-temp/qemu-conf.c -static
> arm-linux-gnueabihf-gcc -Werror -o config-temp/qemu-conf.exe
> config-temp/qemu-conf.c -static
> powerpc-linux-gnu-gcc -o config-temp/qemu-conf.exe
> config-temp/qemu-conf.c -static
> powerpc-linux-gnu-gcc -Werror -o config-temp/qemu-conf.exe
> config-temp/qemu-conf.c -static
> ccache gcc -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static
> ccache -Werror gcc -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -=
static
> ccache: invalid option -- 'W'
> Usage:
>     ccache [options]
>     ccache compiler [compiler options]
>     compiler [compiler options]          (via symbolic link)
>
> Options:
>     -c, --cleanup         delete old files and recalculate size counters
>                           (normally not needed as this is done automatica=
lly)
>     -C, --clear           clear the cache completely (except configuratio=
n)
>     -F, --max-files=3DN     set maximum number of files in cache to N (us=
e 0 for
>                           no limit)
>     -M, --max-size=3DSIZE   set maximum size of cache to SIZE (use 0 for =
no
>                           limit); available suffixes: k, M, G, T (decimal=
) and
>                           Ki, Mi, Gi, Ti (binary); default suffix: G
>     -o, --set-config=3DK=3DV  set configuration key K to value V
>     -p, --print-config    print current configuration options
>     -s, --show-stats      show statistics summary
>     -z, --zero-stats      zero statistics counters
>
>     -h, --help            print this help text
>     -V, --version         print version and copyright information
>
> See also <http://ccache.samba.org>.
> =3D=3D=3D=3D=3D=3D
>
> The configure options for this build are
> '--cc=3Dccache gcc' '--enable-debug' '--python=3Dpython3'
>
> Looks like something is mishandling CC.
>
> On FreeBSD I get an odd linker error:
>
>   LINK    qemu-ga
> /usr/bin/ld: cannot open linker script file ../config-host.ld: No such
> file or directory
> c++: error: linker command failed with exit code 1 (use -v to see invocat=
ion)
> gmake: *** [Makefile:688: qemu-ga] Error 1
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
