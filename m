Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EBEC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED89A206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nLmG90Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED89A206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJcxl-0007ib-4y
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1jJcx1-0007B7-Vw
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1jJcx0-0008Ci-6e
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:58:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1jJcwz-0008Bc-V9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:58:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200401125829euoutp01dffe992a83a599f4a8363f33df11003b~Bs4DWa2cx2395723957euoutp01C
 for <qemu-devel@nongnu.org>; Wed,  1 Apr 2020 12:58:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200401125829euoutp01dffe992a83a599f4a8363f33df11003b~Bs4DWa2cx2395723957euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1585745909;
 bh=g+vcj42Ss4L+HAIwzR8+kr/+iL6TCJPk1LOmOrCg4+k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=nLmG90WznG9HPG/tI+HsVZZtCErNIU5vAhPU4oi9oI9Ib6oN8mIFoJUbmTTpxGRXO
 N7hQHBUx+ZuoUxiXpoloIhyyOHWxVdEZrZOx82WHodHAf/9aZ1dSp8mKHLcOkYAiAY
 pDCwITJwBEB3davk5OICzorgpJGfww1gfeZICzQo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200401125829eucas1p1bdb7c67d104e4093f7e8e1400d6008e7~Bs4DMthr20112601126eucas1p1v;
 Wed,  1 Apr 2020 12:58:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id A8.99.60679.5FF848E5; Wed,  1
 Apr 2020 13:58:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200401125829eucas1p19e8c3859fef1ea2bc1cd10ab2f153479~Bs4C6E99v0110001100eucas1p1E;
 Wed,  1 Apr 2020 12:58:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200401125829eusmtrp1311bb0b907fccaa1d70bf7b31fd35e8b~Bs4C5e7dX0933109331eusmtrp1L;
 Wed,  1 Apr 2020 12:58:29 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-f3-5e848ff5965f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.9A.08375.5FF848E5; Wed,  1
 Apr 2020 13:58:29 +0100 (BST)
