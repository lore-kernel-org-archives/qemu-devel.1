Received: from eggs.gnu.org ([2001:4830:134:3::10]:49851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fnTsA-0006ve-7W
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fnTs7-0003Ts-2p
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:11:54 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41452
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fnTs6-0003Jx-QB
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:11:50 -0400
References: <20180805112850.26063-1-mark.cave-ayland@ilande.co.uk>
	<20180805112850.26063-3-mark.cave-ayland@ilande.co.uk>
	<20180806201128.GB12341@localhost.localdomain>
	<987d9b7e-afdb-e954-4aae-ec192b2b51c9@ilande.co.uk>
	<20180807194558.GZ23195@localhost.localdomain>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <59409730-10ff-86ff-de36-8926eae91d80@ilande.co.uk>
Date: Wed, 8 Aug 2018 20:11:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180807194558.GZ23195@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] fw_cfg: set the
 get_boot_devices_list() ignore_suffixes parameter from machine property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: lersek@redhat.com, qemu-devel@nongnu.org

On 07/08/18 20:45, Eduardo Habkost wrote:

>> Is this sufficient, or are the compat properties supposed to be versioned
>> according to the QEMU machine version?
> 
> I never saw compat_properties being used for non-versioned
> machines, but it should work for this use case as well.
> 
> But, I'm not sure this is the best option.  If the machine type
> is not versioned, you can simply manually set the device property
> to the desired value when creating the device inside your machine
> init function.  See how the "data_width" and "dma_enabled"
> properties are set by existing machines, for an example.

After some more digging, I can see that you are right and that we can 
actually get away with a standard qdev property for the fw_cfg device 
rather than a machine property after all - it's just that I need to 
convert both machines away from using the old fw_cfg_init() functions 
first. I'll send over what I have shortly.


ATB,

Mark.
