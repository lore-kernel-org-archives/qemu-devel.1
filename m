Received: from eggs.gnu.org ([2001:4830:134:3::10]:39722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eyJ33-0005bB-4x
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eyJ2y-00019D-S8
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:19:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39086
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eyJ2y-000192-MI
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:19:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2KFJKQm002357
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:19:31 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gu3t8udef-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:19:26 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 20 Mar 2018 15:19:10 -0000
References: <20180320130702.188689-1-borntraeger@de.ibm.com>
	<c3d189be-29ae-9500-f1b1-c573c842a307@de.ibm.com>
	<760d8180-a6f8-ec8e-fa62-7d2255c9b7a7@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Mar 2018 16:19:08 +0100
MIME-Version: 1.0
In-Reply-To: <760d8180-a6f8-ec8e-fa62-7d2255c9b7a7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <cfa3b29e-8b78-1cd0-e3ed-f4d1d84a7e31@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/1] s390x/cpumodel: fix
 feature groups and breakage of MSA8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mimu@linux.vnet.ibm.com, qemu-s390x <qemu-s390x@nongnu.org>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

On 03/20/2018 04:06 PM, Michael Mueller wrote:
> I could imagine something like this, see attachment.

Unless Conny is willing to take that also for 2.12, this looks like=20
a good thing to do after 2.12. (I suggest to go with my mininal
patch for 2.12)

