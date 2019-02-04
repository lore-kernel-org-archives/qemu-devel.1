Received: from eggs.gnu.org ([209.51.188.92]:42941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gqbpB-0003OS-8v
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gqbpA-0004DL-MQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:50:01 -0500
Received: from server54-2.web-hosting.com ([198.54.126.118]:50648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <admin@grossmann-venter.com>)
	id 1gqbp8-00048A-Nx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:49:59 -0500
Received: from [::1] (port=53350 helo=server54.web-hosting.com)
	by server54.web-hosting.com with esmtpa (Exim 4.91)
	(envelope-from <admin@grossmann-venter.com>) id 1gqbp1-0025RD-R6
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:49:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Feb 2019 05:49:51 -0500
From: liebrecht@grossmann-venter.com
In-Reply-To: <665ec250-c4a5-18ba-ad71-90966a1b9e12@redhat.com>
References: <b0d70556767952dc739454d074bdab52@grossmann-venter.com>
	<665ec250-c4a5-18ba-ad71-90966a1b9e12@redhat.com>
Message-ID: <7d4a413036a784179b1b848a1cd98e13@grossmann-venter.com>
Subject: [Qemu-devel] Usb device disappears from linux  after Qemu starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Below is the string I use:

I use lsb to search for the the hostaddr of the usb device i want to 
connect to qemu.
Qemu when it starts with this hostaddr then removes the device from the 
acticve usb list.
Running lsusb after qemu starts shows the device disappeared.

Is this a bug ? as I cannot see a device just disappearing when qemu 
starts.


sudo qemu-system-x86_64 -usb -device usb-host,hostbus=1,hostaddr=42 
-device piix3-usb-uhci  -enable-kvm -soundhw all  -smp 4 -m 2048M -boot 
d -cdrom /dev/cdrom -drive format=raw,file=hd.img
