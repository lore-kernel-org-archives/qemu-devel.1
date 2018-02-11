Received: from eggs.gnu.org ([2001:4830:134:3::10]:57643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekizd-0005WE-EP
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 23:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekizc-0006CS-GU
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 23:11:57 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:38424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekizc-00068M-Bo
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 23:11:56 -0500
Received: by mail-yw0-x241.google.com with SMTP id m84so7849952ywd.5
	for <qemu-devel@nongnu.org>; Sat, 10 Feb 2018 20:11:55 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20180211004013.10784-2-eblake@redhat.com>
References: <20180211004013.10784-1-eblake@redhat.com>
	<20180211004013.10784-2-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Sun, 11 Feb 2018 01:11:54 -0300
Message-ID: <CAAdtpL74zvDEU8XFNQCG8=fxRvmQAuJucmxv1DMYCsyK29Oucg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: Pass '-u' when doing non-silent
 diff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Sat, Feb 10, 2018 at 9:40 PM, Eric Blake <eblake@redhat.com> wrote:
> Ed-script diffs are awful compared to context diffs.  Fix another
> 'diff -q' while in the area (if the files are different, being
> noisy makes it easier to diagnose why).
>
> Fixes: 46ec4fce
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  tests/Makefile.include | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f41da235aef..375f31b5bc0 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -919,14 +919,14 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): che=
ck-%.json: $(SRC_PATH)/%.json
>                 $^ >$*.test.out 2>$*.test.err; \
>                 echo $$? >$*.test.exit, \
>                 "TEST","$*.out")
> -       @diff $(SRC_PATH)/$*.out $*.test.out
> +       @diff -u $(SRC_PATH)/$*.out $*.test.out
>         @# Sanitize error messages (make them independent of build direct=
ory)
> -       @perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff $(SRC_PATH=
)/$*.err -
> -       @diff $(SRC_PATH)/$*.exit $*.test.exit
> +       @perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -u $(SRC_P=
ATH)/$*.err -
> +       @diff -u $(SRC_PATH)/$*.exit $*.test.exit
>
>  .PHONY: check-tests/qapi-schema/doc-good.texi
>  check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.t=
exi
> -       @diff -q $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
> +       @diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
>
>  # Consolidated targets
>
> --
> 2.14.3
>
>
