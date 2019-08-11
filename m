Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09468C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 06:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6922208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 06:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6922208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwhWI-0008DG-0j
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 02:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hwhVp-0007nV-Sd
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 02:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hwhVo-0007de-RY
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 02:39:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hwhVo-0007cc-JG
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 02:39:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7B6an5p067351
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2019 02:39:27 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uab8tbjvu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2019 02:39:27 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Sun, 11 Aug 2019 07:39:25 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 11 Aug 2019 07:39:21 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7B6dKFZ40042654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 11 Aug 2019 06:39:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EB2A4C044;
 Sun, 11 Aug 2019 06:39:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 354304C040;
 Sun, 11 Aug 2019 06:39:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.2.246])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 11 Aug 2019 06:39:16 +0000 (GMT)
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
 <20190808100903.GC1999@stefanha-x1.localdomain>
From: Balamuruhan S <bala24@linux.ibm.com>
Date: Sun, 11 Aug 2019 12:09:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190808100903.GC1999@stefanha-x1.localdomain>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081106-0020-0000-0000-0000035E631E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081106-0021-0000-0000-000021B36EDD
Message-Id: <65f24bbb-fdab-e648-e47d-66e6dc126eb2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-11_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908110075
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 hari@linux.vnet.ibm.com, clg@kaod.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 8/8/19 3:39 PM, Stefan Hajnoczi wrote:
> On Wed, Aug 07, 2019 at 12:44:40PM +0530, Balamuruhan S wrote:
>> +void python_args_init_cast_int(char *args[], int arg, int pos)
>> +{
>> +    args[pos]= malloc(sizeof(int));
>> +    sprintf(args[pos], "%d", arg);
>> +}
> This is broken.  args[pos] is a (possibly NULL) pointer to 4 bytes.
> sprintf() will buffer overflow if arg has more than 3 digits.
>
> A correct way to do this is:
>
>   args[pos] = g_strdup_printf("%d", arg);

Thanks for correcting it.

>
>> +void python_args_init_cast_long(char *args[], uint64_t arg, int pos)
>> +{
>> +    args[pos]= g_malloc(sizeof(uint64_t) * 2);
>> +    sprintf(args[pos], "%lx", arg);
>> +}
> Same issue.
>
>> +void python_args_clean(char *args[], int nargs)
>> +{
>> +    for (int i = 0; i < nargs; i++) {
>> +        g_free(args[i]);
>> +    }
>> +}
> Mixing malloc() and g_free() is unsafe.  If you switch to
> g_strdup_printf() then g_free() is correct.

sure, I will fix it.

