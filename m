Received: from eggs.gnu.org ([2001:4830:134:3::10]:51083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKEeT-0005fC-N6
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKEeO-0007JI-Pi
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:32:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eKEeO-0007J9-JJ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:32:32 -0500
Date: Thu, 30 Nov 2017 10:32:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171130023226.GC16237@lemon>
References: <2b5d04f3.523b.160064da4db.Coremail.15700157322@163.com>
	<20171129062916.GA12220@lemon>
	<727e90ec.25b0.1600aabe963.Coremail.15700157322@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727e90ec.25b0.1600aabe963.Coremail.15700157322@163.com>
Subject: Re: [Qemu-devel] device_del fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lying <15700157322@163.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

Let's keep qemu-devel@nongnu.org on the list so other people can chime in.

On Thu, 11/30 10:05, Lying wrote:
 
> At 2017-11-29 14:29:17, "Fam Zheng" <famz@redhat.com> wrote:
> >On Wed, 11/29 13:43, Lying wrote:
> >> Hello everybody, I encounter a error on my vm guest
> >> I remove my device on my guest is failed, following is detail message.
> >> I didn't add my audio device before running my guest, So i add audio with "device_add" after running
> >> Then i can use it, so i remove it with "device_del", but when i do it again, i
> >> can't use my audio device and cannot remove it.
> >
> >
> >I haven't tried unplugging an audio device myself but in general PCI hot unplug
> >needs guest cooperation so some infomation about guest is also helpful.  Which
> >guest OS is this?
> >
> >What are the exact commands that you used and what are the messages from
> >host/guest when you device_del?
> >
> 
> >Fam
> 
> 
> hello, thanks for your reply, and i'm sorry that i not notice at yesterday .
> following is my information:
>     guest : window-7
>     host : Ubuntu-16.04
>     qemu : 2.11.0-rc0
>     libvirt : 3.9
>    seabios : 1.10.74 (from qemu)
> exact commands:
>     add:"device_add driver=vfio-pci,host=02:00.0,x-vga=on,multifunction=yes,id=gpu1"
>     remove:"device_del gpu1"
> and not messages when i running device_del. But i can see it still exist while running commands "info pci"

Probably the guest didn't respond to the hot-unplug event. In your original
question you said it is an audio device but your command suggests it is a GPU
device. I'm not sure Windows driver can handle this. Have you tried different
guests, such as Linux?

Cc Alex who may know more.

Fam
