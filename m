Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5580C742A1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 00:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B31B2084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 00:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B31B2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hljt5-0006x8-IO
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 20:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49833)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1hljsv-0006Yy-Pr
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 20:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hljsu-0000wE-MZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 20:58:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:58383)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hljsu-0000uY-Er
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 20:58:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jul 2019 17:57:54 -0700
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; d="scan'208";a="160241163"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.97])
 ([10.239.196.97])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 11 Jul 2019 17:57:53 -0700
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190711130546.18578-1-alex.bennee@linaro.org>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <fcff4c56-7313-de8c-3812-50390637bd36@linux.intel.com>
Date: Fri, 12 Jul 2019 08:57:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711130546.18578-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH for 4.1?] includes: remove stale
 [smp|max]_cpus externs
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/7/11 21:05, Alex Bennée wrote:
> Commit a5e0b3311 removed these in favour of querying machine
> properties. Remove the extern declarations as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Like Xu <like.xu@linux.intel.com>

> ---
>   include/sysemu/sysemu.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 984c439ac9..e70edf7c1c 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -103,8 +103,6 @@ extern const char *keyboard_layout;
>   extern int win2k_install_hack;
>   extern int alt_grab;
>   extern int ctrl_grab;
> -extern int smp_cpus;
> -extern unsigned int max_cpus;
>   extern int cursor_hide;
>   extern int graphic_rotate;
>   extern int no_quit;
> 


