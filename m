Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8511C352A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF5820733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YvueMj19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF5820733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j18i4-0006w6-OP
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1j18hN-0006UY-HI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1j18hI-0007k3-BJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:02:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1j18hI-0007hx-4a
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:01:56 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200210130151euoutp0106d6a4f8bf883d0b3f0e114388b1c4fc~yDBbVC8h43131131311euoutp01_
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 13:01:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200210130151euoutp0106d6a4f8bf883d0b3f0e114388b1c4fc~yDBbVC8h43131131311euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1581339711;
 bh=kd/Ykn9kQ7XReTU/u/Q7Yu/482I7jhMkrW+59fDScKk=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=YvueMj19IHjZj3ANMO/KxEnHxQHSMYQXl4kHDzswF2Nky97C9dvEvQtyhL00ky3nZ
 3J7o1jS4vXWkoc7jg3nD0+pufnZfux0FZou/f/w8IU7efisOkzh4xWSN42vWC4CfKE
 bSQUQYUqlA+UyWF5FmiHHkeVWuNYPrKv1Wd8Z0ZY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200210130151eucas1p23a9d01aa9823d27fd31821a02a714c7b~yDBbHyx7-2728427284eucas1p2w;
 Mon, 10 Feb 2020 13:01:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 60.F9.60698.F34514E5; Mon, 10
 Feb 2020 13:01:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200210130150eucas1p150271de3dc0eaf3ff88b06a7c64435da~yDBatLbBB1370213702eucas1p1v;
 Mon, 10 Feb 2020 13:01:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200210130150eusmtrp1205f2cb4ab2d15a61efed8454835b28e~yDBasg8TP2550325503eusmtrp1k;
 Mon, 10 Feb 2020 13:01:50 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f2-5e41543f02ab
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 16.E4.07950.E34514E5; Mon, 10
 Feb 2020 13:01:50 +0000 (GMT)
