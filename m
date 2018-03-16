Received: from eggs.gnu.org ([2001:4830:134:3::10]:49784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ewkgE-0004TO-Pq
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ewkg9-00076H-Rw
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:25:38 -0400
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:53751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ewkg9-00075v-Hk
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:25:33 -0400
Received: by mail-it0-x235.google.com with SMTP id w63-v6so1133543ita.3
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 01:25:33 -0700 (PDT)
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-4-xiaoguangrong@tencent.com>
	<20180315112937.GC3062@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <3cce6e15-7e0e-1cde-3932-f7b04fe746fa@gmail.com>
Date: Fri, 16 Mar 2018 16:25:25 +0800
MIME-Version: 1.0
In-Reply-To: <20180315112937.GC3062@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/8] migration: support to detect
 compression and decompression errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 03/15/2018 07:29 PM, Dr. David Alan Gilbert wrote:

>> @@ -1051,11 +1052,13 @@ static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
>>   {
>>       RAMState *rs = ram_state;
>>       int bytes_sent, blen;
>> -    uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
>> +    uint8_t buf[TARGET_PAGE_SIZE], *p;
> 
> That should be malloc'd somewhere rather than be on the stack; it's a
> bit big and also there are architectures where TARGET_PAGE_SIZE isn't
> compile time constant.
> 

Okay, i will allocate a internal buffer for each thread...

> (Also, please use g_try_malloc rather than g_malloc on larger chunks,
> since g_try_malloc will return NULL so you can fail nicely;  g_malloc is
> OK for small things that are very unlikely to fail).
> 
> Other than that, I think the patch is fine.

Thank you, Dave!
