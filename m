Received: from eggs.gnu.org ([2001:4830:134:3::10]:60205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fiLmN-0004u9-2f
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fiLmK-0008If-3F
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:32:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36246
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fiLmJ-0008IO-SC
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:32:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6PFT366142736
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 11:32:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2keswyeuk9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 11:32:38 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 25 Jul 2018 16:32:35 +0100
References: <20180725143617.8731-1-mimu@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Jul 2018 17:32:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180725143617.8731-1-mimu@linux.ibm.com>
Content-Language: en-US
Message-Id: <b7a4556c-513e-a1d5-8cb7-0ca53378c0af@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/cpumodel: enum type
 S390FeatGroup now gets generated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Mueller <mimu@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, agraf@suse.de

Acked-by Christian Borntraeger <borntraeger@de.ibm.com>

A quick test seems to indicate that everything is good.


On 07/25/2018 04:36 PM, Michael Mueller wrote:
> The enumeration type S390FeatGroup is now generated as well.
> This shall simplify the definition of new feature groups
> without the requirement to modify existing code.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  target/s390x/cpu_features.c |  1 -
>  target/s390x/cpu_features.h | 19 +------------------
>  target/s390x/gen-features.c | 18 +++++++++++++++++-
>  3 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 3b9e2745e9..d623db34a6 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -13,7 +13,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "cpu_features.h"
> -#include "gen-features.h"
>  
>  #define FEAT_INIT(_name, _type, _bit, _desc) \
>      {                                                \
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index 968b12fdfe..effe790271 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -16,6 +16,7 @@
>  
>  #include "qemu/bitmap.h"
>  #include "cpu_features_def.h"
> +#include "gen-features.h"
>  
>  /* CPU features are announced via different ways */
>  typedef enum {
> @@ -64,24 +65,6 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
>  void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
>                                 void (*fn)(const char *name, void *opaque));
>  
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
> -    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
> -    S390_FEAT_GROUP_MAX,
> -} S390FeatGroup;
> -
>  /* Definition of a CPU feature group */
>  typedef struct {
>      const char *name;       /* name exposed to the user */
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 6626b6f565..2ca5ededb3 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -661,6 +661,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
>  #define FEAT_GROUP_INITIALIZER(_name)                  \
>      {                                                  \
>          .name = "S390_FEAT_GROUP_LIST_" #_name,        \
> +        .enum_name = "S390_FEAT_GROUP_" #_name,        \
>          .bits =                                        \
>              { .data = group_##_name,                   \
>                .len = ARRAY_SIZE(group_##_name) },      \
> @@ -668,6 +669,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
>  
>  typedef struct {
>      const char *name;
> +    const char *enum_name;
>      BitSpec bits;
>  } FeatGroupDefSpec;
>  
> @@ -678,7 +680,6 @@ static FeatGroupDefSpec FeatGroupDef[] = {
>      FEAT_GROUP_INITIALIZER(PLO),
>      FEAT_GROUP_INITIALIZER(TOD_CLOCK_STEERING),
>      FEAT_GROUP_INITIALIZER(GEN13_PTFF),
> -    FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
>      FEAT_GROUP_INITIALIZER(MSA),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_1),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_2),
> @@ -688,6 +689,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
>      FEAT_GROUP_INITIALIZER(MSA_EXT_6),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_7),
>      FEAT_GROUP_INITIALIZER(MSA_EXT_8),
> +    FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
>  };
>  
>  #define QEMU_FEAT_INITIALIZER(_name)                   \
> @@ -810,6 +812,19 @@ static void print_feature_group_defs(void)
>      }
>  }
>  
> +static void print_feature_group_enum_type(void)
> +{
> +    int i;
> +
> +    printf("\n/* CPU feature group enum type */\n"
> +           "typedef enum {\n");
> +    for (i = 0; i < ARRAY_SIZE(FeatGroupDef); i++) {
> +        printf("\t%s,\n", FeatGroupDef[i].enum_name);
> +    }
> +    printf("\tS390_FEAT_GROUP_MAX,\n"
> +           "} S390FeatGroup;\n");
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      printf("/*\n"
> @@ -826,6 +841,7 @@ int main(int argc, char *argv[])
>      print_feature_defs();
>      print_feature_group_defs();
>      print_qemu_feature_defs();
> +    print_feature_group_enum_type();
>      printf("\n#endif\n");
>      return 0;
>  }
> 
