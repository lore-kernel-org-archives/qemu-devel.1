Received: from eggs.gnu.org ([2001:4830:134:3::10]:41259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY5KH-0004EH-QI
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 02:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY5KE-0005Ga-P5
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 02:52:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dY5KE-0005GH-Il
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 02:52:42 -0400
Message-ID: <1500533554.6553.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 20 Jul 2017 08:52:34 +0200
In-Reply-To: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH 0/2] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: marcel@redhat.com, qemu-devel@nongnu.org

On Wed, 2017-07-19 at 16:20 +0300, Aleksandr Bezzubikov wrote:
> Now PCI bridges (and PCIE root port too) get a bus range number in
> system init,
> basing on currently plugged devices. That's why when one wants to
> hotplug another bridge,
> it needs his child bus, which the parent is unable to provide.
> The suggested workaround is to have vendor-specific capability in
> RedHat generic pcie-root-port
> that contains number of additional bus to reserve on BIOS PCI init.

Where is the qemu patch for this?

What about window sizes?  IIRC there was a plan to provide allocation
hints for them too ...

cheers,
  Gerd
