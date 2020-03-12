Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CE8C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB1A206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB1A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCWhd-000831-89
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCWh4-0007dy-83
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCWh3-0005cl-2H
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:52:45 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCWh2-0005Sy-NJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:52:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08355429|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.0697533-0.00163879-0.928608;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03279; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.H-XoZhK_1584053558; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-XoZhK_1584053558)
 by smtp.aliyun-inc.com(10.147.41.199);
 Fri, 13 Mar 2020 06:52:38 +0800
Subject: Re: Questions about pollute the mail list archives
To: Richard Henderson <richard.henderson@linaro.org>,
 Alistair.Francis@wdc.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <a17be147-3e03-b79f-1008-11734c03cfdf@c-sky.com>
 <528c86c4-aad5-78c2-c710-7a09ddc5230d@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <67c08db1-ee63-4ccd-d79c-35652b8bafb0@c-sky.com>
Date: Fri, 13 Mar 2020 06:52:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <528c86c4-aad5-78c2-c710-7a09ddc5230d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/11 11:46, Richard Henderson wrote:
> On 3/10/20 7:19 PM, LIU Zhiwei wrote:
>> Is it serious?
> It isn't ideal.  I would eventually try to review via your branch, and find a
> copy of the patch to reply, or send a reply to the cover letter if no copy of
> the patch arrived.
>
>> Is there any way to clear it in the mail list archives?
> No.
>
>> Can I send it again to the mail list?
> Yes.
>
> To avoid confusion I would label it v4, even if there are no changes since v3.
>
> I would recommend using the --batch-size and --relogin-delay options to
> git-send-email.  I don't know exactly what parameters you need, but choosing
> small batches and long-ish delays should mean that the whole patch set trickles
> out over the course of an hour or two.  Patience is something that computers
> are good at.  :-)
Hi Richard,

Thanks very much.
The two parameters really works. After  setting --batch-size to 1, and 
--relogin-delay to 120,
I sent the complete 60 patches(two hours).

Now I label it with v5, as v4 also failed to be complete.

Besides,  I  fix up a bug in v5, therefore it can boot Linux patches now.

Best Regards,
Zhiwei


>
>
> r~


