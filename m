Received: from eggs.gnu.org ([2001:4830:134:3::10]:45293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cg9QU-0002PS-4t
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cg9QQ-0004g0-5n
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:20:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cg9QP-0004eQ-Vr
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:20:10 -0500
References: <cover.1487286467.git.ben@skyportsystems.com>
	<20170220155752.32892bc3@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <68ab0463-6f6a-bff8-51ef-e60ceeeba639@redhat.com>
Date: Tue, 21 Feb 2017 13:20:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170220155752.32892bc3@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 0/8] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, ben@skyportsystems.com
Cc: Gerd Hoffmann <kraxel@redhat.com>, Kevin O'Connor <kevin@koconnor.net>, qemu-devel@nongnu.org, mst@redhat.com

On 02/20/17 15:57, Igor Mammedov wrote:
> On Thu, 16 Feb 2017 15:15:32 -0800
> ben@skyportsystems.com wrote:
> 
>> From: Ben Warren <ben@skyportsystems.com>
>>
>> This patch set adds support for passing a GUID to Windows guests.  It is a
>> re-implementation of previous patch sets written by Igor Mammedov et al, but
>> this time passing the GUID data as a fw_cfg blob.
>>
>> This patch set has dependencies on new guest functionality, in particular the
>> support for a new linker-loader command and the ability to write back data
>> to QEMU over a DMA link.  Work is in flight in both SeaBIOS and OVMF to support this.
>>
>> v7->v8:
>>     - Rebased to top of tree.
>>     - Fixed two small bugs in "write pointer" function
>>     - minor re-ordering of data in patches
>>     - Fixed unit test by adding delays/retries to reading RSDP table
> Michael,
> 
> series looks good for merging.

The OVMF patches for WRITE_POINTER are now upstream.

Thanks
Laszlo

> Patch
>  [PATCH v8 7/8] tests: Add unit tests for the VM  Generation ID feature
> needs updated seabios blob to make 'make check' happy
> so we probably should merge/update seabios first
>   [PATCH v5 0/5] QEMU: Add capability to write back fw_cfg address to QEMU
> 
> CCing Gerd and Kevin.
> 
