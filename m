Received: from eggs.gnu.org ([2001:4830:134:3::10]:42135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCVLD-0000ii-Vu
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 15:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCVL4-0004LN-80
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 15:49:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCVL2-0004Ii-8J
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 15:49:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4832C30DF710
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 19:49:07 +0000 (UTC)
References: <20181016174158.15229-1-armbru@redhat.com>
	<20181016174158.15229-38-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9ba67f8-d209-5cfa-5241-4603419704ee@redhat.com>
Date: Tue, 16 Oct 2018 14:49:04 -0500
MIME-Version: 1.0
In-Reply-To: <20181016174158.15229-38-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 37/38] raw: Convert a warning to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 10/16/18 12:41 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block/raw-format.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)

Incomplete. tests/qemu-iotests/109.out needs updating:

> @@ -436,14 +437,14 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>               bs->file->bs->supported_zero_flags);
>   
>       if (bs->probed && !bdrv_is_read_only(bs)) {
> -        fprintf(stderr,
> -                "WARNING: Image format was not specified for '%s' and probing "
> -                "guessed raw.\n"
> -                "         Automatically detecting the format is dangerous for "
> -                "raw images, write operations on block 0 will be restricted.\n"
> -                "         Specify the 'raw' format explicitly to remove the "
> -                "restrictions.\n",
> -                bs->file->bs->filename);
> +        warn_report("Image format was not specified for '%s' and probing "

as this changes s/WARNING/warning/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
