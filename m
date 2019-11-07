Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA585C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B7F21882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.utexas.edu header.i=@cs.utexas.edu header.b="KwJB8zQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B7F21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.utexas.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmtx-0002D9-Gc
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rajaths@cs.utexas.edu>) id 1iSmsv-000156-02
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rajaths@cs.utexas.edu>) id 1iSmst-0001Y0-Ht
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:51:56 -0500
Received: from newman.cs.utexas.edu ([128.83.139.110]:43380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rajaths@cs.utexas.edu>)
 id 1iSmst-0001U9-BL
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:51:55 -0500
Received: from [10.147.224.29] (wireless-10-147-224-29.public.utexas.edu
 [10.147.224.29]) (authenticated bits=0)
 by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 xA7IpqkN018336
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
 Thu, 7 Nov 2019 12:51:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
 s=default; t=1573152713;
 bh=f9fEzJX0mTo6FYLrFMwzSkTtJ0HZ+okJ2CltM5Zvpbc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=KwJB8zQnPkqnboN8cK5qWa9FuYAka2pPWQeeUUrxNSi9/zQyy37ru15J7dg8AeVaa
 WU20JA7kN0om9Qdrh03ZLsvKPwNp9BwN0Viry8JNVKqaJFYwnQ1MGS4F4nhcHKt6Kw
 CdZIg0Nx8jm2bLjm+wd02jsM3DDbUyGHZ2Wz3l+k=
Subject: Re: Looking for issues/features for my first contribution
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <20191107135401.GH365089@stefanha-x1.localdomain>
From: Rajath Shashidhara <rajaths@cs.utexas.edu>
Message-ID: <e24684c9-2583-43de-c91e-b8ca8c02f622@cs.utexas.edu>
Date: Thu, 7 Nov 2019 12:51:52 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107135401.GH365089@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9
 (newman.cs.utexas.edu [128.83.139.110]); Thu, 07 Nov 2019 12:51:53 -0600 (CST)
X-Virus-Scanned: clamav-milter 0.100.3 at newman
X-Virus-Status: Clean
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.83.139.110
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

Hi,

Thanks Stefan ! I spoke to Dinah and this issue is still up for grabs.
I would be working on both SeaBIOS MMConfig task and the DS3231 RTC 
emulation feature.

Thanks for your help!
Regards,
Rajath Shashidhara

On 07-11-2019 07:54, Stefan Hajnoczi wrote:
> On Wed, Nov 06, 2019 at 05:50:44PM -0600, Rajath Shashidhara wrote:
>> Hi all,
>>
>> I am a Computer Science graduate student at The University of Texas at
>> Austin (UT, Austin). I am looking forward to contributing to qemu !
>>
>> This semester, I am taking a class in Virtualization
>> (https://github.com/vijay03/cs378-f19) and contributing to a virtualization
>> related open-source project is a significant part of the course.
>> I would be interested in contributing a patchset to qemu - possibly a
>> self-contained feature or a reasonably complex bug fix that can be completed
>> in under a month's time. I did look at both the bugtracker and the QEMU
>> Google Summer of Code 2019 page
>> [https://wiki.qemu.org/Google_Summer_of_Code_2019] for ideas. However, I
>> would be interested in hearing from the community and I would be delighted
>> if somebody can be suggest a suitable project !
>>
>> I am an advanced C programmer with both professional and academic background
>> in systems design & implementation - especially OS & Networks. Given my
>> background, I feel fairly confident that I can pickup the QEMU codebase
>> quickly.
> Please check with Dinah Baum whether the SeaBIOS MMConfig task is
> already taken, maybe you'd like to work on it if the task is still
> available:
>
>    https://lore.kernel.org/qemu-devel/20191105163952.GI166646@stefanha-x1.localdomain/
>
> Stefan

