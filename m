Received: from eggs.gnu.org ([2001:4830:134:3::10]:40716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZl83-0004FS-Bk
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZl82-00058p-G7
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:43:03 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:34157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZl82-00058F-9T
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:43:02 -0400
Received: by mail-pg0-x229.google.com with SMTP id 123so62383377pgj.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:43:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724234138-mutt-send-email-mst@kernel.org>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-7-git-send-email-zuban32s@gmail.com>
	<20170724234138-mutt-send-email-mst@kernel.org>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Tue, 25 Jul 2017 00:43:00 +0300
Message-ID: <CAKSfGUDf090V2Q=Vnpxq0S1o+Ho5gp63BKgkzmDMU=HDL7fGHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/6] hw/pci: add hint capabilty for
 additional bus reservation to pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, seabios@seabios.org

2017-07-24 23:43 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:
> On Sun, Jul 23, 2017 at 01:15:43AM +0300, Aleksandr Bezzubikov wrote:
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> ---
>>  hw/pci-bridge/pcie_root_port.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
>> index b0e49e1..ca92d85 100644
>> --- a/hw/pci-bridge/pcie_root_port.c
>> +++ b/hw/pci-bridge/pcie_root_port.c
>> @@ -106,6 +106,11 @@ static void rp_realize(PCIDevice *d, Error **errp)
>>      pcie_aer_root_init(d);
>>      rp_aer_vector_update(d);
>>
>> +    rc = pci_bridge_help_cap_init(d, 0, p->bus_reserve, 0, 0, 0, errp);
>> +    if (rc < 0) {
>> +        goto err;
>> +    }
>> +
>>      return;
>>
>>  err:
>
> It looks like this will add the capability unconditionally to all
> pcie root ports. Two issues with it:
> 1. you can't add vendor properties to devices where vendor is
>    not qemu as they might have their own concept of what it does.
> 2. this will break compatibility with old machine types,
>    need to disable for these
>

Actually the original idea was to add it for pcie-root-port excusively
(for now at least), looks like I've confused a little with files naming.
Will add it for v3.

>> --
>> 2.7.4



-- 
Alexander Bezzubikov
