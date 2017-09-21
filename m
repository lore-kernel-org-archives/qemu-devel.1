Received: from eggs.gnu.org ([2001:4830:134:3::10]:38072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dv0Cr-0008Nm-JM
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dv0Cq-0006i3-Oj
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:03:49 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170916185123.29255-4-mreitz@redhat.com>
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-4-mreitz@redhat.com>
Date: Thu, 21 Sep 2017 14:03:35 +0200
Message-ID: <w51h8vw6yy0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 3/6] qapi: Add
 qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Sat 16 Sep 2017 08:51:20 PM CEST, Max Reitz wrote:
> This generic function (along with its implementations for different
> types) determines whether two QObjects are equal.

> +bool qnull_is_equal(const QObject *x, const QObject *y);
> +

You could almost make this one inline, but it doesn't really matter.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
