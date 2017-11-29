Received: from eggs.gnu.org ([2001:4830:134:3::10]:33705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eKBXE-0008KB-07
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 18:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eKBXD-0007Tl-5r
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 18:12:55 -0500
References: <20171129224421.18192-1-jsnow@redhat.com>
	<691790b7-4e9f-ab9c-43eb-9f26a401ef02@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5b769683-c840-ff48-0e20-969f0cac4475@redhat.com>
Date: Wed, 29 Nov 2017 18:12:46 -0500
MIME-Version: 1.0
In-Reply-To: <691790b7-4e9f-ab9c-43eb-9f26a401ef02@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 197 for vpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, ldoktor@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com



On 11/29/2017 06:02 PM, Eric Blake wrote:
> On 11/29/2017 04:44 PM, John Snow wrote:
>> VPC has some difficulty creating geometries of particular size.
>> However, we can indeed force it to use a literal one, so let's
>> do that for the sake of test 197, which is testing some specific
>> offsets.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/197=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 3 +++
>> =C2=A0 tests/qemu-iotests/common.filter | 3 ++-
>> =C2=A0 2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> [Does it show that I seldom run ./check -vpc?]
>=20

True of all of us...

Thanks!
