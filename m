Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AE2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8924321556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8924321556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifUoZ-0004yr-Pd
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifUnx-0004QL-Os
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifUnw-0005ik-Bq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:11:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ifUnw-0005fv-2Q; Thu, 12 Dec 2019 15:11:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCK7sT1098452; Thu, 12 Dec 2019 15:10:58 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuswn4nb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 15:10:58 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCK8dWn103369;
 Thu, 12 Dec 2019 15:10:57 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuswn4nas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 15:10:57 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCK5FNw005685;
 Thu, 12 Dec 2019 20:10:57 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02dal.us.ibm.com with ESMTP id 2wr3q7d2bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 20:10:56 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCKAti741550258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 20:10:55 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95DE5136051;
 Thu, 12 Dec 2019 20:10:55 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29A7113605D;
 Thu, 12 Dec 2019 20:10:55 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 20:10:54 +0000 (GMT)
Subject: Re: [PATCH v4 3/8] tpm_emulator: Implement callback for whether we
 are suspended
From: Stefan Berger <stefanb@linux.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
References: <20191212180744.1070446-1-stefanb@linux.vnet.ibm.com>
 <20191212180744.1070446-4-stefanb@linux.vnet.ibm.com>
 <76e147e3-c5d1-e7e0-1297-f1f2f0e07aa5@linux.ibm.com>
Message-ID: <e0c93bcf-e8a6-55c0-a32c-e63b3c5ccb21@linux.ibm.com>
Date: Thu, 12 Dec 2019 15:10:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <76e147e3-c5d1-e7e0-1297-f1f2f0e07aa5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_06:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=971 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120155
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xBCK7sT1098452
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 1:33 PM, Stefan Berger wrote:
> On 12/12/19 1:07 PM, Stefan Berger wrote:
>> Implement the check whether the emulator backend is suspended.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>> index 22f9113432..7be7d3a91b 100644
>> --- a/hw/tpm/tpm_emulator.c
>> +++ b/hw/tpm/tpm_emulator.c
>> @@ -80,6 +80,8 @@ typedef struct TPMEmulator {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int established_flag_cached:1;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPMBlobBuffers state_blobs;
>> +
>> +=C2=A0=C2=A0=C2=A0 bool is_suspended;
>> =C2=A0 } TPMEmulator;
>> =C2=A0 =C2=A0 struct tpm_error {
>> @@ -486,6 +488,13 @@ static size_t=20
>> tpm_emulator_get_buffer_size(TPMBackend *tb)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return actual_size;
>> =C2=A0 }
>> =C2=A0 +static bool tpm_emulator_is_suspended(TPMBackend *tb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>> +
>> +=C2=A0=C2=A0=C2=A0 return tpm_emu->is_suspended;
>> +}
>> +
>> =C2=A0 static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>> @@ -846,6 +855,8 @@ static int tpm_emulator_pre_save(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPMBackend *tb =3D opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPMEmulator *tpm_emu =3D TPM_EMULATOR(t=
b);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 tpm_emu->is_suspended =3D true;
>
> This is the most critical part here. It must be true when we receive a=20
> response in the tpm_spapr_request_completed(). The problem is that=20
> what tpm_backend_finish_sync() does is not specific to this backend=20
> but more a global operation that another device could run as well --=20
> none seem to do this today. So the point is that there could be a race=20
> here. This flag should really be set in '.pre_pre_save,' so before any=20
> other device could poll. Better would be calling a global function=20
> that indicates whether device suspension has started. In this case we=20
> could do away with this and just call that function from the spapr=20
> device.


runstate_check(RUN_STATE_FINISH_MIGRATE) seems to be what we need here...



>
>
>


