Received: from eggs.gnu.org ([209.51.188.92]:47432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMGQ-0003zu-4Z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 02:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMGP-0001RI-40
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 02:29:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hLMGO-0001R7-Sf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 02:29:13 -0400
References: <20190429003322.22908-1-driver1998@foxmail.com>
	<d25baf06-1176-5cce-2ff1-3b5652e3ca27@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d36b32b3-0402-bdd3-3c7e-c0ac35b7656e@redhat.com>
Date: Tue, 30 Apr 2019 08:29:05 +0200
MIME-Version: 1.0
In-Reply-To: <d25baf06-1176-5cce-2ff1-3b5652e3ca27@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] util/cacheinfo.c: Use uintptr_t
 instead of unsigned long in AArch64 arch_cache_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, driver1998 <driver1998@foxmail.com>, qemu-devel@nongnu.org

On 30/04/2019 07.49, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/29/19 2:33 AM, driver1998 wrote:
>> Windows ARM64 uses LLP64 model, which breaks current assumptions.
>>
>> Signed-off-by: driver1998 <driver1998@foxmail.com>
>> ---
>>  util/cacheinfo.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
>> index 3cd080b83d..a815cb0722 100644
>> --- a/util/cacheinfo.c
>> +++ b/util/cacheinfo.c
>> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>>  static void arch_cache_info(int *isize, int *dsize)
>>  {
>>      if (*isize =3D=3D 0 || *dsize =3D=3D 0) {
>> -        unsigned long ctr;
>> +        uintptr_t ctr;
>> =20
>>          /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_=
EL1,
>>             but (at least under Linux) these are marked protected by t=
he
>> @@ -120,6 +120,8 @@ static void arch_cache_info(int *isize, int *dsize=
)
>>          if (*dsize =3D=3D 0) {
>>              *dsize =3D 4 << ((ctr >> 16) & 0xf);
>>          }
>> +
>> +        printf("%d %d\n", *isize, *dsize);
>=20
> The patch looks correct (except your real name), but here you forgot to
> remove this debugging code.

Right. With the "Signed-off-by" line you have to state that you've read
and followed the "Developer's Certificate of Origin". For this, no
pseudonym contributions are possible, sorry.
See this URLs for details:

 https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_=
a_Signed-off-by:_line

  Thomas
