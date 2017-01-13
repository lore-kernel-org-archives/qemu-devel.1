Received: from eggs.gnu.org ([2001:4830:134:3::10]:46718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRxKx-00035P-2V
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRxKt-00028U-7U
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:35:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRxKt-00028F-2B
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:35:47 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 068A58535A
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:35:47 +0000 (UTC)
Message-ID: <1484296543.2019.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 13 Jan 2017 09:35:43 +0100
In-Reply-To: <c88fdce9-4dc4-3b4e-321f-76e1f9ba1c3a@redhat.com>
References: <1484137136-8021-1-git-send-email-marcel@redhat.com>
	<20170112173724-mutt-send-email-mst@kernel.org>
	<4e1faa9c-c586-cd85-5642-a337b43d8c25@redhat.com>
	<20170112181422-mutt-send-email-mst@kernel.org>
	<c88fdce9-4dc4-3b4e-321f-76e1f9ba1c3a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

  Hi,

> Sure, thanks for the pointers!
> I suppose I can change later to msi-x in a follow up patch
> to avoid introducing new bugs from the beginning :)

I'd use msi-x right from start to avoid any backward compatibility
issues.

cheers,
  Gerd
