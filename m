Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6351C4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 01:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC5E20873
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 01:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC5E20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKBXd-0003I9-PW
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 21:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iKBWu-0002pR-Ac
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 21:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iKBWs-0001fy-UA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 21:21:39 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3013)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iKBWs-0001UZ-7C
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 21:21:38 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by
 rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15da51f0eccb-7ccfe;
 Tue, 15 Oct 2019 09:21:18 +0800 (CST)
X-RM-TRANSID: 2ee15da51f0eccb-7ccfe
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.144.67] (unknown[112.25.154.149])
 by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25da51f0a771-c5c99;
 Tue, 15 Oct 2019 09:21:15 +0800 (CST)
X-RM-TRANSID: 2ee25da51f0a771-c5c99
Subject: Re: [PATCH v1 5/5] contrib/gitdm: add China Mobile to the domain map
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014135905.24364-1-alex.bennee@linaro.org>
 <20191014135905.24364-6-alex.bennee@linaro.org>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <719f9549-0b15-a9ef-7f23-11215a02237a@cmss.chinamobile.com>
Date: Tue, 15 Oct 2019 09:21:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20191014135905.24364-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.79
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
Cc: Zhang Shengju <zhangshengju@cmss.chinamobile.com>, dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Alex

On 10/14/19 9:59 PM, Alex Bennée wrote:
> We've had a number of contributions from this domain. I think they are
> from the company rather than customers using the email address but
> it's hard for me to tell. Please confirm.

Yes, this domain comes from a china company, not an individual, and I'm
very grateful for this patch.

Currently we can only view the community's patch via the GNU mailing
list, Does this patch mean that we can now easily subscribe to the
mailing list form the mail client?

Many thanks,
Mao

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Cc: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> ---
>   contrib/gitdm/domain-map | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 304e91010a..7fc7fda68f 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -5,6 +5,7 @@
>   #
>   
>   amd.com         AMD
> +cmss.chinamobile.com China Mobile
>   citrix.com      Citrix
>   greensocs.com   GreenSocs
>   fujitsu.com     Fujitsu
> 



