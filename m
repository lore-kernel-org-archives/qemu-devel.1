Received: from eggs.gnu.org ([2001:4830:134:3::10]:57478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWojj-0006qQ-EG
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWoje-0001nD-FL
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:25:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWoje-0001n3-9N
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:25:26 -0500
References: <cover.1485308342.git.ben@skyportsystems.com>
	<dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
	<827795cf-5399-7092-267e-e912141931f3@redhat.com>
	<29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
	<20170125202812-mutt-send-email-mst@kernel.org>
	<2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
	<20170126165015-mutt-send-email-mst@kernel.org>
	<adbfd67b-bcbc-2da2-78be-810eb35781ec@redhat.com>
	<20170126201124-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6d15ef62-3184-3293-dd83-da67dd48dab0@redhat.com>
Date: Thu, 26 Jan 2017 19:25:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170126201124-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/9] ACPI: Add a function for building
 named qword entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On 01/26/17 19:15, Michael S. Tsirkin wrote:
> On Thu, Jan 26, 2017 at 06:43:22PM +0100, Laszlo Ersek wrote:
>> On 01/26/17 16:20, Michael S. Tsirkin wrote:
>>> On Thu, Jan 26, 2017 at 01:48:37AM +0100, Laszlo Ersek wrote:
>>
>>>> But, again, I'd like to keep COMMAND_ALLOCATE_RETURN_ADDR 8-byte wide.
>>>
>>>
>>> What is COMMAND_ALLOCATE_RETURN_ADDR? I'm only familiar with
>>> COMMAND_ALLOCATE.
>>
>> It's a new command being introduced in this series, at my suggestion. It
>> does the exact same thing as COMMAND_ALLOCATE, except once the
>> allocation / download is carried out by the firmware, the firmware
>> writes back the allocation address to the fw_cfg file that is named in
>> an additional field of the COMMAND_ALLOCATE_RETURN_ADDR structure. (This
>> is how QEMU learns where the blob in GPA space was placed by the
>> firmware.) The format for this address-receiving fw_cfg file is supposed
>> to be 8-byte, little endian.
> 
> I see. I really think it's better as a separate command though.
> E.g. COMMAND_WRITE_PTR?

Sure, but please provide specifics, otherwise Ben & myself will have a
hard time divining & implementing your intent :)

Thanks,
Laszlo
