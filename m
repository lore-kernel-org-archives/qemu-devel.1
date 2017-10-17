Received: from eggs.gnu.org ([2001:4830:134:3::10]:37403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FgX-00079g-BO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FgW-0002Mv-IH
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:24:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-5-f4bug@amsat.org>
	<8a52b6be-ce55-307f-2bba-85858f739210@redhat.com>
	<72e73fee-0e1e-6988-038d-a9823e7b6d19@amsat.org>
Message-ID: <222c1152-fecb-f8ca-2714-43bf3678a34c@amsat.org>
Date: Mon, 16 Oct 2017 21:24:23 -0300
MIME-Version: 1.0
In-Reply-To: <72e73fee-0e1e-6988-038d-a9823e7b6d19@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 27/34] hw/pci: declare
 pci_nic_init_nofail() in "hw/net/pci.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Hi Marcel,

>> It seems the patch is doing much more than
>> what is mentioned in the subject.
>>
[...]
>> Can you add a short explanation on how the split
>> helps removing i386/pc dependency from non-PC world?
>> - it is not straight forward, at least for me.
> 
> I thought there was an old dependency on "hw/pci/pci.h" to something
> from i386/pc, so every machine using a PCI NIC would have this
> dependency. Extracting the NIC part as "hw/net/pci.h" would solve this
> issue. I didn't check attentively but it seems I was wrong, so I'll
> either drop this patch or reword it.

I finally opted to drop it for this series and include it reworded in
part 2 which include more PCI-related patches.

Regards,

Phil.
