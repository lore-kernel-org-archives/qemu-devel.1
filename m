Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECFDC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9C42072C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9C42072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYR9O-0006AO-0M
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kYR8D-0005ZL-C1; Fri, 30 Oct 2020 05:55:37 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:32873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kYR8A-0006T4-II; Fri, 30 Oct 2020 05:55:37 -0400
Received: from [192.168.100.1] ([82.252.154.198]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MiaLn-1juzmC2oK7-00fkGo; Fri, 30 Oct 2020 10:55:19 +0100
Subject: Re: [PATCH v2 4/8] linux-user/mips/cpu_loop: silence the compiler
 warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
 <20201030004046.2191790-5-kuhn.chenqun@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b3a0569a-d4a9-d73f-8c20-6e8c6251dace@vivier.eu>
Date: Fri, 30 Oct 2020 10:55:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030004046.2191790-5-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wM3TDhl3eTI04EfWMRg+X7tQTtHdvtFty5B0VweV2RnshYf5rFI
 7t4Bpvq6fz3Dbb4XvDgD7ymfAjqiyvC540DYatGhWlWp3ud++Vk/hfdLQK5+dTxwYjWBikR
 qBQtBvTWdMshhCH35UEJ6AVNbtUyfC0nrB9xlpahPr63zmi2ktirwFmFIePvKrFb9M5MpdV
 9DInIwLoXy+5jUHKkXciA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HxEIL71dBHo=:PUXhlMFFr46YCl9KiSPHJS
 9cKsGJOz8Okw7EH6K3z4v9QNOheWglaDCeSvpLjtD1UouOmkTXfwqtNqXH8vVZs3Py8BHmQ8T
 oMVPeLdEThj3LdkTwCz6zVcabM7Dd/rhCshqHCbcT7LSbbslh08/GAFzsque+KK9ai1u25e6W
 YZ545ucB9aeyG/t0EgsstJU20QHOxzahpcTBt/bc1sL9my7eXjl4u2WsDs7IvvWyylUcYHGYQ
 7r3ebYNpfgoT6tBfUBHZWNAVvteYp+wxi+CZhR+jjSLbs0jLMuE/MUt2CEuvg4vetgLmiNdzz
 R1QXQd1cLPmtviqvR2F74UOR/5bhznj51PHLUEk4Rs/RFbjUTb22H7hgiABRz2VZ8Y7k7mmeR
 ediB4MfRuiT8+HhCLcEYNfR4E5x6E+yfJimZ5KSWfNkhtqBRNlO+Gypdzh/eD
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 05:55:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.261,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/10/2020 à 01:40, Chen Qun a écrit :
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> linux-user/mips/cpu_loop.c: In function ‘cpu_loop’:
> linux-user/mips/cpu_loop.c:104:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   104 |                     if ((ret = get_user_ual(arg8, sp_reg + 28)) != 0) {
>       |                        ^
> linux-user/mips/cpu_loop.c:107:17: note: here
>   107 |                 case 7:
>       |                 ^~~~
> linux-user/mips/cpu_loop.c:108:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   108 |                     if ((ret = get_user_ual(arg7, sp_reg + 24)) != 0) {
>       |                        ^
> linux-user/mips/cpu_loop.c:111:17: note: here
>   111 |                 case 6:
>       |                 ^~~~
> linux-user/mips/cpu_loop.c:112:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   112 |                     if ((ret = get_user_ual(arg6, sp_reg + 20)) != 0) {
>       |                        ^
> linux-user/mips/cpu_loop.c:115:17: note: here
>   115 |                 case 5:
>       |                 ^~~~
> 
> Add the corresponding "fall through" comment to fix it.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
> Cc: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/mips/cpu_loop.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 553e8ca7f5..cfe7ba5c47 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -104,18 +104,22 @@ void cpu_loop(CPUMIPSState *env)
>                      if ((ret = get_user_ual(arg8, sp_reg + 28)) != 0) {
>                          goto done_syscall;
>                      }
> +                    /* fall through */
>                  case 7:
>                      if ((ret = get_user_ual(arg7, sp_reg + 24)) != 0) {
>                          goto done_syscall;
>                      }
> +                    /* fall through */
>                  case 6:
>                      if ((ret = get_user_ual(arg6, sp_reg + 20)) != 0) {
>                          goto done_syscall;
>                      }
> +                    /* fall through */
>                  case 5:
>                      if ((ret = get_user_ual(arg5, sp_reg + 16)) != 0) {
>                          goto done_syscall;
>                      }
> +                    /* fall through */
>                  default:
>                      break;
>                  }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

