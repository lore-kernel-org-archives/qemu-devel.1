Received: from eggs.gnu.org ([2001:4830:134:3::10]:49367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNkx5-0005Ad-VT
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 15:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNkx1-0007sY-AF
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 15:42:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNkx1-0007rp-55
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 15:42:51 -0500
References: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
	<20181024094051.4470-2-maozhongyi@cmss.chinamobile.com>
	<ff59cbf9-95ef-b581-34ad-a11f73f76f77@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0d11afa-5b03-9d47-b90e-845664e4dec3@redhat.com>
Date: Fri, 16 Nov 2018 14:42:47 -0600
MIME-Version: 1.0
In-Reply-To: <ff59cbf9-95ef-b581-34ad-a11f73f76f77@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu-iotests: convert `pwd` and
 $(pwd) to $PWD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

On 11/16/18 10:53 AM, Eric Blake wrote:
> On 10/24/18 4:40 AM, Mao Zhongyi wrote:
>> POSIX requires $PWD to be reliable, and we expect all
>> shells used by qemu scripts to be relatively close to
>> POSIX.=C2=A0 Thus, it is smarter to avoid forking the pwd
>> executable for something that is already available in
>> the environment.
>>
>> So replac it with the following:
>=20
> s/replac/replace/
>=20
>>
>> sed -i 's/`pwd`/$PWD/g' $(git grep -l "\`pwd\`")
>> sed -i 's/$(pwd)/$PWD/g' $(git grep=C2=A0 -l "\$(pwd)")

This didn't modify anything (the first $ was not escaped).

>>
>> The remaining small parts are manually modified.

What remaining small parts? With a fixed sed line, I made all of the=20
same edits as you, plus one you missed a comment in=20
scripts/coccinelle/tcg_gen_extract.cocci that could also be updated.

>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Here's the updated command line I used:

sed -i 's/\(`pwd`\|\$(pwd)\)/$PWD/g' $(git grep -l pwd)

and reordering this to occur second makes it much easier to review (only=20
6 files outside of tests/qemu-iotests/??? that needed a change).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
