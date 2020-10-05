Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C600C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E592074F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="U4F4xVnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E592074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMcD-00058D-MB
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 05:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1kPMb7-0004eA-1u
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:16:01 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:56070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1kPMb0-00063c-Ns
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:15:54 -0400
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 2A54F2E142E;
 Mon,  5 Oct 2020 12:15:41 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 dvHdMv0dd7-Feweqwur; Mon, 05 Oct 2020 12:15:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1601889341; bh=8X1TQfsRH1XmCWFQ7w3wZdQZsWrpoohX8nONLz6bcvw=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=U4F4xVnRb0qS9wanoeNnAvnmQ9sZuuN/0Q7wlz7+PM3PzDlZMAoMTFdxFXCkEv8nk
 TxpaG6e1tu7ROwTjwKWpetxFnLTMoq4WudWHbLHu1MmhbABAJBgayJ+YFswdyJg4Pb
 xzxhkjEliNJ+5AyeTdQjNEFjTlUWaQ5q5nmNBgWM=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8325::1:7])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 XUICDKoxTI-Fem02h4l; Mon, 05 Oct 2020 12:15:40 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Mon, 5 Oct 2020 12:15:39 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 20/21] contrib/gitdm: Add Yandex to the domain map
Message-ID: <20201005091539.GB2954434@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alexey Kirillov <lekiravi@yandex-team.ru>,
 Alexey Krasikov <alex-krasikov@yandex-team.ru>,
 Anton Kuchin <antonkuchin@yandex-team.ru>,
 Dima Stepanov <dimastep@yandex-team.ru>,
 Evgeny Yakovlev <wrfsh@yandex-team.ru>,
 Yury Kotov <yury-kotov@yandex-team.ru>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-21-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201004180443.2035359-21-f4bug@amsat.org>
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 05:15:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: Alexey Krasikov <alex-krasikov@yandex-team.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Anton Kuchin <antonkuchin@yandex-team.ru>,
 Alexey Kirillov <lekiravi@yandex-team.ru>,
 Dima Stepanov <dimastep@yandex-team.ru>,
 Evgeny Yakovlev <wrfsh@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 04, 2020 at 08:04:42PM +0200, Philippe Mathieu-Daudé wrote:
> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.
> 
> Cc: Alexey Kirillov <lekiravi@yandex-team.ru>
> Cc: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> Cc: Anton Kuchin <antonkuchin@yandex-team.ru>
> Cc: Dima Stepanov <dimastep@yandex-team.ru>
> Cc: Evgeny Yakovlev <wrfsh@yandex-team.ru>
> Cc: Roman Kagan <rvkagan@yandex-team.ru>
> Cc: Yury Kotov <yury-kotov@yandex-team.ru>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 7170ddea7a..4e6bf16e4e 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -42,3 +42,4 @@ wdc.com         Western Digital
>  windriver.com   Wind River
>  xilinx.com      Xilinx
>  yadro.com       YADRO
> +yandex-team.ru  Yandex

Reviewed-by: Roman Kagan <rvkagan@yandex-team.ru>

Thanks!
Roman.

