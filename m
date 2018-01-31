Received: from eggs.gnu.org ([2001:4830:134:3::10]:45775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egv49-00079s-7V
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egv41-0006CL-Jq
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:16:53 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180120154412.9990-5-mreitz@redhat.com>
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-5-mreitz@redhat.com>
Date: Wed, 31 Jan 2018 17:16:32 +0100
Message-ID: <w51mv0uxau7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/6] qapi: Make more of qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Sat 20 Jan 2018 04:44:10 PM CET, Max Reitz wrote:
> This patch reworks some places which use either qobject_type() checks
> plus qobject_to(), where the latter alone is sufficient, or NULL checks
> plus qobject_type() checks where we can simply do a qobject_to() != NULL
> check.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
