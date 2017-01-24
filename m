Received: from eggs.gnu.org ([2001:4830:134:3::10]:33202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cW3P2-00045y-Qt
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cW3Oz-0000qo-Qt
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:53:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cW3Oz-0000qT-KN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:52:57 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DDA1C04B325
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 15:52:57 +0000 (UTC)
Message-ID: <1485273174.4350.10.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 24 Jan 2017 16:52:54 +0100
In-Reply-To: <1485199220-3298-1-git-send-email-marcel@redhat.com>
References: <1485199220-3298-1-git-send-email-marcel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 0/3] hw/pcie: Introduce Generic PCI
 Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, kraxel@redhat.com

On Mon, 2017-01-23 at 21:20 +0200, Marcel Apfelbaum wrote:
> v2 -> v3:
>  - Keep only the root port base class code in pcie_root_port.c (Michael)
>  - Use msix for the generic root port implementation (Michael and Gerd)
>    - The task required some refactoring like having some common
>      init/uninit interrupts functions to be implemented by both
>      generic and Intel Root Ports.
> 
> v1 -> v2:
>  - Rebased on master.
> 
> The Generic Root Port behaves the same as the
> Intel's IOH device with id 3420, without having
> Intel specific attributes.
> 
> The device has two purposes:
>  (1) Can be used on both X86 and ARM machines.
>  (2) It will allow us to tweak the behaviour
>     (e.g add vendor-specific PCI capabilities)
>      - something that obviously cannot be done
>        on a known device.
> 
> Patch 1/3: Introduce a base class for Root Ports - most of the code
>            is migrated from IOH3420 implementation.
> Patch 2/3: Derives the IOH3420 from the new base class
> Patch 3/3: Introduces the generic Root Port.
> 
> Tested with Linux and Windows guests only on x86 hosts.

(on aarch64, Fedora guest)

Tested-by: Andrea Bolognani <abologna@redhat.com>

-- 
Andrea Bolognani / Red Hat / Virtualization
