Received: from eggs.gnu.org ([209.51.188.92]:55812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL95r-0000pV-JZ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL95p-0006Ir-Kv
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:25:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hL95p-0006I4-DJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:25:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so8450060wrs.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:25:23 -0700 (PDT)
Date: Mon, 29 Apr 2019 18:25:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190429162519.s7twbo5jiiylzdfj@steredhat>
References: <155619222209.13917.4120344041326080857.malonedeb@gac.canonical.com>
	<20190429154733.GA13640@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429154733.GA13640@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Bug 1826393] [NEW] QEMU 3.1.0 stuck waiting for
 800ms (5 times slower) in pre-bios phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1826393 <1826393@bugs.launchpad.net>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, kraxel@redhat.com

On Mon, Apr 29, 2019 at 11:47:33AM -0400, Stefan Hajnoczi wrote:
> On Thu, Apr 25, 2019 at 11:37:02AM -0000, Waldemar Kozaczuk wrote:
> 
> Please try building QEMU 4.0.0 from source:
> 
>   https://download.qemu.org/qemu-4.0.0.tar.xz
> 

It seems that is related to an issue with some TPM timeouts found in
SeaBIOS 1.12.0:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg575060.html

As Stefan suggested the new QEMU 4.0.0 should not have this issue since
it is shipped with SeaBIOS 1.12.1 (where the fix is applied).

If you want to use QEMU 3.1.0 with the new SeaBIOS, you can download it
and use the '-bios' parameter:
    $ wget https://github.com/qemu/qemu/blob/v4.0.0/pc-bios/bios-256k.bin
    $ qemu-system-x86_64 -bios /path/to/bios-256k.bin ...
