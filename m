Received: from eggs.gnu.org ([2001:4830:134:3::10]:47444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxW9b-0002S2-Fp
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxW9S-0005ua-8q
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:34:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dxW9S-0005u7-0f
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:34:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8SAY7Q2000625
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 06:34:37 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d8s38u552-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 06:34:36 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 28 Sep 2017 11:34:34 +0100
References: <20170926162058.30772-1-cohuck@redhat.com>
	<20170926162058.30772-2-cohuck@redhat.com>
	<338c8565-691e-a8bc-d8a6-3637ce13701d@redhat.com>
	<20170927114717.72bd69f8.cohuck@redhat.com>
	<e8bef299-5501-a59d-aba3-5a338227966e@linux.vnet.ibm.com>
	<20170927125606.65dc514d.cohuck@redhat.com>
	<14df9ad6-f0e9-cd51-04dd-4fe994808433@de.ibm.com>
	<4681e677-9e5a-4c1c-8e22-dc5c51b7286d@redhat.com>
	<20170927142837.GB2108@work-vm>
	<20170927164644.42205e6f.cohuck@redhat.com>
	<20170927144927.GC2108@work-vm>
	<20170927170346.68ca0cd8.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 28 Sep 2017 12:34:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170927170346.68ca0cd8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <9c8c2596-c4cf-41ad-7228-0ed598cf65cd@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: create a compat s390 phb for
 <=2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com



On 09/27/2017 05:03 PM, Cornelia Huck wrote:
> On Wed, 27 Sep 2017 15:49:27 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>=20
>> * Cornelia Huck (cohuck@redhat.com) wrote:
>>> On Wed, 27 Sep 2017 15:28:38 +0100
>>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>>>  =20
>>>> * David Hildenbrand (david@redhat.com) wrote: =20
>>>>> On 27.09.2017 12:59, Christian Borntraeger wrote:   =20
>>>>>>
>>>>>>
>>>>>> On 09/27/2017 12:56 PM, Cornelia Huck wrote:   =20
>>>>>>> On Wed, 27 Sep 2017 18:25:00 +0800
>>>>>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>>>>>>   =20
>>>>>>>> =E5=9C=A8 2017/9/27 =E4=B8=8B=E5=8D=885:47, Cornelia Huck =E5=86=
=99=E9=81=93:   =20
>>>>>>>>> On Tue, 26 Sep 2017 20:40:25 +0200
>>>>>>>>> David Hildenbrand <david@redhat.com> wrote:   =20
>>>>>>>   =20
>>>>>>>>>> I'd really really really (did I mention really?) favor somethi=
ng like a
>>>>>>>>>> dummy device, because we could easily handle the !CONFIG_PCI c=
ase then.
>>>>>>>>>>
>>>>>>>>>> All these compat options and conditions will kill us someday..=
. we're
>>>>>>>>>> already patching around that whole stuff way too much.
>>>>>>>>>>
>>>>>>>>>> If we ever unconditionally created a device, we should keep do=
ing so.     =20
>>>>>>>>> Yes, that whole thing is horrible, especially interaction with =
compat
>>>>>>>>> machines.
>>>>>>>>>
>>>>>>>>> Do you have an idea on how to create such a dummy device (witho=
ut
>>>>>>>>> having to effectively copy a lot of configured-out code)?
>>>>>>>>>
>>>>>>>>>     =20
>>>>>>>> How about in s390_pcihost_hot_plug() we check s390_has_feat(zpci=
)?
>>>>>>>> If no zpci feature, we avoid plugging any pci device.
>>>>>>>> Then we could always create phb.
>>>>>>>> I think pcibus's vmstate is only data to migrate.   =20
>>>>>>>
>>>>>>> That's still problematic if CONFIG_PCI is off. I currently don't =
have a
>>>>>>> better idea than either disallowing compat machines on builds wit=
hout
>>>>>>> pci, or using a dummy device...   =20
>>>>>>
>>>>>> For this particular case your initial patch might be less problema=
tic than
>>>>>> a dummy device, because the code that does the migration is NOT co=
ntained
>>>>>> in s390 specific code but in common PCI code instead. We would nee=
d to keep
>>>>>> the dummy device always in a way that it will work with the common=
 PCI
>>>>>> code.
>>>>>>    =20
>>>>>
>>>>> Interesting, so how is migration then handled for e.g. x86 or other
>>>>> architectures that can work without CONFIG_PCI? I assume their migr=
ation
>>>>> should also break?   =20
>>>>
>>>> It's tied to machine-type; the x86 i440fx and q35 machine types have
>>>> PCI; you can't disable PCI while still having those machine types.
>>>> (I don't know if you can disable PCI at all on x86) =20
>>>
>>> Ugh, that sounds like we need two machine types on s390x as well
>>> (s390x-ccw-virtio and s390x-ccw-virtio-nopci or so), built
>>> conditionally. That whole zpci detanglement is looking worse and
>>> worse :( =20
>>
>> Well fundamentally the migration expects to migrate something into
>> the same shaped hole on the destination;  if you've got a lump of PCI
>> config on the source there's got to be somewhere for it to fit on the
>> destination.
>> Now, if PCI is actually pretty rare; then you might be able to make
>> the host-pci bridge a normal device and not include it in any
>> machine type; that way those who want PCI can just instantiate
>> the host-pci bridge, and those who don't want it just stick with
>> the base machine type.
>=20
> I fear that ship has already sailed; the s390-ccw-virtio machine type
> has been instantiating a phb for quite some time, which means we have
> to drag this on in the compat machines...

In the end that means that you should revert

commit d32bd032d8fde41281aae34c16a4aa97e9acfeac
Author:     Cornelia Huck <cohuck@redhat.com>
AuthorDate: Thu Jul 6 17:21:52 2017 +0200
Commit:     Cornelia Huck <cohuck@redhat.com>
CommitDate: Wed Aug 30 18:23:25 2017 +0200

    s390x/ccw: create s390 phb conditionally

to keep s390-ccw-virtio clean proper.

If you want to have PCI disabled, you can do you in a machine like=20
s390-rhelx.y.z or whatever.=20
