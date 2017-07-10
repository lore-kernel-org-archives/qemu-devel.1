Received: from eggs.gnu.org ([2001:4830:134:3::10]:50393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVFw-00084S-IH
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVFs-0005gk-L2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:45:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUVFs-0005gX-Eb
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:45:24 -0400
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<5233eee1-a017-ccae-3458-762c9e86902c@redhat.com>
	<20170707133949.GH10776@localhost.localdomain>
	<20170707181642-mutt-send-email-mst@kernel.org>
	<20170707180358.GA12152@localhost.localdomain>
	<626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc129750-6b55-8904-dbef-2dc083c28978@redhat.com>
Date: Mon, 10 Jul 2017 11:45:14 +0200
MIME-Version: 1.0
In-Reply-To: <626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, qemu-devel@nongnu.org, "Tian, Kevin" <kevin.tian@intel.com>, Laszlo Ersek <lersek@redhat.com>



On 10/07/2017 09:42, Marcel Apfelbaum wrote:
>>>>
>>>
>>> How about extending the command for supported machines with a
>>> recommended machine type, and teaching libvirt to use that?
>>
>> I don't think QEMU has enough information to decide if it should
>> recommend "q35" or "pc".
> 
> We don't really need a complicated rule set, we would just recommend q35
> by default. Libvirt will try to create the default machine and if fails
> for some reason (what would it be?) it can switch to PC.
> 
> The advanced logic would be "old systems should use PC", where old
> means Windows XP and before and so on. But this logic should appear
> in management layers above.

That would be libosinfo.

Paolo
