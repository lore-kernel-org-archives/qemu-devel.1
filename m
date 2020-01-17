Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D18C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CE82073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CE82073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRtY-0004KF-Am
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1isRs7-0002y9-RC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1isRs4-00058S-9W
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:41:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5974
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1isRs4-00057N-3a; Fri, 17 Jan 2020 08:41:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00HDRqef123935; Fri, 17 Jan 2020 08:41:01 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xk0qswpb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2020 08:41:01 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00HDS7iv125451;
 Fri, 17 Jan 2020 08:41:01 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xk0qswpam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2020 08:41:01 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00HDUoil021559;
 Fri, 17 Jan 2020 13:41:00 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 2xjuy1j9ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2020 13:41:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00HDexFu41681206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2020 13:40:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94C06112062;
 Fri, 17 Jan 2020 13:40:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85FA4112063;
 Fri, 17 Jan 2020 13:40:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jan 2020 13:40:59 +0000 (GMT)
Subject: Re: [PATCH v8 4/6] tpm_spapr: Support suspend and resume
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
 <20200108161012.1821385-5-stefanb@linux.ibm.com>
 <CAJ+F1CJLKnhWW5kz=C5f9EJd=h-_b46ST_qOpwe1zDBjNU76mw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <9307b42f-3149-2cea-fbc9-28110ebc481b@linux.ibm.com>
Date: Fri, 17 Jan 2020 08:40:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJLKnhWW5kz=C5f9EJd=h-_b46ST_qOpwe1zDBjNU76mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-17_03:2020-01-16,
 2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001170108
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 00HDRqef123935
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 8:31 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Jan 8, 2020 at 8:14 PM Stefan Berger <stefanb@linux.ibm.com> wr=
ote:
>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>
>> Extend the tpm_spapr frontend with VM suspend and resume support.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_spapr.c  | 67 +++++++++++++++++++++++++++++++++++++++++++=
+-
>>   hw/tpm/trace-events |  2 ++
>>   2 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>> index ab184fbb82..cf5c7851e7 100644
>> --- a/hw/tpm/tpm_spapr.c
>> +++ b/hw/tpm/tpm_spapr.c
>> @@ -76,6 +76,9 @@ typedef struct {
>>
>>       unsigned char buffer[TPM_SPAPR_BUFFER_MAX];
>>
>> +    uint32_t numbytes; /* number of bytes in suspend_buffer */
>> +    unsigned char *suspend_buffer;
> Why do you need a copy suspend_buffer? Why not use and save buffer[] di=
rectly?


This addresses David's comment:

"Transferring the whole 4kiB buffer unconditionally when it mostly
won't have anything useful in it doesn't seem like a great idea."

https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg02601.html


>
> Also numbytes wouldn't be necessary, you would just need a bool flag
> to say if the request_completed is pending.
>
>> +
>>       TPMBackendCmd cmd;
>>
>>       TPMBackend *be_driver;
>> @@ -240,6 +243,13 @@ static void tpm_spapr_request_completed(TPMIf *ti=
, int ret)
>>
>>       /* a max. of be_buffer_size bytes can be transported */
>>       len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
>> +
>> +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>> +        /* defer delivery of response until .post_load */
>> +        s->numbytes =3D len;
>> +        return;
>> +    }
>> +
>>       rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->data),
>>                                s->buffer, len);
>>
>> @@ -288,11 +298,13 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>>       SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
>>
>>       s->state =3D SPAPR_VTPM_STATE_NONE;
>> +    s->numbytes =3D 0;
>>
>>       s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
>>
>>       s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driv=
er),
>>                               TPM_SPAPR_BUFFER_MAX);
>> +    s->suspend_buffer =3D g_realloc(s->suspend_buffer, s->be_buffer_s=
ize);
>>
>>       tpm_backend_reset(s->be_driver);
>>       tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
>> @@ -309,9 +321,62 @@ static enum TPMVersion tpm_spapr_get_version(TPMI=
f *ti)
>>       return tpm_backend_get_tpm_version(s->be_driver);
>>   }
>>
>> +/* persistent state handling */
>> +
>> +static int tpm_spapr_pre_save(void *opaque)
>> +{
>> +    SpaprTpmState *s =3D opaque;
>> +
>> +    tpm_backend_finish_sync(s->be_driver);
>> +
>> +    if (s->numbytes) {
>> +        memcpy(s->suspend_buffer, s->buffer, s->numbytes);
>> +    }
>> +
>> +    trace_tpm_spapr_pre_save(s->numbytes);
>> +    /*
>> +     * we cannot deliver the results to the VM since DMA would touch =
VM memory
>> +     */
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpm_spapr_post_load(void *opaque, int version_id)
>> +{
>> +    SpaprTpmState *s =3D opaque;
>> +
>> +    if (s->numbytes) {
>> +        trace_tpm_spapr_post_load();
>> +
>> +        memcpy(s->buffer, s->suspend_buffer,
>> +               MIN(s->numbytes, s->be_buffer_size));
>> +        /* deliver the results to the VM via DMA */
>> +        tpm_spapr_request_completed(TPM_IF(s), 0);
>> +        s->numbytes =3D 0;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vmstate_spapr_vtpm =3D {
>>       .name =3D "tpm-spapr",
>> -    .unmigratable =3D 1,
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 0,
>> +    .minimum_version_id_old =3D 0,
>
> Yyou should leave all the fields to 0 (there is no version 0 so far).
> Thus no need to have them set explicitly either.


Ok, I will fix.

 =C2=A0 Thanks.

