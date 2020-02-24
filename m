Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335C8C35677
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 02:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066EC20658
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 02:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066EC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j63i3-0007xj-6n
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 21:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yangx.jy@cn.fujitsu.com>) id 1j63hW-0007WI-O2
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 21:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yangx.jy@cn.fujitsu.com>) id 1j63hV-0000Yd-R8
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 21:42:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58196
 helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <yangx.jy@cn.fujitsu.com>) id 1j63hV-0000WY-G9
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 21:42:29 -0500
X-IronPort-AV: E=Sophos;i="5.70,478,1574092800"; d="scan'208";a="83810926"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 24 Feb 2020 10:42:20 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
 by cn.fujitsu.com (Postfix) with ESMTP id BF9F1406AB15;
 Mon, 24 Feb 2020 10:32:37 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 24 Feb 2020 10:42:21 +0800
Message-ID: <5E53380A.5050403@cn.fujitsu.com>
Date: Mon, 24 Feb 2020 10:42:18 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN;
 rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] virtiofsd/helper: Add shared/no_shared options to help
 message
References: <20200210104451.20036-1-ice_yangxiao@163.com>
In-Reply-To: <20200210104451.20036-1-ice_yangxiao@163.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: BF9F1406AB15.A9B4D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 183.91.158.132
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

Do you have any comment on this patch? :-)
Cc qemu-devel@nongnu.org

Best Regards,
Xiao Yang

On 2020/2/10 18:44, Xiao Yang wrote:
> From: Xiao Yang <yangx.jy@cn.fujitsu.com>
>
> Also add a hint that user should start 'ireg' daemon before using shared cache.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tools/virtiofsd/helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 819c2bc13c..0aa02b99b0 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -171,6 +171,10 @@ void fuse_cmdline_help(void)
>             "                               default: no_writeback\n"
>             "    -o xattr|no_xattr          enable/disable xattr\n"
>             "                               default: no_xattr\n"
> +           "    -o shared|no_shared        enable/disable shared cache\n"
> +           "                               default: no_shared\n"
> +           "                               please start 'ireg' daemon before "
> +           "using shared cache\n"
>             );
>  }
>  




