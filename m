Received: from eggs.gnu.org ([2001:4830:134:3::10]:46601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7Lmn-0005Ht-Fw
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7LeX-0004fc-0A
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g7LeW-0004fU-QL
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:27:56 -0400
References: <20181002135538.12113-1-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e379f16b-0256-5754-237c-7affde14b482@redhat.com>
Date: Tue, 2 Oct 2018 09:27:53 -0500
MIME-Version: 1.0
In-Reply-To: <20181002135538.12113-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] qmp,
 hmp: make subsystem/system-vendor identities optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 10/2/18 8:55 AM, Denis V. Lunev wrote:
> According to PCI specification subsystem id and subsystem vendor id are
> optinal and could be abscent in Type1 header and can be found on

s/optinal/optional/
s/abscent/absent/

> different offsets within Type0 and Type2 headers.
> 
> Thus we should make this data optional in struct PciDeviceId and skip
> reporting them via HMP if the information is not available.
> 
> Additional (wrong information) about PCI bridges (Type1 devices) has been
> added in 5383a705 and fortunately not released. This patch fixes that
> problem. The problem was spotted by Markus.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> ---
>   hmp.c          |  6 ++++--
>   hw/pci/pci.c   | 13 ++++++++++---
>   qapi/misc.json |  4 ++--
>   3 files changed, 16 insertions(+), 7 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
