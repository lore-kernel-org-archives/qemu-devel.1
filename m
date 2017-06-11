Received: from eggs.gnu.org ([2001:4830:134:3::10]:51120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKAPr-0007dv-39
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 17:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKAPn-00010U-U1
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 17:28:59 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170609152017.7286-3-eblake@redhat.com>
References: <20170609152017.7286-1-eblake@redhat.com>
	<20170609152017.7286-3-eblake@redhat.com>
Date: Sun, 11 Jun 2017 23:28:15 +0200
Message-ID: <w517f0i1afk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] qobject: Catch another
 straggler for use of qdict_put_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, marcandre.lureau@redhat.com

On Fri 09 Jun 2017 05:20:17 PM CEST, Eric Blake <eblake@redhat.com> wrote:
> Dan's addition of key-secret improvements in commit 29cf9336 was
> developed prior to the addition of QDict scalar insertion macros,
> but merged after the general cleanup in commit 46f5ac20.
> Patch created mechanically by rerunning:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>          --macro-file scripts/cocci-macro-file.h --dir . --in-place
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
