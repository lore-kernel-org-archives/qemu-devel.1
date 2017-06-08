Received: from eggs.gnu.org ([2001:4830:134:3::10]:44248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIyyv-0003FL-2y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIyyr-0000RK-Tx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:04:17 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170608133906.12737-3-ehabkost@redhat.com>
References: <20170608133906.12737-1-ehabkost@redhat.com>
	<20170608133906.12737-3-ehabkost@redhat.com>
Date: Thu, 08 Jun 2017 17:04:08 +0200
Message-ID: <w51bmpyo713.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/5] block: Don't try to set
 *errp directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 08 Jun 2017 03:39:03 PM CEST, Eduardo Habkost wrote:
> Assigning directly to *errp is not valid, as errp may be NULL,
> &error_fatal, or &error_abort.  Use error_propagate() instead.

Well, the NULL case was already handled by the code, but &error_fatal
and &error_abort certainly not.

> With this, there's no need to check if errp is NULL anymore, as
> error_propagate() and error_prepend() are able to handle that.
>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
