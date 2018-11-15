Received: from eggs.gnu.org ([2001:4830:134:3::10]:37443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNPit-0003eL-Pl
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNPih-0000xO-IB
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:02:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNPig-0000vr-Lk
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:02:38 -0500
References: <cover.1542301855.git.xiezhide@huawei.com>
	<37e2a76b4020a5f9e48fe3b7c36d8e4bfb111569.1542301855.git.xiezhide@huawei.com>
	<df1afb51-f027-d5f8-d5e2-b9869cf104f7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d858252-f6ff-55d6-42f9-48aa56d5e294@redhat.com>
Date: Thu, 15 Nov 2018 16:02:33 -0600
MIME-Version: 1.0
In-Reply-To: <df1afb51-f027-d5f8-d5e2-b9869cf104f7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/4] fsdev-throttle-qmp: move struct
 ThrottleLimits to new file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>, qemu-devel@nongnu.org
Cc: berto@igalia.com, armbru@redhat.com, zengcanfu@huawei.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

On 11/15/18 3:41 PM, Eric Blake wrote:
> On 11/15/18 2:55 AM, xiezhide wrote:
>> this patch move ThrottleLimits to new file and rename struct
>> field with common format
>=20
> As written, you need s/move/moves/ and s/rename/renames/ to match the=20
> singular actor 'this patch'.=C2=A0 Or, if you stick with my preference =
for=20
> imperative sense, s/this patch move/Move/
>=20
> s/to new/to a new/
>=20
>>
>> Signed-off-by: xiezhide <xiezhide@huawei.com>
>> ---
>=20
>> +++ b/Makefile
>> @@ -106,6 +106,7 @@ GENERATED_FILES +=3D qapi/qapi-types-sockets.h=20
>> qapi/qapi-types-sockets.c
>> =C2=A0 GENERATED_FILES +=3D qapi/qapi-types-tpm.h qapi/qapi-types-tpm.=
c
>> =C2=A0 GENERATED_FILES +=3D qapi/qapi-types-trace.h qapi/qapi-types-tr=
ace.c
>> =C2=A0 GENERATED_FILES +=3D qapi/qapi-types-transaction.h=20
>> qapi/qapi-types-transaction.c
>> +GENERATED_FILES +=3D qapi/qapi-types-tlimits.h qapi/qapi-types-tlimit=
s.c
>=20
> tlimits comes before tpm, not after transaction.=C2=A0 (Multiple times =
in=20
> this file)

Or, just apply your patch after mine[1], for a much simpler task of=20
inserting 'tlimits' in the right place within QAPI_MODULES.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03070.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
