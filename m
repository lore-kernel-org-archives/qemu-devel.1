Received: from eggs.gnu.org ([2001:4830:134:3::10]:58417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dVBJU-0008Rr-MN
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dVBJR-0000F5-En
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:39:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dVBJR-0000EL-5T
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:39:53 -0400
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
	<1cc3488e-d40b-ac73-9087-f2bf64f2cd1c@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8d6ed662-63e5-fe49-f41e-05f80a52bc20@redhat.com>
Date: Wed, 12 Jul 2017 09:39:39 +0300
MIME-Version: 1.0
In-Reply-To: <1cc3488e-d40b-ac73-9087-f2bf64f2cd1c@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>

On 11/07/2017 17:47, Paolo Bonzini wrote:
> On 11/07/2017 16:42, Kevin Wolf wrote:
>>>>   Concerning QEMU, could we maybe simply emit a warning a la
>>>>
>>>>   "you did not specify a machine type with the -M option, so you are
>>>>    currently running the the 'pc' machine type. Please note that
>>>> future
>>>>    versions of QEMU might use the 'q35' machine type instead. If you
>>>>    require the 'pc' machine type for your setting, then please specify
>>>>    it with the -M option."
>>> Warnings tend to get ignored until things are actually break, so I
>>> don't think this helps much.  I think simply not having a default
>>> machine type (as already suggested elsewhere in this thread) is the
>>> best way to deal with this.
>> I would absolutely hate this. One of the nice things about qemu has
>> always been that 'qemu disk.img' is enough to start a simple VM. You
>> only need to touch any other options for things you care about. I
>> wouldn't want to give this up.
> 
> I agree.  Don't change anything, leave "-M pc" aside, and let libosinfo
> pick q35 for newer guests.
> 

Hi Paolo,

While I do think it would be a good step moving forward, I am not
convinced is "enough" to get more users using it. More so, a low
level bug in upper layers (e.g. Open stack) will lead to difficulty
to debug and result in the same "The machine is not steady enough,
it doesn't worth the effort, let's move back to pc", or even
frustration of the people that really need Q35.

IMHO we need to find a way to let more users use Q35 by default
and make an effort to fix the possible issues before.


Thanks,
Marcel


> Paolo
> 
