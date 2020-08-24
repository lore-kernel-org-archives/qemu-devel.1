Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D30C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EA92074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EA92074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAG2N-0000y7-Qk
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAG1m-00009A-34
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:13:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAG1j-0004pE-Dt
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:13:01 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MkEdF-1ku1301Q5J-00kgn1; Mon, 24 Aug 2020 19:12:55 +0200
Subject: Re: [PATCH 1/2] linux-user: Add support for 'ppoll_time64()' and
 'pselect6_time64()'
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200812135703.39404-1-Filip.Bozuta@syrmia.com>
 <20200812135703.39404-2-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <df9fe823-26e9-c0a4-bf0d-c117dfe06e67@vivier.eu>
Date: Mon, 24 Aug 2020 19:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812135703.39404-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LWwLaADpdDM9Jz8nfYaKHBIyGYP775PLuGHHKl5VC3oUsRpTGy8
 gZtEHeuoYOu2SJiztm6Re28KrNrACCyw+cf6aXSdVi0fH0mA9K+NmA75LLWjtbeYxYkBiNH
 Bvfrt81xu4U0Sv0lmTMaOygyb+iTrmA1mhOjYYR7Oabma8cgU+o/1zuTNg31rvYquSKjDws
 RILNcPnj+mss+9BpyYm8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+jD8oYVE+VA=:e3eGx4eQTg/xDvGDmj5Mxo
 1jIR9SDSOPOLyVOZo3d1hrh04daf00+Woy4jmi7jE/Yu5GKL4Opmjf500UAmZKNl8JHhtx+13
 qjozczn+ZXfenIr+v00XLsDGE7zQTNo/4LxjXsH32rzr14CJFjgiJzFslPY/kjyVM3S+kFdwT
 uxVpDr6eJn5XaAa5GK+gXLyj/eaeazzXWJy9LtvC4NGTzgygonovvP7HkTYlhHa4+KaDOtrkr
 WevO7OWpOfqhZwp7ksjgxrgByEYXGKHzMggTxZSjTLgU7UTLKNfroIA9T3j7wMs7gA+smKfpm
 puempyQNTimrTVbTAWWn0pRiEdol3wH95wQmGQ+3lqn3tNRL+9JeBKnQAGocQ5/xuYCjZyhab
 ugrFaPB2F/ko4EZjK7IYAcao+Vc114rMbcABk6qQVAflma9codb/zGd/fL7H1BriAJ9mZwiwH
 aa6/D6+sR7id3l0YIROW2ua1844xy+cCZUvrO7w59NNpOqLva/IrGWreSQnXUVPwFXmpJjVFX
 sfR/j83xvbZw3VKcvVfljh55q8XC6hnkj79gwhEn4Mx7at8AHv8bt3Roc2S7dRAUnU3ha5NG0
 gZHCWhBxCupQvBAMFU1Yg79MzrG/fjMxBNdIMIzt12KslVf6CBXFgKjylAnv8WXiprZlJ+VCl
 boK9ycsu+nkrhrifYbLcKpEiJ5Ymih/O+dzV9iOM/snjRon3ZJDFPTTuHLM3/yzjuqWChJu1o
 EeVFg8fA2PSSQLvEBvEBqL9Kz4wKdX/wSnQf2yUN0tpEd+j0rBTtN3aFvRcK2PDXBnz27A9zT
 c9MYbrf8IXRYs2EgKR77E8UWc50S7lvzZJSc0fCtzcxW4sAXRWRyCQHpTBynDYDFLxds3ug
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 11:24:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.25,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/08/2020 à 15:57, Filip Bozuta a écrit :
> This patch introduces functionality for following time64 syscalls:
> 
> *ppoll_time64
> 
>     This is a year 2038 safe variant of:
> 
>     int poll(struct pollfd *fds, nfds_t nfds, int timeout)
>     -- wait for some event on a file descriptor --
>     man page: https://man7.org/linux/man-pages/man2/ppoll.2.html
> 
> *pselect6_time64
> 
>     This is a year 2038 safe variant of:
> 
>     int pselect6(int nfds, fd_set *readfds, fd_set *writefds,
>                  fd_set *exceptfds, const struct timespec *timeout,
>                  const sigset_t *sigmask);
>     -- synchronous I/O multiplexing --
>     man page: https://man7.org/linux/man-pages/man2/pselect6.2.html
> 
> Implementation notes:
> 
>     Year 2038 safe syscalls in this patch were implemented
>     with the same code as their regular variants (ppoll() and pselect()).
>     A switch/case statement was used to call an apropriate converting
>     function for 'struct timespec' between target and host.
>     (target_to_host/host_to_target_timespec() for regular and
>      target_to_host/host_to_target_timespec64() for time64 variants)
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c | 101 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 86 insertions(+), 15 deletions(-)
> 

I think it would be cleaner if you move the code to new functions,
do_ppoll() and do_pselect6() first, and then you introduce a new
parameter "bool time64" to implement the time64 variant (rather than a
switch()) as you do in PATCH 2.

Thanks,
Laurent

