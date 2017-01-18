Received: from eggs.gnu.org ([2001:4830:134:3::10]:48814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTtLE-00029X-9L
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTtLA-0001pn-Bk
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:44:08 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cTtLA-0001nh-47
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:44:04 -0500
Received: by mail-lf0-x244.google.com with SMTP id q89so2515481lfi.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 08:44:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-7-pbonzini@redhat.com>
	<20170118152444.GG30347@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8102c8f-feae-c40e-07cd-d1cd0abc3055@redhat.com>
Date: Wed, 18 Jan 2017 17:43:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170118152444.GG30347@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/16] nbd: do not block on partial reply
 header reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org



On 18/01/2017 16:24, Stefan Hajnoczi wrote:
> On Fri, Jan 13, 2017 at 02:17:21PM +0100, Paolo Bonzini wrote:
>> @@ -65,54 +67,34 @@ static void nbd_teardown_connection(BlockDriverState *bs)
>>      client->ioc = NULL;
>>  }
>>  
>> -static void nbd_reply_ready(void *opaque)
>> +static void nbd_read_reply_entry(void *opaque)
> 
> Please use coroutine_fn.

Yes, you requested that in the RFC as well.

Paolo