Received: from [106.210.122.12] (unknown [106.210.122.12]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200401125828eusmtip1614845696767fe1e8c8facfb5716c00f~Bs4Ci_wkp2866728667eusmtip1L;
 Wed,  1 Apr 2020 12:58:28 +0000 (GMT)
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
From: =?UTF-8?Q?Igor_Kotrasi=c5=84ski?= <i.kotrasinsk@partner.samsung.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Message-ID: <0bd92bb6-9ff6-be44-37a0-8d0b3f79693e@partner.samsung.com>
Date: Wed, 1 Apr 2020 14:58:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <91525902-952f-7f84-c1b0-a4e5c35e0363@partner.samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87pf+1viDDZNVLQ4fbSD2eLezZvM
 Fvu3/WO1mHPmAYvF8d4dLBY3p09lcmDz2DnrLrvHnWt72DyeXNvM5PF+31U2j+0nJzEFsEZx
 2aSk5mSWpRbp2yVwZczruMNcsEqj4vyeC0wNjNcVuhg5OSQETCSuPDvG2MXIxSEksIJRYsO7
 C+wQzhdGienznrBBOJ8ZJeY83MUG0/K59QMLRGI5o8TBhZ+hqt4zSqydfpkRpEpYwFqi53kf
 WAebgJfE/YkrweIiAv4Ss890soDYzAL5EsdOfmbtYuTg4BVwk9i8zwQkzCKgIvFm53ywElGB
 WIlzj26wgti8AoISJ2c+AYtzCrhLtHT+ghojLnHryXwmCFteonnrbGaQeyQEVrFL/JmzmxHi
 aheJd4cnMkHYwhKvjm9hh7BlJE5P7mGBsOslWu7sYIJo7mCU6Fs5Hepla4kvG5aygBzKLKAp
 sX6XPkTYUeLKnSZmkLCEAJ/EjbeCEDfwSUzaNh0qzCvR0SYEUa0n0f3kJhPM1mWNj1gmMCrN
 QvLZLCTfzELyzSyEvQsYWVYxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEpp7T/45/2cG4
 60/SIUYBDkYlHt6KjJY4IdbEsuLK3EOMEhzMSiK8s12AQrwpiZVVqUX58UWlOanFhxilOViU
 xHmNF72MFRJITyxJzU5NLUgtgskycXBKNTDyeS0vOtSwdbq8P+cZ6XN2BxR2lcx9yPWG0duH
 uev7BI3b1xQOuMgvWzuDMe5xv+TxAlOrPydkt1tVJ1TOcdtv0Zh+4rXj/5rjsXWTL6z88msa
 c+HxdAc9i4igmZlT06pnLtRe3DF1gnv7lo87Yi7bWogGrPfZfa3iWIdE5MlXUkYP3Cezz92l
 xFKckWioxVxUnAgAMPHJAjkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xu7pf+1viDC494LM4fbSD2eLezZvM
 Fvu3/WO1mHPmAYvF8d4dLBY3p09lcmDz2DnrLrvHnWt72DyeXNvM5PF+31U2j+0nJzEFsEbp
 2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZczruMNc
 sEqj4vyeC0wNjNcVuhg5OSQETCQ+t35g6WLk4hASWMooce/yU0aIhIzEj9Nr2CBsYYk/17rY
 IIreMkrsvNwHlhAWsJboeQ5hswl4SdyfuBKsWUTAV+LN4wtMIDazQL7EtK41UM0PmSUWrNrF
 2sXIwcEr4CaxeZ8JSA2LgIrEm53zWUBsUYFYif7m3WBzeAUEJU7OfAIW5xRwl2jp/MUCMdNM
 Yt7mh8wQtrjErSfzoXbJSzRvnc08gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE
 3OLSvHS95PzcTYzAaNt27OfmHYyXNgYfYhTgYFTi4a3IaIkTYk0sK67MPcQowcGsJMI72wUo
 xJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnARJBXEm9oamhuYWlobmxubGahJM7bIXAwRkgg
 PbEkNTs1tSC1CKaPiYNTqoGxXlBoT1qy0YSH8t+tXiy7vLZnT9BjxQlaS7IDth1e/fHnvcc7
 fbas7l+lcnnausuF7xU8axbZPrvAuurq3Qn9mXeLlvKffxJ3/bzzRYXv3td4H64tlzY6npjF
 PPlNm4JVwC7D1mfvWqOKJNW/ssrNUrocGMjP7qympmg7dbWp2e/PM4w313myKrEUZyQaajEX
 FScCAPwygJbMAgAA
X-CMS-MailID: 20200401125829eucas1p19e8c3859fef1ea2bc1cd10ab2f153479
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a
References: <CGME20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a@eucas1p1.samsung.com>
 <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <20200205143911.GG58062@stefanha-x1.localdomain>
 <1e872eb3-a21b-0f9b-e6a4-54843a028bed@siemens.com>
 <91d3f574-3a4f-8291-040e-520c5c58e77e@partner.samsung.com>
 <20200207110403.08a8a7cc@redhat.com>
 <20200207163349.GI168381@stefanha-x1.localdomain>
 <91525902-952f-7f84-c1b0-a4e5c35e0363@partner.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pbonzini@redhat.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.02.2020 14:01, Igor Kotrasi=C5=84ski wrote:
> On 2/7/20 5:33 PM, Stefan Hajnoczi wrote:
>> On Fri, Feb 07, 2020 at 11:04:03AM +0100, Igor Mammedov wrote:
>>> On Fri, 7 Feb 2020 10:00:50 +0100
>>> Igor Kotrasi=C5=84ski <i.kotrasinsk@partner.samsung.com> wrote:
>>>
>>>> On 2/5/20 3:49 PM, Jan Kiszka wrote:
>>>>> On 05.02.20 15:39, Stefan Hajnoczi wrote:
>>>>>> On Tue, Feb 04, 2020 at 12:30:42PM +0100,
>>>>>> i.kotrasinsk@partner.samsung.com wrote:
>>>>>>> From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
>>>>>>>
>>>>>>> This patchset adds a "memory exposing" device that allows two QEM=
U
>>>>>>> instances to share arbitrary memory regions. Unlike ivshmem, it=20
>>>>>>> does not
>>>>>>> create a new region of memory that's shared between VMs, but inst=
ead
>>>>>>> allows one VM to access any memory region of the other VM we=20
>>>>>>> choose to
>>>>>>> share.
>>>>>>>
>>>>>>> The motivation for this device is a sort of ARM Trustzone=20
>>>>>>> "emulation",
>>>>>>> where a rich system running on one machine (e.g. x86_64 linux) is=
=20
>>>>>>> able
>>>>>>> to perform SMCs to a trusted system running on another (e.g.=20
>>>>>>> OpTEE on
>>>>>>> ARM). With a device that allows sharing arbitrary memory between=20
>>>>>>> VMs,
>>>>>>> this can be achieved with minimal changes to the trusted system=20
>>>>>>> and its
>>>>>>> linux driver while allowing the rich system to run on a speedier =
x86
>>>>>>> emulator. I prepared additional patches for linux, OpTEE OS and=20
>>>>>>> OpTEE
>>>>>>> build system as a PoC that such emulation works and passes OpTEE=20
>>>>>>> tests;
>>>>>>> I'm not sure what would be the best way to share them.
>>>>>>>
>>>>>>> This patchset is my first foray into QEMU source code and I'm=20
>>>>>>> certain
>>>>>>> it's not yet ready to be merged in. I'm not sure whether memory=20
>>>>>>> sharing
>>>>>>> code has any race conditions or breaks rules of working with memo=
ry
>>>>>>> regions, or if having VMs communicate synchronously via chardevs=20
>>>>>>> is the
>>>>>>> right way to do it. I do believe the basic idea for sharing memor=
y
>>>>>>> regions is sound and that it could be useful for inter-VM=20
>>>>>>> communication.
>>>>>>
>>>>>> Hi,
>>>>>> Without having looked into the patches yet, I'm already wondering=20
>>>>>> if you
>>>>>> can use the existing -object
>>>>>> memory-backend-file,size=3D512M,mem-path=3D/my/shared/mem feature =
for=20
>>>>>> your
>>>>>> use case?
>>>>>>
>>>>>> That's the existing mechanism for fully sharing guest RAM and if y=
ou
>>>>>> want to share all of memory then maybe a device is not necessary -=
=20
>>>>>> just
>>>>>> share the memory.
>>>>
>>>> That option adds memory in addition to the memory allocated with the
>>>> '-m' flag, doesn't it? I looked into that option, and it seemed to m=
e
>>>> you can't back all memory this way.
>>> with current QEMU you play with memory sharing using numa workaround
>>>
>>> -m 512 \
>>> -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/share=
d/mem=20
>>> feature,share=3Don \
>>> -numa node,memdev=3Dmem
>>>
>>> also on the list there is series that allows to share main ram
>>> without numa workaround, see
>>> =C2=A0=C2=A0 "[PATCH v4 00/80] refactor main RAM allocation to use ho=
stmem=20
>>> backend"
>>>
>>> with it applied you can share main RAM with following CLI:
>>>
>>> -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/share=
d/mem=20
>>> feature,share=3Don \
>>> -m 512 \
>>> -M virt,memory-backend=3Dmem
>>
>> Nice!=C2=A0 That takes care of memory.
>=20
> After a bit of hacking to map the shared RAM instead of communicating=20
> via socket I can confirm - I can run OpTEE this way, and it passes=20
> tests. My solution is *technically* more accurate since it is aware of=20
> memory subregions and completely independent from memory backend setup,=
=20
> but with my use case satisfied already, I don't think it's of use to=20
> anyone.
>=20

After a long while hacking QEMU to achieve 1-to-1 memory mapping between=20
machines, I realized that I wasn't completely right here. I can share=20
main memory from both machines, but for the arm machine that's only=20
non-secure memory. Secure memory (VIRT_SECURE_MEM) is always allocated=20
with memory_region_init_ram(), I don't know if other secure memory=20
regions (e.g. VIRT_FLASH) might need to be shared as well.

This can probably be solved by allowing these regions to use file-backed=20
memory when configured to do so, then mapping these files in the other=20
machine at correct offsets.

Another solution would be memory sharing in this patchset. If we strip=20
away interrupts, PCI stuff and io memory region support, it amounts to=20
basically the same thing - a mechanism for accessing shareable memory in=20
the other machine in a discoverable way.

>>
>> If signalling (e.g. a notification interrupt) is necessary then a
>> mechanism is still needed for that.=C2=A0 I don't know enough about Tr=
ustZone
>> to suggest an appropriate way of doing it with existing QEMU features.
>> Maybe Peter understands?
>>
>=20
> Any signalling mechanism that can pass data along with it (e.g. ivshmem=
=20
> with its shared memory) will suffice.

Igor

