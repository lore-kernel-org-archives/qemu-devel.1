Received: from eggs.gnu.org ([2001:4830:134:3::10]:52379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dSgfW-0003x6-1Y
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dSgfS-0002fF-R2
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:32:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dSgfS-0002eQ-Gp
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:32:18 -0400
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <5233eee1-a017-ccae-3458-762c9e86902c@redhat.com>
Date: Wed, 5 Jul 2017 12:32:10 +0300
MIME-Version: 1.0
In-Reply-To: <6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 05/07/2017 11:14, Thomas Huth wrote:
>   Hi,
> 

Hi,

> On 05.07.2017 08:57, Chao Peng wrote:
>>
>> Q35 has been in QEMU for quite a while. Compared to the current default
>> i440FX, Q35 is probably not that mature and not widely used, however in
>> some case, Q35 has advantages, for example, in supporting new features.
>> For instance, we have some features require PCI-e support which is only
>> available on Q35 and some others need it for EFI support. It is of
>> course not necessary to change it as the default but if more and more
>> features have dependencies on Q35 because of requiring much more modern
>> features then I think it may be worth to do so. In such case we can have
>> more people to use it and find problems we may know or not know.
> 

Agreed

> Yes, IMHO at one point in time, we should switch the default machine
> type to q35.

+1

> The i440FX is really quite old...
> 
>> There are certainly some drawbacks:
>> -        Compatibility: current code or script may need adjustment
> 
> That might be a real concern ... 

I am not so sure about that. Developers working on upstream projects
should expect such changes and, for our case,
modifying the command line by adding "-M pc" should not be a big deal.

The upper layers should manage the defaults by themselves so
are not supposed to be affected.

> so I think a good point in time to
> switch to the q35 machine type would be when we switch to the next major
> version number of QEMU, i.e. when we switch to version 3.0.

It does seem a good opportunity.

  If the users
> see a new major version number, they might be more willing to accept
> such major changes (yeah, I know, we've discussed in the past that
> version numbers are just numbers ... but still, there is some kind of
> psychological aspect to this, too, I think)
> 
>> -        Quality: we may suffer more bugs on Q35
> > I hope that the q35 machine will become mature soon once it has been
> made the default machine.
>

It will certainly help, the question is the cost.
Exposing the bugs by having more developers working on Q35 looks
more like an opportunity then a "cost"  to me.

Thanks,
Marcel

>   Thomas
> 
