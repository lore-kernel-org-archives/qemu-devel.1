Received: from eggs.gnu.org ([2001:4830:134:3::10]:32802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gD7gp-0007oW-MC
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gD7go-0000s8-7k
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:46:11 -0400
References: <20181018031723.23459-1-maozhongyi@cmss.chinamobile.com>
	<20181018031723.23459-2-maozhongyi@cmss.chinamobile.com>
	<c46fe8e5-e31d-478b-d2fa-e51740f1aa32@redhat.com>
	<37ec6ad2-1392-7970-f9a5-c95b633585c7@cmss.chinamobile.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5663e159-85b2-93d7-ed46-45f742355cdd@redhat.com>
Date: Thu, 18 Oct 2018 07:46:00 -0500
MIME-Version: 1.0
In-Reply-To: <37ec6ad2-1392-7970-f9a5-c95b633585c7@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu-iotests: Modern
 shellscripting(use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: maozy <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Jeff Cody <codyprime@gmail.com>

[adding Jeff]

On 10/18/18 2:14 AM, maozy wrote:
> Hi, Eric
>=20
> On 10/18/18 11:28 AM, Eric Blake wrote:
>> On 10/17/18 10:17 PM, Mao Zhongyi wrote:
>>> Various shell files contain a mix between obsolete ``
>>> and modern $(); It would be nice to convert to using $()
>>> everywhere.
>>>
>>> `pwd` and `basename $0` are in 231 files under directory
>>> tests/qemu-iotests, so replaced it with the following:
>>>
>>> sed -i 's/`pwd`/$(pwd)/g' $(git grep -l "\`pwd\`")
>>
>> No. Instead, I'd rather a separate patch that does:
>>
>> s/`pwd`/$PWD/
>> s/\$(pwd)/$PWD/
>>
>> since POSIX requires $PWD to be sane, and thus save us a wasted forked=
=20
>> process.
>=20
> I got you, thank you very much.
>=20

>> At one point, someone (Jeff?) proposed a cleanup patch that got rid of=
=20
>> a lot of cruft in iotests, including the fact that scripts that don't=20
>> use $seq don't need to assign seq=3D$(basename $0).=C2=A0 We should pr=
obably=20
>> revive that rather than just making pointless churn on stuff that is=20
>> garbage anyways.=C2=A0 But I don't have time to look up a URL to that =
older=20
>> series at the moment.
>>
>=20
>=20
> I think I might have found this patchset, but it was a long time ago.
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg04056.html

Yes, you found it.

>=20
> I will remove this patch from this series and resend a separate patch
> to replace `pwd` and "$(pwd)" with $PWD. Am I right?

That whole series from Jeff should be revived and rebased to master.  I=20
don't know if Jeff has time to commit to it any more, so anyone is=20
welcome to pick it up at this point.  But your plan in the meantime=20
sounds reasonable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
