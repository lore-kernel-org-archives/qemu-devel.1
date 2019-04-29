Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A072C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD0E2087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD0E2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL3Sg-0007gX-R8
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 06:24:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3R5-0006df-4q
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3O3-0007WW-F9
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:19:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hL3O2-0007Vu-Lk; Mon, 29 Apr 2019 06:19:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C22E5307CDF0;
	Mon, 29 Apr 2019 10:19:49 +0000 (UTC)
Received: from [10.36.118.17] (unknown [10.36.118.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C179A19749;
	Mon, 29 Apr 2019 10:19:45 +0000 (UTC)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
	<20190429090250.7648-8-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <42919d38-cd8e-0bb0-e218-e163d93479ff@redhat.com>
Date: Mon, 29 Apr 2019 12:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429090250.7648-8-borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 29 Apr 2019 10:19:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 7/9] s390x/cpumodel: add
 Deflate-conversion facility
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429101943.G0u4nO-Y0zPBMqny9DoUbqeq2HCbc5yYDr-uTsS4dPU@z>

On 29.04.19 11:02, Christian Borntraeger wrote:
> add the deflate conversion facility.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     |  9 +++++++++
>  target/s390x/cpu_features.h     |  1 +
>  target/s390x/cpu_features_def.h |  7 +++++++
>  target/s390x/gen-features.c     | 12 ++++++++++++
>  target/s390x/kvm.c              |  6 ++++++
>  5 files changed, 35 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 1d19b3072e..f64f581c86 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -110,6 +110,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
>      FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
>      FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort facility (excluding subfunctions)"),
> +    FEAT_INIT("deflate-base", S390_FEAT_TYPE_STFL, 151, "Deflate-conversion facility (excluding subfunctions)"),
>      FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
>      FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
>      FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
> @@ -347,6 +348,11 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lists"),
>      FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input lists"),
>      FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 parameter-block"),
> +
> +    FEAT_INIT("dfltcc-gdht", S390_FEAT_TYPE_DFLTCC, 1, "DFLTCC GDHT"),
> +    FEAT_INIT("dfltcc-cmpr", S390_FEAT_TYPE_DFLTCC, 2, "DFLTCC CMPR"),
> +    FEAT_INIT("dfltcc-xpnd", S390_FEAT_TYPE_DFLTCC, 4, "DFLTCC XPND"),
> +    FEAT_INIT("dfltcc-f0", S390_FEAT_TYPE_DFLTCC, 192, "DFLTCC format 0 parameter-block"),
>  };
>  
>  const S390FeatDef *s390_feat_def(S390Feat feat)
> @@ -411,6 +417,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>      case S390_FEAT_TYPE_KMA:
>      case S390_FEAT_TYPE_KDSA:
>      case S390_FEAT_TYPE_SORTL:
> +    case S390_FEAT_TYPE_DFLTCC:
>          set_be_bit(0, data); /* query is always available */
>          break;
>      default:
> @@ -439,6 +446,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
>         break;
>      case S390_FEAT_TYPE_PLO:
>      case S390_FEAT_TYPE_SORTL:
> +    case S390_FEAT_TYPE_DFLTCC:
>         nr_bits = 256;
>         break;
>      default:
> @@ -511,6 +519,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
>      FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
>      FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
>      FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
> +    FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion facility"),
>  };
>  
>  const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index 3b8c5b25dd..da695a8346 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -41,6 +41,7 @@ typedef enum {
>      S390_FEAT_TYPE_KMA,
>      S390_FEAT_TYPE_KDSA,
>      S390_FEAT_TYPE_SORTL,
> +    S390_FEAT_TYPE_DFLTCC,
>  } S390FeatType;
>  
>  /* Definition of a CPU feature */
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index bb8585847f..292b17b35d 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -98,6 +98,7 @@ typedef enum {
>      S390_FEAT_CMM_NT,
>      S390_FEAT_VECTOR_ENH2,
>      S390_FEAT_ESORT_BASE,
> +    S390_FEAT_DEFLATE_BASE,
>      S390_FEAT_VECTOR_BCD_ENH,
>      S390_FEAT_MSA_EXT_9,
>      S390_FEAT_ETOKEN,
> @@ -354,6 +355,12 @@ typedef enum {
>      S390_FEAT_SORTL_128,
>      S390_FEAT_SORTL_F0,
>  
> +    /* DEFLATE */
> +    S390_FEAT_DEFLATE_GHDT,
> +    S390_FEAT_DEFLATE_CMPR,
> +    S390_FEAT_DEFLATE_XPND,
> +    S390_FEAT_DEFLATE_F0,
> +
>      S390_FEAT_MAX,
>  } S390Feat;
>  
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 0a62cc5631..8fc2e8e72f 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -254,6 +254,13 @@
>      S390_FEAT_SORTL_F0
>  
>  
> +#define S390_FEAT_GROUP_DEFLATE_CONVERSION \
> +    S390_FEAT_DEFLATE_BASE, \
> +    S390_FEAT_DEFLATE_GHDT, \
> +    S390_FEAT_DEFLATE_CMPR, \
> +    S390_FEAT_DEFLATE_XPND, \
> +    S390_FEAT_DEFLATE_F0
> +
>  /* cpu feature groups */
>  static uint16_t group_PLO[] = {
>      S390_FEAT_GROUP_PLO,
> @@ -307,6 +314,10 @@ static uint16_t group_ENH_SORT[] = {
>      S390_FEAT_GROUP_ENH_SORT,
>  };
>  
> +static uint16_t group_DEFLATE_CONVERSION[] = {
> +    S390_FEAT_GROUP_DEFLATE_CONVERSION,
> +};
> +
>  /* Base features (in order of release)
>   * Only non-hypervisor managed features belong here.
>   * Base feature sets are static meaning they do not change in future QEMU
> @@ -766,6 +777,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
>      FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
>      FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
>      FEAT_GROUP_INITIALIZER(ENH_SORT),
> +    FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
>  };
>  
>  #define QEMU_FEAT_INITIALIZER(_name)                   \
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index f91f436a31..e5e2b691f2 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2079,6 +2079,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
>      if (test_bit(S390_FEAT_ESORT_BASE, features)) {
>          s390_add_from_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
>      }
> +    if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
> +        s390_add_from_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
> +    }
>      return 0;
>  }
>  
> @@ -2129,6 +2132,9 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
>      if (test_bit(S390_FEAT_ESORT_BASE, features)) {
>          s390_fill_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
>      }
> +    if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
> +        s390_fill_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
> +    }
>      return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
> 


Reviewed-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David / dhildenb

