Received: from eggs.gnu.org ([2001:4830:134:3::10]:38790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAI6B-0002ds-Hd
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAI6A-0000EZ-Lw
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:12:07 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-19-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-19-mreitz@redhat.com>
Date: Thu, 02 Nov 2017 17:11:58 +0100
Message-ID: <w51o9okwtgx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 18/25] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Fri 29 Sep 2017 06:53:40 PM CEST, Max Reitz wrote:
>      QLIST_ENTRY(BlockDriver) list;
> +
> +    /* Pointer to a NULL-terminated array of names of significant options that
> +     * can be specified for bdrv_open(). A significant option is one that
> +     * changes the data of a BDS.
> +     * If this pointer is NULL, the array is considered empty.
> +     * "filename" and "driver" are always considered significant. */
> +    const char *const *sgfnt_runtime_opts;
>  };

Is sgfnt a common acronym? I actually had to look it up...

> +static const char *const iscsi_sgfnt_runtime_opts[] = {
> +    "transport",
> +    "portal",
> +    "target",
> +    "user",
> +    "password",
> +    "password-secret",
> +    "lun",
> +    "initiator-name",
> +    "header-digest",
> +
> +    NULL
> +};

Ideally it would be nice to have constants for all these options, but
this is a pre-existing problem.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
