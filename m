Received: from eggs.gnu.org ([2001:4830:134:3::10]:34043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1duzw4-0003PR-Jr
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1duzw3-0008UC-Q4
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:46:28 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170916185123.29255-3-mreitz@redhat.com>
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-3-mreitz@redhat.com>
Date: Thu, 21 Sep 2017 13:46:20 +0200
Message-ID: <w51k20s6zqr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 2/6] qapi/qlist: Add
 qlist_append_null() macro
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

On Sat 16 Sep 2017 08:51:19 PM CEST, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> @@ -37,6 +38,8 @@ typedef struct QList {
>          qlist_append(qlist, qbool_from_bool(value))
>  #define qlist_append_str(qlist, value) \
>          qlist_append(qlist, qstring_from_str(value))
> +#define qlist_append_null(qlist) \
> +        qlist_append(qlist, qnull())

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
