Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2013C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 02:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B10F20684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 02:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAWeo529"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B10F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itNG2-00015r-P0
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 21:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1itNFN-0000et-OJ
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 21:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1itNFK-0003de-RG
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 21:56:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1itNFK-0003d8-Bd
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 21:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579489017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Z8ttRBa7SE+nrGNIAI87DI7UM74q+4YzubCDpvt6X4=;
 b=GAWeo529ag4g2JejXPdF4qpGmgUjH6TSA2JH3i7q0j/BDY1xMSPsB/lTlwd322gXtRz/E+
 9ezHvUZ1Y1rLAhefIaVtxB7yk2BxhbCB09RRr+23EuunOzcVfWkSeS+cN49s4Wo3Pcsi2h
 kRrOKx/x33ucOahnroeJeMFTLdIJJJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-07aA_yyBODyUJOMIFN1S6g-1; Sun, 19 Jan 2020 21:56:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0FC98017CC;
 Mon, 20 Jan 2020 02:56:52 +0000 (UTC)
Received: from [10.72.12.173] (ovpn-12-173.pek2.redhat.com [10.72.12.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3765519C7F;
 Mon, 20 Jan 2020 02:56:47 +0000 (UTC)
Subject: Re: [PATCH V4 0/5] Introduce Advanced Watch Dog module
To: "Zhang, Chen" <chen.zhang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20191217124554.30818-1-chen.zhang@intel.com>
 <fa1ed6cb-63d7-ee83-a5a0-b099b662fef2@intel.com>
 <0502a0db0a17484c9220b3a63c40b397@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <08a1a225-52c1-4e6c-85f7-fcf6612b5383@redhat.com>
Date: Mon, 20 Jan 2020 10:56:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0502a0db0a17484c9220b3a63c40b397@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 07aA_yyBODyUJOMIFN1S6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/1/19 =E4=B8=8B=E5=8D=885:10, Zhang, Chen wrote:
> Hi~
>
> Anyone have comments about this module?


Hi Chen:

I will take a look at this series.

Two general questions:

- if it can detect more than network stall, it should not belong to /net
- need to convince libvirt guys for this proposal, since usually it's=20
the duty of upper layer instead of qemu itself

Thanks


> We have some clients already try to use this module with COLO. Please rev=
iew this part.
> If no one want to maintain this module, I can maintain this module myself=
.
>
> Thanks
> Zhang Chen
>
>> -----Original Message-----
>> From: Qemu-devel <qemu-devel-
>> bounces+chen.zhang=3Dintel.com@nongnu.org> On Behalf Of Zhang, Chen
>> Sent: Tuesday, January 7, 2020 12:33 PM
>> To: Jason Wang <jasowang@redhat.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>;
>> qemu-dev <qemu-devel@nongnu.org>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Subject: Re: [PATCH V4 0/5] Introduce Advanced Watch Dog module
>>
>> Hi All,
>>
>> No news for a while about this series.
>>
>> This version already add new docs to address Paolo's comments.
>>
>> Please give me more comments.
>>
>>
>> Thanks
>>
>> Zhang Chen
>>
>>
>> On 12/17/2019 8:45 PM, Zhang, Chen wrote:
>>> From: Zhang Chen <chen.zhang@intel.com>
>>>
>>> Advanced Watch Dog is an universal monitoring module on VMM side, it
>>> can be used to detect network down(VMM to guest, VMM to VMM, VMM
>> to
>>> another remote server) and do previously set operation. Current AWD
>>> patch just accept any input as the signal to refresh the watchdog
>>> timer, and we can also make a certain interactive protocol here. For
>>> the outputs, user can pre-write some command or some messages in the
>>> AWD opt-script. We noticed that there is no way for VMM communicate
>>> directly, maybe some people think we don't need such things(up layer
>>> software like openstack can handle it). so we engaged with real
>>> customer found that they need a lightweight and efficient mechanism to
>>> solve some practical problems,
>>>
>>> For example Edge Computing cases(they think high level software is too
>>> heavy to use in Edge or it is hard to manage and combine with VM instan=
ce).
>>> It make user have basic VM/Host network monitoring tools and basic
>>> false tolerance and recovery solution..
>>>
>>> Please see the detail documentation in the last patch.
>>>
>>> V4:
>>>    - Add more introduction in qemu-options.hx
>>>    - Addressed Paolo's comments add docs/awd.txt for the AWD module
>> detail.
>>> V3:
>>>    - Rebased on Qemu 4.2.0-rc1 code.
>>>    - Fix commit message issue.
>>>
>>> V2:
>>>    - Addressed Philippe comments add configure selector for AWD.
>>>
>>> Initial:
>>>    - Initial version.
>>>
>>>
>>> Zhang Chen (5):
>>>     net/awd.c: Introduce Advanced Watch Dog module framework
>>>     net/awd.c: Initailize input/output chardev
>>>     net/awd.c: Load advanced watch dog worker thread job
>>>     vl.c: Make Advanced Watch Dog delayed initialization
>>>     docs/awd.txt: Add doc to introduce Advanced WatchDog(AWD) module
>>>
>>>    configure         |   9 +
>>>    docs/awd.txt      |  88 +++++++++
>>>    net/Makefile.objs |   1 +
>>>    net/awd.c         | 491
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>    qemu-options.hx   |  20 ++
>>>    vl.c              |   7 +
>>>    6 files changed, 616 insertions(+)
>>>    create mode 100644 docs/awd.txt
>>>    create mode 100644 net/awd.c
>>>


