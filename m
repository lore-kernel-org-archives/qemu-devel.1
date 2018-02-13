Received: from eggs.gnu.org ([2001:4830:134:3::10]:37565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eldEY-0007bD-50
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eldEU-0003sI-W6
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:15:06 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eldEU-0003s2-QQ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:15:02 -0500
Received: by mail-qk0-f193.google.com with SMTP id i184so11985334qkf.10
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 08:15:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-30-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-30-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 13 Feb 2018 17:15:02 +0100
Message-ID: <CAMxuvayo0m6880_F+zDfy9y=iN2L78iQh7hoybC1mSqK0E6U5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 29/29] qapi: Don't create useless
 directory qapi-generated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>

On Sun, Feb 11, 2018 at 10:36 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> We used to generate first test and later QGA QAPI code into
> qapi-generated/.  Commit b93b63f574 moved the test code to tests/.
> Commit 54c2e50205 moved the QGA code to qga/qapi-generated/.  The
> directory has been unused since.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

good catch,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  .gitignore | 1 -
>  Makefile   | 1 -
>  configure  | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index dabfe6bea8..4055e12ee8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -27,7 +27,6 @@
>  /libuser
>  /linux-headers/asm
>  /qga/qapi-generated
> -/qapi-generated
>  /qapi-gen-timestamp
>  /qapi/qapi-builtin-types.[ch]
>  /qapi/qapi-builtin-visit.[ch]
> diff --git a/Makefile b/Makefile
> index 84411ee6ab..7eb1ede6f4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -726,7 +726,6 @@ clean:
>         rm -f trace/generated-tracers-dtrace.h*
>         rm -f $(foreach f,$(GENERATED_FILES),$(f) $(f)-timestamp)
>         rm -f qapi-gen-timestamp
> -       rm -rf qapi-generated
>         rm -rf qga/qapi-generated
>         for d in $(ALL_SUBDIRS); do \
>         if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
> diff --git a/configure b/configure
> index 62562f08cf..f564a1639e 100755
> --- a/configure
> +++ b/configure
> @@ -7015,7 +7015,6 @@ DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm=
32 tests/libqos tests/qapi-sche
>  DIRS=3D"$DIRS docs docs/interop fsdev scsi"
>  DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>  DIRS=3D"$DIRS roms/seabios roms/vgabios"
> -DIRS=3D"$DIRS qapi-generated"
>  FILES=3D"Makefile tests/tcg/Makefile qdict-test-data.txt"
>  FILES=3D"$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
>  FILES=3D"$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Mak=
efile"
> --
> 2.13.6
>
