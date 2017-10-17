Received: from eggs.gnu.org ([2001:4830:134:3::10]:58978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <humbell@inf.ethz.ch>) id 1e4Lno-0000yA-Rf
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <humbell@inf.ethz.ch>) id 1e4Lnl-0000qy-QP
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:56:36 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:12747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <humbell@inf.ethz.ch>) id 1e4Lnl-0000py-IZ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:56:33 -0400
References: <1508169816-5993-1-git-send-email-lukas.humbel@inf.ethz.ch>
	<20171016200124-mutt-send-email-mst@kernel.org>
From: Lukas Humbel <lukas.humbel@inf.ethz.ch>
Message-ID: <db57339d-ba39-5b4d-cdfd-be6200871007@inf.ethz.ch>
Date: Tue, 17 Oct 2017 08:33:50 +0200
MIME-Version: 1.0
In-Reply-To: <20171016200124-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw/pci: Add e1000e NIC as command line
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>


On 16.10.2017 19:02, Michael S. Tsirkin wrote:
> On Mon, Oct 16, 2017 at 06:03:36PM +0200, lukas.humbel@inf.ethz.ch wrote:
>> From: Lukas Humbel <lukas.humbel@inf.ethz.ch>
>>
>> Signed-off-by: Lukas Humbel <lukas.humbel@inf.ethz.ch>
> We keep these around for legacy reasons but I'm not sure we need to add
> to the list.  What's wrong with just creating them with -device e1000e?
Ah, I didn't realize that the -net argument is considered legacy. I
think there is nothing stopping me from using -device...

Thanks,
Lukas
>
>> ---
>>  hw/pci/pci.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 1e6fb88..9d6cd04 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1819,6 +1819,7 @@ static const char * const pci_nic_models[] = {
>>      "i82559er",
>>      "rtl8139",
>>      "e1000",
>> +    "e1000e",
>>      "pcnet",
>>      "virtio",
>>      "sungem",
>> @@ -1832,6 +1833,7 @@ static const char * const pci_nic_names[] = {
>>      "i82559er",
>>      "rtl8139",
>>      "e1000",
>> +    "e1000e",
>>      "pcnet",
>>      "virtio-net-pci",
>>      "sungem",
>> -- 
>> 2.7.4

-- 
Lukas Humbel
