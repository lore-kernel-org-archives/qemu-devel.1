Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EB8C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF49208CA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF49208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbNvu-0002NQ-EC
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frankja@linux.ibm.com>) id 1hbNtf-0000qC-9Y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1hbNtc-0000iB-F7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:27:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1hbNtb-0000gX-BW
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:27:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5DBR3OG102868
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 07:27:53 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t3mg32v9f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 07:27:52 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 13 Jun 2019 12:27:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Jun 2019 12:27:48 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5DBRl9N57671684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2019 11:27:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E771EA405C;
 Thu, 13 Jun 2019 11:27:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88972A405F;
 Thu, 13 Jun 2019 11:27:46 +0000 (GMT)
Received: from dyn-9-152-224-35.boeblingen.de.ibm.com (unknown [9.152.224.35])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2019 11:27:46 +0000 (GMT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190612132526.8905-1-david@redhat.com>
 <20190612132526.8905-3-david@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 13 Jun 2019 13:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612132526.8905-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061311-0008-0000-0000-000002F36EB7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061311-0009-0000-0000-00002260744E
Message-Id: <72a235fd-c245-72f2-3c42-1d5d4752b998@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-13_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=979 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/cpumodel: Prepend KDSA
 features with "KDSA"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/19 3:25 PM, David Hildenbrand wrote:
> Let's handle it just like for other crypto features.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_features_def.inc.h | 30 ++++++++++++++---------------
>  target/s390x/gen-features.c         | 30 ++++++++++++++---------------
>  2 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
> index 5dffff65fa..c20c780f2e 100644
> --- a/target/s390x/cpu_features_def.inc.h
> +++ b/target/s390x/cpu_features_def.inc.h
> @@ -339,21 +339,21 @@ DEF_FEAT(KMA_GCM_EAES_192, "kma-gcm-eaes-192", KMA, 27, "KMA GCM-Encrypted-AES-1
>  DEF_FEAT(KMA_GCM_EAES_256, "kma-gcm-eaes-256", KMA, 28, "KMA GCM-Encrypted-AES-256")
>  
>  /* Features exposed via the KDSA instruction. */
> -DEF_FEAT(ECDSA_VERIFY_P256, "kdsa-ecdsa-verify-p256", KDSA, 1, "KDSA ECDSA-Verify-P256")
> -DEF_FEAT(ECDSA_VERIFY_P384, "kdsa-ecdsa-verify-p384", KDSA, 2, "KDSA ECDSA-Verify-P384")
> -DEF_FEAT(ECDSA_VERIFY_P512, "kdsa-ecdsa-verify-p521", KDSA, 3, "KDSA ECDSA-Verify-P521")
> -DEF_FEAT(ECDSA_SIGN_P256, "kdsa-ecdsa-sign-p256", KDSA, 9, "KDSA ECDSA-Sign-P256")
> -DEF_FEAT(ECDSA_SIGN_P384, "kdsa-ecdsa-sign-p384", KDSA, 10, "KDSA ECDSA-Sign-P384")
> -DEF_FEAT(ECDSA_SIGN_P512, "kdsa-ecdsa-sign-p521", KDSA, 11, "KDSA ECDSA-Sign-P521")
> -DEF_FEAT(EECDSA_SIGN_P256, "kdsa-eecdsa-sign-p256", KDSA, 17, "KDSA Encrypted-ECDSA-Sign-P256")
> -DEF_FEAT(EECDSA_SIGN_P384, "kdsa-eecdsa-sign-p384", KDSA, 18, "KDSA Encrypted-ECDSA-Sign-P384")
> -DEF_FEAT(EECDSA_SIGN_P512, "kdsa-eecdsa-sign-p521", KDSA, 19, "KDSA Encrypted-ECDSA-Sign-P521")
> -DEF_FEAT(EDDSA_VERIFY_ED25519, "kdsa-eddsa-verify-ed25519", KDSA, 32, "KDSA EdDSA-Verify-Ed25519")
> -DEF_FEAT(EDDSA_VERIFY_ED448, "kdsa-eddsa-verify-ed448", KDSA, 36, "KDSA EdDSA-Verify-Ed448")
> -DEF_FEAT(EDDSA_SIGN_ED25519, "kdsa-eddsa-sign-ed25519", KDSA, 40, "KDSA EdDSA-Sign-Ed25519")
> -DEF_FEAT(EDDSA_SIGN_ED448, "kdsa-eddsa-sign-ed448", KDSA, 44, "KDSA EdDSA-Sign-Ed448")
> -DEF_FEAT(EEDDSA_SIGN_ED25519, "kdsa-eeddsa-sign-ed25519", KDSA, 48, "KDSA Encrypted-EdDSA-Sign-Ed25519")
> -DEF_FEAT(EEDDSA_SIGN_ED448, "kdsa-eeddsa-sign-ed448", KDSA, 52, "KDSA Encrypted-EdDSA-Sign-Ed448")
> +DEF_FEAT(KDSA_ECDSA_VERIFY_P256, "kdsa-ecdsa-verify-p256", KDSA, 1, "KDSA ECDSA-Verify-P256")
> +DEF_FEAT(KDSA_ECDSA_VERIFY_P384, "kdsa-ecdsa-verify-p384", KDSA, 2, "KDSA ECDSA-Verify-P384")
> +DEF_FEAT(KDSA_ECDSA_VERIFY_P512, "kdsa-ecdsa-verify-p521", KDSA, 3, "KDSA ECDSA-Verify-P521")
> +DEF_FEAT(KDSA_ECDSA_SIGN_P256, "kdsa-ecdsa-sign-p256", KDSA, 9, "KDSA ECDSA-Sign-P256")
> +DEF_FEAT(KDSA_ECDSA_SIGN_P384, "kdsa-ecdsa-sign-p384", KDSA, 10, "KDSA ECDSA-Sign-P384")
> +DEF_FEAT(KDSA_ECDSA_SIGN_P512, "kdsa-ecdsa-sign-p521", KDSA, 11, "KDSA ECDSA-Sign-P521")
> +DEF_FEAT(KDSA_EECDSA_SIGN_P256, "kdsa-eecdsa-sign-p256", KDSA, 17, "KDSA Encrypted-ECDSA-Sign-P256")
> +DEF_FEAT(KDSA_EECDSA_SIGN_P384, "kdsa-eecdsa-sign-p384", KDSA, 18, "KDSA Encrypted-ECDSA-Sign-P384")
> +DEF_FEAT(KDSA_EECDSA_SIGN_P512, "kdsa-eecdsa-sign-p521", KDSA, 19, "KDSA Encrypted-ECDSA-Sign-P521")
> +DEF_FEAT(KDSA_EDDSA_VERIFY_ED25519, "kdsa-eddsa-verify-ed25519", KDSA, 32, "KDSA EdDSA-Verify-Ed25519")
> +DEF_FEAT(KDSA_EDDSA_VERIFY_ED448, "kdsa-eddsa-verify-ed448", KDSA, 36, "KDSA EdDSA-Verify-Ed448")
> +DEF_FEAT(KDSA_EDDSA_SIGN_ED25519, "kdsa-eddsa-sign-ed25519", KDSA, 40, "KDSA EdDSA-Sign-Ed25519")
> +DEF_FEAT(KDSA_EDDSA_SIGN_ED448, "kdsa-eddsa-sign-ed448", KDSA, 44, "KDSA EdDSA-Sign-Ed448")
> +DEF_FEAT(KDSA_EEDDSA_SIGN_ED25519, "kdsa-eeddsa-sign-ed25519", KDSA, 48, "KDSA Encrypted-EdDSA-Sign-Ed25519")
> +DEF_FEAT(KDSA_EEDDSA_SIGN_ED448, "kdsa-eeddsa-sign-ed448", KDSA, 52, "KDSA Encrypted-EdDSA-Sign-Ed448")
>  
>  /* Features exposed via the SORTL instruction. */
>  DEF_FEAT(SORTL_SFLR, "sortl-sflr", SORTL, 1, "SORTL SFLR")
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index dc320a06c2..af06be3e3b 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -216,21 +216,21 @@
>  
>  #define S390_FEAT_GROUP_MSA_EXT_9 \
>      S390_FEAT_MSA_EXT_9, \
> -    S390_FEAT_ECDSA_VERIFY_P256, \
> -    S390_FEAT_ECDSA_VERIFY_P384, \
> -    S390_FEAT_ECDSA_VERIFY_P512, \
> -    S390_FEAT_ECDSA_SIGN_P256, \
> -    S390_FEAT_ECDSA_SIGN_P384, \
> -    S390_FEAT_ECDSA_SIGN_P512, \
> -    S390_FEAT_EECDSA_SIGN_P256, \
> -    S390_FEAT_EECDSA_SIGN_P384, \
> -    S390_FEAT_EECDSA_SIGN_P512, \
> -    S390_FEAT_EDDSA_VERIFY_ED25519, \
> -    S390_FEAT_EDDSA_VERIFY_ED448, \
> -    S390_FEAT_EDDSA_SIGN_ED25519, \
> -    S390_FEAT_EDDSA_SIGN_ED448, \
> -    S390_FEAT_EEDDSA_SIGN_ED25519, \
> -    S390_FEAT_EEDDSA_SIGN_ED448, \
> +    S390_FEAT_KDSA_ECDSA_VERIFY_P256, \
> +    S390_FEAT_KDSA_ECDSA_VERIFY_P384, \
> +    S390_FEAT_KDSA_ECDSA_VERIFY_P512, \
> +    S390_FEAT_KDSA_ECDSA_SIGN_P256, \
> +    S390_FEAT_KDSA_ECDSA_SIGN_P384, \
> +    S390_FEAT_KDSA_ECDSA_SIGN_P512, \
> +    S390_FEAT_KDSA_EECDSA_SIGN_P256, \
> +    S390_FEAT_KDSA_EECDSA_SIGN_P384, \
> +    S390_FEAT_KDSA_EECDSA_SIGN_P512, \
> +    S390_FEAT_KDSA_EDDSA_VERIFY_ED25519, \
> +    S390_FEAT_KDSA_EDDSA_VERIFY_ED448, \
> +    S390_FEAT_KDSA_EDDSA_SIGN_ED25519, \
> +    S390_FEAT_KDSA_EDDSA_SIGN_ED448, \
> +    S390_FEAT_KDSA_EEDDSA_SIGN_ED25519, \
> +    S390_FEAT_KDSA_EEDDSA_SIGN_ED448, \
>      S390_FEAT_PCC_SCALAR_MULT_P256, \
>      S390_FEAT_PCC_SCALAR_MULT_P384, \
>      S390_FEAT_PCC_SCALAR_MULT_P512, \
> 


