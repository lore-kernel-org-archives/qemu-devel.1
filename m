Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC50C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627E420652
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627E420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41155 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH6a5-0001wv-MX
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 08:55:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6Yw-0001Lm-K9
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6Yu-0004SO-Th
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:54:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hH6Yu-0004S6-Kw; Thu, 18 Apr 2019 08:54:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8A02319939C;
	Thu, 18 Apr 2019 12:54:43 +0000 (UTC)
Received: from [10.36.117.133] (ovpn-117-133.ams2.redhat.com [10.36.117.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB25C5C205;
	Thu, 18 Apr 2019 12:54:41 +0000 (UTC)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-5-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <f493851a-a723-9982-0342-ea417be0afd2@redhat.com>
Date: Thu, 18 Apr 2019 14:54:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-5-borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 18 Apr 2019 12:54:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/10] s390x/cpumodel: msa9 facility
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
Message-ID: <20190418125441.Pu5kjnvVTPfeY3g2QXyW8qkbEXszfeLajUr9P3ERJyE@z>

On 18.04.19 13:31, Christian Borntraeger wrote:
> Provide the MSA9 facility (stfle.155).  This also contains pckmo
> functions for key wrapping. Keep them in a separate group to allow
> disabling/enabling those as a block if necessary.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     | 32 +++++++++++++++++++++++++
>  target/s390x/cpu_features.h     |  1 +
>  target/s390x/cpu_features_def.h | 31 ++++++++++++++++++++++++
>  target/s390x/cpu_models.c       |  1 +
>  target/s390x/gen-features.c     | 42 +++++++++++++++++++++++++++++++++
>  target/s390x/kvm.c              |  6 +++++
>  6 files changed, 113 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index bbd8902087..4d624b2256 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -108,6 +108,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-multiple facility"),
>      FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
> +    FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
>      FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
>  
>      /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
> @@ -242,6 +243,11 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("pckmo-aes-128", S390_FEAT_TYPE_PCKMO, 18, "PCKMO Encrypted-AES-128-Key"),
>      FEAT_INIT("pckmo-aes-192", S390_FEAT_TYPE_PCKMO, 19, "PCKMO Encrypted-AES-192-Key"),
>      FEAT_INIT("pckmo-aes-256", S390_FEAT_TYPE_PCKMO, 20, "PCKMO Encrypted-AES-256-Key"),
> +    FEAT_INIT("pckmo-ecc-p256", S390_FEAT_TYPE_PCKMO,32, "PCKMO Encrypt-ECC-P256-Key"),
> +    FEAT_INIT("pckmo-ecc-p384", S390_FEAT_TYPE_PCKMO,33, "PCKMO Encrypt-ECC-P384-Key"),
> +    FEAT_INIT("pckmo-ecc-p521", S390_FEAT_TYPE_PCKMO,34, "PCKMO Encrypt-ECC-P521-Key"),
> +    FEAT_INIT("pckmo-ecc-ed25519", S390_FEAT_TYPE_PCKMO,40 , "PCKMO Encrypt-ECC-Ed25519-Key"),
> +    FEAT_INIT("pckmo-ecc-ed448", S390_FEAT_TYPE_PCKMO,41 , "PCKMO Encrypt-ECC-Ed448-Key"),
>  
>      FEAT_INIT("kmctr-dea", S390_FEAT_TYPE_KMCTR, 1, "KMCTR DEA"),
>      FEAT_INIT("kmctr-tdea-128", S390_FEAT_TYPE_KMCTR, 2, "KMCTR TDEA-128"),
> @@ -298,6 +304,13 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("pcc-xts-aes-256", S390_FEAT_TYPE_PCC, 52, "PCC Compute-XTS-Parameter-Using-AES-256"),
>      FEAT_INIT("pcc-xts-eaes-128", S390_FEAT_TYPE_PCC, 58, "PCC Compute-XTS-Parameter-Using-Encrypted-AES-128"),
>      FEAT_INIT("pcc-xts-eaes-256", S390_FEAT_TYPE_PCC, 60, "PCC Compute-XTS-Parameter-Using-Encrypted-AES-256"),
> +    FEAT_INIT("pcc-scalar-mult-p256", S390_FEAT_TYPE_PCC, 64, "PCC Scalar-Multiply-P256"),
> +    FEAT_INIT("pcc-scalar-mult-p384", S390_FEAT_TYPE_PCC, 65, "PCC Scalar-Multiply-P384"),
> +    FEAT_INIT("pcc-scalar-mult-p521", S390_FEAT_TYPE_PCC, 66, "PCC Scalar-Multiply-P521"),
> +    FEAT_INIT("pcc-scalar-mult-ed25519", S390_FEAT_TYPE_PCC, 72, "PCC Scalar-Multiply-Ed25519"),
> +    FEAT_INIT("pcc-scalar-mult-ed448", S390_FEAT_TYPE_PCC, 73, "PCC Scalar-Multiply-Ed448"),
> +    FEAT_INIT("pcc-scalar-mult-x25519", S390_FEAT_TYPE_PCC, 80, "PCC Scalar-Multiply-X25519"),
> +    FEAT_INIT("pcc-scalar-mult-x448", S390_FEAT_TYPE_PCC, 81, "PCC Scalar-Multiply-X448"),
>  
>      FEAT_INIT("ppno-sha-512-drng", S390_FEAT_TYPE_PPNO, 3, "PPNO SHA-512-DRNG"),
>      FEAT_INIT("prno-trng-qrtcr", S390_FEAT_TYPE_PPNO, 112, "PRNO TRNG-Query-Raw-to-Conditioned-Ratio"),
> @@ -309,6 +322,22 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("kma-gcm-eaes-128", S390_FEAT_TYPE_KMA, 26, "KMA GCM-Encrypted-AES-128"),
>      FEAT_INIT("kma-gcm-eaes-192", S390_FEAT_TYPE_KMA, 27, "KMA GCM-Encrypted-AES-192"),
>      FEAT_INIT("kma-gcm-eaes-256", S390_FEAT_TYPE_KMA, 28, "KMA GCM-Encrypted-AES-256"),
> +
> +    FEAT_INIT("kdsa-ecdsa-verify-p256", S390_FEAT_TYPE_KDSA, 1, "KDSA ECDSA-Verify-P256"),
> +    FEAT_INIT("kdsa-ecdsa-verify-p384", S390_FEAT_TYPE_KDSA, 2, "KDSA ECDSA-Verify-P384"),
> +    FEAT_INIT("kdsa-ecdsa-verify-p521", S390_FEAT_TYPE_KDSA, 3, "KDSA ECDSA-Verify-P521"),
> +    FEAT_INIT("kdsa-ecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 9, "KDSA ECDSA-Sign-P256"),
> +    FEAT_INIT("kdsa-ecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 10, "KDSA ECDSA-Sign-P384"),
> +    FEAT_INIT("kdsa-ecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 11, "KDSA ECDSA-Sign-P521"),
> +    FEAT_INIT("kdsa-eecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 17, "KDSA Encrypted-ECDSA-Sign-P256"),
> +    FEAT_INIT("kdsa-eecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 18, "KDSA Encrypted-ECDSA-Sign-P384"),
> +    FEAT_INIT("kdsa-eecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 19, "KDSA Encrypted-ECDSA-Sign-P521"),
> +    FEAT_INIT("kdsa-eddsa-verify-ed25519", S390_FEAT_TYPE_KDSA, 32, "KDSA EdDSA-Verify-Ed25519"),
> +    FEAT_INIT("kdsa-eddsa-verify-ed448", S390_FEAT_TYPE_KDSA, 36, "KDSA EdDSA-Verify-Ed448"),
> +    FEAT_INIT("kdsa-eddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 40, "KDSA EdDSA-Sign-Ed25519"),
> +    FEAT_INIT("kdsa-eddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 44, "KDSA EdDSA-Sign-Ed448"),
> +    FEAT_INIT("kdsa-eeddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 48, "KDSA Encrypted-EdDSA-Sign-Ed25519"),
> +    FEAT_INIT("kdsa-eeddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 52, "KDSA Encrypted-EdDSA-Sign-Ed448"),
>  };
>  
>  const S390FeatDef *s390_feat_def(S390Feat feat)
> @@ -371,6 +400,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>      case S390_FEAT_TYPE_PCC:
>      case S390_FEAT_TYPE_PPNO:
>      case S390_FEAT_TYPE_KMA:
> +    case S390_FEAT_TYPE_KDSA:
>          set_be_bit(0, data); /* query is always available */
>          break;
>      default:
> @@ -466,6 +496,8 @@ static S390FeatGroupDef s390_feature_groups[] = {
>      FEAT_GROUP_INIT("msa6", MSA_EXT_6, "Message-security-assist-extension 6 facility"),
>      FEAT_GROUP_INIT("msa7", MSA_EXT_7, "Message-security-assist-extension 7 facility"),
>      FEAT_GROUP_INIT("msa8", MSA_EXT_8, "Message-security-assist-extension 8 facility"),
> +    FEAT_GROUP_INIT("msa9", MSA_EXT_9, "Message-security-assist-extension 9 facility"),
> +    FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
>      FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
>  };
>  
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index effe790271..5ffd3db083 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -39,6 +39,7 @@ typedef enum {
>      S390_FEAT_TYPE_PCC,
>      S390_FEAT_TYPE_PPNO,
>      S390_FEAT_TYPE_KMA,
> +    S390_FEAT_TYPE_KDSA,
>  } S390FeatType;
>  
>  /* Definition of a CPU feature */
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index 31dd678301..030784811b 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -96,6 +96,7 @@ typedef enum {
>      S390_FEAT_INSERT_REFERENCE_BITS_MULT,
>      S390_FEAT_MSA_EXT_8,
>      S390_FEAT_CMM_NT,
> +    S390_FEAT_MSA_EXT_9,
>      S390_FEAT_ETOKEN,
>  
>      /* Sclp Conf Char */
> @@ -240,6 +241,11 @@ typedef enum {
>      S390_FEAT_PCKMO_AES_128,
>      S390_FEAT_PCKMO_AES_192,
>      S390_FEAT_PCKMO_AES_256,
> +    S390_FEAT_PCKMO_ECC_P256,
> +    S390_FEAT_PCKMO_ECC_P384,
> +    S390_FEAT_PCKMO_ECC_P521,
> +    S390_FEAT_PCKMO_ECC_ED25519,
> +    S390_FEAT_PCKMO_ECC_ED448,
>  
>      /* KMCTR */
>      S390_FEAT_KMCTR_DEA,
> @@ -300,6 +306,13 @@ typedef enum {
>      S390_FEAT_PCC_XTS_AES_256,
>      S390_FEAT_PCC_XTS_EAES_128,
>      S390_FEAT_PCC_XTS_EAES_256,
> +    S390_FEAT_PCC_SCALAR_MULT_P256,
> +    S390_FEAT_PCC_SCALAR_MULT_P384,
> +    S390_FEAT_PCC_SCALAR_MULT_P512,
> +    S390_FEAT_PCC_SCALAR_MULT_ED25519,
> +    S390_FEAT_PCC_SCALAR_MULT_ED448,
> +    S390_FEAT_PCC_SCALAR_MULT_X25519,
> +    S390_FEAT_PCC_SCALAR_MULT_X448,
>  
>      /* PPNO/PRNO */
>      S390_FEAT_PPNO_SHA_512_DRNG,
> @@ -313,6 +326,24 @@ typedef enum {
>      S390_FEAT_KMA_GCM_EAES_128,
>      S390_FEAT_KMA_GCM_EAES_192,
>      S390_FEAT_KMA_GCM_EAES_256,
> +
> +    /* KDSA */
> +    S390_FEAT_ECDSA_VERIFY_P256,
> +    S390_FEAT_ECDSA_VERIFY_P384,
> +    S390_FEAT_ECDSA_VERIFY_P512,
> +    S390_FEAT_ECDSA_SIGN_P256,
> +    S390_FEAT_ECDSA_SIGN_P384,
> +    S390_FEAT_ECDSA_SIGN_P512,
> +    S390_FEAT_EECDSA_SIGN_P256,
> +    S390_FEAT_EECDSA_SIGN_P384,
> +    S390_FEAT_EECDSA_SIGN_P512,
> +    S390_FEAT_EDDSA_VERIFY_ED25519,
> +    S390_FEAT_EDDSA_VERIFY_ED448,
> +    S390_FEAT_EDDSA_SIGN_ED25519,
> +    S390_FEAT_EDDSA_SIGN_ED448,
> +    S390_FEAT_EEDDSA_SIGN_ED25519,
> +    S390_FEAT_EEDDSA_SIGN_ED448,
> +
>      S390_FEAT_MAX,
>  } S390Feat;
>  
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 4e5aa879f3..4c355e936e 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -808,6 +808,7 @@ static void check_consistency(const S390CPUModel *model)
>          { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
>          { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
>          { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
> +        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },

This is sufficient to handle key wrapping, right?


-- 

Thanks,

David / dhildenb

