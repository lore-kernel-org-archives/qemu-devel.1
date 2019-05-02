Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3EBC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B90620873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B90620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7k8-0003QC-Hi
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:11:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7jQ-00038a-O0
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7jB-0005oP-Sy
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:10:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hM7if-0004Nu-QN; Thu, 02 May 2019 05:09:40 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MIMXC-1haNJ8374u-00EKiG; Thu, 02 May 2019 11:07:38 +0200
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
References: <20190423160608.7519-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <33e682e0-59e3-14f6-8f87-471ceea2657f@vivier.eu>
Date: Thu, 2 May 2019 11:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190423160608.7519-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zzQojMkdvaKX1eEHph0pSp1zzUuaMLwtE51B+yWtc6t4ZYR6eFy
	FG99pSjhjgCEaf5bP0G+hWdRWezuVUORWjbbR3FXpYENbSH+h74WFPP/fGBcGyXa6vCHxuB
	Ihe1MCaF013aym25T8B4LAZ0rbyixoxIeX26L7PE7uvetoAhpssCu4zcBebFLuP1CgL7PJA
	pD0PMtsyH5vAsag3OeLIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WnEJj1PidDk=:swGZwuySFEfpdxjE+7ZqAE
	1Vyikr2hizVPa0mW+i2l5ZuUmcOxhe4dLLXCXKzj0wbNlCz628FWH1Xy9vNeujVobB8dTBZMV
	RChnmmuJZjFCji8bzWU7YbneOy4sSf7dG6dB4gwdPx3iht296kg5dwWuV2v+FrOOCk4c/Y75S
	3GuvkX223DmfjCHltC9TMpJ76fA0hAEOE4TS0ucdwnNKK5yj+wnD0CX8mZ7fjuo4AwOCHojw3
	c6L0Nkms6ee4f8OJ1eMe3Bg6gUn4K4eiT42LoeU61vqOEGEGOF93py4K5zw72Ylb+gghkBtot
	gkhuiAM513RC40z5T69PMyuMQz3NfHQk73N2pHKin69O6ILjqMlC2MXHlQemXb8kRWFA1rFm9
	MAABoGMuzPGz13+hBTP96XYVpVt8CiJUE7YnaxA+PLRgKSlIBl3Q+sv8woPOlqiCloHy0vWMs
	wStQpjNA0kwZ0qg/ep8PVAPbfZWDAyYjifKXW/d1V+vkDrTJk6Z3FmEjoZEk9rGtYBUVlfT/r
	J4hdTrfLALZz8nspHakjUR7NjCnzreaiGB5voSxj59n0TZJ31d550TcAlKeqy+51wpC+Txeda
	KsyawV4mCXkenYnaRRFF4WyDh0vQ7EowaDy1qHW7oMENAwYD1+SB1mVrdRiNxwROUvOK/ce7P
	cb1U33ynFKMSk2R+QVWo7z1oEl9SHmU+FE/hpPNO4t+xjYIMKOilG+547uNse01uzQ9YEy3hH
	4nS8xx3jdeOGeP+FActUBVaVr9HgRugoNYqEZtvWaf/oftUSxjNGci3vFO8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] net: Print output of "-net
 nic, model=help" to stdout instead of stderr
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502090737.-gmzBfzAPjUKGOAL150jysc2ENzzr_Wkr0Jakq_nde8@z>

On 23/04/2019 18:06, Thomas Huth wrote:
> We are printing all other help output to stdout already (e.g. "-help",
> "-cpu help" and "-machine help" output). So the "-net nic,model=help"
> output should go to stdout instead of stderr, too. And while we're at
> it, also print the NICs line by line, like we do it e.g. with the
> "-cpu help" or "-M help" output, too.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1574327
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  net/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/net.c b/net/net.c
> index f3a3c5444c..2cf5e76469 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -837,9 +837,10 @@ int qemu_show_nic_models(const char *arg, const char *const *models)
>          return 0;
>      }
>  
> -    fprintf(stderr, "qemu: Supported NIC models: ");
> -    for (i = 0 ; models[i]; i++)
> -        fprintf(stderr, "%s%c", models[i], models[i+1] ? ',' : '\n');
> +    printf("Supported NIC models:\n");
> +    for (i = 0 ; models[i]; i++) {
> +        printf("%s\n", models[i]);
> +    }
>      return 1;
>  }
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

