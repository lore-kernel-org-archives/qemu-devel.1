Received: from eggs.gnu.org ([2001:4830:134:3::10]:55129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fiJSG-0001bK-Ut
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fiJSD-0006p9-HO
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:03:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fiJSD-0006oe-AA
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:03:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so7312084wrt.11
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 06:03:45 -0700 (PDT)
References: <3390c4bf-ffac-3744-fd85-84f4ee8193bf@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c285bce-478f-b786-76e0-f0810336ec23@redhat.com>
Date: Wed, 25 Jul 2018 15:03:42 +0200
MIME-Version: 1.0
In-Reply-To: <3390c4bf-ffac-3744-fd85-84f4ee8193bf@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] How to generate custom fw paths for
 IDE devices?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Laszlo Ersek <lersek@redhat.com>, armbru@redhat.com, marcel@redhat.com

On 18/07/2018 23:13, Mark Cave-Ayland wrote:
> One option may be to consider subclassing IDEBus and overriding
> idebus_get_fw_dev_path() there, but the cmd646 device is a child of
> TYPE_PCI_IDE which has its own internal IDEBus and so it seems
> overriding it is impossible.

It's possible as long as you don't add any members.  You can add a new
const char* argument to ide_bus_new, and call it from cmd646.

However, another possibility is to implement the FWPathProvider
interface in the sun4u machine type.  See hw/ppc/spapr.c for an example.

Thanks,

Paolo
