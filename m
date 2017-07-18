Received: from eggs.gnu.org ([2001:4830:134:3::10]:58720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQXp-0006hI-BV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQXk-0002KX-F8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:20:01 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQXk-0002JU-90
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:19:56 -0400
Received: by mail-wr0-x230.google.com with SMTP id 12so24516449wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 04:19:56 -0700 (PDT)
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-7-f4bug@amsat.org>
	<87bmoiysko.fsf@secure.mitica>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87bmoiysko.fsf@secure.mitica>
Date: Tue, 18 Jul 2017 12:19:53 +0100
Message-ID: <87a8428012.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/29] migration/block: use QEMU_IS_ALIGNED
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


Juan Quintela <quintela@redhat.com> writes:

> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  migration/block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/block.c b/migration/block.c
>> index 9171f60028..498c72ad59 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -933,7 +933,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>>                  ret = bdrv_get_info(blk_bs(blk), &bdi);
>>                  if (ret == 0 && bdi.cluster_size > 0 &&
>>                      bdi.cluster_size <= BLOCK_SIZE &&
>> -                    BLOCK_SIZE % bdi.cluster_size == 0) {
>> +                    QEMU_IS_ALIGNED(BLOCK_SIZE, bdi.cluster_size)) {
>>                      cluster_size = bdi.cluster_size;
>>                  } else {
>>                      cluster_size = BLOCK_SIZE;
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> Should I take this patch, or does it go through the block layer?  Your
> call.

Given it is part of a set would it not make more sense going through
-trivial with the rest of them?

--
Alex Bennée
