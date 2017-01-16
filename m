Received: from eggs.gnu.org ([2001:4830:134:3::10]:59376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT8bC-0005Nu-4H
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT8b9-0000zH-2K
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:49:30 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cT8b8-0000z9-Qy
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:49:26 -0500
Received: by mail-lf0-x244.google.com with SMTP id h65so12889858lfi.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 06:49:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-12-pbonzini@redhat.com>
	<20170116133643.GH14226@lemon.Home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9fcfec94-87c0-6239-52c6-90f8fa162550@redhat.com>
Date: Mon, 16 Jan 2017 15:49:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170116133643.GH14226@lemon.Home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/16] block: explicitly acquire aiocontext
 in callbacks that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>



On 16/01/2017 14:36, Fam Zheng wrote:
>> +        /* Note that the handlers do not expect any concurrency; qemu-nbd
>> +         * does not instantiate multiple AioContexts yet, nor does it call
>> +         * aio_poll/aio_dispatch from multiple threads.
>> +         */
>>          aio_set_fd_handler(client->exp->ctx, client->sioc->fd, true,
>>                             client->can_read ? nbd_read : NULL,
>>                             client->send_coroutine ? nbd_restart_write : NULL,
> 
> What about the built-in server (QMP nbd_server_start)?

Will fix. :)

Paolo
