Received: from eggs.gnu.org ([2001:4830:134:3::10]:36633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dA4vt-0004oV-5Y
	for qemu-devel@nongnu.org; Sun, 14 May 2017 21:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dA4vq-0003dY-0N
	for qemu-devel@nongnu.org; Sun, 14 May 2017 21:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dA4vp-0003cu-Pz
	for qemu-devel@nongnu.org; Sun, 14 May 2017 21:36:17 -0400
Date: Mon, 15 May 2017 09:36:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170515013613.GA23262@lemon.lan>
References: <87efvrovn7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efvrovn7.fsf@gmail.com>
Subject: Re: [Qemu-devel] Installing Windows with virtio (was: QEMU,
 increase graphics memory)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "jenia.ivlev" <jenia.ivlev@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, 05/14 19:39, jenia.ivlev wrote:
> 
> I wanted to get more graphics memory on my QEMU Windows client.
> 
> I decided to install **Virtio** drivers for QEMU to achieve that purpose.
> 
> I create an *imagine_file* like this:
> 
> 
>     qemu-img create -f raw image_file 4G
> 
> 
> Also, I ran the windows-install like this:
> 
> 
>     qemu-system-x86_64 -enable-kvm -m 4G -cdrom "OS.iso" -boot order=c -drive file=image_file,if=virtio
> 
> 
> But when Windows ran, it didn't find any hard-drive (the *image_file*
> basically). It asked for some drivers instead. I think it wanted drivers
> to communicate with the hard-drive (*image_file*).
> 
> Running the install without Virtio works though:
> 
> 
>     qemu-system-x86_64 -enable-kvm -m 4G -cdrom "OS.iso" -boot order=d -drive file=image_file,format=raw
> 
> 
> The difference betweeen the two commands is:
> 
> 
>     order=c vs order=d
> 
> 
> and
> 
> 
>     if=virtio vs format=raw
> 
> 
> How do I install windows with Virtio in QEMU?
> 
> My original goal is to get 512 MB of graphics memory on Windows (running
> as a guest in QEMU). Unfortunately, by default  (no Virtio) I get 8MB of
> video memory which is not enough for my purposes
> 
> 
> Thanks
> 
> P.S. My OS is Arch-Linux

Since you use ArchLinux, wiki.archlinux.org is rather helpful, as always.  Yes,
you need virtio drivers:

https://wiki.archlinux.org/index.php/QEMU#New_Install_of_Windows


Fam
