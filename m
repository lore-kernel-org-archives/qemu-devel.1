Received: from eggs.gnu.org ([209.51.188.92]:40818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h3B7r-0000zj-2e
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 22:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h3B7p-0004EV-U0
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 22:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h3B7p-0004D7-No
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 22:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A2A6308219C
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 02:57:11 +0000 (UTC)
Date: Mon, 11 Mar 2019 10:57:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190311025705.GD16479@xz-x1>
References: <20190308160731.23312-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308160731.23312-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix small leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Mar 08, 2019 at 05:07:31PM +0100, Marc-Andr=C3=A9 Lureau wrote:

[...]

> diff --git a/migration/socket.c b/migration/socket.c
> index 239527fb1f..49bacf78fd 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -199,6 +199,7 @@ static void socket_start_incoming_migration(SocketA=
ddress *saddr,
>              return;
>          }
>          migrate_add_address(address);
> +        qapi_free_SocketAddress(address);

Or just don't clone in migrate_add_address()?  Either way:

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

--=20
Peter Xu
