Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9899EC49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD5420717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD5420717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRv7Z-0007P4-M2
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRv6G-0006Wm-7H
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRv6F-0001AA-0X
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:26:07 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:58913)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iRv6E-00019P-Np
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:26:06 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MSbov-1iL1Mc07on-00SyGT; Tue, 05 Nov 2019 10:25:51 +0100
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20191029224310.164025-1-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Support for NETLINK socket options
Message-ID: <6653ca74-bbad-c63e-860c-161911c16f98@vivier.eu>
Date: Tue, 5 Nov 2019 10:25:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029224310.164025-1-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sFPCmKcO3SMn0/j39rljZuS3zXpS0Mcyfg4K7ZMRBlUjGYm9c8S
 A1fSVntlwiT+MolJ85nYJ7kuNcdTi/bxLwh8y4cGF4jzRtNkDpmZSlj/2O1PdfHimKSrVG0
 fQ1veAsYNCmO62HCS07HJqB5LHlF+25d3vZrhdKtM8uPbh+E1P+jxxAr7pYf3cuG9/ew0RZ
 eK4uQYWM9gU9IW3xITd/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bAyn0NJjecE=:O+ZvZN9WIphkr6Q5Gcnh1a
 brye1uXcgxyiW9Ud8PpclGMzzhfSohjcAEHbl7BL/HqQlD5+pkaFWrzrfr9dxivBKCcwkgFTw
 iG9X4tsl0w3X/lrRak08e4i/5TgeiLrev+eR+d85Mv5jSA/0xQfYmpsKhtuRKlNuLIfl0tSRJ
 WmxIblQ+ue7wtRmpgohVsQRznPEGv08NVOgvZcPmMIZd4k90+doLZmy5SBhN/2m6edHYrQ+R/
 e4ijlS5qqOYnoHfru1AZBc4Qvpx0ZEz3sRKv0FgZg17OIAqz1r/YDT3NDXyGcl1AZJbrQNbkN
 5D84TvFKARRq3gKHY60ZZItHagb9VSTygEyZm2Yvgenm6rKtonz73USXMNwh8ETl4UmOeZFkn
 pYIZ9JmfCDUHBjaL8xvs1N8uQH8TEd6yVPEo83yNwI6GdaYjxirV6Ux1FAUXYVXwrdr9i8lE7
 Svik5Infg4/fNxKnCtWGoMAfmqkdsLvztr3fCqetHH7o4w0vgUaHzc9uZEW0A1vsISQuDyzz3
 I6GoowM04hJnmQTqFgz7n9CDo59aDhhd1d1NckLTFDg9Um1DObyzEMX+CGp4/IfRViNFPdWTl
 udnVeKujDaWjPMYzz1k7ZZSUILvyGB0Kvfckl6EOYmXJKir91zOFY8aGFl2Zm+sThQbEIAmsG
 DRtjyKCTOq52TsxOfB9T0SyNtWti06oZz5j7hQB9iJvleuRRvLzEZiMiKYJXsc6OEK+m81L/P
 xjKAh4jFXR5dHNmNo9wfe1TkAcaJDIJ5WKNP+WSEOKunMxm5xB+qOHs1fveJ1N3itZm4055CJ
 2rR587YFWxboqz9t4l8a2NXkXw0XGe0fEaZjS9E2cAq/eRm0sIr2XZlqoIY37uScQbfE4ho6m
 T4RHtjTLoQHkP/USMUUIWYxgpWBH6NgV5XPT9ILro=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/10/2019 à 23:43, Josh Kunz a écrit :
> This change includes support for all AF_NETLINK socket options up to about
> kernel version 5.4 (5.4 is not formally released at the time of writing).
> Socket options that were introduced in kernel versions before the oldest
> currently stable kernel version are guarded by kernel version macros.
> 
> This change has been built under gcc 8.3, and clang 9.0, and it passes
> `make check`. The netlink options have been tested by emulating some
> non-trival software that uses NETLINK socket options, but they have
> not been exaustively verified.
> 
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 

I've updated the coding style and applied to my linux-user branch.

Thanks,
Laurent


