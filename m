Received: from eggs.gnu.org ([2001:4830:134:3::10]:37231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stou4r@gmail.com>) id 1e74mm-0005o5-Cd
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stou4r@gmail.com>) id 1e74ml-0008PT-CC
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:22:48 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:48665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stou4r@gmail.com>) id 1e74ml-0008Ob-5c
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:22:47 -0400
Received: by mail-pg0-x232.google.com with SMTP id v78so15302416pgb.5
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 12:22:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171024115032.GA18756@stefanha-x1.localdomain>
References: <CACw_XP_8GrqEa4GcK06BrZJjjvGu=BJKZB6DTVtoJrd1YcRFWw@mail.gmail.com>
	<20171024115032.GA18756@stefanha-x1.localdomain>
From: Deema B <stou4r@gmail.com>
Date: Tue, 24 Oct 2017 12:22:45 -0700
Message-ID: <CACw_XP-pUdB-JCThpoibqAF0D4Fi+AS-j3tthtLdWMmLm2X9Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

Thank you, Stefan!  That worked.
Sorry for the double email, I'm learning quickly :)

On Tue, Oct 24, 2017 at 4:50 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, Oct 23, 2017 at 02:22:05PM -0700, Deema B wrote:
> > I'm trying to use the -option-rom option to supply my own virtio OpROM.
> >
> > I am not able to see the ROM being launch (the built-in version comes up
> > instead).
> > The only way I am able to make it work is to rebuild the Qemu and iPXE
> > together.
> >
> > I'm assuming this is working feature, and I'm simply doing something
> wrong.
> > Appreciate any suggestions, pointers, and to hear your experience with
> this
> > particular option.
>
> Hi Deema,
> You can specify the option ROM on a per-device basis:
>
>   -device virtio-net-pci,romfile=my-ipxe.rom,...
>
> The advantage of this approach is that there is no conflict between the
> global -option-rom file and the default file loaded by the NIC device.
>
> Stefan
>
