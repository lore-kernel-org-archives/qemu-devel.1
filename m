Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67375C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A34E20866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A34E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbfva-0001qT-Dh
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 02:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao.peng@linux.alibaba.com>) id 1hbftm-0000pU-GL
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao.peng@linux.alibaba.com>) id 1hbftk-00008p-Iu
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:41:18 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28013)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao.peng@linux.alibaba.com>)
 id 1hbftj-00005H-1P
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:41:16 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R611e4; CH=green; DM=||false|;
 FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07487; MF=tao.peng@linux.alibaba.com; NM=1;
 PH=DS; RN=6; SR=0; TI=SMTPD_---0TU86dQt_1560494465; 
Received: from graymalkin.local(mailfrom:tao.peng@linux.alibaba.com
 fp:SMTPD_---0TU86dQt_1560494465) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 14 Jun 2019 14:41:06 +0800
To: qemu-devel@nongnu.org
References: <1560494113-1141-1-git-send-email-tao.peng@linux.alibaba.com>
From: Peng Tao <tao.peng@linux.alibaba.com>
Message-ID: <6fecc0bc-64f4-2d66-354b-4fe8082fa353@linux.alibaba.com>
Date: Fri, 14 Jun 2019 14:41:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560494113-1141-1-git-send-email-tao.peng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
Subject: Re: [Qemu-devel] [PATCH] migration: allow private destination ram
 with x-ignore-shared
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>, Xu Wang <xu@hyper.sh>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jiangshan Lai <laijs@hyper.sh>,
 kata-dev@lists.katacontainers.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/6/14 14:35, Peng Tao wrote:
> By removing the share ram check, qemu is able to migrate
> to private destination ram when x-ignore-shared capability
> is on. Then we can create multiple destination VMs based
> on the same source VM.
> 
> This changes the x-ignore-shared migration capability to
> work similar to Lai's original bypass-shared-memory
> work(https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00003.html)
> which enables kata containers (https://katacontainers.io)
> to implement the VM templating feature.
> 
> An example usage in kata containers(https://katacontainers.io):
> 1. Start the source VM:
>     qemu-system-x86 -m 2G \
>       -object memory-backend-file,id=mem0,size=2G,share=on,mem-path=/tmpfs/template-memory \
>       -numa node,memdev=mem0
> 2. Stop the template VM, set migration x-ignore-shared capability,
>     migrate "exec:cat>/tmpfs/state", quit it
> 3. Start target VM:
>     qemu-system-x86 -m 2G \
>       -object memory-backend-file,id=mem0,size=2G,share=off,mem-path=/tmpfs/template-memory \
>       -numa node,memdev=mem0 \
>       -incoming defer
> 4. connect to target VM qmp, set migration x-ignore-shared capability,
> migrate_incoming "exec:cat /tmpfs/state"
> 5. create more target VMs repeating 3 and 4
> 
FYI, corresponding kata pull request is posted at 
https://github.com/kata-containers/runtime/pull/1799

Cheers,
Tao
-- 
Into something rich and strange.

