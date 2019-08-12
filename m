Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2967BC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 04:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F306B20842
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 04:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F306B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx2LT-0002Na-Ao
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 00:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52498)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hx2Ku-0001vj-6g
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 00:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hx2Kt-0004Nh-3Y
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 00:53:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51208
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hx2Ks-0004MR-Ut
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 00:53:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7C4q5MM003276
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 00:53:33 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uasq43vu3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 00:53:33 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Mon, 12 Aug 2019 05:53:31 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Aug 2019 05:53:26 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x7C4rPIi42795466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2019 04:53:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C515B42041;
 Mon, 12 Aug 2019 04:53:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B1134204B;
 Mon, 12 Aug 2019 04:53:22 +0000 (GMT)
Received: from [9.124.35.43] (unknown [9.124.35.43])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 12 Aug 2019 04:53:21 +0000 (GMT)
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
 <5839fa4e-b6f3-9547-e71d-50be75c4f9fc@redhat.com>
 <20190808101013.GD1999@stefanha-x1.localdomain>
 <20190808105307.GE2534@redhat.com>
 <20190809084605.GE25286@stefanha-x1.localdomain>
From: Balamuruhan S <bala24@linux.ibm.com>
Date: Mon, 12 Aug 2019 10:23:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190809084605.GE25286@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081204-0028-0000-0000-0000038EAB48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081204-0029-0000-0000-00002450B5DF
Message-Id: <b220aaf3-7fec-f5c7-dcf7-5f5f63774ca0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-12_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120053
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x7C4q5MM003276
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Peter Maydell <peter.maydell@linaro.org>, maddy@linux.vnet.ibm.com,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 anju@linux.vnet.ibm.com, clg@kaod.org, hari@linux.vnet.ibm.com,
 pbonzini@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/9/19 2:16 PM, Stefan Hajnoczi wrote:
> On Thu, Aug 08, 2019 at 11:53:07AM +0100, Daniel P. Berrang=E9 wrote:
>> On Thu, Aug 08, 2019 at 11:10:13AM +0100, Stefan Hajnoczi wrote:
>>> On Wed, Aug 07, 2019 at 12:20:47PM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
>>>>> +void python_args_clean(char *args[], int nargs)
>>>>> +{
>>>>> +    for (int i =3D 0; i < nargs; i++) {
>>>>> +        g_free(args[i]);
>>>>> +    }
>>>>> +}
>>>>>
>>>> Wondering about security, is this feature safe to enable in producti=
on
>>>> environment? It seems to bypass all the hard effort to harden QEMU s=
ecurity.
>>> This seems like a feature that distros would not enable.  Only users
>>> building QEMU from source could enable it.
>> Well that's true when this scripting is only used from one obscure ppc
>> device. Once merged though, its inevitable that people will want to
>> extend scripting to more & more parts of QEMU code. This is a big can
>> of worms...
> When it gets used in new contexts it will be necessary to address
> problems or accept that it is unsuitable for those use cases.  Starting
> simple and dealing with challenges as and when necessary seems okay to
> me.
>
> I think we should give features a chance in QEMU if there is a
> maintainer to support them.  I don't want to use this feature myself an=
d
> I see lots of issues with it for my use cases, but if it is compiled ou=
t
> and doesn't place many requirements on code that does not use it, let's
> give it a chance.
>
> My main concern is licensing.  I think the QEMU Python API should be GP=
L
> licensed because these scripts are executing as part of the QEMU
> process.
>
> Beyond that, let's see if people find this feature useful.  Maybe it
> will die and be removed, maybe it will become popular and we'll have to
> change our perspective :).

Thank you all for review and sharing the thoughts :)=20

>
> Stefan


