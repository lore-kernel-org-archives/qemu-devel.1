Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F2BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED30E205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED30E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNht4-0000Uz-Gk
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNgtZ-0007jM-Ip
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNgtX-0006ex-J1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:27:33 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNgtX-0006er-9i; Thu, 24 Oct 2019 13:27:31 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N6srH-1hwGOn1YIZ-018KvV; Thu, 24 Oct 2019 19:27:26 +0200
Subject: Re: [PATCH 2/3] event_notifier: avoid dandling file descriptor in
 event_notifier_cleanup
To: Frediano Ziglio <fziglio@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20191023122652.2999-1-fziglio@redhat.com>
 <20191023122652.2999-2-fziglio@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <63bab37e-f848-8361-2333-cfae59e81ae6@vivier.eu>
Date: Thu, 24 Oct 2019 19:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023122652.2999-2-fziglio@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RLI+O/ihPBSQVdaCNiHO8/KZeE2zCJ2ej+k0mZq4LqWDWWsk+c0
 9mrnucF4O2bZsCTgp/CahQo2maS7Ar2a4F21rhPJXX0+Jw5qi5xX6IUwMGRcPqlM1TJ4yjH
 V1YdVlq7z4zqyDUFFUR76XhzZcdUXgls3g6SIWL3aF+TLZJO0l0fmi1e5vqtW8axvy0Mrh9
 5rEs+XuRkssUmzyu2ozGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jvQwkczo4Oo=:4YVkAV5/J3N1Wbi2rB3VgN
 VsttpdpA8AIWhNCehBl/Vj9L4VaQKTwsGIOzEm4T2NJedriU1lm153GJQkxF6amkXICPSQd+w
 Vki3AW6nhHEJV/I3ql9vRb4wjbEi5/NzdnNxc2+7sh929RdKQweaSkuREARw361Fub+zDLYiU
 DFL7HKP9sVves04r3JpPkmui6eNMb9kLWL8wLgv4zkwNweCPFwhq0RQKpo8Bp/68mI8on9Z19
 27uWegrViQtA8KwRtlhm5utprupvknfmqDZN3r09974Pn65ZXwTDVW2wDyPq2cnij16wcGYWY
 Oy7CNCDbB92TvXtYUrMJxSpomjIICSdvHj/C9FmEiUmjl01nQJkdE5Y7o32Z8dytDwx3gVUON
 l5Rna06aQ0Bfiwr0Oib7CJ6Pz2lXLu0sxdclUmrdTTLNi7Gz5D2SJrCvTIjw//rIl3Qht3/9X
 CvGvRDdD/Nx8l6r9A5lBEpTKqy0mXN79diN3Sa4MSvyn3Kkopb00xMwaG91gQ0Ko4dS2iu5zF
 0Xs5x5Ba7iDgiq7EEJY6eow3sWW4zGOb0n6aoBYGhH7yCCRBbF+rGS5/+sFpEA+ZhCDnVUJ9D
 pBD97hvKBgjy1kDvR/bNK9qKy4qUyA8JN4Mvit7hOzFSPqmRWp+yuBroWf31l+6fUvAZJWjzJ
 Q0KafTcuDbf4e8R6XvjeOrkQmCYvRWBOeHRWUvyQVGkci0q29aG8ollPq7bxFhA63RXDLXzMN
 E0r/G9YzX9jN/J1lvKHjrkRcj0zZDRtjHtxIQqKHTg5L9V66tDLpQuCfh5zg5HhnkIL7Bjj+P
 FcDkoROI76zlY3EfXIN86reLZZRweFNrN6mXc6yHtvcljXrommZtZkcrqVZWi5VE6ALXvzuSa
 IPFM+IzK0CHP9KeVEjKfZ/uo0miunJMvyOryt/7Sc=
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/10/2019 à 14:26, Frediano Ziglio a écrit :
> If rfd is equal to wfd the file descriptor is closed but
> rfd will still have the closed value.
> The EventNotifier structure should not be used again after calling
> event_notifier_cleanup or should be initialized again but make
> sure to not have dandling file descriptors around.
> 
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> ---
>  util/event_notifier-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
> index 73c4046b58..00d93204f9 100644
> --- a/util/event_notifier-posix.c
> +++ b/util/event_notifier-posix.c
> @@ -80,8 +80,8 @@ void event_notifier_cleanup(EventNotifier *e)
>  {
>      if (e->rfd != e->wfd) {
>          close(e->rfd);
> -        e->rfd = -1;
>      }
> +    e->rfd = -1;
>      close(e->wfd);
>      e->wfd = -1;
>  }
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

