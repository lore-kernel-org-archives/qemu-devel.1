Received: from eggs.gnu.org ([2001:4830:134:3::10]:57816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZYwG-0000RM-AZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZYwB-0004qw-EW
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:42:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dZYwB-0004pP-84
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:41:59 -0400
Message-ID: <1500885714.15837.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Jul 2017 10:41:54 +0200
In-Reply-To: <b1a62908-c925-3dde-583b-71e3967539a6@redhat.com>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500533554.6553.1.camel@redhat.com>
	<3e0f92ea-58ce-abfb-1aed-4d56c1fa68b2@redhat.com>
	<1500631461.12926.5.camel@redhat.com>
	<eeba9fcf-4b52-2c24-af03-d88333cd2dc6@redhat.com>
	<1500640952.12926.9.camel@redhat.com>
	<b1a62908-c925-3dde-583b-71e3967539a6@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>

  Hi,

> Maybe we don't want to allocate IO at all,
> So value 0 would say do not allocate.
> 
> But we can disable IO by other means.

Indeed.  As IO is optional for pcie we don't need a qemu-specific
extension for that.

cheers,
  Gerd
