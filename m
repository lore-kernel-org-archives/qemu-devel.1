Received: from eggs.gnu.org ([2001:4830:134:3::10]:52185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEco1-0000rX-Q3
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEcnx-0008LY-Oc
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:07:17 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171110203111.7666-6-mreitz@redhat.com>
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-6-mreitz@redhat.com>
Date: Tue, 14 Nov 2017 16:06:57 +0100
Message-ID: <w51y3n8zypa.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get
 unaligned offsets from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Fri 10 Nov 2017 09:31:11 PM CET, Max Reitz wrote:
> +static inline const char *qcow2_cache_get_name(BDRVQcow2State *s, Qcow2Cache *c)
> +{
> +    if (c == s->refcount_block_cache) {
> +        return "refcount block";
> +    } else if (c == s->l2_table_cache) {
> +        return "L2 table";
> +    } else {
> +        /* Do not abort, because this is not critical */
> +        return "unknown";
> +    }
> +}

Why is an unknown cache not critical?

Berto
