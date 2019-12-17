Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCDBC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 19:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB5E2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 19:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB5E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihImR-0003Ww-4m
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 14:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ihIld-00034e-Qo
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 14:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ihIlc-0003SQ-Er
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 14:44:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ihIlc-0003S0-6v; Tue, 17 Dec 2019 14:44:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBHJd69S027508; Tue, 17 Dec 2019 14:44:13 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wy41qthcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Dec 2019 14:44:12 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBHJd8Ra027751;
 Tue, 17 Dec 2019 14:44:12 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wy41qthcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Dec 2019 14:44:12 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBHJePWh009484;
 Tue, 17 Dec 2019 19:44:11 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 2wvqc6px22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Dec 2019 19:44:11 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBHJiAPG22151476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2019 19:44:10 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34EB378063;
 Tue, 17 Dec 2019 19:44:10 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB13B78066;
 Tue, 17 Dec 2019 19:44:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 17 Dec 2019 19:44:09 +0000 (GMT)
Subject: Re: [PATCH v5 1/5] tpm_spapr: Support TPM for ppc64 using CRQ based
 interface
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
 <20191212202430.1079725-2-stefanb@linux.vnet.ibm.com>
 <20191213053453.GD207300@umbus.fritz.box>
 <75fd3e95-d72f-069b-22ce-f354e1c34660@linux.ibm.com>
 <20191217002954.GH6242@umbus.fritz.box>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1efef315-cb85-79ea-9c46-ff318e05a543@linux.ibm.com>
Date: Tue, 17 Dec 2019 14:44:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217002954.GH6242@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_03:2019-12-17,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912170156
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xBHJd69S027508
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 7:29 PM, David Gibson wrote:
> On Fri, Dec 13, 2019 at 08:03:36AM -0500, Stefan Berger wrote:
>> On 12/13/19 12:34 AM, David Gibson wrote:
>>
>> The existing one looks like this:
>>
>> typedef struct SpaprVioCrq {
>>  =A0=A0=A0 uint64_t qladdr;
>>  =A0=A0=A0 uint32_t qsize;
>>  =A0=A0=A0 uint32_t qnext;
>>  =A0=A0=A0 int(*SendFunc)(struct SpaprVioDevice *vdev, uint8_t *crq);
>> } SpaprVioCrq;
>>
>> I don't seem to find the fields there that we need for vTPM support.
> Yeah, I can see the difference in the structures.  What I'm after is
> what is the difference in purpose which means they have different
> content.
>
> Having read through the whole series now, I *think* the answer is that
> the tpm specific structure is one entry in the request queue for the
> vtpm, whereas the VioCrq structure is a handle on an entire queue.
>
> I think the tpm one needs a rename to reflect that a) it's vtpm
> specific and b) it's not actually a queue, just part of it.


v6 has it as TpmCrq. It's local to the file, so from that perspective=20
it's specific to (v)TPM.


>> This is a 1:1 copy from the existing TIS driver.
> Hm, right.  Probably not a bad idea to move that out as a helper
> function then.


In V7 then.


>>>> +static void tpm_spapr_update_deviceclass(SpaprVioDevice *dev)
>>>> +{
>>>> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
>>>> +    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
>>>> +
>>>> +    switch (s->be_tpm_version) {
>>>> +    case TPM_VERSION_UNSPEC:
>>>> +        assert(false);
>>>> +        break;
>>>> +    case TPM_VERSION_1_2:
>>>> +        k->dt_name =3D "vtpm";
>>>> +        k->dt_type =3D "IBM,vtpm";
>>>> +        k->dt_compatible =3D "IBM,vtpm";
>>>> +        break;
>>>> +    case TPM_VERSION_2_0:
>>>> +        k->dt_name =3D "vtpm";
>>>> +        k->dt_type =3D "IBM,vtpm";
>>>> +        k->dt_compatible =3D "IBM,vtpm20";
>>>> +        break;
>>> Erk.  Updating DeviceClass structures on the fly is hideously ugly.
>>> We might need to take a different approach for this.
>> Make a suggestion... Obviously, we can hard-initialize dt_name and dt_=
type
>> but dt_compatible can only be set after we have determined the version=
 of
>> TPM.
> As you say name and type can just be put into the class statically.


I did this in v6.


> Since you need to change compatible based on an internal variable,
> we'd need to replace the static dt_compatible in the class with a
> callback.


Why can we not initialize it once we know the version of TPM? From the=20
perspective of SLOF at least this seems to be building the device tree=20
fine since it sees the proper value...


 =A0=A0 Stefan


