Received: from eggs.gnu.org ([2001:4830:134:3::10]:33907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVi1H-0007yJ-8B
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVi1G-0005jQ-F7
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:35:19 -0400
Date: Thu, 13 Jul 2017 20:35:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170713203308-mutt-send-email-mst@kernel.org>
References: <1499825297-20335-1-git-send-email-gengdongjiu@huawei.com>
	<1499825297-20335-2-git-send-email-gengdongjiu@huawei.com>
	<74ac9b79-0225-0cab-559f-6204754de5f0@redhat.com>
	<47cc803a-d1d9-da3b-43f9-31a54ce290e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47cc803a-d1d9-da3b-43f9-31a54ce290e2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/3] ACPI: Add new ACPI structures and
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: Laszlo Ersek <lersek@redhat.com>, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, james.morse@arm.com, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, Gaozhihui <zhihui.gao@huawei.com>

On Thu, Jul 13, 2017 at 08:00:26PM +0800, gengdongjiu wrote:
>    Laszlo, I pasted Michael's comments here, as shown below. Michael said the definition
> should use build_append_int_noprefix to add data. but I think it may not good, becuase
> the section "UEFI_CPER_SEC_PLATFORM_MEM" is runtime recorded as CPER,

One thing I wanted to understand is how are races avoided. E.g. what if
you are in the process of writing out CPER and guest reads it.
I tried to find where is this function writing CPER called and couldn't.
Can you clarify pls?

> not a ACPI/HEST
> table member, so it is not generated when system boot up. On the other hand,UEFI_CPER_SEC_PLATFORM_MEM
> definition is from UEFI spec 2.6, N.2.2 Section Descriptor: {0xA5BC1114, 0x6F64, 0x4EDE, {0xB8, 0x63, 0x3E, 0x83, 0xED, 0x7C, 0x83, 0xB1}}.
> if use  build_append_int_noprefix to add, may confuse others.

Right but ACPI/HEST generation could use cleanup, and build_append_int_noprefix
would be a nice way to do it.

-- 
MST
