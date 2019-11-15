Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5EEC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D142073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D142073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdSs-0002RT-JH
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iVdS7-0001eT-0B
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iVdS5-0006qs-T5
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:24:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54466
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iVdS5-0006qI-NW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:24:01 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAFFMfP3143974
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:23:59 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9qmjr7cj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 10:23:59 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Fri, 15 Nov 2019 15:23:57 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 15:23:53 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAFFNr3P36045130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 15:23:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 009F24C059;
 Fri, 15 Nov 2019 15:23:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A026C4C044;
 Fri, 15 Nov 2019 15:23:52 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.171.60])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2019 15:23:52 +0000 (GMT)
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub Channels
 tests
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
 <20191114113823.5d752648.cohuck@redhat.com>
 <b103f51b-f304-cf71-15f9-5fd456a6fcfe@redhat.com>
 <bfbf35b1-16a9-3fa1-14e0-49b0f9632897@linux.ibm.com>
 <badf7ed3-8832-89f6-e094-163d29c14bef@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 15 Nov 2019 16:23:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <badf7ed3-8832-89f6-e094-163d29c14bef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19111515-0020-0000-0000-00000386826E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111515-0021-0000-0000-000021DCA006
Message-Id: <cc61ab72-3cd5-92f3-8342-542c2540d483@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150139
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id xAFFMfP3143974
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
Cc: frankja@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019-11-15 15:22, Thomas Huth wrote:
> On 14/11/2019 18.17, Pierre Morel wrote:
>> On 2019-11-14 13:33, Thomas Huth wrote:
>>> On 14/11/2019 11.38, Cornelia Huck wrote:
>>>> On Wed, 13 Nov 2019 20:02:33 +0100
>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>
>>>> Minor nit for $SUBJECT: this isn't a kvm-unit-tests patch, that's ju=
st
>>>> one consumer :)
>>>>
>>>>> The PONG device accept two commands: PONG_READ and PONG_WRITE
>>>>> which allow to read from and write to an internal buffer of
>>>>> 1024 bytes.
>>>>>
>>>>> The QEMU device is named ccw-pong.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> ---
>>>>>  =C2=A0 hw/s390x/Makefile.objs=C2=A0 |=C2=A0=C2=A0 1 +
>>>>>  =C2=A0 hw/s390x/ccw-pong.c=C2=A0=C2=A0=C2=A0=C2=A0 | 186
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  =C2=A0 include/hw/s390x/pong.h |=C2=A0 47 ++++++++++++
>>>>>  =C2=A0 3 files changed, 234 insertions(+)
>>>>>  =C2=A0 create mode 100644 hw/s390x/ccw-pong.c
>>>>>  =C2=A0 create mode 100644 include/hw/s390x/pong.h
>>>>>
>>>>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>>>>> index ee91152..3a83438 100644
>>>>> --- a/hw/s390x/Makefile.objs
>>>>> +++ b/hw/s390x/Makefile.objs
>>>>> @@ -32,6 +32,7 @@ obj-$(CONFIG_KVM) +=3D tod-kvm.o
>>>>>  =C2=A0 obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>>>>>  =C2=A0 obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o s390-mchk.o
>>>>>  =C2=A0 obj-y +=3D s390-ccw.o
>>>>> +obj-y +=3D ccw-pong.o
>>>> Not sure if unconditionally introducing a test device is a good idea.
>>> This definitely needs a CONFIG switch (which can be "y" by default, b=
ut
>>> still we should provide a possibility to disable it)
>> yes, clearly
> I just noticed that we already have a global config switch for such
> devices, so you could simply do:
>
> obj-$(CONFIG_TEST_DEVICE) +=3D ccw-pong.o
>
>   Thomas


Thanks, will do! :)

regards,

Pierre


--=20
Pierre Morel
IBM Lab Boeblingen


