Received: from eggs.gnu.org ([2001:4830:134:3::10]:50504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoFs2-0008GV-6o
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoFrz-0004fq-3H
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:54:42 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:39098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eoFry-0004f6-Sq
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:54:39 -0500
Received: by mail-wr0-f174.google.com with SMTP id w77so18582884wrc.6
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:54:38 -0800 (PST)
References: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c23f28d-ee14-c504-ae13-04414c4b032e@redhat.com>
Date: Tue, 20 Feb 2018 22:54:35 +0100
MIME-Version: 1.0
In-Reply-To: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 20/02/2018 18:04, Peter Lieven wrote:
> Hi,
> 
> I remember we discussed a long time ago to limit the stack usage of all
> functions that are executed in a coroutine
> context to a very low value to be able to safely limit the coroutine
> stack size as well.

IIRC the only issue was that hw/ide/atapi.c has mutual recursion between
ide_atapi_cmd_reply_end -> ide_transfer_start -> ahci_start_transfer ->
ide_atapi_cmd_reply_end.

But perhaps it's not an issue, somebody needs to audit the code.

> I checked through all functions in block/, migration/ and nbd/ and there
> are only very few larger or unbound stack
> allocations that can easily be fixed.

Yeah, the really large allocations are very few and mostly have to do
with networking (https://wiki.qemu.org/BiteSizedTasks#Large_frames).
Unfortunately the link to the original list has died together with the
gmane archives.

Paolo