Received: from [106.120.51.21] (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200210130150eusmtip2b80b1561db0c58ff3926b0c3baf73f71~yDBaRYhHi0631906319eusmtip2I;
 Mon, 10 Feb 2020 13:01:50 +0000 (GMT)
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
To: Stefan Hajnoczi <stefanha@gmail.com>, Igor Mammedov <imammedo@redhat.com>
From: =?UTF-8?Q?Igor_Kotrasi=c5=84ski?= <i.kotrasinsk@partner.samsung.com>
Message-ID: <91525902-952f-7f84-c1b0-a4e5c35e0363@partner.samsung.com>
Date: Mon, 10 Feb 2020 14:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207163349.GI168381@stefanha-x1.localdomain>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7r2IY5xBodXsFqcPtrBbHHv5k1m
 i/3b/rFazDnzgMXieO8OFoub06cyObB57Jx1l93jzrU9bB5Prm1m8ni/7yqbx/aTk5gCWKO4
 bFJSczLLUov07RK4Mn5PamIp6JSv2HRLq4FxsWQXIyeHhICJxLztL1m7GLk4hARWMEp87O1j
 hnC+MEqceLmUCcL5zCgxccp6ZpiWxYfvQFUtZ5RYfWUxlPOWUWLFmY3sIFXCAtYSPc/72EBs
 EQF/idlnOllAbGaBfIljJz+zgthsAl4S9yeuZASxeQXcJObfPwJWwyKgKrFu5RGgoRwcogIR
 Eqe/JkKUCEqcnPkErIRTwE7iwJ0zjBAjxSVuPZnPBGHLSzRvnQ12j4TAMnaJXz+boK52kVj0
 bDUbhC0s8er4FnYIW0bi9OQeFgi7XqLlzg4miOYORom+ldOhGqwlvmxYygJyELOApsT6XfoQ
 YUeJK3eawO6UEOCTuPFWEOIGPolJ26ZDhXklOtqEIKr1JLqf3GSC2bqs8RHLBEalWUg+m4Xk
 m1lIvpmFsHcBI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwMRz+t/xrzsY9/1JOsQo
 wMGoxMN7IdgxTog1say4MvcQowQHs5IIr6U0UIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKX
 sUIC6YklqdmpqQWpRTBZJg5OqQbGuCeXD/odybHk65npuHW6za4jPDcjNvbMiTY+d4dX9VHC
 RtGI0CuPqmP+HAw0MpO4l9u+o+1h3edts6bE3uhirIp6eN/XI8+Fn+noicsqK7itJ+/ZzvWu
 7Y3/bfMLmQ32XkdfGRxLKnq5vsk9ZPW7+jk8n0zeyjNG/sq843OSrd3Glnnl5IKlSizFGYmG
 WsxFxYkAJpTJXzgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7p2IY5xBn1/lCxOH+1gtrh38yaz
 xf5t/1gt5px5wGJxvHcHi8XN6VOZHNg8ds66y+5x59oeNo8n1zYzebzfd5XNY/vJSUwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gb8nNbEU
 dMpXbLql1cC4WLKLkZNDQsBEYvHhO8xdjFwcQgJLGSU27uplg0jISPw4vQbKFpb4c62LDaLo
 NaPElkdLmEESwgLWEj3P+8CKRAR8Jd48vsAEYjML5EtM61oD1bCEWeLjk9OsIAk2AS+J+xNX
 MoLYvAJuEvPvH2EBsVkEVCXWrTwCNlRUIELi+fYbUDWCEidnPgGr4RSwkzhw5wwjxAIziXmb
 HzJD2OISt57Mh1osL9G8dTbzBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL
 89L1kvNzNzECo23bsZ9bdjB2vQs+xCjAwajEw3sh2DFOiDWxrLgy9xCjBAezkgivpTRQiDcl
 sbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBiSCvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJ
 anZqakFqEUwfEwenVANjt/aiuRNztry0XDPj0n+ryl1XTpTKrn684GlT5fa9Fkqiu5k0JU6H
 NSrP8Yw5Yv3tRIj7Z7fEdQuD1p1Y1iLrwhn38n7XCpauiiSvTdZqcmfCGN32eh0xF9NsuKH6
 6G7+rEXKBxu69Q7zfD14gdN74Y29usZHTy1wmhGm+bRCSnr+sSP/t4t3K7EUZyQaajEXFScC
 AMFZxQ3MAgAA
X-CMS-MailID: 20200210130150eucas1p150271de3dc0eaf3ff88b06a7c64435da
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

On 2/7/20 5:33 PM, Stefan Hajnoczi wrote:
> On Fri, Feb 07, 2020 at 11:04:03AM +0100, Igor Mammedov wrote:
>> On Fri, 7 Feb 2020 10:00:50 +0100
>> Igor Kotrasi=C5=84ski <i.kotrasinsk@partner.samsung.com> wrote:
>>
>>> On 2/5/20 3:49 PM, Jan Kiszka wrote:
>>>> On 05.02.20 15:39, Stefan Hajnoczi wrote:
>>>>> On Tue, Feb 04, 2020 at 12:30:42PM +0100,
>>>>> i.kotrasinsk@partner.samsung.com wrote:
>>>>>> From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
>>>>>>
>>>>>> This patchset adds a "memory exposing" device that allows two QEMU
>>>>>> instances to share arbitrary memory regions. Unlike ivshmem, it do=
es not
>>>>>> create a new region of memory that's shared between VMs, but inste=
ad
>>>>>> allows one VM to access any memory region of the other VM we choos=
e to
>>>>>> share.
>>>>>>
>>>>>> The motivation for this device is a sort of ARM Trustzone "emulati=
on",
>>>>>> where a rich system running on one machine (e.g. x86_64 linux) is =
able
>>>>>> to perform SMCs to a trusted system running on another (e.g. OpTEE=
 on
>>>>>> ARM). With a device that allows sharing arbitrary memory between V=
Ms,
>>>>>> this can be achieved with minimal changes to the trusted system an=
d its
>>>>>> linux driver while allowing the rich system to run on a speedier x=
86
>>>>>> emulator. I prepared additional patches for linux, OpTEE OS and Op=
TEE
>>>>>> build system as a PoC that such emulation works and passes OpTEE t=
ests;
>>>>>> I'm not sure what would be the best way to share them.
>>>>>>
>>>>>> This patchset is my first foray into QEMU source code and I'm cert=
ain
>>>>>> it's not yet ready to be merged in. I'm not sure whether memory sh=
aring
>>>>>> code has any race conditions or breaks rules of working with memor=
y
>>>>>> regions, or if having VMs communicate synchronously via chardevs i=
s the
>>>>>> right way to do it. I do believe the basic idea for sharing memory
>>>>>> regions is sound and that it could be useful for inter-VM communic=
ation.
>>>>>
>>>>> Hi,
>>>>> Without having looked into the patches yet, I'm already wondering i=
f you
>>>>> can use the existing -object
>>>>> memory-backend-file,size=3D512M,mem-path=3D/my/shared/mem feature f=
or your
>>>>> use case?
>>>>>
>>>>> That's the existing mechanism for fully sharing guest RAM and if yo=
u
>>>>> want to share all of memory then maybe a device is not necessary - =
just
>>>>> share the memory.
>>>
>>> That option adds memory in addition to the memory allocated with the
>>> '-m' flag, doesn't it? I looked into that option, and it seemed to me
>>> you can't back all memory this way.
>> with current QEMU you play with memory sharing using numa workaround
>>
>> -m 512 \
>> -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/shared=
/mem feature,share=3Don \
>> -numa node,memdev=3Dmem
>>
>> also on the list there is series that allows to share main ram
>> without numa workaround, see
>>    "[PATCH v4 00/80] refactor main RAM allocation to use hostmem backe=
nd"
>>
>> with it applied you can share main RAM with following CLI:
>>
>> -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/shared=
/mem feature,share=3Don \
>> -m 512 \
>> -M virt,memory-backend=3Dmem
>=20
> Nice!  That takes care of memory.

After a bit of hacking to map the shared RAM instead of communicating=20
via socket I can confirm - I can run OpTEE this way, and it passes=20
tests. My solution is *technically* more accurate since it is aware of=20
memory subregions and completely independent from memory backend setup,=20
but with my use case satisfied already, I don't think it's of use to anyo=
ne.

>=20
> If signalling (e.g. a notification interrupt) is necessary then a
> mechanism is still needed for that.  I don't know enough about TrustZon=
e
> to suggest an appropriate way of doing it with existing QEMU features.
> Maybe Peter understands?
>=20

Any signalling mechanism that can pass data along with it (e.g. ivshmem=20
with its shared memory) will suffice.

Igor

