Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7BBC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 03:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F093021911
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 03:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F093021911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hplPT-0002Ui-5H
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 23:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hplPI-00025x-BV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 23:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hplPH-0002P4-Do
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 23:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41674)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hplPH-0002NV-8S
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 23:24:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E3D0300C032;
 Tue, 23 Jul 2019 03:24:01 +0000 (UTC)
Received: from [10.72.12.57] (ovpn-12-57.pek2.redhat.com [10.72.12.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AC7760BF1;
 Tue, 23 Jul 2019 03:23:57 +0000 (UTC)
To: "Zhang, Chen" <chen.zhang@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190722171828.11322-1-chen.zhang@intel.com>
 <CAFEAcA8==zAupCx=3sZt2tNUQH4OKza7FGhkwuCyxHpguTMGTA@mail.gmail.com>
 <9CFF81C0F6B98A43A459C9EDAD400D78061D67D3@shsmsx102.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <599f9e75-3d85-c1e7-fe6b-34c95d9d240c@redhat.com>
Date: Tue, 23 Jul 2019 11:23:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D78061D67D3@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 23 Jul 2019 03:24:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V5] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: qemu-dev <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/7/23 =E4=B8=8A=E5=8D=882:38, Zhang, Chen wrote:
>
>
>> -----Original Message-----
>> From: Peter Maydell [mailto:peter.maydell@linaro.org]
>> Sent: Tuesday, July 23, 2019 1:25 AM
>> To: Zhang, Chen <chen.zhang@intel.com>
>> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat=
.com>;
>> qemu-dev <qemu-devel@nongnu.org>; Zhang Chen <zhangckid@gmail.com>
>> Subject: Re: [PATCH V5] net/colo-compare.c: Fix memory leak and code s=
tyle
>> issue.
>>
>> On Mon, 22 Jul 2019 at 18:23, Zhang Chen <chen.zhang@intel.com> wrote:
>>> From: Zhang Chen <chen.zhang@intel.com>
>>>
>>> This patch to fix the origin "char *data" memory leak, code style
>>> issue and add necessary check here.
>>> Reported-by: Coverity (CID 1402785)
>>>
>>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>>> ---
>>>   net/colo-compare.c | 27 ++++++++++++++++++++-------
>>>   1 file changed, 20 insertions(+), 7 deletions(-)
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Thanks for your patience in sending out all these versions as we worke=
d
>> through the code review process.
> Thank you too~
> Maybe you or Jason can pick up this patch?
>
> Thanks
> Zhang Chen


Applied.

Thanks


>
>> thanks
>> -- PMM

