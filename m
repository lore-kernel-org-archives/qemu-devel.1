Received: from eggs.gnu.org ([2001:4830:134:3::10]:39236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nitin.gupta981@gmail.com>) id 1evId6-0000KA-Op
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 04:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nitin.gupta981@gmail.com>) id 1evId5-0000Zx-RD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 04:16:24 -0400
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:45939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nitin.gupta981@gmail.com>)
	id 1evId5-0000ZL-Kk
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 04:16:23 -0400
Received: by mail-ua0-x233.google.com with SMTP id n24so6188658ual.12
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 01:16:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180306113457.GE31045@stefanha-x1.localdomain>
References: <CAB3_1NuKx8EspXZstkUYRTtXfNLQiDBF3QUW2WsGtycOd4Vmpw@mail.gmail.com>
	<20180306113457.GE31045@stefanha-x1.localdomain>
From: Nitin Gupta <nitin.gupta981@gmail.com>
Date: Mon, 12 Mar 2018 13:46:22 +0530
Message-ID: <CAB3_1Ns+AcnVSkkw-aDBrJzrbmChkoO4dczxApyBDhPgSV1Gqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] SSD virtio-scsi passthrough
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

Hi   Stefan

Thanks for your response , i tried the the command provided by you and it
did not work as well
somehow i find that  after changing the controller to LSI in qemu command
it started working , please find command below

-device lsi,id=scsi0,bus=pci.0,addr=0xa    -drive
file=/dev/sdc,format=raw,if=none,id=drive-scsi1-0-0-0,cache=none -device
scsi-block,bus=scsi1.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi1-0-0-0,id=scsi1-0-0-0


looks like virtio-pci is not able to bind when i am using qemu command ,
its working with virsh(libvirt).

Regards
Nitin

On Tue, Mar 6, 2018 at 5:04 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Feb 21, 2018 at 02:51:38PM +0530, Nitin Gupta wrote:
> > Please let me know the qemu command for doing ssd virtio-scsi
> passthrough .
> > i am able to do the pass through with virsh .but same command when i am
> > trying with qemu , VM is not coming up
> >
> > Please let me know how can i proceed further . any help will be
> appreciated
>
> Something like this:
>
>   -drive if=none,id=drive0,file=/dev/sdX,format=raw,aio=native,cache=none
>   -device virtio-scsi-pci,id=virtio-scsi-pci0
>   -device scsi-block,drive=drive0,bus=virtio-scsi-pci0.0
>
> Stefan
>
