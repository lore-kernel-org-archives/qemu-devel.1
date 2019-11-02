Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C464CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 09:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC4620862
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 09:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC4620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQpmF-0001Mc-2E
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 05:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iQpjt-0000eY-N3
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 05:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iQpjr-0000ga-Li
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 05:30:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43751)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iQpjr-0000Nl-Cc
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 05:30:31 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MkYHO-1hgFMq1o7y-00m3bZ; Sat, 02 Nov 2019 10:30:18 +0100
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20191029224310.164025-1-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Support for NETLINK socket options
Message-ID: <7e707755-4a3c-d573-6dc4-81b5c2ad4e56@vivier.eu>
Date: Sat, 2 Nov 2019 10:30:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029224310.164025-1-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nvA4ifmd2MsepDy0Ks+uOlkozVzcua/Ay25I5JEfvQUS5yS77qr
 BUvJGeHnXHGKaaZ3Mk1byyVVYYPcYF0OGMZiGEgbh/Tllp14azTOx7PvNK0nsFu180ziU2c
 MLW1oix2Tf1+zoZHoUzxC1nn8ANWF0jO4gnYF/HxOjtlJmFaNISRISen+1y/f94He+F8cJi
 OuaP6KYaAjKY5a4K3ja5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dzi5GZOWgyI=:KilKYTlaeKb5rAKc84zbgv
 0rKeHTpPSnjJYdrbvNE81tIl6iRrEIXejnjpX43YzkoanVxWXqrOzKH1zkUHFMrJvSmBflBKT
 ZX/weBzuWR6k0Lp1c9LYye/anDb0L81IQkCn7rLZRD3WVgxLb0WKZa6e2e150cxwVjUoTdXB/
 7l8tflHZ8g1x6/8qIj/i5UIGV+RuW10kaJyMslRM6BpkarNZSWdqAxV3+z/1cKYIDVQcnACCs
 +ad9bX7GXq4NMzwSPp7dDJm0RkgeOQXrxq3Gni2kyeuDkT3pI5eGV6bYu6WyUd3OSdU688+Yj
 kwo3R1nMOlICg3xErDmXS05MB6dPp2zfSPPu7TGZbjDIa8uM9zG0XUNiTA6nS0B+PFP7HpZI9
 q8J6Vdlwsqm3C8MBe1IaMdsW5hmVYwRxRvE2nKAFJL+O6q4912SHDhgPJzQS3SLHIVszC+DLE
 8jH10Bah32TQQRmI9Stg7W3S6aslBQleWs3AUsOlJtGuYdurooCpo5Bu8Io/aTIjt01CxpPh1
 /x8fBQBSqXo9ydSNIpUlfzQmuilqFImDCNm94M7m4+41OOIXw41Pofk8cJHuv7iNBViHgZVbc
 3HEBA03ODmNeitFY0/xwFfttope+qyJcsDdt2vE056KMglzMJjlb7K0ktuwye7G++Ubu4RBX1
 uAkcbKOUxfwKVC/Pmm8M0wXHXvL9qJ02xcw80PLRfS4YPolGjO+CXILfq8hINqrtDW8Qh8xOg
 XuNj1W9M1hDmQ2yC//qTr97cAPIEyj5YfIv5UGgI2Tu/Hk/kI6FsSajTmg8iQCGpppdhMsQuX
 CO8RJ0uMBrrY6XVDkczpwMB0XBAW76o8iBLfFJuZTt1ZtMDFAb+TOlfyAYq64lUu2dg27OdaP
 7b6818cpw55eQAgBvqtwnJJQMhKDpD0iBkYUGtE9A=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
...
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
> +        case NETLINK_LIST_MEMBERSHIPS:
> +        {
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            if (len < 0) {
> +                return -TARGET_EINVAL;
> +            }
> +            uint32_t *results = lock_user(VERIFY_WRITE, optval_addr, len, 1);

Please put the declaration of "results" at the beginning of the block.
See CODING_STYLE file, "Declarations"

> +            if (!results) {
> +                return -TARGET_EFAULT;
> +            }
> +            lv = len;
> +            ret = get_errno(getsockopt(sockfd, level, optname, results, &lv));
> +            if (ret < 0) {
> +                unlock_user(results, optval_addr, 0);
> +                return ret;
> +            }
> +            /* swap host endianess to target endianess. */
> +            for (int i = 0; i < (len / sizeof(uint32_t)); i++) {

Put the declaration of "i" at the beginning of the block.

Otherwise, it looks good.

Thanks,
Laurent

