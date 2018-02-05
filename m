Received: from eggs.gnu.org ([2001:4830:134:3::10]:52173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih4j-0008Ux-4e
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih4e-0002Nq-SB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:49 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:40818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih4e-0002Mu-Mh
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:44 -0500
Received: by mail-qk0-f176.google.com with SMTP id d18so32559247qke.7
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:44:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-3-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-3-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:44:43 +0100
Message-ID: <CAMxuvaw1-UtqTSYX1nD8Sh7ypaVv0kXcF3X0K0aw-_ci0d58nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 02/21] qapi: Generate up-to-date
 copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>, mdroth@linux.vnet.ibm.com

Hi

On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Each generator carries a copyright notice for the generator itself,
> and another one for the files it generates.  Only the former have been
> updated along the way, the latter have not, and are all out of date.
>
> Fix by copying the generator's copyright notice to the generated files
> instead.

That makes sense, but we loose the Author lines in the generated
files. Not a big deal I guess, but worth to point out, no?

>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Other than that,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi-commands.py   | 34 +++++++++++++++-------------------
>  scripts/qapi-event.py      | 32 ++++++++++++++------------------
>  scripts/qapi-introspect.py | 25 ++++++++++++-------------
>  scripts/qapi-types.py      | 32 ++++++++++++++------------------
>  scripts/qapi-visit.py      | 34 +++++++++++++++-------------------
>  scripts/qapi.py            |  7 +++++--
>  6 files changed, 75 insertions(+), 89 deletions(-)
>
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index 25ac52503a..a861ac52e7 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -1,16 +1,17 @@
> -#
> -# QAPI command marshaller generator
> -#
> -# Copyright IBM, Corp. 2011
> -# Copyright (C) 2014-2016 Red Hat, Inc.
> -#
> -# Authors:
> -#  Anthony Liguori <aliguori@us.ibm.com>
> -#  Michael Roth    <mdroth@linux.vnet.ibm.com>
> -#  Markus Armbruster <armbru@redhat.com>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2.
> -# See the COPYING file in the top-level directory.
> +"""
> +QAPI command marshaller generator
> +
> +Copyright IBM, Corp. 2011
> +Copyright (C) 2014-2018 Red Hat, Inc.
> +
> +Authors:
> + Anthony Liguori <aliguori@us.ibm.com>
> + Michael Roth <mdroth@linux.vnet.ibm.com>
> + Markus Armbruster <armbru@redhat.com>
> +
> +This work is licensed under the terms of the GNU GPL, version 2.
> +See the COPYING file in the top-level directory.
> +"""
>
>  from qapi import *
>
> @@ -257,16 +258,11 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor=
):
>
>  blurb =3D '''
>   * Schema-defined QAPI/QMP commands
> - *
> - * Copyright IBM, Corp. 2011
> - *
> - * Authors:
> - *  Anthony Liguori   <aliguori@us.ibm.com>
>  '''
>
>  (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
>                              'qmp-marshal.c', 'qmp-commands.h',
> -                            blurb)
> +                            blurb, __doc__)
>
>  fdef.write(mcgen('''
>
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index 31faedc689..b1d611c5ea 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -1,15 +1,16 @@
> -#
> -# QAPI event generator
> -#
> -# Copyright (c) 2014 Wenchao Xia
> -# Copyright (c) 2015-2016 Red Hat Inc.
> -#
> -# Authors:
> -#  Wenchao Xia <wenchaoqemu@gmail.com>
> -#  Markus Armbruster <armbru@redhat.com>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2.
> -# See the COPYING file in the top-level directory.
> +"""
> +QAPI event generator
> +
> +Copyright (c) 2014 Wenchao Xia
> +Copyright (c) 2015-2018 Red Hat Inc.
> +
> +Authors:
> + Wenchao Xia <wenchaoqemu@gmail.com>
> + Markus Armbruster <armbru@redhat.com>
> +
> +This work is licensed under the terms of the GNU GPL, version 2.
> +See the COPYING file in the top-level directory.
> +"""
>
>  from qapi import *
>
> @@ -173,16 +174,11 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>
>  blurb =3D '''
>   * Schema-defined QAPI/QMP events
> - *
> - * Copyright (c) 2014 Wenchao Xia
> - *
> - * Authors:
> - *  Wenchao Xia   <wenchaoqemu@gmail.com>
>  '''
>
>  (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
>                              'qapi-event.c', 'qapi-event.h',
> -                            blurb)
> +                            blurb, __doc__)
>
>  fdef.write(mcgen('''
>  #include "qemu/osdep.h"
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index 83da2bdb94..bd9253a172 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -1,13 +1,14 @@
> -#
> -# QAPI introspection generator
> -#
> -# Copyright (C) 2015-2016 Red Hat, Inc.
> -#
> -# Authors:
> -#  Markus Armbruster <armbru@redhat.com>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2.
> -# See the COPYING file in the top-level directory.
> +"""
> +QAPI introspection generator
> +
> +Copyright (C) 2015-2018 Red Hat, Inc.
> +
> +Authors:
> + Markus Armbruster <armbru@redhat.com>
> +
> +This work is licensed under the terms of the GNU GPL, version 2.
> +See the COPYING file in the top-level directory.
> +"""
>
>  from qapi import *
>
> @@ -178,13 +179,11 @@ for o, a in opts:
>
>  blurb =3D '''
>   * QAPI/QMP schema introspection
> - *
> - * Copyright (C) 2015 Red Hat, Inc.
>  '''
>
>  (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
>                              'qmp-introspect.c', 'qmp-introspect.h',
> -                            blurb)
> +                            blurb, __doc__)
>
>  fdef.write(mcgen('''
>  #include "qemu/osdep.h"
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index 86afc57f92..1103dbda2d 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -1,15 +1,17 @@
> -#
> -# QAPI types generator
> -#
> -# Copyright IBM, Corp. 2011
> -# Copyright (c) 2013-2016 Red Hat Inc.
> -#
> -# Authors:
> -#  Anthony Liguori <aliguori@us.ibm.com>
> -#  Markus Armbruster <armbru@redhat.com>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2.
> +"""
> +QAPI types generator
> +
> +Copyright IBM, Corp. 2011
> +Copyright (c) 2013-2018 Red Hat Inc.
> +
> +Authors:
> + Anthony Liguori <aliguori@us.ibm.com>
> + Michael Roth <mdroth@linux.vnet.ibm.com>
> + Markus Armbruster <armbru@redhat.com>
> +
> +This work is licensed under the terms of the GNU GPL, version 2.
>  # See the COPYING file in the top-level directory.
> +"""
>
>  from qapi import *
>
> @@ -252,17 +254,11 @@ for o, a in opts:
>
>  blurb =3D '''
>   * Schema-defined QAPI types
> - *
> - * Copyright IBM, Corp. 2011
> - *
> - * Authors:
> - *  Anthony Liguori   <aliguori@us.ibm.com>
> - *  Michael Roth      <mdroth@linux.vnet.ibm.com>
>  '''
>
>  (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
>                              'qapi-types.c', 'qapi-types.h',
> -                            blurb)
> +                            blurb, __doc__)
>
>  fdef.write(mcgen('''
>  #include "qemu/osdep.h"
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index 9f7127e548..5231f89c36 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -1,16 +1,17 @@
> -#
> -# QAPI visitor generator
> -#
> -# Copyright IBM, Corp. 2011
> -# Copyright (C) 2014-2016 Red Hat, Inc.
> -#
> -# Authors:
> -#  Anthony Liguori <aliguori@us.ibm.com>
> -#  Michael Roth    <mdroth@linux.vnet.ibm.com>
> -#  Markus Armbruster <armbru@redhat.com>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2.
> -# See the COPYING file in the top-level directory.
> +"""
> +QAPI visitor generator
> +
> +Copyright IBM, Corp. 2011
> +Copyright (C) 2014-2018 Red Hat, Inc.
> +
> +Authors:
> + Anthony Liguori <aliguori@us.ibm.com>
> + Michael Roth    <mdroth@linux.vnet.ibm.com>
> + Markus Armbruster <armbru@redhat.com>
> +
> +This work is licensed under the terms of the GNU GPL, version 2.
> +See the COPYING file in the top-level directory.
> +"""
>
>  from qapi import *
>
> @@ -336,16 +337,11 @@ for o, a in opts:
>
>  blurb =3D '''
>   * Schema-defined QAPI visitors
> - *
> - * Copyright IBM, Corp. 2011
> - *
> - * Authors:
> - *  Anthony Liguori   <aliguori@us.ibm.com>
>  '''
>
>  (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
>                              'qapi-visit.c', 'qapi-visit.h',
> -                            blurb)
> +                            blurb, __doc__)
>
>  fdef.write(mcgen('''
>  #include "qemu/osdep.h"
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 2e4b2bc9eb..d0816f7479 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1975,21 +1975,24 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
>  #
>
>
> -def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb):
> +def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb, d=
oc):
>      guard =3D guardname(prefix + h_file)
>      c_file =3D output_dir + prefix + c_file
>      h_file =3D output_dir + prefix + h_file
> +    copyright =3D '\n * '.join(re.findall(r'^Copyright .*', doc, re.MULT=
ILINE))
>      comment =3D mcgen('''/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
>
>  /*
>  %(blurb)s
>   *
> + * %(copyright)s
> + *
>   * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
>   * See the COPYING.LIB file in the top-level directory.
>   */
>
>  ''',
> -                    blurb=3Dblurb.strip('\n'))
> +                    blurb=3Dblurb.strip('\n'), copyright=3Dcopyright)
>
>      if output_dir:
>          try:
> --
> 2.13.6
>
