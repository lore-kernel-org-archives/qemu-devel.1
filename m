Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8AC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B8A206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B8A206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVIn8-0003BL-3Q
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iVIky-0001c3-G6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iVIkt-00040j-Cp
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:18:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39506
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iVIkt-0003xw-6Q
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:18:03 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xAEGnGIw024547
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 12:17:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9a5aatqg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 12:17:58 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Thu, 14 Nov 2019 17:17:56 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Nov 2019 17:17:54 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAEHHrQt40894934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 17:17:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 703D45204E;
 Thu, 14 Nov 2019 17:17:53 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.27])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 37BFD52050;
 Thu, 14 Nov 2019 17:17:53 +0000 (GMT)
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub Channels
 tests
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
 <20191114113823.5d752648.cohuck@redhat.com>
 <b103f51b-f304-cf71-15f9-5fd456a6fcfe@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 18:17:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <b103f51b-f304-cf71-15f9-5fd456a6fcfe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19111417-0016-0000-0000-000002C3AC90
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111417-0017-0000-0000-000033254FDD
Message-Id: <bfbf35b1-16a9-3fa1-14e0-49b0f9632897@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140150
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
Cc: qemu-s390x@nongnu.org, david@redhat.com, qemu-devel@nongnu.org,
 frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019-11-14 13:33, Thomas Huth wrote:
> On 14/11/2019 11.38, Cornelia Huck wrote:
>> On Wed, 13 Nov 2019 20:02:33 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>> Minor nit for $SUBJECT: this isn't a kvm-unit-tests patch, that's just
>> one consumer :)
>>
>>> The PONG device accept two commands: PONG_READ and PONG_WRITE
>>> which allow to read from and write to an internal buffer of
>>> 1024 bytes.
>>>
>>> The QEMU device is named ccw-pong.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   hw/s390x/Makefile.objs  |   1 +
>>>   hw/s390x/ccw-pong.c     | 186 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>   include/hw/s390x/pong.h |  47 ++++++++++++
>>>   3 files changed, 234 insertions(+)
>>>   create mode 100644 hw/s390x/ccw-pong.c
>>>   create mode 100644 include/hw/s390x/pong.h
>>>
>>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>>> index ee91152..3a83438 100644
>>> --- a/hw/s390x/Makefile.objs
>>> +++ b/hw/s390x/Makefile.objs
>>> @@ -32,6 +32,7 @@ obj-$(CONFIG_KVM) += tod-kvm.o
>>>   obj-$(CONFIG_KVM) += s390-skeys-kvm.o
>>>   obj-$(CONFIG_KVM) += s390-stattrib-kvm.o s390-mchk.o
>>>   obj-y += s390-ccw.o
>>> +obj-y += ccw-pong.o
>> Not sure if unconditionally introducing a test device is a good idea.
> This definitely needs a CONFIG switch (which can be "y" by default, but
> still we should provide a possibility to disable it)

yes, clearly


>
>>>   obj-y += ap-device.o
>>>   obj-y += ap-bridge.o
>>>   obj-y += s390-sei.o
>>> diff --git a/hw/s390x/ccw-pong.c b/hw/s390x/ccw-pong.c
>>> new file mode 100644
>>> index 0000000..e7439d5
>>> --- /dev/null
>>> +++ b/hw/s390x/ccw-pong.c
>>> @@ -0,0 +1,186 @@
>>> +/*
>>> + * CCW PING-PONG
> Please add a short description here what this device is all about.


yes


>
>>> + * Copyright 2019 IBM Corp.
>>> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>>> + * your option) any later version. See the COPYING file in the top-level
>>> + * directory.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "qemu/module.h"
>>> +#include "cpu.h"
>>> +#include "exec/address-spaces.h"
>>> +#include "hw/s390x/css.h"
>>> +#include "hw/s390x/css-bridge.h"
>>> +#include "hw/qdev-properties.h"
>>> +#include "hw/s390x/pong.h"
>>> +
>>> +#define PONG_BUF_SIZE 0x1000
>>> +static char buf[PONG_BUF_SIZE] = "Hello world\n";
>>> +
>>> +static inline int pong_rw(CCW1 *ccw, char *p, int len, bool dir)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = address_space_rw(&address_space_memory, ccw->cda,
>>> +                           MEMTXATTRS_UNSPECIFIED,
>>> +                           (unsigned char *)buf, len, dir);
>>> +
>>> +    return (ret == MEMTX_OK) ? -EIO : 0;
> If return code was OK, then you return an EIO error? That looks weird?

Totally weird. it is of course the oposite.

This explain the comment from Connie on the unit check.


>
>>> +}
>>> +
>>> +/* Handle READ ccw commands from guest */
...snip...
>>> +
>>> +static Property pong_ccw_properties[] = {
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void pong_ccw_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +
>>> +    dc->props = pong_ccw_properties;
> As long as there are no properties, I think you can simply drop that line.
>
>   Thomas

Yes, right.


Thanks for the comments,

Regards,

Pierre


-- 
Pierre Morel
IBM Lab Boeblingen


