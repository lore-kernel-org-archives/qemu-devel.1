Received: from eggs.gnu.org ([2001:4830:134:3::10]:40994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS6AK-0005fF-5N
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS6AG-0007Qa-0l
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:10:32 -0500
References: <20181128195802.B6A6C7456B9@zero.eik.bme.hu>
	<2bdbd7b4-c1de-4ab4-7057-f87a535838e0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c921877e-75c6-028a-2418-72a02245213d@redhat.com>
Date: Wed, 28 Nov 2018 21:10:18 +0100
MIME-Version: 1.0
In-Reply-To: <2bdbd7b4-c1de-4ab4-7057-f87a535838e0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i2c: Move typedef of bitbang_i2c_interface
 to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 2018-11-28 21:03, Eric Blake wrote:
> On 11/28/18 1:27 PM, BALATON Zoltan wrote:
>> Clang 3.4 considers duplicate typedef in ppc4xx_i2c.h and
>> bitbang_i2c.h an error even if they are identical. Move it to a common
>> place to allow building with this clang version.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> =C2=A0 hw/i2c/bitbang_i2c.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 2 --
>> =C2=A0 include/hw/i2c/i2c.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 2 ++
>> =C2=A0 include/hw/i2c/ppc4xx_i2c.h | 3 ---
>> =C2=A0 3 files changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/i2c/bitbang_i2c.h b/hw/i2c/bitbang_i2c.h
>> index 3a7126d5de..9443021710 100644
>> --- a/hw/i2c/bitbang_i2c.h
>> +++ b/hw/i2c/bitbang_i2c.h
>> @@ -3,8 +3,6 @@
>> =C2=A0 =C2=A0 #include "hw/i2c/i2c.h"
>> =C2=A0 -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
>=20
> Would this also be an opportunity to rename the struct to something
> CamelCase to match our coding conventions?

That's a different issue, so I'd say it should be done in a different pat=
ch.

 Thomas
