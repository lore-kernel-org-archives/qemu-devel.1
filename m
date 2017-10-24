Received: from eggs.gnu.org ([2001:4830:134:3::10]:36109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6xjH-0005cW-2N
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6xjC-0003nk-2o
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:50:43 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:54308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e6xjB-0003nd-SL
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:50:38 -0400
Received: by mail-wr0-x22f.google.com with SMTP id o44so20346142wrf.11
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 04:50:37 -0700 (PDT)
Date: Tue, 24 Oct 2017 13:50:32 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171024115032.GA18756@stefanha-x1.localdomain>
References: <CACw_XP_8GrqEa4GcK06BrZJjjvGu=BJKZB6DTVtoJrd1YcRFWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACw_XP_8GrqEa4GcK06BrZJjjvGu=BJKZB6DTVtoJrd1YcRFWw@mail.gmail.com>
Subject: Re: [Qemu-devel] Command line option "-option-rom" doesn't take the
 ROM file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Deema B <stou4r@gmail.com>
Cc: qemu-devel@nongnu.org

On Mon, Oct 23, 2017 at 02:22:05PM -0700, Deema B wrote:
> I'm trying to use the -option-rom option to supply my own virtio OpROM.
> 
> I am not able to see the ROM being launch (the built-in version comes up
> instead).
> The only way I am able to make it work is to rebuild the Qemu and iPXE
> together.
> 
> I'm assuming this is working feature, and I'm simply doing something wrong.
> Appreciate any suggestions, pointers, and to hear your experience with this
> particular option.

Hi Deema,
You can specify the option ROM on a per-device basis:

  -device virtio-net-pci,romfile=my-ipxe.rom,...

The advantage of this approach is that there is no conflict between the
global -option-rom file and the default file loaded by the NIC device.

Stefan
