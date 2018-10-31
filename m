Received: from eggs.gnu.org ([2001:4830:134:3::10]:56382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHtkb-0005bB-CA
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHtka-0008RW-K2
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:49 -0400
References: <20181031053920.7565-1-famz@redhat.com>
	<1d819a62-3fb0-d039-4cda-0b0a542979e3@redhat.com>
	<7e44b5b5-c76b-d1f0-b899-84429a086456@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <995b78b5-fbd0-8fdc-b49e-afe6c2843df5@redhat.com>
Date: Wed, 31 Oct 2018 11:53:26 -0500
MIME-Version: 1.0
In-Reply-To: <7e44b5b5-c76b-d1f0-b899-84429a086456@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Use error API properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 10/31/18 11:05 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 31/10/18 15:57, Eric Blake wrote:
>> On 10/31/18 12:39 AM, Fam Zheng wrote:
> ...
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "%s: stat=
 failed: %s\n",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
name, strerror(errno));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "%s: sta=
t failed: %s", fname,=20
>>> strerror(errno));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -errno;
>>
>> error_setg_errno() is nicer here.=C2=A0 In fact, should we have a Cove=
rity=20
>> script that looks for error_setg(... strerror())?
>>
>=20
> Coverity -> Coccinelle?

Yes. (Is it okay if I begin my defense with: They both start with "Co"?)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
