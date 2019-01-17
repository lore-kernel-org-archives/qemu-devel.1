Received: from eggs.gnu.org ([209.51.188.92]:58729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk69U-00088J-Cb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk69S-0007Rg-U8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:48:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:31963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gk69S-0007Lc-KU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:48:02 -0500
Date: Thu, 17 Jan 2019 19:44:20 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190117114420.GF11760@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-7-yang.zhong@intel.com>
	<56bbd753-dc3d-fef0-0416-cb204893f722@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bbd753-dc3d-fef0-0416-cb204893f722@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 06/37] hw/mips/Makefile.objs: Create
 CONFIG_* for r4k, malta, mipssim boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, =?iso-8859-1?Q?=E1kos_Kov=E1cs?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com, yang.zhong@intel.com

On Wed, Jan 16, 2019 at 09:34:15AM +0100, Thomas Huth wrote:
> On 2019-01-15 15:10, Yang Zhong wrote:
[...] 
> I think that change to the CONFIG_VT82C686 is unrelated and should not
> be part of this patch. Also looking at commit
> 
>  dff4021730b112ca00522d4c98c24a15feeef5a0
>  mips: Remove CONFIG_VT82C686 from non-Fulong configs
> 
> it seems like it should stay in mips64el-softmmu.mak and not be moved to
> mips-softmmu-common.mak.
> 
  Hello Thomas,

  Wow, you can find this corner case, and thanks for you detailed review.

  Regards,

  Yang

>  Thomas
