Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F16CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7E1208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJd3Dc+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7E1208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9kJM-0003f5-59
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 01:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9kIb-00037b-9H
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9kIZ-0006pm-Km
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:48:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9kIZ-0006pG-Gi
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583390878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oa/MMtIyNyoZTihfyVTkSk7K6p7bZh9ZOEu+Yk2qalY=;
 b=jJd3Dc+dVv3qMfDoZfTMHDG55GwhXCpeMLeIdVSPF3yNKM83oEorM6WzxRyj649BFTGzvC
 r3aRw/B0rQaDspPpWseqq7nkT69Ueq+IF8R1UzBoFjM+Ba+saOk1DyZCeWDoq+TsjK+j8r
 /ApfB/8LSeOP/rIoePTzA/06kOjCh1o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-rGiABfFfPMuYk6DY6SNJZA-1; Thu, 05 Mar 2020 01:47:57 -0500
X-MC-Unique: rGiABfFfPMuYk6DY6SNJZA-1
Received: by mail-wm1-f70.google.com with SMTP id t2so1200940wmj.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 22:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HEZmZwhdvBOCsqf8+cxAGj0byl/HCrci2AZE5LKhCqk=;
 b=hK+NbYXMHfVPHwXIMDXoB7Cib4LDt6jBkHe3Yba+Csr1V7A4+VZt8gDcvfmu2v43NT
 c6i9JTbB6vU8hRLzWotsxLi1lttT68mzxcJz4x4eHLyjH1l/0tEI6qmFWhdEyE1CDp/I
 fnOleb3Xnj+9/ouMBouZxVCohrmRirxrqWyOkLPyXAwyMe3n7ZX4ejPa6d8HO+F/Idqz
 BFsovE4Djhf7ao0EYdE1bbSZs/gTEHG+dOnI4WQqBmw8RqRso2T+UWNb/YAdRnIuq9KR
 8XVM/HjceDi1EYUNUFJaJupHEHxWRYWBRtxJ4/WnZMzu+Lc5TJecupzekL8tE3SrFKtW
 cYjA==
X-Gm-Message-State: ANhLgQ3+SHajyfbIZJmkPVTyhqjoquPrv5Iz2UBy/9Yf1QEcbW+5nXKw
 qeQ7ClZMO4I7OJvcx1xOi6bd3OfEdb/9UUHOIjwRtc7PGEbq1e5mTvQCx0uFvRbf8puyzhzt7rQ
 gy9E800bW4fT0Axg=
X-Received: by 2002:a1c:3884:: with SMTP id f126mr7510136wma.26.1583390875795; 
 Wed, 04 Mar 2020 22:47:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvFy0uL5Wo2Aw9PInwXmDghIcgfQmssBLTUEwe0Mp/u+nWv7bLbjIIkrmyfcl9LePz+RUK38Q==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr7510104wma.26.1583390875457; 
 Wed, 04 Mar 2020 22:47:55 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z10sm7948264wmk.31.2020.03.04.22.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 22:47:54 -0800 (PST)
Subject: Re: [PATCH 5/5] hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA
 buffer size
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200304153311.22959-1-philmd@redhat.com>
 <20200304153311.22959-6-philmd@redhat.com>
 <20200305004337.GL593957@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <020a0760-bca5-346e-810c-28d438206458@redhat.com>
Date: Thu, 5 Mar 2020 07:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305004337.GL593957@umbus.fritz.box>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 1:43 AM, David Gibson wrote:
> On Wed, Mar 04, 2020 at 04:33:11PM +0100, Philippe Mathieu-Daud=E9 wrote:
>> The 'union srp_iu' is meant as a pointer to any SRP Information
>> Unit type, it is not related to the size of a VIO DMA buffer.
>>
>> Use a plain buffer for the VIO DMA read/write calls.
>> We can remove the reserved buffer from the 'union srp_iu'.
>>
>> This issue was noticed when replacing the zero-length arrays
>> from hw/scsi/srp.h with flexible array member,
>> 'clang -fsanitize=3Dundefined' reported:
>>
>>    hw/scsi/spapr_vscsi.c:69:29: error: field 'iu' with variable sized ty=
pe 'union viosrp_iu' not at the end of a struct or class is a GNU extension=
 [-Werror,-Wgnu-variable-sized-type-not-at-end]
