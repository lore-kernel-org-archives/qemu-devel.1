Received: from eggs.gnu.org ([2001:4830:134:3::10]:58535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evT3y-0002qw-Ep
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evT3u-00009M-HO
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:24:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evT3u-00008u-CS
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:24:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1D7976FB9
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 19:24:45 +0000 (UTC)
Date: Mon, 12 Mar 2018 19:24:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312192442.GC15677@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180312185503.5746-1-ehabkost@redhat.com>
	<20180312185503.5746-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312185503.5746-3-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qmp.py: Encode json data before sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Mon, Mar 12, 2018 at 03:55:02PM -0300, Eduardo Habkost wrote:
> On Python 3, json.dumps() return a str object, which can't be
> sent directly through a socket and must be encoded into a bytes
> object.  Use .encode('utf-8'), which will work on both Python 2
> and Python 3.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qmp.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 07c9632e9e..5c8cf6a056 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -166,7 +166,7 @@ class QEMUMonitorProtocol(object):
>          """
>          self.logger.debug(">>> %s", qmp_cmd)
>          try:
> -            self.__sock.sendall(json.dumps(qmp_cmd))
> +            self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
>          except socket.error as err:
>              if err[0] =3D=3D errno.EPIPE:
>                  return

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
