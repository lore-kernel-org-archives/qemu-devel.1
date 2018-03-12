Received: from eggs.gnu.org ([2001:4830:134:3::10]:58450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evT3m-0002hr-QF
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evT3i-0008TB-Ve
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:24:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evT3i-0008St-QM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:24:34 -0400
Date: Mon, 12 Mar 2018 19:24:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312192421.GB15677@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180312185503.5746-1-ehabkost@redhat.com>
	<20180312185503.5746-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312185503.5746-2-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu.py: Use items() instead of
 iteritems()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

On Mon, Mar 12, 2018 at 03:55:01PM -0300, Eduardo Habkost wrote:
> items() is less efficient on Python 2.x, but makes the code work
> on both Python 2 and Python 3.
>=20
> Cc: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qemu.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 305a946562..08a3e9af5a 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -277,7 +277,7 @@ class QEMUMachine(object):
>      def qmp(self, cmd, conv_keys=3DTrue, **args):
>          '''Invoke a QMP command and return the response dict'''
>          qmp_args =3D dict()
> -        for key, value in args.iteritems():
> +        for key, value in args.items():
>              if conv_keys:
>                  qmp_args[key.replace('_', '-')] =3D value
>              else:

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
