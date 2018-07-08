Received: from eggs.gnu.org ([2001:4830:134:3::10]:37028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fc2t0-0003rw-4K
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fc2sw-0005LL-4X
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:09:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fc2sv-0005L9-Ux
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:09:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F0D2402242D
	for <qemu-devel@nongnu.org>; Sun,  8 Jul 2018 06:09:25 +0000 (UTC)
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-3-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ce407520-def5-c41d-8b32-60090341152d@redhat.com>
Date: Sun, 8 Jul 2018 08:09:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180706105753.26700-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 02/27] json: remove useless return value
 from lexer/parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 06.07.2018 12:57, Marc-Andr=C3=A9 Lureau wrote:
> The lexer always returns 0 when char feeding. Furthermore, none of the
> caller care about the return value.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20180326150916.9602-10-marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/json-lexer.h    |  4 ++--
>  include/qapi/qmp/json-streamer.h |  4 ++--
>  qobject/json-lexer.c             | 23 ++++++++---------------
>  qobject/json-streamer.c          |  8 ++++----
>  4 files changed, 16 insertions(+), 23 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
