Received: from eggs.gnu.org ([2001:4830:134:3::10]:50012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPAoc-00036P-Sc
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPAoZ-0006VY-M8
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:32:02 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181120180029.GD7513@localhost.localdomain>
References: <cover.1542031058.git.berto@igalia.com>
	<ab8395c8926892311948dcfd3f88c598dd74797b.1542031058.git.berto@igalia.com>
	<20181120180029.GD7513@localhost.localdomain>
Date: Tue, 20 Nov 2018 19:31:20 +0100
Message-ID: <w51o9ajsirr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 05/16] block: Use
 bdrv_reopen_set_read_only() in stream_start/complete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 20 Nov 2018 07:00:29 PM CET, Kevin Wolf wrote:
>> @@ -226,12 +226,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>>  {
>>      StreamBlockJob *s;
>>      BlockDriverState *iter;
>> -    int orig_bs_flags;
>> +    int bs_read_only;
>
> bool certainly?

Oops!

Berto
