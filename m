Received: from eggs.gnu.org ([2001:4830:134:3::10]:49308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZJOM-0006dL-Cm
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZJOL-0000Ql-87
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:06:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dZJOL-0000QP-0t
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:06:01 -0400
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<1500761510-1556-3-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <b66aaeea-aeb5-cfba-2478-7ea7a5addd9d@redhat.com>
Date: Sun, 23 Jul 2017 19:05:50 +0300
MIME-Version: 1.0
In-Reply-To: <1500761510-1556-3-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/4] pci: add RedHat vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com

On 23/07/2017 1:11, Aleksandr Bezzubikov wrote:
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   src/hw/pci_ids.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/src/hw/pci_ids.h b/src/hw/pci_ids.h
> index 4ac73b4..db2e694 100644
> --- a/src/hw/pci_ids.h
> +++ b/src/hw/pci_ids.h
> @@ -2263,6 +2263,8 @@
>   #define PCI_DEVICE_ID_KORENIX_JETCARDF0	0x1600
>   #define PCI_DEVICE_ID_KORENIX_JETCARDF1	0x16ff
>   
> +#define PCI_VENDOR_ID_REDHAT 		0x1b36
> +
>   #define PCI_VENDOR_ID_TEKRAM		0x1de1
>   #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>   
> 

I suggest to merge this patch with patch 4
that uses it.


Thanks,
Marcel
