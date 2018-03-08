Received: from eggs.gnu.org ([2001:4830:134:3::10]:46588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu1eT-0001ma-0t
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu1eP-0005EG-9h
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:56:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eu1eP-0005E3-4d
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:56:29 -0500
From: Laszlo Ersek <lersek@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-9-marcandre.lureau@redhat.com>
	<a62073a3-cc41-ca4b-4822-e28ebcf5204b@redhat.com>
Message-ID: <4776cb4a-4037-2a0d-f07d-f627bffabbbf@redhat.com>
Date: Thu, 8 Mar 2018 20:56:26 +0100
MIME-Version: 1.0
In-Reply-To: <a62073a3-cc41-ca4b-4822-e28ebcf5204b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] ovmf: add DxeTpm2MeasureBootLib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org, jiewen.yao@intel.com
Cc: pjones@redhat.com, stefanb@linux.vnet.ibm.com, qemu-devel@nongnu.org, javierm@redhat.com

On 03/08/18 20:54, Laszlo Ersek wrote:

> In other words, the ordering between Tcg2Dxe and external UEFI_DRIVER /
> UEFI_APPLICATION modules is ensured that Tcg2Dxe will be dispatched in
> the DXE phase, while the latter will only be loaded in BDS.

Sigh, I meant:

The ordering between Tcg2Dxe and external UEFI_DRIVER / UEFI_APPLICATION
modules is ensured *by the fact* that Tcg2Dxe will be dispatched in the
DXE phase, while the latter will only be loaded in BDS.

Thanks,
Laszlo
