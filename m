Received: from eggs.gnu.org ([2001:4830:134:3::10]:47517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0OCd-0003OW-GN
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0OCX-0000iA-8U
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:14:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f0OCX-0000gJ-2s
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:14:01 -0400
Received: by mail-it0-f66.google.com with SMTP id e98-v6so9808039itd.4
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 02:14:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-6-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-6-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 11:13:59 +0200
Message-ID: <CAMxuvawap7Uu-3km0dHZhhoaCSZVOOET8QT2L_R=82WKo96ikQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 5/8] tests: let qapi-schema tests
 detect oob
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Mar 26, 2018 at 8:38 AM, Peter Xu <peterx@redhat.com> wrote:
> The allow_oob parameter was passed in but not used in tests.  Now
> reflect that in the tests, so we need to touch up other command testers
> with that new change.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/qapi-schema/doc-good.out          |  4 ++--
>  tests/qapi-schema/ident-with-escape.out |  2 +-
>  tests/qapi-schema/indented-expr.out     |  4 ++--
>  tests/qapi-schema/qapi-schema-test.out  | 18 +++++++++---------
>  tests/qapi-schema/test-qapi.py          |  4 ++--
>  5 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
> index 430b5a87db..63058b1590 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -28,9 +28,9 @@ object q_obj_cmd-arg
>      member arg2: str optional=3DTrue
>      member arg3: bool optional=3DFalse
>  command cmd q_obj_cmd-arg -> Object
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
>  command cmd-boxed Object -> None
> -   gen=3DTrue success_response=3DTrue boxed=3DTrue
> +   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse
>  doc freeform
>      body=3D
>  =3D Section
> diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
> index ee3b34e623..82213aa51d 100644
> --- a/tests/qapi-schema/ident-with-escape.out
> +++ b/tests/qapi-schema/ident-with-escape.out
> @@ -5,4 +5,4 @@ module ident-with-escape.json
>  object q_obj_fooA-arg
>      member bar1: str optional=3DFalse
>  command fooA q_obj_fooA-arg -> None
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
> diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
> index a79935e8c3..862678f8f4 100644
> --- a/tests/qapi-schema/indented-expr.out
> +++ b/tests/qapi-schema/indented-expr.out
> @@ -3,6 +3,6 @@ enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', =
'qlist', 'qbool']
>      prefix QTYPE
>  module indented-expr.json
>  command eins None -> None
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
>  command zwei None -> None
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
> index 012e7fc06a..4f43370017 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -16,7 +16,7 @@ object Empty1
>  object Empty2
>      base Empty1
>  command user_def_cmd0 Empty2 -> Empty2
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
>  enum QEnumTwo ['value1', 'value2']
>      prefix QENUM_TWO
>  object UserDefOne
> @@ -143,29 +143,29 @@ object UserDefNativeListUnion
>      case sizes: q_obj_sizeList-wrapper
>      case any: q_obj_anyList-wrapper
>  command user_def_cmd None -> None
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
>  object q_obj_user_def_cmd1-arg
>      member ud1a: UserDefOne optional=3DFalse
>  command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
>  object q_obj_user_def_cmd2-arg
>      member ud1a: UserDefOne optional=3DFalse
>      member ud1b: UserDefOne optional=3DTrue
>  command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
>  object q_obj_guest-get-time-arg
>      member a: int optional=3DFalse
>      member b: int optional=3DTrue
>  command guest-get-time q_obj_guest-get-time-arg -> int
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
>  object q_obj_guest-sync-arg
>      member arg: any optional=3DFalse
>  command guest-sync q_obj_guest-sync-arg -> any
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
>  command boxed-struct UserDefZero -> None
> -   gen=3DTrue success_response=3DTrue boxed=3DTrue
> +   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse
>  command boxed-union UserDefNativeListUnion -> None
> -   gen=3DTrue success_response=3DTrue boxed=3DTrue
> +   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse
>  object UserDefOptions
>      member i64: intList optional=3DTrue
>      member u64: uint64List optional=3DTrue
> @@ -229,4 +229,4 @@ object q_obj___org.qemu_x-command-arg
>      member c: __org.qemu_x-Union2 optional=3DFalse
>      member d: __org.qemu_x-Alt optional=3DFalse
>  command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qem=
u_x-Union1
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index 10e68b01d9..c1a144ba29 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -45,8 +45,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>                        gen, success_response, boxed, allow_oob):
>          print('command %s %s -> %s' % \
>                (name, arg_type and arg_type.name, ret_type and ret_type.n=
ame))
> -        print('   gen=3D%s success_response=3D%s boxed=3D%s' % \
> -              (gen, success_response, boxed))
> +        print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s' % =
\
> +              (gen, success_response, boxed, allow_oob))
>
>      def visit_event(self, name, info, arg_type, boxed):
>          print('event %s %s' % (name, arg_type and arg_type.name))
> --
> 2.14.3
>
