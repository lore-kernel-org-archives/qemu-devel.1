Received: from eggs.gnu.org ([2001:4830:134:3::10]:40739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD83R-0002G6-TG
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD83L-00088o-SC
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:09:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gD83K-00086g-6P
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:09:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so208164wmd.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 06:09:14 -0700 (PDT)
References: <20181018130434.23237-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <43045a7f-4092-c039-af58-6221db22d3f4@redhat.com>
Date: Thu, 18 Oct 2018 15:09:12 +0200
MIME-Version: 1.0
In-Reply-To: <20181018130434.23237-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] hw/misc: Add a MMIO interface to
 the pvpanic device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Wen Congyang <wency@cn.fujitsu.com>, Hu Tao <hutao@cn.fujitsu.com>

On 18/10/2018 15:04, Philippe Mathieu-Daudé wrote:
> Hi, this series takes Peng Hao's previous work but rather than adding yet
> another device, simply add the MMIO interface to the current device (which
> only implements the I/O port access). 
> 
> The first patches are simple cleanups:
> - patch 1 move the pvpanic device with the 'ocmmon objects' so we compile
>   it once for the x86/arm/aarch64 archs,
> - patch 2 simply renames ISA fields/definitions to generic ones.
> 
> Then instead of add/use the MMIO pvpanic device in the virt machine in an
> unique patch, I split it in two distinct patches:
> - patch 3 uses Peng Hao's work, but add the MMIO interface to the existing
>   device (no logical change).
> - patch 4 is Peng Hao's work in the virt machine (no logical change).
> 
> v2 from Peng Hao is:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03433.html
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (4):
>   hw/misc/pvpanic: Build the pvpanic device in $(common-obj)
>   hw/misc/pvpanic: Cosmetic renaming

Oops I failed when rebasing, these two are supposed to be from

  Peng Hao

with below my S-o-b:
[PMD: Use TYPE_PVPANIC definition, split in 2 patches,
     improved patch subject]

>   hw/misc/pvpanic: Add the MMIO interface
>   hw/arm/virt: Use the pvpanic device
> 
>  default-configs/arm-softmmu.mak |  2 +-
>  hw/arm/virt.c                   | 21 ++++++++++
>  hw/misc/Makefile.objs           |  2 +-
>  hw/misc/pvpanic.c               | 68 +++++++++++++++++++++++++++++----
>  include/hw/arm/virt.h           |  1 +
>  5 files changed, 84 insertions(+), 10 deletions(-)
> 
