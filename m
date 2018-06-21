Received: from eggs.gnu.org ([2001:4830:134:3::10]:40472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVxxw-0000bd-9m
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVxxt-0004ds-25
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:41:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVxxs-0004dh-Sm
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:41:24 -0400
Date: Thu, 21 Jun 2018 12:41:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180621114121.GJ3615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180621083551.775-1-armbru@redhat.com>
	<871sd0nzw9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871sd0nzw9.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix some pycodestyle-3 complaints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Jun 21, 2018 at 01:27:02PM +0200, Markus Armbruster wrote:
> Forgot tests/qapi-schema/test-qapi.py, as usual.  To be squashed in:
>=20
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qa=
pi.py
> index 4512a41504..abbc9c7830 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -33,8 +33,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>          if base:
>              print('    base %s' % base.name)
>          for m in members:
> -            print('    member %s: %s optional=3D%s' % \
> -                  (m.name, m.type.name, m.optional))
> +            print('    member %s: %s optional=3D%s'
> +                  % (m.name, m.type.name, m.optional))
>          self._print_variants(variants)
> =20
>      def visit_alternate_type(self, name, info, variants):
> @@ -43,10 +43,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
> =20
>      def visit_command(self, name, info, arg_type, ret_type, gen,
>                        success_response, boxed, allow_oob, allow_precon=
fig):
> -        print('command %s %s -> %s' % \
> -              (name, arg_type and arg_type.name, ret_type and ret_type=
.name))
> -        print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s p=
reconfig=3D%s' % \
> -              (gen, success_response, boxed, allow_oob, allow_preconfi=
g))
> +        print('command %s %s -> %s'
> +              % (name, arg_type and arg_type.name,
> +                 ret_type and ret_type.name))
> +        print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s p=
reconfig=3D%s'
> +              % (gen, success_response, boxed, allow_oob, allow_precon=
fig))
> =20
>      def visit_event(self, name, info, arg_type, boxed):
>          print('event %s %s' % (name, arg_type and arg_type.name))

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
