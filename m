Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB25EC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 07:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936B12075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 07:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936B12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVW8C-00079a-N1
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 03:02:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVW7A-0006m1-BR
	for qemu-devel@nongnu.org; Tue, 28 May 2019 03:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVW79-0007vM-GI
	for qemu-devel@nongnu.org; Tue, 28 May 2019 03:01:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hVW79-0007rY-8A; Tue, 28 May 2019 03:01:39 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N5W0q-1gYTUc23re-016suf; Tue, 28 May 2019 09:01:08 +0200
To: Li Qiang <liq3ea@163.com>, quintela@redhat.com, dgilbert@redhat.com
References: <20190525062832.18009-1-liq3ea@163.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <04f4d19e-1669-35f0-52b3-44124c862913@vivier.eu>
Date: Tue, 28 May 2019 09:01:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190525062832.18009-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CsbRl4/qJYgj5NSlcEl/uC14OenYdpvSxvdGrK9M2RZGD0OhWcU
	BEP/FdMOBz3KAo3/spAGpQMSkSlelAXjrR/NjB8aXMBnN3iOtCjQ6VQ3ADupsL4pcxwHPqT
	UyG/S2SiNL7UEwzwCwYD1TZIn3xniCsB+Jc8KV5XoI3URPbSFgr7XDFs0y1WgOaO3Nthkyo
	nermMcK2+seOFxBYvGsoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DKYLav02uDk=:QQGDN4cOjbwHGq+Xby65eJ
	lx7+GjV+1/hWmhTYKPjYKSlAu9eUHE3aoDXK+vFZOImcYG181U036OvCe8ojk7QsTHmuXFwys
	BXXvB9nzriYOiNVgzUH6DhYEF6Jo+FprmtY/DOdlQ+GTIx5zz33C7M4fB0fSpXQx4BbO3Zbbq
	T9INgHpXMq69kPAJEL/+F4UMOWP9/4C0GwTqydviAoEdddci6jbY4tyLkrBhgRMl+s+p+fVfS
	7MYKpH9OabP6GHNqpZAyTpXtAQDi6WEZmclKxUFsjhXZtWAjXrf92vvuk7spg9KW6YW0d95oA
	61kCuAHyCGS+LvLV4gF+BFBo4ICwHW80LqFm00wf1JT2+snbgAZa7oNL19pHItHqRq1AwVQKn
	DrNpsK6wsojyqWAGq2MeeaVJ3KAeK+/XyeEqsdfEu9Oc4QGLcj5C1TCWNyzPw/etaEVgE0gP9
	tAhcKHp9IulDcEMarSfbZ234rqozkZE/O4TtlreqvcOsSDc8ymNTuaVdrETwCtvCigXuuwq8L
	EfQNCDI64Z1ah6FLwt9eZuRUv2sv7eR6PrSbbfbroKgcPJdOB8tmmJWlMqZyIRktBY5y5FkXS
	tnahyx6Fq0UlghvoNAizZB6QYVp0mbG2+IsDFtp8onxxI1xLK1nJkjX+uopiRTMhDjfuICfP+
	KTYfSdZNDqN+GM8uG1dVoXg6Dhx62wdGICyEL/jiLK40wZ/KOvKoWUeGsNnY9b0qXW0YirpVu
	ib+0mjksawTWYQyyPGJ91mwir/P9F3HuTDjh+a4I0mfu+raCkL0YoNfdhaE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] migration: fix a typo
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/05/2019 08:28, Li Qiang wrote:
> 'postocpy' should be 'postcopy'.
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   migration/ram.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 4c60869226..359dc8f1bc 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2236,7 +2236,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
>   }
>   
>   /**
> - * get_queued_page: unqueue a page from the postocpy requests
> + * get_queued_page: unqueue a page from the postcopy requests
>    *
>    * Skips pages that are already sent (!dirty)
>    *
>
Applied to my trivial-patches branch.

Thanks,
Laurent

