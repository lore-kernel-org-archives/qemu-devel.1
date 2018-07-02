Received: from eggs.gnu.org ([2001:4830:134:3::10]:43551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fa6Rf-0002AX-RS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fa6Rc-00037S-NY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:33:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fa6Rc-00035f-It
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:33:12 -0400
Date: Tue, 3 Jul 2018 00:33:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180630013310-mutt-send-email-mst@kernel.org>
References: <152976906812.26719.4060539263907295716.malonedeb@gac.canonical.com>
	<153000439210.6815.3824890774185490224.malone@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153000439210.6815.3824890774185490224.malone@wampee.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1778350] Re: Android-x86 4.4-r5 won't boot on
 QEMU since v2.11.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1778350 <1778350@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

I looked at it and while I might be wrong, I suspect
it's a bug in ACPI parser in that version of Linux.
Is there a way for you to try a later Linux version?
Alternatively, I tried to build 4.4-rc2 on Fedora and couldn't.

On Tue, Jun 26, 2018 at 09:13:12AM -0000, navicrej wrote:
> Nevermind that, just found out how to run:
> 
> qemu-system-x86_64 -cdrom android-x86-4.4-r5.iso -m 1024 -global i440FX-
> pcihost.x-pci-hole64-fix=off -global q35-pcihost.x-pci-hole64-fix=off
> 
> -- 
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1778350
> 
> Title:
>   Android-x86 4.4-r5 won't boot on QEMU since v2.11.0-rc2
> 
> Status in QEMU:
>   New
> 
> Bug description:
>   Try to boot from the Android-x86 4.4-r5 ISO won't boot in QEMU after 2.11.0-rc2. The last known version it works is 2.11.0-rc1.
>   It also works on the 2.10.x-line, even the 2.10.2 which was released after 2.11.0-rc2!
> 
>   How to reproduce:
>   Download the ISO from
>   http://www.android-x86.org/releases/releasenote-4-4-r5 or directly https://www.fosshub.com/Android-x86.html/android-x86-4.4-r5.iso
> 
>   Start QEMU with this command-line: qemu-system-x86_64 -cdrom
>   android-x86-4.4-r5.iso -m 1024
> 
>   On 2.11.0-rc1 and 2.10.2 after selecting to boot from CD it shows the Android splash after a short while ...
>   On 2.11.0-rc2 through the latest 2.12 line it goes to black screen shortly right after selecting to boot from CD
> 
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1778350/+subscriptions
