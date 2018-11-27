Received: from eggs.gnu.org ([2001:4830:134:3::10]:46261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRdbc-0001tV-Iv
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRdbX-00050x-Ly
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:40:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRdbX-0004zl-Gm
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:40:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27A0D308A941
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 13:40:42 +0000 (UTC)
Date: Tue, 27 Nov 2018 11:40:37 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127134037.GL18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181127092801.21777-10-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 09/28] tests:
 qdev_prop_check_globals() doesn't return "all_used"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

On Tue, Nov 27, 2018 at 01:27:42PM +0400, Marc-Andr=E9 Lureau wrote:
> Instead, it returns 1 if an error was detected, which is the case for:
>=20
> /qdev/properties/dynamic/global/subprocess:
> warning: global dynamic-prop-type-bad.prop3 has invalid class name
> warning: global nohotplug-type.prop5=3D105 not used
> warning: global nondevice-type.prop6 has invalid class name
>=20
> Clarify the function return value.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
