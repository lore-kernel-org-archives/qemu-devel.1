Received: from eggs.gnu.org ([2001:4830:134:3::10]:39926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMBPl-0004Fj-Lh
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMBPg-00065C-KK
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:29:29 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-2-david@redhat.com>
	<20171204180349.379dd02e.cohuck@redhat.com>
	<10941b30-4fa9-37e6-7d25-f3423282f5b0@redhat.com>
	<20171205112001.2fb7ec1e.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6e90a2d0-44e3-c1bf-a1a2-aa3786c17971@redhat.com>
Date: Tue, 5 Dec 2017 12:29:18 +0100
MIME-Version: 1.0
In-Reply-To: <20171205112001.2fb7ec1e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 1/5] s390x/kvm: factor out
 build_channel_report_mcic() into cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 05.12.2017 11:20, Cornelia Huck wrote:
> On Mon, 4 Dec 2017 18:16:15 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 04.12.2017 18:03, Cornelia Huck wrote:
>>> On Mon,  4 Dec 2017 13:55:01 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>  =20
>>>> We'll need it later on in two places. Refactor it to just indicate t=
he
>>>> valid bit. While at it, introduce a define for the used CR14 bit (we=
'll =20
>>>
>>> s/valid bit/validity bits/ =20
>>
>> In the PoP they are defined as "validity" (e.g. 11-15)
>>
>> Vector-register validity (VR)
>> External-damage-code validity (EC)
>> Floating-point-register validity (FP)
>> General-register validity (GR)
>> Control-register validity (CR)
>>
>> So I am not sure if using a slightly different terminology here helps.
>=20
> I don't know, "validity" seems to be more in line with the doc?
>=20

Yes, will use "validity" consistently here. Thanks!

--=20

Thanks,

David / dhildenb
