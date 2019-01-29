Received: from eggs.gnu.org ([209.51.188.92]:52635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1goQYj-0001Yw-W1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1goQYj-0005VF-99
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:24:01 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:32811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1goQYj-0005UL-31
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:24:01 -0500
Date: Tue, 29 Jan 2019 11:23:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <8b87466e-3e9a-14ae-c827-ac5e61717a87@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1901291123160.84186@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1901290213290.42676@zero.eik.bme.hu>
	<8b87466e-3e9a-14ae-c827-ac5e61717a87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] macOS build error after ddac19f534 (virtio: split
 virtio 9p bits from virtio-pci)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 29 Jan 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/29/19 2:20 AM, BALATON Zoltan wrote:
>> Hello,
>>
>> I'm getting error building on macOS after commit ddac19f534:
>>
>> ? CC????? aarch64-softmmu/hw/virtio/virtio-blk-pci.o
>> In file included from qemu/hw/virtio/virtio-9p-pci.c:19:
>> In file included from qemu/hw/9pfs/virtio-9p.h:6:
>> In file included from qemu/hw/9pfs/9p.h:7:
>> qemu/fsdev/file-op-9p.h:19:10: fatal error: 'sys/vfs.h' file not found
>> #include <sys/vfs.h>
>> ???????? ^~~~~~~~~~~
>>
>> Am I missing something? (Apart from the include file which is not
>> present on OS X... Maybe this needs the #ifdefs it had before the spli=
t?)
>
> It seems commits are not correctly ordered for bisectability :(
>
> If you cherry-pick ecd3b89b054, does it build?

No it fails with same error on HEAD as well ever since the above commit.

Regards,
BALATON Zoltan
