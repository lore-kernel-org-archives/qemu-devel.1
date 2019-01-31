Received: from eggs.gnu.org ([209.51.188.92]:53197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpITe-00083q-UZ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpITe-0003mK-7f
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:58:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gpITe-0003ll-2E
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:58:22 -0500
From: Laszlo Ersek <lersek@redhat.com>
References: <20190124203959.30875-1-lersek@redhat.com>
	<20190124203959.30875-5-lersek@redhat.com>
	<6d5868f5-70b4-71e2-3495-8d47156148c1@redhat.com>
	<f39b4b89-bd10-de9c-d3d2-c38411594f70@redhat.com>
Message-ID: <2dc8ea0f-047c-efa7-78d7-18eccf6a3148@redhat.com>
Date: Thu, 31 Jan 2019 20:58:06 +0100
MIME-Version: 1.0
In-Reply-To: <f39b4b89-bd10-de9c-d3d2-c38411594f70@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 01/31/19 19:55, Laszlo Ersek wrote:

> (4) IMPORTANT: did you make sure you didn't have an earlier *mis-built*
> BaseTools directory in the submodule? For that, run "make clean" in the
> QEMU project root.

Sorry, thinko above; the command to run is

  make -C tests/uefi-test-tools clean

> Note that "git clean -ffdx" will *not* clean
> submodules, when issued from the QEMU project root.

Thanks
Laszlo
