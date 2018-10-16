Received: from eggs.gnu.org ([2001:4830:134:3::10]:57357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1gCRo5-0004Sb-8e
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1gCRny-0000s5-33
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:02:53 -0400
Date: Tue, 16 Oct 2018 17:02:06 +0100
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <20181016170206.500a12de@donnerap.cambridge.arm.com>
In-Reply-To: <b8a89518794b4436af0c151ed10de4fa@dornerworks.com>
References: <b8a89518794b4436af0c151ed10de4fa@dornerworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/boot: Increase compliance with
 kernel arm64 boot protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Julien Grall <julien.grall@arm.com>

On Tue, 16 Oct 2018 15:06:29 +0000
Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com> wrote:

Hi, 

> "The Image must be placed text_offset bytes from a 2MB aligned base
> address anywhere in usable system RAM and called there."
> 
> For the virt board, we write our startup bootloader at the very
> bottom of RAM, so that bit can't be used for the image. To avoid
> overlap in case the image requests to be loaded at an offset
> smaller than our bootloader, we increment the load offset to the
> next 2MB.
> 
> This fixes a boot failure for Xen AArch64.

Thanks for that, works for me.

> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@dornerworks.com>

Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.