>>         union viosrp_iu         iu;
>>                                 ^
>>
>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> ---
>>   hw/scsi/viosrp.h      |  2 +-
>>   hw/scsi/spapr_vscsi.c | 10 +++++-----
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/scsi/viosrp.h b/hw/scsi/viosrp.h
>> index 25676c2383..aba3203028 100644
>> --- a/hw/scsi/viosrp.h
>> +++ b/hw/scsi/viosrp.h
>> @@ -49,8 +49,8 @@ union srp_iu {
>>       struct srp_tsk_mgmt tsk_mgmt;
>>       struct srp_cmd cmd;
>>       struct srp_rsp rsp;
>> -    uint8_t reserved[SRP_MAX_IU_LEN];
>>   };
>> +_Static_assert(sizeof(union srp_iu) <=3D SRP_MAX_IU_LEN, "srp_iu size i=
ncorrect");
>=20
> Hrm.  Given that srp_iu will be a variably sized type, is this
> assertion actually testing anything meaningful?

I wanted to assert that if another SRP IU is added, the DMA buffer will=20
be big enough to hold it. I'll simply remove the check.

> Otherwise, LGTM.

Thanks for reviewing the series,

Phil.

>=20
>>  =20
>>   enum viosrp_crq_formats {
>>       VIOSRP_SRP_FORMAT =3D 0x01,
>> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
>> index f1a0bbdc31..f9be68e44e 100644
>> --- a/hw/scsi/spapr_vscsi.c
>> +++ b/hw/scsi/spapr_vscsi.c
>> @@ -66,7 +66,7 @@ typedef union vscsi_crq {
>>  =20
>>   typedef struct vscsi_req {
>>       vscsi_crq               crq;
>> -    union viosrp_iu         iu;
>> +    uint8_t                 viosrp_iu_buf[SRP_MAX_IU_LEN];
>>  =20
>>       /* SCSI request tracking */
>>       SCSIRequest             *sreq;
>> @@ -99,7 +99,7 @@ typedef struct {
>>  =20
>>   static union viosrp_iu *req_iu(vscsi_req *req)
>>   {
>> -    return (union viosrp_iu *)req->iu.srp.reserved;
>> +    return (union viosrp_iu *)req->viosrp_iu_buf;
>>   }
>>  =20
>>  =20
>> @@ -184,7 +184,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *r=
eq,
>>  =20
>>       /* First copy the SRP */
>>       rc =3D spapr_vio_dma_write(&s->vdev, req->crq.s.IU_data_ptr,
>> -                             &req->iu, length);
>> +                             &req->viosrp_iu_buf, length);
>>       if (rc) {
>>           fprintf(stderr, "vscsi_send_iu: DMA write failure !\n");
>>       }
>> @@ -603,7 +603,7 @@ static const VMStateDescription vmstate_spapr_vscsi_=
req =3D {
>>       .minimum_version_id =3D 1,
>>       .fields =3D (VMStateField[]) {
>>           VMSTATE_BUFFER(crq.raw, vscsi_req),
>> -        VMSTATE_BUFFER(iu.srp.reserved, vscsi_req),
>> +        VMSTATE_BUFFER(viosrp_iu_buf, vscsi_req),
>>           VMSTATE_UINT32(qtag, vscsi_req),
>>           VMSTATE_BOOL(active, vscsi_req),
>>           VMSTATE_UINT32(data_len, vscsi_req),
>> @@ -1104,7 +1104,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi=
_crq *crq)
>>       }
>>  =20
>>       /* XXX Handle failure differently ? */
>> -    if (spapr_vio_dma_read(&s->vdev, crq->s.IU_data_ptr, &req->iu,
>> +    if (spapr_vio_dma_read(&s->vdev, crq->s.IU_data_ptr, &req->viosrp_i=
u_buf,
>>                              crq->s.IU_length)) {
>>           fprintf(stderr, "vscsi_got_payload: DMA read failure !\n");
>>           vscsi_put_req(req);
>=20


