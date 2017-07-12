Received: from eggs.gnu.org ([2001:4830:134:3::10]:53953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dVAyn-0002AV-20
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dVAyj-0006di-UG
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:18:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dVAyj-0006dV-Ng
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:18:29 -0400
References: <5233eee1-a017-ccae-3458-762c9e86902c@redhat.com>
	<20170707133949.GH10776@localhost.localdomain>
	<20170707181642-mutt-send-email-mst@kernel.org>
	<20170707180358.GA12152@localhost.localdomain>
	<626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
	<20170710135943.GG12152@localhost.localdomain>
	<20170710194345-mutt-send-email-mst@kernel.org>
	<20170710174730.GL12152@localhost.localdomain>
	<063778b8-d517-dcac-3c83-95076604a16c@redhat.com>
	<1499760785.8257.5.camel@redhat.com>
	<20170711144215.GI4335@noname.str.redhat.com>
	<1499838706.18762.1.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <b3bd4bd1-dbe0-ba4f-bb4f-9eacd0773597@redhat.com>
Date: Wed, 12 Jul 2017 09:18:18 +0300
MIME-Version: 1.0
In-Reply-To: <1499838706.18762.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 12/07/2017 8:51, Gerd Hoffmann wrote:
>    Hi,
>

Hi,

>>> I think simply not having a default
>>> machine type (as already suggested elsewhere in this thread) is the
>>> best way to deal with this.
>>
>> I would absolutely hate this. One of the nice things about qemu has
>> always been that 'qemu disk.img' is enough to start a simple VM.
> 
> Well, not really.  There is no "qemu" any more, and there are other
> defaults like default memory size which need tweaks, so the minimum
> command line isn't that short any more and looks more like this:
> 
>      qemu-system-x86_64 -enable-kvm -m 1G disk.img
>

If the command line is the main concern, I don't think is
enough to be the reason not to switch the default.
We can work on achieving the same/close with Q35.

Thanks,
Marcel


> cheers,
>    Gerd
> 
