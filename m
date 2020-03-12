Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA95EC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68F8206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68F8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJJH-000082-RA
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chengang@emindsoft.com.cn>) id 1jCJIW-00084R-BO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chengang@emindsoft.com.cn>) id 1jCJIT-0007QO-Gf
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:34:31 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:38818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jCJIT-0007Bq-0F
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:34:29 -0400
Received: from localhost (unknown [192.168.167.8])
 by regular1.263xmail.com (Postfix) with ESMTP id 4C38D10AE;
 Thu, 12 Mar 2020 16:34:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.31.119] (42.17.110.36.static.bjtelecom.net
 [36.110.17.42]) by smtp.263.net (postfix) whith ESMTP id
 P24783T140190926292736S1584002056857908_; 
 Thu, 12 Mar 2020 16:34:17 +0800 (CST)
X-UNIQUE-TAG: <4ef5ea25f0c85fde964c40985710c905>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 36.110.17.42
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
X-System-Flag: 0
Subject: Re: [PATCH] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
References: <20200226113834.26404-1-chengang@emindsoft.com.cn>
 <6abe4989-6d63-6bc5-f566-96d7bda30df7@vivier.eu>
 <b1d26a73-67d0-239f-0a71-16cbfddf8b96@vivier.eu>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <e96bc419-1536-57e9-4be1-48ee4f29d05c@emindsoft.com.cn>
Date: Thu, 12 Mar 2020 16:34:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b1d26a73-67d0-239f-0a71-16cbfddf8b96@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.150.70.196
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you very much for your reply. :)

DRM_IOCTL_VERSION has to be a special one, but my patch really need be
improved. The string pointers should be translated, but the new string
buffers need not be allocated.

I will try to send patch v2 within this week end.

DRM_IOCTL_* really have many commands, at present, I have implemented
about 20+ commands for i965 gpu using, although some of them are not
generic enough. I will try to send all of them when I have free time.

Thanks.

On 2020/3/11 =E4=B8=8B=E5=8D=883:35, Laurent Vivier wrote:
> Le 10/03/2020 =C3=A0 21:16, Laurent Vivier a =C3=A9crit=C2=A0:
>> Le 26/02/2020 =C3=A0 12:38, chengang@emindsoft.com.cn a =C3=A9crit=C2=A0=
:
>>> From: Chen Gang <chengang@emindsoft.com.cn>
>>>
>>> The other DRM_IOCTL_* commands will be done later.
>>>
>>> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
>>> ---
>>>  linux-user/ioctls.h        |   3 +
>>>  linux-user/syscall.c       | 134 +++++++++++++++++++++++++++++++++++=
++
>>>  linux-user/syscall_defs.h  |  16 +++++
>>>  linux-user/syscall_types.h |  12 ++++
>>>  4 files changed, 165 insertions(+)
>>>
>>> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>>> index 0defa1d8c1..c2294b48a0 100644
>>> --- a/linux-user/ioctls.h
>>> +++ b/linux-user/ioctls.h
>>> @@ -574,6 +574,9 @@
>>>    IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
>>>                  MK_PTR(MK_STRUCT(STRUCT_rtentry)))
>>> =20
>>> +  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
>>> +                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
>>> +
>>
>> Rather than adding a specific function to process the structure, perha=
ps
>> we can add this in a generic way?
>>
>> The problem with drm_version structure is the pointers to the strings.
>>
>> Did you try to add a TYPE_STRING in
>> thunk_type_size()/thunk_type_align()/think_convert()/do_ioctl() to do =
that?
>=20
> In fact we can't do that because we need to know the size of the buffer
> to allocate and it is provided by another field. It cannot be generic,
> so I think what you do is the best we can do.
>=20
> Thanks,
> LAurent
>=20
>=20
>=20
>=20
>=20



