Received: from eggs.gnu.org ([2001:4830:134:3::10]:37610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dShru-0000BD-Uf
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dShrq-0003xp-3g
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:49:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dShrp-0003xe-Tl
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:49:10 -0400
References: <1499237876.3041.4.camel@linux.intel.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3af410ff-9fd3-3175-18be-ea5ae8e6b0b7@redhat.com>
Date: Wed, 5 Jul 2017 12:49:07 +0200
MIME-Version: 1.0
In-Reply-To: <1499237876.3041.4.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Peng <chao.p.peng@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Tian, Kevin" <kevin.tian@intel.com>

On 07/05/17 08:57, Chao Peng wrote:
> Hi,
>  
> Q35 has been in QEMU for quite a while. Compared to the current default
> i440FX, Q35 is probably not that mature and not widely used, however in
> some case, Q35 has advantages, for example, in supporting new features.
> For instance, we have some features require PCI-e support which is only
> available on Q35 and some others need it for EFI support.

To be a bit more precise: OVMF's default upstream build works fine with
i440fx. But, if you build OVMF with "-D SMM_REQUIRE" -- which is
required for making "-D SECURE_BOOT_ENABLE" actually secure --, then you
do need q35 (the firmware binary won't even boot on i440fx past a
certain point), because only q35 provides SMM emulation.

Thanks
Laszlo

> It is of
> course not necessary to change it as the default but if more and more
> features have dependencies on Q35 because of requiring much more modern
> features then I think it may be worth to do so. In such case we can have
> more people to use it and find problems we may know or not know. There
> are certainly some drawbacks:
> -        Compatibility: current code or script may need adjustment
> -        Quality: we may suffer more bugs on Q35
>  
> Any thoughts?
>  
> Chao
> 
