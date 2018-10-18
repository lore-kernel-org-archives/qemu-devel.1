Received: from eggs.gnu.org ([2001:4830:134:3::10]:51884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gD8eq-0000OR-AY
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gD8en-0007vs-6M
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gD8em-0007vI-VT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:48:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8344C3002E34
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:48:07 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
References: <20180927212438.32024-1-lersek@redhat.com>
	<785e1781-398c-725f-4ded-b81b4aabe220@redhat.com>
Message-ID: <a7f30106-87ad-edb5-ba7d-4b8552c49269@redhat.com>
Date: Thu, 18 Oct 2018 15:47:59 +0200
MIME-Version: 1.0
In-Reply-To: <785e1781-398c-725f-4ded-b81b4aabe220@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] hw/pci-host/x86: extend the 64-bit
 PCI hole relative to the fw-assigned base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 10/11/18 09:59, Laszlo Ersek wrote:
> Michael,
> 
> On 09/27/18 23:24, Laszlo Ersek wrote:
>> This is v2 of the series previously posted at
>> <http://mid.mail-archive.com/20180924221346.16733-1-lersek@redhat.com>.
>>
>> Changes are noted on every patch.
> 
> can you please merge this series?
> 
> Please note that it depends on v2 of the following patch, from Gerd:
> 
>> The bios-tables-test case depends on Gerd's "[PATCH] pci-testdev: add
>> optional memory bar" at
>> <https://patchew.org/QEMU/20180927121055.28361-1-kraxel@redhat.com/>.
> 
> [Qemu-devel] [PATCH v2] pci-testdev: add optional memory bar
> message-id: <20180928064419.2106-1-kraxel@redhat.com>
> 
> so please include that as well (first).

Ping
