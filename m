Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDC7C35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 05:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA4D2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 05:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/jagc5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA4D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izDYo-0000CJ-5Y
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 00:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1izDYA-0008C2-5g
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 00:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1izDY9-0000ft-3Z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 00:48:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34608
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1izDY8-0000eW-Vf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 00:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580881712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOG8QAVmsJGAWH/LrsiwymMK/aUWcNNY2PzEusy/a+k=;
 b=A/jagc5kyEy7BeVa//hcmeeNDOwuhYiBSfcMX5z0SOSK/0jMmNgaf6Tgfg8Im9STkg0aBq
 Ka4J0UUg98nhnedSEmxFOG0ZrO77WfWLQwbEh7Z19egXoAZ7V8bYF33gn31lDLRBXEKu1R
 CVUVwWCIbdSh17x1CtxYC47uwPwJFjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-ZX-s9rlVN6ah_mSJgO-Rgg-1; Wed, 05 Feb 2020 00:48:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4C951081FA3;
 Wed,  5 Feb 2020 05:48:27 +0000 (UTC)
Received: from [10.72.13.188] (ovpn-13-188.pek2.redhat.com [10.72.13.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CDD11BC6D;
 Wed,  5 Feb 2020 05:48:26 +0000 (UTC)
Subject: Re: [PATCH 0/1] Introduce Xlnx ZynqMP CAN controller for QEMU
To: Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1580764010-310744-1-git-send-email-fnu.vikram@xilinx.com>
 <9782ee22-c004-b569-66e8-071e8447e44e@redhat.com>
 <BYAPR02MB563811B646F102BB37293F9FBC020@BYAPR02MB5638.namprd02.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <db517307-30b0-7099-1f7c-bcc3e40fec80@redhat.com>
Date: Wed, 5 Feb 2020 13:48:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB563811B646F102BB37293F9FBC020@BYAPR02MB5638.namprd02.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ZX-s9rlVN6ah_mSJgO-Rgg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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


On 2020/2/5 =E4=B8=8A=E5=8D=8811:23, Vikram Garhwal wrote:
> Hi Jason,
> Yes, I will maintain this NIC. Thanks for the help.
>
> Regards,
> Vikram


Good to know that.

Please update MAINTINERS and it would be better if you can draft a qtest=20
for this NIC.

I leave some quick comments for the patch and I hope the patch could be=20
reviewed by others as well.

Thanks


>
>> -----Original Message-----
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Tuesday, February 4, 2020 7:17 PM
>> To: Vikram Garhwal <fnuv@xilinx.com>; qemu-devel@nongnu.org
>> Subject: Re: [PATCH 0/1] Introduce Xlnx ZynqMP CAN controller for QEMU
>>
>>
>> On 2020/2/4 =E4=B8=8A=E5=8D=885:06, Vikram Garhwal wrote:
>>> Example for single CAN:
>>>       -object can-bus,id=3Dcanbus0 \
>>>       -global driver=3Dxlnx.zynqmp-can,property=3Dcanbus0,value=3Dcanbu=
s0 \
>>>       -object can-host-socketcan,id=3Dsocketcan0,if=3Dvcan0,canbus=3Dca=
nbus0
>>>
>>> Example for connecting both CAN:
>>>       -object can-bus,id=3Dcanbus0 -object can-bus,id=3Dcanbus1 \
>>>       -global driver=3Dxlnx.zynqmp-can,property=3Dcanbus0,value=3Dcanbu=
s0 \
>>>       -global driver=3Dxlnx.zynqmp-can,property=3Dcanbus1,value=3Dcanbu=
s1 \
>>>       -object can-host-socketcan,id=3Dsocketcan0,if=3Dvcan0,canbus=3Dca=
nbus0 \
>>>       -object can-host-socketcan,id=3Dsocketcan1,if=3Dvcan0,canbus=3Dca=
nbus1
>>>
>>> Vikram Garhwal (1):
>>>     hw/net/can: Introduce Xlnx ZynqMP CAN controller for QEMU
>>>
>>>    hw/net/can/Makefile.objs         |    1 +
>>>    hw/net/can/xlnx-zynqmp-can.c     | 1106
>> ++++++++++++++++++++++++++++++++++++++
>>>    include/hw/net/xlnx-zynqmp-can.h |   77 +++
>>>    3 files changed, 1184 insertions(+)
>>>    create mode 100644 hw/net/can/xlnx-zynqmp-can.c
>>>    create mode 100644 include/hw/net/xlnx-zynqmp-can.h
>>>
>> Hi Vikram:
>>
>> I would like to confirm that whether or not you would maintain this NIC.
>> (I think the answer is yes). I tend not to merge a NIC model without a
>> maintainer.
>>
>> Thanks


