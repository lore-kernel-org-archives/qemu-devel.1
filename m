Received: from eggs.gnu.org ([2001:4830:134:3::10]:56064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxFVw-00047J-IN
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxFVr-00087m-FL
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:48:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dxFVr-00087X-9O
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:48:43 -0400
References: <b5786d73-10f9-bba8-28c6-275cdf623004@redhat.com>
	<CAKSfGUC5qvxreaP2cVusw6wAaHV9H8NQ91x9EtiSiz9Y-LkmTQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c0074bc4-ae13-6321-f830-27257334419b@redhat.com>
Date: Wed, 27 Sep 2017 18:48:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAKSfGUC5qvxreaP2cVusw6wAaHV9H8NQ91x9EtiSiz9Y-LkmTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Problem in pcie_pci_bridge_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 27.09.2017 18:22, Aleksandr Bezzubikov wrote:
> 2017-09-27 18:50 GMT+03:00 Thomas Huth <thuth@redhat.com>:
>>  Hi,
>>
>> QEMU currently aborts with an assertion when plugging of the
>> pcie-pci-bridge fails, e.g.:
>>
>> $ mips64el-softmmu/qemu-system-mips64el -M malta -nographic -S \
>>                 -device pcie-pci-bridge -bios pc-bios/bios.bin
>> qemu-system-mips64el: memory.c:1699: memory_region_finalize:
>>  Assertion `!mr->container' failed.
>> Aborted (core dumped)
[...]
> Hi Thomas,
> This bug was already reported by Eduardo with ppc64, try this patch
> that is intended to fix it
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg06696.html

Thanks, that fixed the issue indeed!

 Thomas
