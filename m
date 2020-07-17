Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33868C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0731420829
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0731420829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arrikto.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMDP-0005Nb-8X
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 04:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ndragazis@arrikto.com>)
 id 1jwMCd-0004ga-10
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 04:58:47 -0400
Received: from mx0.arrikto.com ([212.71.252.59]:58530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ndragazis@arrikto.com>)
 id 1jwMCa-00074g-R7
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 04:58:46 -0400
Received: from troi.prod.arr (mail.arr [10.99.0.5])
 by mx0.arrikto.com (Postfix) with ESMTP id 8E3F819E0B0;
 Fri, 17 Jul 2020 11:58:41 +0300 (EEST)
Received: from [10.89.50.23] (naxos.vpn.arr [10.89.50.23])
 by troi.prod.arr (Postfix) with ESMTPSA id 2C1552AD;
 Fri, 17 Jul 2020 11:58:41 +0300 (EEST)
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <deb5788e-c828-6996-025d-333cf2bca7ab@siemens.com>
 <20200715153855.GA47883@stefanha-x1.localdomain> <87y2nkwwvy.fsf@linaro.org>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <b3efd773-c07e-8095-c1ca-5ffb894ac2ac@arrikto.com>
Date: Fri, 17 Jul 2020 11:58:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87y2nkwwvy.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=212.71.252.59; envelope-from=ndragazis@arrikto.com;
 helo=mx0.arrikto.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 04:58:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "John G. Johnson" <john.g.johnson@oracle.com>,
 Andra-Irina Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Alexander Graf <graf@amazon.com>, Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/7/20 7:44 μ.μ., Alex Bennée wrote:

> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
>> On Wed, Jul 15, 2020 at 01:28:07PM +0200, Jan Kiszka wrote:
>>> On 15.07.20 13:23, Stefan Hajnoczi wrote:
>>>> Let's have a call to figure out:
>>>>
>>>> 1. What is unique about these approaches and how do they overlap?
>>>> 2. Can we focus development and code review efforts to get something
>>>>     merged sooner?
>>>>
>>>> Jan and Nikos: do you have time to join on Monday, 20th of July at 15:00
>>>> UTC?
>>>> https://www.timeanddate.com/worldclock/fixedtime.html?iso=20200720T1500
>>>>
>>> Not at that slot, but one hour earlier or later would work for me (so far).
>> Nikos: Please let us know which of Jan's timeslots works best for you.
> I'm in - the earlier slot would be preferential for me to avoid clashing with
> family time.
>

I'm OK with all timeslots.

