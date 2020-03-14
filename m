Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBBAC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 12:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A842076F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 12:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zAZQYoo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A842076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD5g2-00073e-7k
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 08:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jD5fU-0006e4-6S
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 08:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jD5fS-00027V-MP
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 08:13:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jD5fS-00025i-DD
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 08:13:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ECDNgB175995;
 Sat, 14 Mar 2020 12:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XtjLorMcHVca248IdYZlYThr7IJkdJ+VQNzeFjgBflI=;
 b=zAZQYoo3U+x+1Fe7WVbE1hfhcDlwuLxJX6TFEzyjIn/ydePCL67rxL/eswkU7vGzn+QL
 QERRX+buJPshiCUuh4Ro37Ab7IYUhgVrD6giPCpUYUlvFp4dW61dnWaQQ6Z2WIPALbt0
 TsmxC4uxX+YWyxejCVG+4sQWjnKhzf3o2DVukBNO5wyWGPzsP8W/yTT6QHMNV/7uQCZD
 6u41+s+4XsTIWF/cGezZTGlgKndI+OYWFKmNdkzB0XPbBvLdO020VWXSjUzWcY4qpIVL
 nrMgxAMACsN/vn9VkSxbRWC0wkRusI6+UXsJIaYZ0yPZAId2HcpLv4EotGAoF4mzFvIH 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2yrppqrx65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 12:13:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ECCj7t180799;
 Sat, 14 Mar 2020 12:13:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2yrpkgucs9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2020 12:13:23 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02ECDKGs026272;
 Sat, 14 Mar 2020 12:13:20 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 14 Mar 2020 05:13:20 -0700
Subject: Re: [PATCH v3 07/16] hw/i386/vmport: Introduce vmport.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-8-liran.alon@oracle.com>
 <13b98a16-6465-e1c9-5f52-0f338c60fbd5@redhat.com>
 <d81dc7a5-2b20-1792-c1df-ecdb8a964fa7@oracle.com>
 <2f168ddb-34e3-a286-080c-261dcb8ee6bb@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <2cf0d523-ff41-43f4-f1a8-a29d8235ee2e@oracle.com>
Date: Sat, 14 Mar 2020 14:13:17 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2f168ddb-34e3-a286-080c-261dcb8ee6bb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9559
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9559
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003140068
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 02ECDNgB175995
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 14/03/2020 10:31, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/13/20 11:38 PM, Liran Alon wrote:
>> On 13/03/2020 21:57, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 3/12/20 5:54 PM, Liran Alon wrote:
>>>> No functional change. This is mere refactoring.
>>>>
>>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>> ---
>>>> =C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>> =C2=A0 hw/i386/vmmouse.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 1 +
>>>> =C2=A0 hw/i386/vmport.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>>>> =C2=A0 include/hw/i386/pc.h=C2=A0=C2=A0=C2=A0=C2=A0 | 13 -----------=
--
>>>> =C2=A0 include/hw/i386/vmport.h | 16 ++++++++++++++++
>>>
>>> What about moving it to hw/i386/vmport.h (no under include/)?
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>>
>> Can you explain the logic that separates between hw/i386/*.h to=20
>> include/hw/i386/*.h?
>
> Headers in the include/hw/ namespace can be consumed by all machine=20
> targets.
But this doesn't seem true for headers in include/hw/i386/*.h...
It contains things that are target-specific. E.g. ioapic.h, x86-iommu.h,=20
intel_iommu.h and etc.
I still don't quite understand the separation between these directories.=20
It seems both are i386-specific and one of them shouldn't exists.
> If this is a target-specific device, having it local to the target=20
> (hw/i386/) protect generic code (and other targets) of using it. This=20
> helps detecting wrong dependencies between components.
>
>> If it makes sense, sure I will move it. I just don't know what is the=20
>> convention here.
>
> Michael/Paolo/Eduardo what do you recommend?
>

