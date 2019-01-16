Received: from eggs.gnu.org ([209.51.188.92]:47847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gjnWj-0007Wl-6K
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gjnWh-00005y-F2
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:54:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gjnWf-0008W0-Hg
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:54:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20190116155442euoutp02d520ffd3fb92d38811eecb3d53259685~6XzAv86sO2488124881euoutp02t
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:54:42 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <58907276-dcc3-3f5b-bb12-647fff13325e@samsung.com>
Date: Wed, 16 Jan 2019 18:54:38 +0300
MIME-Version: 1.0
In-Reply-To: <20190116154857.GC20275@redhat.com>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
	<20181211105329.GE921@redhat.com>
	<52c43506-ef39-6d08-7db4-ad3c0f96dd1f@samsung.com>
	<20181212064936.ubnv3yif34e7ga5j@sirius.home.kraxel.org>
	<20190116153027.GC14807@habkost.net>
	<856c189d-937e-2471-c3c1-77e4d1e61ed6@samsung.com>
	<20190116154857.GC20275@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 16.01.2019 18:48, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 16, 2019 at 06:46:39PM +0300, Ilya Maximets wrote:
>>
>>
>> On 16.01.2019 18:30, Eduardo Habkost wrote:
>>> On Wed, Dec 12, 2018 at 07:49:36AM +0100, Gerd Hoffmann wrote:
>>>> On Tue, Dec 11, 2018 at 02:09:11PM +0300, Ilya Maximets wrote:
>>>>> On 11.12.2018 13:53, Daniel P. Berrang=C3=A9 wrote:
>>>>>>>
>>>>>>> Let's restrict memfd backend to systems with sealing support.
>>>>>>
>>>>>> I don't think we need todo that - sealing is optional in the QEMU =
code,
>>>>>> we simply have it set to the wrong default when sealing is not ava=
ilable.
>>>>>
>>>>> That was literally what I've fixed in v1:
>>>>>     https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg054=
83.html
>>>>>
>>>>> but 2 people suggested me to disable memfd entirely for this case.
>>>>> Do you think I need to get patch from v1 back ?
>>>>>
>>>>> Gerd, Marc-Andr=C3=A9, what do you think?
>>>>
>>>> I still think it makes sense to require sealing support.  Sealing is
>>>> very useful, and there are only a few kernel versions with memfd but
>>>> without sealing.  So finding such kernels in the wild will become mo=
re
>>>> rare over time.  I wouldn't worry too much about them.
>>>
>>> -object memory-backend-memfd,id=3Dmem,size=3D2M,seal=3Doff still
>>> works on those systems, doesn't it?  What's the rationale for
>>> breaking a working configuration without following the
>>> deprecation policy?
>>>
>>
>> See the commit message.
>> '.seal' property is not registered if sealing is not supported.
>> So, there is no way to disable sealing on the system that does not sup=
port it.
>=20
> As I pointed out a few lines up, this is simply because QEMU has a bug
> setting seal=3Dtrue as the built-in default value even when it isn't
> supported.=20

So, do you think I need to return to the solution from my v1:
  https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg05483.html

?
