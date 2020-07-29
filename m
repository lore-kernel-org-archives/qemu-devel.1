Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BBDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B8420672
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B8420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0kUT-0005WP-7e
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 07:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihajlov@linux.ibm.com>)
 id 1k0kTS-00056u-Or
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 07:42:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24284
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihajlov@linux.ibm.com>)
 id 1k0kTN-0003cf-BO
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 07:42:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06TBWFcm106332
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 07:42:10 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32j0a6wwhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 07:42:10 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06TBaQhP011306
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 11:42:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 32gcqgn00e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 11:42:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06TBg6Js30081462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 11:42:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D3B052050
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 11:42:06 +0000 (GMT)
Received: from oc6604088431.ibm.com (unknown [9.145.164.244])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 08B5152051
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 11:42:05 +0000 (GMT)
Subject: Re: [PATCH for-5.2 0/6] Continue booting in case the first device is
 not bootable
To: qemu-devel@nongnu.org
References: <20200728183734.7838-1-thuth@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Message-ID: <5c860673-9c0c-79fe-2804-4864856257f5@linux.ibm.com>
Date: Wed, 29 Jul 2020 13:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728183734.7838-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-29_04:2020-07-29,
 2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=596 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290071
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mihajlov@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 07:42:10
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/28/20 8:37 PM, Thomas Huth wrote:
> If the user did not specify a "bootindex" property, the s390-ccw bios
> tries to find a bootable device on its own. Unfortunately, it alwasy
> stops at the very first device that it can find, no matter whether it's
> bootable or not. That causes some weird behavior, for example while
> 
>   qemu-system-s390x -hda bootable.qcow2
> 
> boots perfectly fine, the bios refuses to work if you just specify
> a virtio-scsi controller in front of it:
> 
>   qemu-system-s390x -device virtio-scsi -hda bootable.qcow2
> 
> Since this is quite uncomfortable and confusing for the users, and
> all major firmwares on other architectures correctly boot in such
> cases, too, let's also try to teach the s390-ccw bios how to boot
> in such cases.
> 
> For this, we have to get rid of the various panic()s and IPL_assert()
> statements at the "low-level" function and let the main code handle
> the decision instead whether a boot from a device should fail or not,
> so that the main code can continue searching in case it wants to.
> 

Looking at it from an architectural perspective: If an IPL Information 
Block specifying the boot device has been set and can be retrieved using 
Diagnose 308 it has to be respected, even if the device doesn't contain 
a bootable program. The boot has to fail in this case.

I had not the bandwidth to follow all code paths, but I gather that this 
is still the case with the series. So one can argue that these changes 
are taking care of an undefined situation (real hardware will always 
have the IPIB set).

As long as the architecture is not violated, I can live with the 
proposed changes. I however would like to point out that this only 
covers a corner case (no -boot or -device ..,bootindex specified). A VM 
defined and started with libvirt will always specify the boot device. 
Please don't create the impression that this patches will lead to the 
same behavior as on other platforms. It is still not possible to have an 
order list of potential boot devices in an architecture compliant way.

[...]

-- 
Kind Regards,
    Viktor

