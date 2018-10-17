Received: from eggs.gnu.org ([2001:4830:134:3::10]:34646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCecH-0000x4-AA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 01:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCecE-0005RM-3F
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 01:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCecC-0005Nk-3p
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 01:43:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0FEC307D858
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 05:43:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
	<20181016174158.15229-38-armbru@redhat.com>
	<e9ba67f8-d209-5cfa-5241-4603419704ee@redhat.com>
Date: Wed, 17 Oct 2018 07:43:23 +0200
In-Reply-To: <e9ba67f8-d209-5cfa-5241-4603419704ee@redhat.com> (Eric Blake's
	message of "Tue, 16 Oct 2018 14:49:04 -0500")
Message-ID: <871s8pgmbo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 10/16/18 12:41 PM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   block/raw-format.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>
> Incomplete. tests/qemu-iotests/109.out needs updating:
>
>> @@ -436,14 +437,14 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>>               bs->file->bs->supported_zero_flags);
>>         if (bs->probed && !bdrv_is_read_only(bs)) {
>> -        fprintf(stderr,
>> -                "WARNING: Image format was not specified for '%s' and probing "
>> -                "guessed raw.\n"
>> -                "         Automatically detecting the format is dangerous for "
>> -                "raw images, write operations on block 0 will be restricted.\n"
>> -                "         Specify the 'raw' format explicitly to remove the "
>> -                "restrictions.\n",
>> -                bs->file->bs->filename);
>> +        warn_report("Image format was not specified for '%s' and probing "
>
> as this changes s/WARNING/warning/

Not run by "make check-block"...  Will fix, thanks!
