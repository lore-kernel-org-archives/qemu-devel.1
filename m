Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61681C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F893214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9fIpHRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F893214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94hb-0008Aw-BN
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94X2-0001hj-HT
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94X1-0006cL-Ce
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:12:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94X1-0006cB-87
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEtSN5Hpd+3gSc1CYwRxIGc80UMCJm9UyOg8gZh3qiA=;
 b=c9fIpHRXj3oBz3QXKPrnXtCqzqctW4KrMbtJf8QmmdL8/liWYcjHzxm8PcUVcSsLPjU7z7
 6ncqPhGYBwkhut7t6LBN9POXMpd9EwV2Db+AbI7jl+FSyeyvXuVOzAYLoJEqatbW8laFwJ
 wM3e8GvdT5gse5dCPTNB7Hp4sUSa4/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-G-rt014TNIa622MAhrjqxQ-1; Tue, 03 Mar 2020 05:12:05 -0500
X-MC-Unique: G-rt014TNIa622MAhrjqxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58BF8189F762;
 Tue,  3 Mar 2020 10:12:04 +0000 (UTC)
Received: from [10.72.13.58] (ovpn-13-58.pek2.redhat.com [10.72.13.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6342A7387C;
 Tue,  3 Mar 2020 10:12:03 +0000 (UTC)
Subject: Re: [PULL 00/23] Net patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA9JEDW7XDx_uxyhoJdinXR6nK-_jz+HM9_9n=P9wwZeXg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a4b33617-85ba-1060-430c-e13188a6f913@redhat.com>
Date: Tue, 3 Mar 2020 18:12:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9JEDW7XDx_uxyhoJdinXR6nK-_jz+HM9_9n=P9wwZeXg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/2 =E4=B8=8B=E5=8D=8810:11, Peter Maydell wrote:
> On Mon, 2 Mar 2020 at 07:40, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit e0175b71638cf4398903c0d25f93fe62e0606=
389:
>>
>>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2=
0200228' into staging (2020-02-28 16:39:27 +0000)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to 41aa2e3f9b27fd259a13711545d933a20f1d2f16:
>>
>>    l2tpv3: fix RFC number typo in qemu-options.hx (2020-03-02 15:30:08 +=
0800)
>>
>> ----------------------------------------------------------------
> Hi; at least one of the commits in this is missing your signed-off-by
> as the submaintainer. Could you fix and resubmit, please?
>
> thanks
> -- PMM


My fault.

V2 was sent.

Thanks



