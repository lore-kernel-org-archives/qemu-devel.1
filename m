Received: from eggs.gnu.org ([2001:4830:134:3::10]:58532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gKvsv-0008Bz-Ml
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 20:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gKvsu-00021D-Lz
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 20:46:57 -0500
References: <20181105205641.17862-1-v.mayatskih@gmail.com>
	<20181105205641.17862-2-v.mayatskih@gmail.com>
	<d96db69e-1276-b4d5-e8a1-e9cdf8bda567@oracle.com>
	<20181108114640-mutt-send-email-mst@kernel.org>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <1b0590da-68a2-cc52-bfe8-cb6e59eb43ec@oracle.com>
Date: Fri, 9 Nov 2018 09:48:17 +0800
MIME-Version: 1.0
In-Reply-To: <20181108114640-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1 V2] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Vitaly Mayatskikh <v.mayatskih@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>



On 11/09/2018 12:47 AM, Michael S. Tsirkin wrote:
> On Thu, Nov 08, 2018 at 10:09:00PM +0800, Dongli Zhang wrote:
>> It looks the kernel space vhost-blk can only process raw image.
>>
>> How about to verify that only raw image is used in the drive command line when
>> vhost-blk-pci is paired with it?
>>
>> Otherwise, vhost-blk-pci might be working with qcow2 image without any warning
>> on qemu side.
>>
>> Dongli Zhang
> 
> raw being raw can you really verify that?
> 

I meant to verify the property 'format=' of '-drive', e.g., to check if
BlockBackend->root->bs->drv->format_name is raw?

We allow the user to erroneously give a qcow2 file with 'format=raw'. However,
if 'format=qcow2' is set explicitly, vhots-blk-pci would exit with error as only
raw is supported in kernel space.

Dongli Zhang
