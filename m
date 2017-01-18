Received: from eggs.gnu.org ([2001:4830:134:3::10]:43993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unix.co@gmail.com>) id 1cTnks-0000RY-Ku
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unix.co@gmail.com>) id 1cTnkr-0006Al-O0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:46:14 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <unix.co@gmail.com>) id 1cTnkr-0006Ah-Je
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:46:13 -0500
Received: by mail-qt0-x244.google.com with SMTP id f4so1057052qte.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 02:46:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170118102942.GA5284@stefanha-x1.localdomain>
References: <CAAKRE72RN=DvVqxYMba5KdnWQ+jrAXTpxQc7Qdgiymu6oByosg@mail.gmail.com>
	<20170118102942.GA5284@stefanha-x1.localdomain>
From: Umar Draz <unix.co@gmail.com>
Date: Wed, 18 Jan 2017 15:46:12 +0500
Message-ID: <CAAKRE70s=Cdk9xedS3xavOj9_TMRa4ZNvZqVw8jqVxVMDCM7Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] VM Hung issue
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

Hello Stefan,

Well yes, whenever vm hung, then there is nothing on vnc display, and
network of that vm is also down. I can not ping the vm that time.

Mostly my Windows VMs are affected due to this and sometime same thing
happen with Linux vm.

On Wed, Jan 18, 2017 at 3:29 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Jan 18, 2017 at 01:51:26PM +0500, Umar Draz wrote:
> > I am running qemu-kvm on CentOS 7.3, I have few vms of CentOS and Windows
> > 2012 servers.
> >
> > Randomly they are hung, but the status of virtual machine keep running,
> vnc
> > and network not responding.
>
> It's not clear whether the guest is hung or QEMU is hung.
>
> Does the VNC client connect successfully?  If the client fails to
> connect then QEMU is hung.  If the client connects but the guest doesn't
> respond to input then only the guest is hanging.
>
> If QEMU is hung please post a backtrace:
>
>   # gstack $PID_OF_QEMU
>
> Stefan
>
