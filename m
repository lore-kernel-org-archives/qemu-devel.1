Received: from eggs.gnu.org ([209.51.188.92]:45676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3L4Z-0006DL-Tk
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3L4T-00031f-MF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:34:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3L4R-00030E-Rx
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:34:24 -0400
References: <20190308123937.2346-1-kraxel@redhat.com>
	<CAFEAcA-trb9TKzEtbbSXEJapBrqUpBvLFE5zFObMRqD9u6zeJg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <31a1fc19-377b-4339-480e-fed2c919481f@redhat.com>
Date: Mon, 11 Mar 2019 14:33:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-trb9TKzEtbbSXEJapBrqUpBvLFE5zFObMRqD9u6zeJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/5] Vga 20190308 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 09/03/19 15:42, Peter Maydell wrote:
> On Fri, 8 Mar 2019 at 12:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:
>>
>>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://git.kraxel.org/qemu tags/vga-20190308-pull-request
>>
>> for you to fetch changes up to 61dbd9eaa1450f94886fb41366e4687d405c52c8:
>>
>>   virtio-gpu: make virtio_gpu_reset static (2019-03-08 09:36:23 +0100)
>>
>> ----------------------------------------------------------------
>> vga: virtio reset fix, add ati emulation.
>>
>> ----------------------------------------------------------------
> 
> Hi -- I'm afraid this has conflicted with the Kconfig merge:
> 
> CONFLICT (modify/delete): default-configs/pci.mak deleted in HEAD and
> modified in remotes/kraxel/tags/vga-20190308-pull-request.
> 
> Can you figure out what the Kconfig equivalent of the
> pci.mak change is and resend, please?

Should be:

config ATI_VGA
    bool
    default y if PCI_DEVICES
    depends on PCI
    select VGA

Paolo
