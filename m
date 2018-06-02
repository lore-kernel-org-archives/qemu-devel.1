Received: from eggs.gnu.org ([2001:4830:134:3::10]:52819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1fP0qV-0001Ud-Vr
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 03:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1fP0qR-00087L-1O
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 03:21:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:45105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1fP0qQ-000822-NZ
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 03:20:58 -0400
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <a51fbf8b-9839-ebc1-cde5-5ae95656f918@suse.de>
Date: Sat, 2 Jun 2018 09:20:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Am 01.06.2018 um 17:39 schrieb Ricardo Perez Blanco:
> For debugging purposes it is very useful to:
>  - See the description of the field. This information is already filled
>    in but not shown in "qom-list" command.

No objection on this part.

>  - Display value of the field.

That is by definition the qom-get operation, not qom-list. Just like the
ls command does not show file contents, there's cat etc. for that. For
debugging purposes we had a qom-tree (?) command that would combine
both. There might be unmerged patches on qemu-devel related to display
of certain data types.

Regards,
Andreas

>=20
> Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
> ---
>  hmp.c          | 13 +++++++++++--
>  qapi/misc.json |  6 ++++--
>  qmp.c          |  7 +++++++
>  qom/object.c   |  8 +++-----
>  4 files changed, 25 insertions(+), 9 deletions(-)
[snip]

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