>=20
> Michael
>=20
> On 20.03.18 14:17, Christian Borntraeger wrote:
>> David, Jason, Michael,
>>
>> the cpumodel code is somewhat fragile as we have to add maintain thing=
s
>> in multiple places. I would like to have more robust code, e.g. by eit=
her
>> generating more or by having build bug_ons or something like that.
>> Any idea is highly welcome.
>>
>> Christian
>>
>>
>> On 03/20/2018 02:07 PM, Christian Borntraeger wrote:
>>> Since commit 46a99c9f73c7 ("s390x/cpumodel: model PTFF subfunctions
>>> for Multiple-epoch facility") -cpu help no longer shows the MSA8
>>> feature group. Turns out that we forgot to add the new MEPOCH_PTFF
>>> group enum.
>>>
>>> Fixes: 46a99c9f73c7 ("s390x/cpumodel: model PTFF subfunctions for Mul=
tiple-epoch facility")
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>> =C2=A0 target/s390x/cpu_features.h | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.=
h
>>> index e306aa7ab2..968b12fdfe 100644
>>> --- a/target/s390x/cpu_features.h
>>> +++ b/target/s390x/cpu_features.h
>>> @@ -78,6 +78,7 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_GROUP_MSA_EXT_6,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_GROUP_MSA_EXT_7,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_GROUP_MSA_EXT_8,
>>> +=C2=A0=C2=A0=C2=A0 S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390_FEAT_GROUP_MAX,
>>> =C2=A0 } S390FeatGroup;
>>>
>>
>>
>=20
> 0001-target-s390x-enum-type-S390FeatGroup-now-gets-genera.patch
>=20
>=20
> From 978d0b480824248586149ed67dca7b31c6a5e5d8 Mon Sep 17 00:00:00 2001
> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> Date: Tue, 20 Mar 2018 15:56:18 +0100
> Subject: [PATCH] target/s390x: enum type S390FeatGroup now gets generat=
ed
>=20
> The enumeration type S390FeatGroup is now gererated as well.
> This shall simplify the definition of new feature groups
> without modifying existing code.
>=20
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> ---
>  target/s390x/cpu_features.c |  1 -
>  target/s390x/cpu_features.h | 18 +-----------------
>  target/s390x/gen-features.c | 18 +++++++++++++++++-
>  3 files changed, 18 insertions(+), 19 deletions(-)
>=20
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 3b9e2745e9..d623db34a6 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -13,7 +13,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "cpu_features.h"
> -#include "gen-features.h"
> =20
>  #define FEAT_INIT(_name, _type, _bit, _desc) \
>      {                                                \
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index e306aa7ab2..effe790271 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -16,6 +16,7 @@
> =20
>  #include "qemu/bitmap.h"
>  #include "cpu_features_def.h"
> +#include "gen-features.h"
> =20
>  /* CPU features are announced via different ways */
>  typedef enum {
> @@ -64,23 +65,6 @@ void s390_add_from_feat_block(S390FeatBitmap feature=
s, S390FeatType type,
>  void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *op=
aque,
>                                 void (*fn)(const char *name, void *opaq=
ue));
> =20
> -/* static groups that will never change */
> -typedef enum {
> -    S390_FEAT_GROUP_PLO,
> -    S390_FEAT_GROUP_TOD_CLOCK_STEERING,
> -    S390_FEAT_GROUP_GEN13_PTFF_ENH,
> -    S390_FEAT_GROUP_MSA,
> -    S390_FEAT_GROUP_MSA_EXT_1,
> -    S390_FEAT_GROUP_MSA_EXT_2,
> -    S390_FEAT_GROUP_MSA_EXT_3,
> -    S390_FEAT_GROUP_MSA_EXT_4,
> -    S390_FEAT_GROUP_MSA_EXT_5,
> -    S390_FEAT_GROUP_MSA_EXT_6,
> -    S390_FEAT_GROUP_MSA_EXT_7,
> -    S390_FEAT_GROUP_MSA_EXT_8,
> -    S390_FEAT_GROUP_MAX,
> -} S390FeatGroup;
> -
>  /* Definition of a CPU feature group */
>  typedef struct {
>      const char *name;       /* name exposed to the user */
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 0cdbc15378..94602f4386 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -659,6 +659,7 @@ static CpuFeatDefSpec CpuFeatDef[] =3D {
>  #define FEAT_GROUP_INITIALIZER(_name)                  \
>      {                                                  \
>          .name =3D "S390_FEAT_GROUP_LIST_" #_name,        \
> +        .enum_name =3D "S390_FEAT_GROUP_" #_name,        \
>          .bits =3D                                        \
>              { .data =3D group_##_name,                   \
>                .len =3D ARRAY_SIZE(group_##_name) },      \
> @@ -666,6 +667,7 @@ static CpuFeatDefSpec CpuFeatDef[] =3D {
> =20
>  typedef struct {
>      const char *name;
> +    const char *enum_name;
>      BitSpec bits;
>  } FeatGroupDefSpec;
> =20
> @@ -676,7 +678,6 @@ static FeatGroupDefSpec FeatGroupDef[] =3D {
>      FEAT_GROUP_INITIALIZER(PLO),
>      FEAT_GROUP_INITIALIZER(TOD_CLOCK_STEERING),
>      FEAT_GROUP_INITIALIZER(GEN13_PTFF),
> -    FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
>      FEAT_GROUP_INITIALIZER(MSA),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_1),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_2),
> @@ -686,6 +687,7 @@ static FeatGroupDefSpec FeatGroupDef[] =3D {
>      FEAT_GROUP_INITIALIZER(MSA_EXT_6),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_7),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_8),
> +    FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
>  };
> =20
>  #define QEMU_FEAT_INITIALIZER(_name)                   \
> @@ -808,6 +810,19 @@ static void print_feature_group_defs(void)
>      }
>  }
> =20
> +static void print_feature_group_enum_type(void)
> +{
> +    int i;
> +
> +    printf("\n/* CPU feature group enum type */\n");
> +    printf("typedef enum {\n");
> +    for (i =3D 0; i < ARRAY_SIZE(FeatGroupDef); i++) {
> +        printf("\t%s,\n", FeatGroupDef[i].enum_name);
> +    }
> +    printf("\tS390_FEAT_GROUP_MAX,\n");
> +    printf("} S390FeatGroup;\n");
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      printf("/*\n"
> @@ -824,6 +839,7 @@ int main(int argc, char *argv[])
>      print_feature_defs();
>      print_feature_group_defs();
>      print_qemu_feature_defs();
> +    print_feature_group_enum_type();
>      printf("\n#endif\n");
>      return 0;
>  }
> -- 2.13.4
>=20
