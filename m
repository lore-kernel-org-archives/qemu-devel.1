Received: from eggs.gnu.org ([2001:4830:134:3::10]:32993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gQ6Sb-0005at-Io
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 03:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gQ6Sa-0008KL-QD
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 03:05:09 -0500
References: <20181122180143.14237-1-eric.auger@redhat.com>
	<1259e457-6cb8-3b1e-853f-53f1e47cac63@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <43381cce-1af0-8613-edf3-c216afdbe142@redhat.com>
Date: Fri, 23 Nov 2018 09:04:47 +0100
MIME-Version: 1.0
In-Reply-To: <1259e457-6cb8-3b1e-853f-53f1e47cac63@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] MAINTAINERS: Add an ARM SMMU
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com

Hi Philippe,

On 11/22/18 11:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 22/11/18 19:01, Eric Auger wrote:
>> Add a new ARM SMMU section and set Eric Auger as the maintainer
>> for ARM SMMU emulation sources.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  MAINTAINERS | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1032406c56..3cac9f0a0c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -151,6 +151,13 @@ F: disas/arm.c
>>  F: disas/arm-a64.cc
>>  F: disas/libvixl/
>> =20
>> +ARM SMMU
>> +M: Eric Auger <eric.auger@redhat.com>
>> +L: qemu-arm@nongnu.org
>> +S: Maintained
>=20
> Shouldn't you use 'Supported': "Someone is actually paid to look after
> this."?
Not sure this is really important as long as get_maintainer.pl returns
the right contacts. Many ARM sections do not feature the "Supported"
tag. I will follow Peter's guidance though.

Thanks

Eric
>=20
>> +F: hw/arm/smmu*
>> +F: include/hw/arm/smmu*
>> +
>>  CRIS
>>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>>  S: Maintained
>>
