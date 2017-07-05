Received: from eggs.gnu.org ([2001:4830:134:3::10]:42396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSiFf-0002x4-LH
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSiFc-0004oy-C7
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:13:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dSiFc-0004op-2z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:13:44 -0400
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<20170705110757.GF22008@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b994bcd8-7a4b-6d83-633d-7889d46ebd75@redhat.com>
Date: Wed, 5 Jul 2017 13:13:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170705110757.GF22008@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Chao Peng <chao.p.peng@linux.intel.com>, qemu-devel@nongnu.org, "Tian, Kevin" <kevin.tian@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 05.07.2017 13:07, Daniel P. Berrange wrote:
> On Wed, Jul 05, 2017 at 10:14:23AM +0200, Thomas Huth wrote:
>>  Hi,
>>
>> On 05.07.2017 08:57, Chao Peng wrote:
>>>
>>> Q35 has been in QEMU for quite a while. Compared to the current default
>>> i440FX, Q35 is probably not that mature and not widely used, however in
>>> some case, Q35 has advantages, for example, in supporting new features.
>>> For instance, we have some features require PCI-e support which is only
>>> available on Q35 and some others need it for EFI support. It is of
>>> course not necessary to change it as the default but if more and more
>>> features have dependencies on Q35 because of requiring much more modern
>>> features then I think it may be worth to do so. In such case we can have
>>> more people to use it and find problems we may know or not know.
>>
>> Yes, IMHO at one point in time, we should switch the default machine
>> type to q35. The i440FX is really quite old...
>>
>>> There are certainly some drawbacks:
>>> -        Compatibility: current code or script may need adjustment
>>
>> That might be a real concern ... so I think a good point in time to
>> switch to the q35 machine type would be when we switch to the next major
>> version number of QEMU, i.e. when we switch to version 3.0. If the users
>> see a new major version number, they might be more willing to accept
>> such major changes (yeah, I know, we've discussed in the past that
>> version numbers are just numbers ... but still, there is some kind of
>> psychological aspect to this, too, I think)
> 
> Most users aren't even aware of version numbers of QEMU - they'll just
> take whatever their distro has provided run it. The notion that their
> latest distro version happened to pull in a "major" version instead of
> previously pulling in a "minor" version is invisible to everyone,
> except the minority of people who care about the low level details.

Well, but those users who do not care at all hopefully use libvirt,
GNOME boxes or a similar management layer to start their virtual
machines, so it should not matter for them at all.

 Thomas
