Received: from eggs.gnu.org ([2001:4830:134:3::10]:60063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDSVc-0002JL-D2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDSVZ-0004W5-Vm
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:59:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDSVZ-0004QD-IM
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:59:57 -0400
Received: by mail-ot1-x342.google.com with SMTP id w67so32756239ota.7
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:59:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b8a89518794b4436af0c151ed10de4fa@dornerworks.com>
References: <b8a89518794b4436af0c151ed10de4fa@dornerworks.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 11:59:33 +0100
Message-ID: <CAFEAcA8FU97+DZH127zNgUwzornSCg2qMX=FDfXV1B40yqgGPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Andre Przywara <andre.przywara@arm.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Julien Grall <julien.grall@arm.com>

On 16 October 2018 at 16:06, Stewart Hildebrand
<Stewart.Hildebrand@dornerworks.com> wrote:
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
>
> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@dornerworks.com>
> ---


Applied to target-arm.next, thanks. I rephrased the comment a bit,
since this isn't a virt-board specific issue.

-- PMM
