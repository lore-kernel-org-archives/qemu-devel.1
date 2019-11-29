Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6702C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B532C215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpkutC5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B532C215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadXh-0007HB-Nq
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iadDc-0001I9-2l
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iadDW-000765-TI
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:09:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iadDW-00072V-Of
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575022177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sbvJXd+GdyQ8d5DO/Cr5XpJ2EnjgTtdk7MuGQRPDo6s=;
 b=bpkutC5w3mZXQjDB0ZTZAFAy/JWEQTK7u0h5XPbCaZH118FfaKNh+bWXsNZSWcfbA47arC
 3/9IdQN+Hsvwtk0DNgXNSqzQ1mpTqxTzYr17MAQm3CCwRo+uOJeXjybb3FUvkWKLc0klwO
 I/VttaSkai/22jsDhIAaPBnw0BpxT0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-WJ3xszJiM42YRAogSpMvTw-1; Fri, 29 Nov 2019 05:09:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C88B8107ACC4;
 Fri, 29 Nov 2019 10:09:32 +0000 (UTC)
Received: from [10.36.118.44] (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C0B9600C8;
 Fri, 29 Nov 2019 10:09:30 +0000 (UTC)
Subject: Re: [PATCH v2 01/13] s390x: protvirt: Add diag308 subcodes 8 - 10
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <d12fe27e-fcce-1704-8ac3-5dca18627422@redhat.com>
Date: Fri, 29 Nov 2019 11:09:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129094809.26684-2-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WJ3xszJiM42YRAogSpMvTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[...]
> =20
> +struct IPLBlockPVComp {
> +    uint64_t tweak_pref;
> +    uint64_t addr;
> +    uint64_t size;
> +} QEMU_PACKED;

QEMU_PACKED  should not be needed.

> +typedef struct IPLBlockPVComp IPLBlockPVComp;
> +
> +struct IPLBlockPV {
> +    uint8_t  reserved[84];

"reserved0"

> +    uint8_t  reserved67[3];

Where does that magic 67 come from? (84 dec is 54 hex)

> +    uint8_t  version;

So, to this point we spent 88 bytes =3D=3D 11 * uint64_t.

> +    uint32_t num_comp;

... so after this, all uint64_t (and components) are mis-aligned by
32bit - is that correct?

> +    uint64_t pv_header_addr;
> +    uint64_t pv_header_len;
> +    struct IPLBlockPVComp components[];
> +} QEMU_PACKED;
> +typedef struct IPLBlockPV IPLBlockPV;
> +
>  struct IplBlockCcw {
>      uint8_t  reserved0[85];
>      uint8_t  ssid;
> @@ -71,6 +89,7 @@ union IplParameterBlock {
>          union {
>              IplBlockCcw ccw;
>              IplBlockFcp fcp;
> +            IPLBlockPV pv;
>              IplBlockQemuScsi scsi;
>          };
>      } QEMU_PACKED;
> @@ -84,9 +103,11 @@ union IplParameterBlock {
>  typedef union IplParameterBlock IplParameterBlock;
> =20
>  int s390_ipl_set_loadparm(uint8_t *loadparm);
> +int s390_ipl_pv_check_comp(IplParameterBlock *iplb);
>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>  IplParameterBlock *s390_ipl_get_iplb(void);
> +IplParameterBlock *s390_ipl_get_iplb_secure(void);
> =20
>  enum s390_reset {
>      /* default is a reset not triggered by a CPU e.g. issued by QMP */
> @@ -94,6 +115,7 @@ enum s390_reset {
>      S390_RESET_REIPL,
>      S390_RESET_MODIFIED_CLEAR,
>      S390_RESET_LOAD_NORMAL,
> +    S390_RESET_PV,

I do wonder if that should be called S390_RESET_PV_START

>  };
>  void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
>  void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_ty=
pe);
> @@ -133,6 +155,7 @@ struct S390IPLState {
>      /*< private >*/
>      DeviceState parent_obj;
>      IplParameterBlock iplb;
> +    IplParameterBlock iplb_pbt5;
>      QemuIplParameters qipl;
>      uint64_t start_addr;
>      uint64_t compat_start_addr;
> @@ -140,6 +163,7 @@ struct S390IPLState {
>      uint64_t compat_bios_start_addr;
>      bool enforce_bios;
>      bool iplb_valid;
> +    bool iplb_valid_pbt5;
>      bool netboot;
>      /* reset related properties don't have to be migrated or reset */
>      enum s390_reset reset_type;
> @@ -161,9 +185,11 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3,=
 "alignment of iplb wrong");
> =20
>  #define S390_IPL_TYPE_FCP 0x00
>  #define S390_IPL_TYPE_CCW 0x02
> +#define S390_IPL_TYPE_PV 0x05
>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
> =20
>  #define S390_IPLB_HEADER_LEN 8
> +#define S390_IPLB_MIN_PV_LEN 148
>  #define S390_IPLB_MIN_CCW_LEN 200
>  #define S390_IPLB_MIN_FCP_LEN 384
>  #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
> @@ -185,4 +211,11 @@ static inline bool iplb_valid_fcp(IplParameterBlock =
*iplb)
>             iplb->pbt =3D=3D S390_IPL_TYPE_FCP;
>  }
> =20
> +static inline bool iplb_valid_se(IplParameterBlock *iplb)

s/_se/_pv/ ? Or was that intended?

> +{
> +    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_PV_LEN &&
> +           iplb->pbt =3D=3D S390_IPL_TYPE_PV;
> +}
> +
> +

Maybe drop one empty line

>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index b5aec06d6b..112a6c92e0 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
[...]


--=20
Thanks,

David / dhildenb


