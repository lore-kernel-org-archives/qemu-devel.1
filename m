Received: from eggs.gnu.org ([2001:4830:134:3::10]:43274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej3sJ-0001bT-4k
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej3sB-00034w-ID
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:05:31 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180205151835.20812-25-mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-25-mreitz@redhat.com>
Date: Tue, 06 Feb 2018 15:05:07 +0100
Message-ID: <w51y3k6ciy4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 24/26] block/curl: Harmonize option
 defaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon 05 Feb 2018 04:18:33 PM CET, Max Reitz wrote:
> Both of the defaults we currently have in the curl driver are named
> based on a slightly different schema, let's unify that and call both
> CURL_BLOCK_OPT_${NAME}_DEFAULT.
>
> While at it, we can add a macro for the third option for which a default
> exists, namely "sslverify".
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
