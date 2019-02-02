Received: from eggs.gnu.org ([209.51.188.92]:48638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gpytW-00006l-Iy
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 12:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gpytV-0007bF-SC
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 12:15:54 -0500
References: <1548942810-22942-1-git-send-email-thuth@redhat.com>
	<1548942810-22942-3-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <2fa6bb50-401c-ae97-807c-2ef8d56428b3@reactos.org>
Date: Sat, 2 Feb 2019 18:13:01 +0100
MIME-Version: 1.0
In-Reply-To: <1548942810-22942-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] ppc: Express dependencies of the
 'prep' and '40p' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, yang.zhong@intel.com

Le 31/01/2019 à 14:53, Thomas Huth a écrit :
> Select the required devices in hw/ppc/Kconfig instead, so that
> ppc-softmmu.mak only contains the user-selectable PREP switch.
> Plug-in devices like NE2000_ISA are pulled in automatically by the
> Kconfig build system now.
> 
> Cc: Hervé Poussineau <hpoussin@reactos.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   default-configs/ppc-softmmu.mak | 8 --------
>   hw/ppc/Kconfig                  | 8 ++++++++
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
