Received: from eggs.gnu.org ([2001:4830:134:3::10]:58990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUaMS-0005Io-TA
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUaMR-0002s0-Ns
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:49:20 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-6-eblake@redhat.com>
	<130d5198-ae09-03d6-65fc-b829b990bb29@virtuozzo.com>
	<4477052f-329a-ee6d-034a-d76e7858ea29@redhat.com>
	<afc7270e-79d9-5655-e3ac-2b528d40942a@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb6430aa-10cd-55fd-2b33-7dc831742002@redhat.com>
Date: Wed, 5 Dec 2018 10:49:00 -0600
MIME-Version: 1.0
In-Reply-To: <afc7270e-79d9-5655-e3ac-2b528d40942a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/14] nbd/client: Drop pointless buf
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/5/18 10:38 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> -=C2=A0=C2=A0=C2=A0 magic =3D ldq_be_p(buf);
>>>> +=C2=A0=C2=A0=C2=A0 magic =3D be64_to_cpu(magic);
>>>
>>> Isn't it better to use be64_to_cpus?
>>
>> No. We're intentionally getting rid of that because of clang; see comm=
it 80c7c2b0.
>>
>>
>=20
> Ok, thanks. In this case it should be safe, but if we decided to avoid =
these functions in general than OK.
> Hmm, not in general, but only in nbd.. Strange, why not in qcow2 for ex=
?,

Peter is working on that - it's a slow process, because he's sending=20
separate patch series per maintainer, so they are not all getting=20
checked in at the same time. But the idea is that once everything is=20
converted, we nuke the *_to_*s variants as unused, and in the meantime,=20
we don't add more uses of it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
