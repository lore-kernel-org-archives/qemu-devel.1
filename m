Received: from eggs.gnu.org ([2001:4830:134:3::10]:57394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fhXDi-0006Ys-TW
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fhXDf-0004bh-OM
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:33:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fhXDf-0004bT-J9
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:33:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71C96814F0A3
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:33:30 +0000 (UTC)
Date: Mon, 23 Jul 2018 10:33:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180723093327.GE3397@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180720154425.31285-1-marcandre.lureau@redhat.com>
	<20180720154425.31285-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720154425.31285-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] RFC: seccomp: prefer
 SCMP_ACT_KILL_PROCESS if available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pmoore@redhat.com, Eduardo Otubo <otubo@redhat.com>

On Fri, Jul 20, 2018 at 05:44:25PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> The upcoming libseccomp release should have SCMP_ACT_KILL_PROCESS
> action (https://github.com/seccomp/libseccomp/issues/96).
>=20
> SCMP_ACT_KILL_PROCESS is preferable to immediately terminate the
> offending process, rather than having the SIGSYS handler running.
>=20
> Use SECCOMP_GET_ACTION_AVAIL to check availability of kernel support,
> as libseccomp will fallback on SCMP_ACT_KILL otherwise, and we still
> prefer SCMP_ACT_TRAP.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-seccomp.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)

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
