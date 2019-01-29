Received: from eggs.gnu.org ([209.51.188.92]:47446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goNsV-0003Vn-NX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goNsT-00053b-Ee
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:32:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goNsR-0004xd-Rz
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:32:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so20792942wrx.9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 23:32:11 -0800 (PST)
References: <alpine.BSF.2.21.9999.1901290213290.42676@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b87466e-3e9a-14ae-c827-ac5e61717a87@redhat.com>
Date: Tue, 29 Jan 2019 08:32:08 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901290213290.42676@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: BALATON Zoltan <balaton@eik.bme.hu>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi Zoltan,

On 1/29/19 2:20 AM, BALATON Zoltan wrote:
> Hello,
> 
> I'm getting error building on macOS after commit ddac19f534:
> 
>   CC      aarch64-softmmu/hw/virtio/virtio-blk-pci.o
> In file included from qemu/hw/virtio/virtio-9p-pci.c:19:
> In file included from qemu/hw/9pfs/virtio-9p.h:6:
> In file included from qemu/hw/9pfs/9p.h:7:
> qemu/fsdev/file-op-9p.h:19:10: fatal error: 'sys/vfs.h' file not found
> #include <sys/vfs.h>
>          ^~~~~~~~~~~
> 
> Am I missing something? (Apart from the include file which is not
> present on OS X... Maybe this needs the #ifdefs it had before the split?)

It seems commits are not correctly ordered for bisectability :(

If you cherry-pick ecd3b89b054, does it build?
