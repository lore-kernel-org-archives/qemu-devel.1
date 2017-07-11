Received: from eggs.gnu.org ([2001:4830:134:3::10]:46057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUwS9-0005cO-1r
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUwS5-0002e5-6p
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:47:53 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUwS5-0002dk-0L
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:47:49 -0400
Received: by mail-wr0-f173.google.com with SMTP id k67so2280117wrc.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 07:47:48 -0700 (PDT)
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
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cc3488e-d40b-ac73-9087-f2bf64f2cd1c@redhat.com>
Date: Tue, 11 Jul 2017 16:47:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170711144215.GI4335@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 11/07/2017 16:42, Kevin Wolf wrote:
>>>  Concerning QEMU, could we maybe simply emit a warning a la
>>>
>>>  "you did not specify a machine type with the -M option, so you are
>>>   currently running the the 'pc' machine type. Please note that
>>> future
>>>   versions of QEMU might use the 'q35' machine type instead. If you
>>>   require the 'pc' machine type for your setting, then please specify
>>>   it with the -M option."
>> Warnings tend to get ignored until things are actually break, so I
>> don't think this helps much.  I think simply not having a default
>> machine type (as already suggested elsewhere in this thread) is the
>> best way to deal with this.
> I would absolutely hate this. One of the nice things about qemu has
> always been that 'qemu disk.img' is enough to start a simple VM. You
> only need to touch any other options for things you care about. I
> wouldn't want to give this up.

I agree.  Don't change anything, leave "-M pc" aside, and let libosinfo
pick q35 for newer guests.

Paolo
