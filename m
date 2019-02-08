Received: from eggs.gnu.org ([209.51.188.92]:46928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs5K0-000680-S8
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs5Jx-0000sj-9S
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:31:55 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1546200557-774583-2-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1546200557-774583-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Fri, 08 Feb 2019 13:31:46 +0100
Message-ID: <w51r2ci8nrh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 1/6] Stream block job
 involves copy-on-read filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jcody@redhat.com, armbru@redhat.com, dgilbert@redhat.com, den@openvz.org, mreitz@redhat.com

On Sun 30 Dec 2018 09:09:12 PM CET, Andrey Shinkevich wrote:
> +static BlockDriverState *child_file_bs(BlockDriverState *bs)
> +{
> +    return bs->file ? bs->file->bs : NULL;
> +}

In addition to Vladimir's comments, I wonder if it's useful to put this
in block_int.h (together with backing_bs()). It seems that there's a
couple of more places where this can be used.

Berto
