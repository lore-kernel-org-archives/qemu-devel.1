Received: from eggs.gnu.org ([2001:4830:134:3::10]:59438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cSo9R-0005kD-Hr
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 11:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cSo9O-0008Or-HD
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 11:59:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cSo9O-0008NA-B3
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 11:59:26 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A42AE4E03F
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 16:59:24 +0000 (UTC)
References: <1484137136-8021-1-git-send-email-marcel@redhat.com>
	<20170112173724-mutt-send-email-mst@kernel.org>
	<4e1faa9c-c586-cd85-5642-a337b43d8c25@redhat.com>
	<20170112181422-mutt-send-email-mst@kernel.org>
	<c88fdce9-4dc4-3b4e-321f-76e1f9ba1c3a@redhat.com>
	<1484296543.2019.10.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f305748b-cba6-e55a-4e26-ffa0d186c766@redhat.com>
Date: Sun, 15 Jan 2017 18:59:19 +0200
MIME-Version: 1.0
In-Reply-To: <1484296543.2019.10.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 0/3] hw/pcie: Introduce Generic PCI
 Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On 01/13/2017 10:35 AM, Gerd Hoffmann wrote:
>   Hi,
>
>> Sure, thanks for the pointers!
>> I suppose I can change later to msi-x in a follow up patch
>> to avoid introducing new bugs from the beginning :)
>
> I'd use msi-x right from start to avoid any backward compatibility
> issues.
>

Hi Gerd, Michael

I'll post a version with msi-x.

Thanks,
Marcel

> cheers,
>   Gerd
>
