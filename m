Received: from eggs.gnu.org ([2001:4830:134:3::10]:39859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT7Nq-0002Ko-LF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT7Nm-0001Y3-Lw
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:31:38 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cT7Nm-0001Xl-F7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:31:34 -0500
Received: by mail-lf0-x244.google.com with SMTP id x1so7310048lff.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 05:31:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-7-pbonzini@redhat.com>
	<20170116125208.GF14226@lemon.Home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67f59827-f7a7-2df1-3cb9-cc066603ba59@redhat.com>
Date: Mon, 16 Jan 2017 14:31:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170116125208.GF14226@lemon.Home>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com



On 16/01/2017 13:52, Fam Zheng wrote:
> +    /* Kick the read_reply_co to get the next reply.  */
> +    aio_co_wake(s->read_reply_co);
> 
> Can't s->read_reply_co be NULL? nbd_read_reply_entry unsets it. (Surprisingly
> this file is rather unfamiliar to me, it's possible I'm missing something.)

Yes, that can happen depending on how the coroutines are scheduled when
the server goes down.

Paolo
