Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C31C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15F122BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15F122BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeql-0007F4-3j
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36347)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanb@linux.ibm.com>) id 1hqeqY-0006qn-NT
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1hqeqX-0001eb-KJ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:35:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1806
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1hqeqX-0001do-FC
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:35:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6PEXKMv151208
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:35:51 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tydmrjbxb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:35:51 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
 Thu, 25 Jul 2019 15:35:50 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 25 Jul 2019 15:35:46 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6PEZj6U48496998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 14:35:46 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D969478060;
 Thu, 25 Jul 2019 14:35:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83FAA78066;
 Thu, 25 Jul 2019 14:35:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jul 2019 14:35:45 +0000 (GMT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20190725105842.872625-1-stefanb@linux.vnet.ibm.com>
 <20190725105842.872625-3-stefanb@linux.vnet.ibm.com>
 <CAJ+F1CKdMR_ab=cz9RKsTUZQ5ioQp0=fSiqTOZcuVDiyZMZgWw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Thu, 25 Jul 2019 10:35:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKdMR_ab=cz9RKsTUZQ5ioQp0=fSiqTOZcuVDiyZMZgWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19072514-0004-0000-0000-0000152E91E3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011491; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01237267; UDB=6.00652185; IPR=6.01018640; 
 MB=3.00027886; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-25 14:35:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072514-0005-0000-0000-00008C9B2BC9
Message-Id: <83cba945-2634-d500-0cdb-999cd6e2a402@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-25_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250170
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x6PEXKMv151208
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH 2/2] tpm_emulator: Translate TPM error
 codes to strings
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 7:08 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Thu, Jul 25, 2019 at 2:58 PM Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Implement a function to translate TPM error codes to strings so that
>> at least the most common error codes can be translated to human
>> readable strings.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   hw/tpm/tpm_emulator.c | 50 ++++++++++++++++++++++++++++++++++-------=
--
>>   1 file changed, 40 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>> index 1288cbcb8d..186dde0838 100644
>> --- a/hw/tpm/tpm_emulator.c
>> +++ b/hw/tpm/tpm_emulator.c
>> @@ -82,6 +82,30 @@ typedef struct TPMEmulator {
>>       TPMBlobBuffers state_blobs;
>>   } TPMEmulator;
>>
>> +struct tpm_error {
>> +    uint32_t tpm_result;
>> +    const char *string;
>> +};
>> +
>> +static const struct tpm_error tpm_errors[] =3D {
>> +    {  9 , "operation failed" },
>> +    {  32, "encryption error" },
>> +    {  33, "decryption error" },
>> +    /* TPM 2 codes */
>> +    { 0x101, "operation failed" },
>> +};
> Wouldn't those codes be better defined in tpm_ioctl.h?

tpm_int.h has some already. will add some more there.


Stefan



