Received: from eggs.gnu.org ([2001:4830:134:3::10]:40171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxmGo-0006lq-Ne
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxmGl-0007Dl-DY
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:15:06 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxmGl-0007DR-7s
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:15:03 -0400
Received: by mail-qt0-x244.google.com with SMTP id o36so5798554qtb.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 20:15:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170407222016.15308-1-f4bug@amsat.org>
	<20170407222016.15308-5-f4bug@amsat.org>
	<149187362699.15312.3273219849572595103@loki>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <011bf97c-63da-43b7-3259-43254cd4145a@amsat.org>
Date: Tue, 11 Apr 2017 00:14:59 -0300
MIME-Version: 1.0
In-Reply-To: <149187362699.15312.3273219849572595103@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qga: improve error handling in
 transfer_memory_block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

On 04/10/2017 10:20 PM, Michael Roth wrote:
> Quoting Philippe Mathieu-Daudé (2017-04-07 17:20:16)
>> Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>
>> ---
>>
>> Michael should I use Signed-off-by instead of the Suggested-by (since it is your
>> code)?
>
> I suppose it could go either way depending on the circumstances
> (assuming you've asked for / obtained their SoB obviously), but
> speaking for myself here I don't think it's necessary.
>

Ok! I allowed myself to add your "Suggested-by" after reading Linux's 
process/submitting-patches.rst doc, assuming no need to ask for it since 
you answered in public ML. I'll diligently ask next time!

>>
>>  qga/commands-posix.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index fc45102a1e..ca5a24b2c9 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -2128,6 +2128,9 @@ static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
>>              if (errno == ENOENT) {
>>                  result->response =
>>                      GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
>> +            } else {
>> +                result->response =
>> +                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
>>              }
>>              goto out1;
>>          }
>> --
>> 2.11.0
>>
>
