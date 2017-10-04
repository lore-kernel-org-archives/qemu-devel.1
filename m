Received: from eggs.gnu.org ([2001:4830:134:3::10]:33349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhWo-0005kH-GP
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhWm-0004v1-TI
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:07:50 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:51844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzhWm-0004uR-N2
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:07:48 -0400
Received: by mail-oi0-x243.google.com with SMTP id n82so18926361oib.8
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 04:07:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-12-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-12-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 13:07:46 +0200
Message-ID: <CAJ+F1CJ+La6tJHyzc4f1A4UqO_q_TYBKY1Ski=mq7YW164mD7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 11/32] qapi: Drop the options to
 generate only .c or .h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi-commands.py   |  4 ++--
>  scripts/qapi-event.py      |  4 ++--
>  scripts/qapi-introspect.py |  4 ++--
>  scripts/qapi-types.py      |  4 ++--
>  scripts/qapi-visit.py      |  4 ++--
>  scripts/qapi.py            | 25 ++++---------------------
>  6 files changed, 14 insertions(+), 31 deletions(-)
>
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index 974d0a4a80..56a1009564 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -253,7 +253,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>          self._regy +=3D gen_register_command(name, success_response)
>
>
> -(input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command_lin=
e()
> +(input_file, output_dir, prefix, opts) =3D parse_command_line()
>
>  c_comment =3D '''
>  /*
> @@ -284,7 +284,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> +(fdef, fdecl) =3D open_output(output_dir, prefix,
>                              'qmp-marshal.c', 'qmp-commands.h',
>                              c_comment, h_comment)
>
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index 07b4b70199..0a308e6b69 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -169,7 +169,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self._event_names.append(name)
>
>
> -(input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_li=
ne()
> +(input_file, output_dir, prefix, dummy) =3D parse_command_line()
>
>  c_comment =3D '''
>  /*
> @@ -200,7 +200,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> +(fdef, fdecl) =3D open_output(output_dir, prefix,
>                              'qapi-event.c', 'qapi-event.h',
>                              c_comment, h_comment)
>
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index 032bcea491..c2e46182c8 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -169,7 +169,7 @@ const char %(c_name)s[] =3D %(c_string)s;
>  # We normally mask them, because they're not QMP wire ABI
>  opt_unmask =3D False
>
> -(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> +(input_file, output_dir, prefix, opts) =3D \
>      parse_command_line('u', ['unmask-non-abi-names'])
>
>  for o, a in opts:
> @@ -199,7 +199,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> +(fdef, fdecl) =3D open_output(output_dir, prefix,
>                              'qmp-introspect.c', 'qmp-introspect.h',
>                              c_comment, h_comment)
>
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index 7e3051dbb9..dc7dd08512 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -243,7 +243,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>  # QAPISchemaGenTypeVisitor.visit_end().
>  do_builtins =3D False
>
> -(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> +(input_file, output_dir, prefix, opts) =3D \
>      parse_command_line('b', ['builtins'])
>
>  for o, a in opts:
> @@ -280,7 +280,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> +(fdef, fdecl) =3D open_output(output_dir, prefix,
>                              'qapi-types.c', 'qapi-types.h',
>                              c_comment, h_comment)
>
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index 7e1cfc13f0..9757911d2d 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -327,7 +327,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>  # QAPISchemaGenVisitVisitor.visit_end().
>  do_builtins =3D False
>
> -(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> +(input_file, output_dir, prefix, opts) =3D \
>      parse_command_line('b', ['builtins'])
>
>  for o, a in opts:
> @@ -363,7 +363,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> +(fdef, fdecl) =3D open_output(output_dir, prefix,
>                              'qapi-visit.c', 'qapi-visit.h',
>                              c_comment, h_comment)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 8f9c5666bd..5434987108 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1931,8 +1931,6 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
>
>      output_dir =3D ''
>      prefix =3D ''
> -    do_c =3D False
> -    do_h =3D False
>      extra_opts =3D []
>
>      for oa in opts:
> @@ -1947,30 +1945,22 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
>              prefix =3D a
>          elif o in ('-o', '--output-dir'):
>              output_dir =3D a + '/'
> -        elif o in ('-c', '--source'):
> -            do_c =3D True
> -        elif o in ('-h', '--header'):
> -            do_h =3D True
>          else:
>              extra_opts.append(oa)
>
> -    if not do_c and not do_h:
> -        do_c =3D True
> -        do_h =3D True
> -
>      if len(args) !=3D 1:
>          print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0=
]
>          sys.exit(1)
>      fname =3D args[0]
>
> -    return (fname, output_dir, do_c, do_h, prefix, extra_opts)
> +    return (fname, output_dir, prefix, extra_opts)
>
>  #
>  # Generate output files with boilerplate
>  #
>
>
> -def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
> +def open_output(output_dir, prefix, c_file, h_file,
>                  c_comment, h_comment):
>      guard =3D guardname(prefix + h_file)
>      c_file =3D output_dir + prefix + c_file
> @@ -1983,15 +1973,8 @@ def open_output(output_dir, do_c, do_h, prefix, c_=
file, h_file,
>              if e.errno !=3D errno.EEXIST:
>                  raise
>
> -    def maybe_open(really, name, opt):
> -        if really:
> -            return open(name, opt)
> -        else:
> -            import StringIO
> -            return StringIO.StringIO()
> -
> -    fdef =3D maybe_open(do_c, c_file, 'w')
> -    fdecl =3D maybe_open(do_h, h_file, 'w')
> +    fdef =3D open(c_file, 'w')
> +    fdecl =3D open(h_file, 'w')
>
>      fdef.write(mcgen('''
>  /* AUTOMATICALLY GENERATED, DO NOT MODIFY */
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
