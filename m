Received: from eggs.gnu.org ([2001:4830:134:3::10]:56003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTWlE-0007Uo-JH
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 11:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTWl9-0002sE-O2
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 11:37:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cTWl9-0002rk-Hl
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 11:37:23 -0500
References: <cover.1484593565.git.ben@skyportsystems.com>
	<ac2ea4262e8e64d010b152493ce3a3e1cc85e225.1484594095.git.ben@skyportsystems.com>
	<20170117140058.166de8c2@nial.brq.redhat.com>
	<20170117163848-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6bbd752d-d354-808e-81c6-2aa270997538@redhat.com>
Date: Tue, 17 Jan 2017 17:37:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170117163848-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On 01/17/17 15:41, Michael S. Tsirkin wrote:
> On Tue, Jan 17, 2017 at 02:00:58PM +0100, Igor Mammedov wrote:
>> Question is how you'd get address of it and I think that's where
>> writable fwcfg files come in play.
>> I'd prefer fwcfg_loader in firmware to write it back after buffer
>> allocation is done as it's already has utilities for fw_cfg,
>> but that probably would mean extending loader protocol to support
>> new writeback command.
> 
> Right. It's quite easy to do as at least seabios was written to
> ignore commands it does not recognize. So with old bios you
> just don't get a write. Not sure about UEFI, worth checking.

Same; OVMF skips (and logs) unknown commands.

> 
>> PS, address one would get from guest should be migrated as well
> 
> IIRC writeable fw cfg blobs are migrated automatically.
> 

When added with rom_add_blob() or derivative functions / function-like
macros, they are.

Thanks
Laszlo
