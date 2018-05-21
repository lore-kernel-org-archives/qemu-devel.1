Received: from eggs.gnu.org ([2001:4830:134:3::10]:41971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fKogE-00072R-6c
	for qemu-devel@nongnu.org; Mon, 21 May 2018 13:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fKogD-0003dY-Ad
	for qemu-devel@nongnu.org; Mon, 21 May 2018 13:33:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180521163203.26590-3-ross.zwisler@linux.intel.com>
	<6332df7d-3588-9ecc-6220-2f40c1581fe6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <be62d517-9b3e-6fe2-7333-b8315e830b4b@amsat.org>
Date: Mon, 21 May 2018 14:32:16 -0300
MIME-Version: 1.0
In-Reply-To: <6332df7d-3588-9ecc-6220-2f40c1581fe6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu PATCH v4 2/4] tests/.gitignore: add entry
 for generated file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu block <qemu-block@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>

On 05/21/2018 01:41 PM, Eric Blake wrote:
> On 05/21/2018 11:32 AM, Ross Zwisler wrote:
>> After a "make check" we end up with the following:
>>
>> $ git status
>> On branch master
>> Your branch is up-to-date with 'origin/master'.
>>
>> Untracked files:
>>    (use "git add <file>..." to include in what will be committed)
>>
>>     tests/test-block-backend
>>
>> nothing added to commit but untracked files present (use "git add" to
>> track)
>>
>> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> Fixes: commit ad0df3e0fdac ("block: test blk_aio_flush() with
>> blk->root == NULL")
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> ---
>>   tests/.gitignore | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
>>
>> diff --git a/tests/.gitignore b/tests/.gitignore
>> index fb62d2299b..2bc61a9a58 100644
>> --- a/tests/.gitignore
>> +++ b/tests/.gitignore
>> @@ -21,6 +21,7 @@ test-base64
>>   test-bdrv-drain
>>   test-bitops
>>   test-bitcnt
>> +test-block-backend
>>   test-blockjob
>>   test-blockjob-txn
>>   test-bufferiszero

What about using gitignore negated pattern in tests/?
