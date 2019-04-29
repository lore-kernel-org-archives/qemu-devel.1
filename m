Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D050CC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E5620673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E5620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8oi-0007Gm-QN
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:07:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1hL8k0-0003yX-Bw
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1hL8jy-0005Vq-Aj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:02:52 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:40333)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1hL8jw-0005Pa-Bk
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:02:48 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1hL8jq-00059t-J0 from Sandra_Loosemore@mentor.com ;
	Mon, 29 Apr 2019 09:02:42 -0700
Received: from [127.0.0.1] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
	(147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4;
	Mon, 29 Apr 2019 09:02:39 -0700
To: Peter Maydell <peter.maydell@linaro.org>
References: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
	<CAFEAcA_X+rmREYo_HRjKwwNmUGG4vEeb6s=5eLb3MudmEsUH=A@mail.gmail.com>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <4e91e256-a8dc-930d-fc10-bc2b01f4d6ce@codesourcery.com>
Date: Mon, 29 Apr 2019 10:02:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_X+rmREYo_HRjKwwNmUGG4vEeb6s=5eLb3MudmEsUH=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
	svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
	[fuzzy]
X-Received-From: 192.94.38.131
Subject: Re: [Qemu-devel] [PATCH v7 0/2] Nios II generic board config and
 semihosting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429160238.en4LcBLwMpQi0cOKbjGhMzjIWo_trxNUOSr52L7ZhTI@z>

On 4/29/19 9:55 AM, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 20:53, Sandra Loosemore <sandra@codesourcery.com> wrote:
>>
>> This is the seventh version of the patch series last posted here:
>> http://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg06255.html
>>
>> Changes since v6:
>> - Fixed block comment formatting for QEMU style.
>> - Fixed fixme for interrupt handler (now added to libgloss BSP).
>> - Added link to libgloss semihosting documentation.
>>
>> Sandra Loosemore (2):
>>    Add generic Nios II board.
>>    Add Nios II semihosting support.
> 
> Since Nios II doesn't have anybody actively handling
> pull requests for it right now, I've applied these patches
> directly to master -- thanks!

Thank you for taking care of this!

-Sandra



