Received: from eggs.gnu.org ([2001:4830:134:3::10]:53924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRKhR-0005On-Gk
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRKhL-0005pm-CQ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:20:29 -0500
Received: from [59.151.112.132] (port=8456 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRKhK-0005fq-Vd
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:20:23 -0500
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170109234446-mutt-send-email-mst@kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58764E6E.2030905@cn.fujitsu.com>
Date: Wed, 11 Jan 2017 23:25:34 +0800
MIME-Version: 1.0
In-Reply-To: <20170109234446-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/10] Convert msix_init() to error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>



On 01/10/2017 05:45 AM, Michael S. Tsirkin wrote:
> On Mon, Nov 14, 2016 at 03:25:30PM +0800, Cao jin wrote:
>> v7 changelog:
>> 1. fix the segfaut bug in patch 2. So drop the all the R-b of it,
>>    please take a look, there is detailed description in the patch.
>> 2. add the R-b from Hannes Reinecke
>>
>> Test:
>> 1. make check: pass
>> 2. After applied all the patch, command line test for all the
>>    affected devices, just make sure device realize process is ok,
>>    no crash, but no further use of device.
> 
> Consider the megasas device for example, don't you
> need to test that the change actually does what
> it's intended to do?
> 

Thanks very much for your reminding, it does has a problem in patch
"megasas: remove unnecessary megasas_use_msix()", it is only one screw
megasas. Sorry for that.

Install linux distro to test megasas as following:

./qemu-system-x86_64 --enable-kvm -m 1024 -device
megasas,id=scsi0,bus=pci.0 -drive
file=/xx/xx/scsi-disk.img,if=none,id=drive-scsi0 -device
scsi-disk,bus=scsi0.0,channel=0,scsi-id=4,lun=0,drive=drive-scsi0,id=scsi0-4
-cdrom /xx/vm/Fedora-Server-DVD-x86_64-23.iso [-boot once=d] --monitor stdio

Sincerely,
Cao jin
