Received: from eggs.gnu.org ([2001:4830:134:3::10]:34729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1e42VW-0005Ew-8j
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1e42VT-0002L9-5T
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:20:26 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:47089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xiaoguangrong.eric@gmail.com>)
	id 1e42VS-0002KY-R9
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:20:23 -0400
Received: by mail-io0-x242.google.com with SMTP id 101so15491580ioj.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 03:20:21 -0700 (PDT)
References: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
From: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Message-ID: <ebb88add-3173-78b9-397e-53a364ca0d53@gmail.com>
Date: Mon, 16 Oct 2017 18:20:32 +0800
MIME-Version: 1.0
In-Reply-To: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] add "nopin" option in the
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, anthony.xu@intel.com



On 10/16/2017 04:56 PM, Yang Zhong wrote:
> Qemu does not need pin NVDIMM memory for VFIO device during VFIO
> hotplug, what's more, if there is no NVDIMM hw in the test machine,
> the VFIO hotplug operation will need at least 10 minutes to pin RAM
> as the NVDIMM, this time is not accepted. So we add "nopin=on" option
> in the memory-backed-file, which can avoid to pin RAM memory for NVDIMM.

No.

memory-backed-file does not dedicate for nvdimm only, it can be mapped
as normal memory as well. Rather more, this is no way to stop guest to
use it as DMA.
