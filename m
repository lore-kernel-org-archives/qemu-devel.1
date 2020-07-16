Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B66DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3694A2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gc4Cnvvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3694A2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvu9W-0006qu-GP
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 23:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvu8a-0005vY-38
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 23:00:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvu8X-0004X5-Ps
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 23:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594868440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3UfTp4BIgAKkuMqkS4pQYOqNyz5sK9nfykS4N+Dpac=;
 b=Gc4Cnvvx//fRcfeiBQO82tcul3VAGwNpuMg9YqIr4wJyWEgDX6JQypoTRGJ/x1eIbukTXo
 MF0IyIK+HmFuh6+MwVpYHv/JxKSVV9k1mqCbti/OQQnvTbCI1W4bbJmtiamARS+t+eSYBn
 th4SrrEryTH3ny9krjUZLBPRQM2DoBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-NbI-BdTgOby8CWnVvUM9bg-1; Wed, 15 Jul 2020 23:00:26 -0400
X-MC-Unique: NbI-BdTgOby8CWnVvUM9bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33C20108B;
 Thu, 16 Jul 2020 03:00:25 +0000 (UTC)
Received: from [10.72.12.131] (ovpn-12-131.pek2.redhat.com [10.72.12.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F8A15C1BD;
 Thu, 16 Jul 2020 03:00:23 +0000 (UTC)
Subject: Re: [PULL 0/7] Net patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA8q1WnAG7jDOh1AjqLnf5Hc0Gxr1oACEAz5U3uQQLy41w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <86032619-ee9d-14b0-1080-d7e0b9dd7e48@redhat.com>
Date: Thu, 16 Jul 2020 11:00:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8q1WnAG7jDOh1AjqLnf5Hc0Gxr1oACEAz5U3uQQLy41w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/16 上午2:06, Peter Maydell wrote:
> On Wed, 15 Jul 2020 at 14:53, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit 673205379fb499d2b72f2985b47ec7114282f5fe:
>>
>>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/python-next-20200714' into staging (2020-07-15 13:04:27 +0100)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to a134321ef676723768973537bb9b49365ae2062e:
>>
>>    ftgmac100: fix dblac write test (2020-07-15 21:00:13 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
> just a note that this has missed rc0 but will go into rc1.


Yes, I think it's fine.

Thanks


>
> thanks
> -- PMM
>


