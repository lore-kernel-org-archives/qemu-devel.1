Received: from eggs.gnu.org ([2001:4830:134:3::10]:35969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZJfo-0003bb-Dx
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZJfl-0004HV-Gx
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:00:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZJfl-0004EC-9E
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:00:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80CE480F84
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:00:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
	<20181216140902.23986-8-marcandre.lureau@redhat.com>
Date: Tue, 18 Dec 2018 19:00:43 +0100
In-Reply-To: <20181216140902.23986-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sun, 16 Dec 2018 18:08:56 +0400")
Message-ID: <87sgyud8ac.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/13] qapi: make s390 commands depend on
 TARGET_S390X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> ---
[...]
> diff --git a/qapi/target.json b/qapi/target.json
> index f277b69a2a..d751e1623a 100644
> --- a/qapi/target.json
> +++ b/qapi/target.json
> @@ -7,6 +7,8 @@
>=20=20
>  { 'pragma': { 'top-unit': 'target' } }
>=20=20
> +{ 'include': 'misc.json' }
> +

misc.json is a bit of a kitchen sink.  I'd prefer not to include it
here, but instead factor out the bits we actually need into a new .json.
I suspect that would be an improvement all by itself.

>  ##
>  # @rtc-reset-reinjection:
>  #
[...]
