Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EBCC74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764F3208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764F3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlWB4-0003KP-M9
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 06:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60426)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <borntraeger@de.ibm.com>) id 1hlWAY-0002rC-Qk
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1hlWAX-0006Ew-4F
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:19:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43330
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1hlWAW-0006CC-UP
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:19:17 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6BAH0XW182295
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:19:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tp1qkcafa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:19:11 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Thu, 11 Jul 2019 11:19:10 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 11 Jul 2019 11:19:06 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6BAJ5HB30998732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2019 10:19:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 694B552054;
 Thu, 11 Jul 2019 10:19:05 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.140])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3212652052;
 Thu, 11 Jul 2019 10:19:05 +0000 (GMT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
References: <20190617131103.1413-1-berrange@redhat.com>
 <b6d3c3b0-da81-8b59-1660-83ef5423b097@vivier.eu>
 <CAATJJ0K4xZ4iPxBKz-iCv6sDTjWE5y+-wg7T9OOiRq4tTG__mA@mail.gmail.com>
 <20190711092430.GC11930@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date: Thu, 11 Jul 2019 12:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711092430.GC11930@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19071110-0012-0000-0000-00000331B90F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071110-0013-0000-0000-0000216B2541
Message-Id: <8847ac2a-374a-b679-fce2-96b822e92b2c@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-11_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110123
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x6BAH0XW182295
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix to handle variably
 sized SIOCGSTAMP with new kernels
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Arnd Bergmann <arnd@arndb.de>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11.07.19 11:24, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jul 11, 2019 at 10:02:01AM +0200, Christian Ehrhardt wrote:
>> On Mon, Jun 17, 2019 at 5:35 PM Laurent Vivier <laurent@vivier.eu> wro=
te:
>>>
>>> Le 17/06/2019 =C3=A0 15:11, Daniel P. Berrang=C3=A9 a =C3=A9crit :
>>>> The SIOCGSTAMP symbol was previously defined in the
>>>> asm-generic/sockios.h header file. QEMU sees that header
>>>> indirectly via sys/socket.h
>>>>
>>>> In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
>>>> the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
>>>> Instead it provides only SIOCGSTAMP_OLD, which only uses a
>>>> 32-bit time_t on 32-bit architectures.
>>>>
>>>> The linux/sockios.h header then defines SIOCGSTAMP using
>>>> either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
>>>> SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
>>>> on 32-bit architectures
>>>>
>>>> To cope with this we must now define two separate syscalls,
>>>> with corresponding old and new sizes, as well as including
>>>> the new linux/sockios.h header.
>>>>
>>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>> ---
>>>>  linux-user/ioctls.h        | 15 +++++++++++++++
>>>>  linux-user/syscall.c       |  1 +
>>>>  linux-user/syscall_defs.h  |  5 +++++
>>>>  linux-user/syscall_types.h |  4 ++++
>>>>  4 files changed, 25 insertions(+)
>>>>
>>>> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>>>> index 5e84dc7c3a..5a6d6def7e 100644
>>>> --- a/linux-user/ioctls.h
>>>> +++ b/linux-user/ioctls.h
>>>> @@ -222,8 +222,23 @@
>>>>    IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_if=
req)))
>>>>    IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
>>>>    IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
>>>> +
>>>> +#ifdef SIOCGSTAMP_OLD
>>>> +  IOCTL(SIOCGSTAMP_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
>>>> +#else
>>>>    IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
>>>> +#endif
>>>> +#ifdef SIOCGSTAMPNS_OLD
>>>> +  IOCTL(SIOCGSTAMPNS_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec))=
)
>>>> +#else
>>>>    IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
>>>> +#endif
>>>> +#ifdef SIOCGSTAMP_NEW
>>>> +  IOCTL(SIOCGSTAMP_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval64)))
>>>> +#endif
>>>> +#ifdef SIOCGSTAMPNS_NEW
>>>> +  IOCTL(SIOCGSTAMPNS_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec64=
)))
>>>> +#endif
>>>>
>>>>    IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
>>>>    IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>> index b187c1281d..f13e260b02 100644
>>>> --- a/linux-user/syscall.c
>>>> +++ b/linux-user/syscall.c
>>>> @@ -37,6 +37,7 @@
>>>>  #include <sched.h>
>>>>  #include <sys/timex.h>
>>>>  #include <sys/socket.h>
>>>> +#include <linux/sockios.h>
>>>>  #include <sys/un.h>
>>>>  #include <sys/uio.h>
>>>>  #include <poll.h>
>>>> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
>>>> index 7f141f699c..7830b600e7 100644
>>>> --- a/linux-user/syscall_defs.h
>>>> +++ b/linux-user/syscall_defs.h
>>>> @@ -750,6 +750,11 @@ struct target_pollfd {
>>>>
>>>>  #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeva=
l) */
>>>>  #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timesp=
ec) */
>>>> +#define TARGET_SIOCGSTAMP_OLD   0x8906          /* Get stamp (timev=
al) */
>>>> +#define TARGET_SIOCGSTAMPNS_OLD 0x8907          /* Get stamp (times=
pec) */
>>>> +#define TARGET_SIOCGSTAMP_NEW   TARGET_IOC(TARGET_IOC_READ, 's', 6,=
 sizeof(long long) + sizeof(long)) /* Get stamp (timeval64) */
>>>> +#define TARGET_SIOCGSTAMPNS_NEW TARGET_IOC(TARGET_IOC_READ, 's', 7,=
 sizeof(long long) + sizeof(long)) /* Get stamp (timespec64) */
>>> kernel defines:
>>>
>>> #define SIOCGSTAMP_NEW   _IOR(SOCK_IOC_TYPE, 0x06, long long[2])
>>> #define SIOCGSTAMPNS_NEW _IOR(SOCK_IOC_TYPE, 0x07, long long[2])
>>>
>>> So it should be TARGET_IOR(0x89, 0x6, abi_llong[2])
>>>
>>> Their codes are 0x80108906 and 80108907.
>>
>> Hi,
>> I found the discussion around this topic being almost a month old.
>> And related to this fedora bug [1] was closed by adding [2] which
>> matches [3] that was nacked in the discussion here.
>>
>> Since I found nothing later (neither qemu commits nor further
>> discussions) I wonder if it has fallen through the cracks OR if there
>> was a kernel fix/change to resolve it (if that is the case a pointer
>> to the related kernel change would be nice)?
>=20
> I didn't have time to address the feedback to this v2, and since the
> immediate problem for Fedora has a workaround, its been lower priority
> especially since my understanding of linux-iser is limited.
>=20
> IOW, If anyone wants to take over my patch proposal here feel free. It
> would obviously be nice to fix for this 4.1 release if practical.

Same for me. I have never dealt with linux-user and my workaround was the
simplest thing that I could come up with. Would be good it Laurent or oth=
er
linux-user experts could do the "right thing".


Adding Peter, for your awareness. qemu does not build with newer kernel h=
eaders.

>=20
>>
>> [1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1718926
>> [2]: https://src.fedoraproject.org/rpms/qemu/blob/master/f/0005-NOT-UP=
STREAM-Build-fix-with-latest-kernel.patch
>> [3]: https://patchew.org/QEMU/20190604071915.288045-1-borntraeger@de.i=
bm.com/
>>
>>> Thanks,
>>> Laurent
>>>
>>
>>
>> --=20
>> Christian Ehrhardt
>> Software Engineer, Ubuntu Server
>> Canonical Ltd
>>
>=20
> Regards,
> Daniel
>=20


