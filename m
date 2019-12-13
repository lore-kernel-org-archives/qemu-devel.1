Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AE4C2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF1821655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF1821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkMo-0004di-LO
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifkLX-0003Po-PK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifkLW-00086x-Bs
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:47:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ifkLW-000852-0r; Fri, 13 Dec 2019 07:47:02 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDChVT8111256; Fri, 13 Dec 2019 07:46:53 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wugd3hwh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2019 07:46:53 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBDCheiG112482;
 Fri, 13 Dec 2019 07:46:52 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wugd3hwgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2019 07:46:52 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBDCjwi2015739;
 Fri, 13 Dec 2019 12:46:51 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01dal.us.ibm.com with ESMTP id 2wr3q7vf7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2019 12:46:51 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDCkouC61932012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 12:46:50 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5383136051;
 Fri, 13 Dec 2019 12:46:49 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8410713604F;
 Fri, 13 Dec 2019 12:46:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 12:46:49 +0000 (GMT)
Subject: Re: [PATCH v5 3/5] tpm_spapr: Support suspend and resume
To: David Gibson <david@gibson.dropbear.id.au>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
 <20191212202430.1079725-4-stefanb@linux.vnet.ibm.com>
 <20191213053933.GE207300@umbus.fritz.box>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <3ee5443f-6156-62de-d70d-13b4b224c2f3@linux.ibm.com>
Date: Fri, 13 Dec 2019 07:46:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213053933.GE207300@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130102
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/13/19 12:39 AM, David Gibson wrote:
> On Thu, Dec 12, 2019 at 03:24:28PM -0500, Stefan Berger wrote:
>> Extend the tpm_spapr frontend with VM suspend and resume support.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>
>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>> index c4a67e2403..8f5a142bd4 100644
>> --- a/hw/tpm/tpm_spapr.c
>> +++ b/hw/tpm/tpm_spapr.c
>> @@ -87,6 +87,8 @@ typedef struct {
>>       TPMVersion be_tpm_version;
>>   
>>       size_t be_buffer_size;
>> +
>> +    bool deliver_response; /* whether to deliver response after VM resume */
>>   } SPAPRvTPMState;
>>   
>>   static void tpm_spapr_show_buffer(const unsigned char *buffer,
>> @@ -256,6 +258,12 @@ static void tpm_spapr_request_completed(TPMIf *ti, int ret)
>>       uint32_t len;
>>       int rc;
>>   
>> +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> I'm trying to figure out the circumstances in which
> request_completed() would get called before post_load on the
> destination.


This is on the source side where we must not deliver the response in 
case the devices are now suspending but defer the delivery to after the 
resume.


>
>> +        /* defer delivery of response until .post_load */
>> +        s->deliver_response |= true;
> |= is a bitwise OR which is not what you want, although it will
> *probably* work in practice.  Better to just use
> 	s->deliver_response = true;
>
>> +        return;
>> +    }
>> +
>>       s->state = SPAPR_VTPM_STATE_COMPLETION;
>>   
>>       /* a max. of be_buffer_size bytes can be transported */
>> @@ -316,6 +324,7 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>>       SPAPRvTPMState *s = VIO_SPAPR_VTPM(dev);
>>   
>>       s->state = SPAPR_VTPM_STATE_NONE;
>> +    s->deliver_response = false;
>>   
>>       s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
>>       tpm_spapr_update_deviceclass(dev);
>> @@ -339,9 +348,53 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
>>       return tpm_backend_get_tpm_version(s->be_driver);
>>   }
>>   
>> +/* persistent state handling */
>> +
>> +static int tpm_spapr_pre_save(void *opaque)
>> +{
>> +    SPAPRvTPMState *s = opaque;
>> +
>> +    s->deliver_response |= tpm_backend_finish_sync(s->be_driver);
> Same problem here.
>
>> +    trace_tpm_spapr_pre_save(s->deliver_response);
>> +    /*
>> +     * we cannot deliver the results to the VM since DMA would touch VM memory
>> +     */
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpm_spapr_post_load(void *opaque, int version_id)
>> +{
>> +    SPAPRvTPMState *s = opaque;
>> +
>> +    if (s->deliver_response) {
>> +        trace_tpm_spapr_post_load();
>> +        /* deliver the results to the VM via DMA */
>> +        tpm_spapr_request_completed(TPM_IF(s), 0);
>> +        s->deliver_response = false;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vmstate_spapr_vtpm = {
>>       .name = "tpm-spapr",
>> -    .unmigratable = 1,
>> +    .version_id = 1,
>> +    .minimum_version_id = 0,
>> +    .minimum_version_id_old = 0,
>> +    .pre_save = tpm_spapr_pre_save,
>> +    .post_load = tpm_spapr_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_SPAPR_VIO(vdev, SPAPRvTPMState),
>> +
>> +        VMSTATE_UINT8(state, SPAPRvTPMState),
>> +        VMSTATE_BUFFER(buffer, SPAPRvTPMState),
> Transferring the whole 4kiB buffer unconditionally when it mostly
> won't have anything useful in it doesn't seem like a great idea.


It's really only needed in case of a 'delayed response'. So, yeah, we 
could transfer data in only that case then.


>
>> +        /* remember DMA address */
>> +        VMSTATE_UINT32(crq.s.data, SPAPRvTPMState),
>> +        VMSTATE_BOOL(deliver_response, SPAPRvTPMState),
>> +        VMSTATE_END_OF_LIST(),
>> +    }
>>   };
>>   
>>   static Property tpm_spapr_properties[] = {
>> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
>> index 6278a39618..d109661b96 100644
>> --- a/hw/tpm/trace-events
>> +++ b/hw/tpm/trace-events
>> @@ -67,3 +67,5 @@ tpm_spapr_do_crq_get_version(uint32_t version) "response: version %u"
>>   tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspend"
>>   tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x%02x"
>>   tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x%02x 0x%02x ..."
>> +tpm_spapr_pre_save(bool v) "TPM response to deliver after resume: %d"
>> +tpm_spapr_post_load(void) "Delivering TPM response after resume"



