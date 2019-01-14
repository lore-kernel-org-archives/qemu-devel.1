Received: from eggs.gnu.org ([209.51.188.92]:50983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizW3-0003tt-Js
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizW2-00088F-VJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:30:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gizW2-00086w-P7
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:30:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so22154638wrt.11
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:30:46 -0800 (PST)
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-11-philmd@redhat.com>
	<3d52c4eb-1254-08e2-440c-3edb42c2ba01@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1588529c-2606-5994-2a25-10e3488e7f28@redhat.com>
Date: Mon, 14 Jan 2019 11:30:44 +0100
MIME-Version: 1.0
In-Reply-To: <3d52c4eb-1254-08e2-440c-3edb42c2ba01@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/15] range: Remove Range from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

On 1/14/19 9:56 AM, Thomas Huth wrote:
> On 2019-01-11 15:08, Philippe Mathieu-Daudé wrote:
>> Range is only used in "hw/pci-host/q35.h" in the MCHPCIState, and
>> in "hw/pci/pci.h" by pci_bus_get_w64_range().  Let them include
>> "qemu/range.h" directly to simplify "qemu/typedefs.h".
>>
>> To clean "qemu/typedefs.h", move the declaration to "qemu/range.h"
>> (removing the forward declaration).
> 
> Since Range seems to be meant as a common type (i.e. not specific to any
> device like the other typedefs that you move in this series), I think
> it's should be OK if this resides in typedefs.h ?

My idea was to clean files not very used, and this one is only used
twice. Why rebuild the World if someone add another function or fix a
typo in "qemu/range.h"?
I agree this typedef is meant for global use however.

Since I don't have a strong opinion, I'll drop it (until someone else
respond to this thread).
