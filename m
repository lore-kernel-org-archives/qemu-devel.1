Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA57C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458D920829
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S1L+LHRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458D920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgcXb-0003KC-E7
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 19:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jgcWd-0002mR-VK
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 19:10:23 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:38394)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jgcWZ-0007DZ-On
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 19:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=u+7X1
 D9ewf9417g2UWvPJdXIYHjEVA6+8mjZAY7kpVY=; b=S1L+LHRNWzfMHQoywbEcq
 xWYZ+Ugcx51StQU2ZHUvfMpwNm1sSVqSJXazyRGI7PkgMsOYpd+zBCXHa5RGnWqv
 TUwR42mou46XWz95MxjNTcnZSFT8Z5S0ygTM6p/CCOSXJX9yrXNZdmpQq7tRsHY5
 OmyFm5Jvhu7Em4R3ANYnvU=
Received: from [192.168.0.123] (unknown [123.120.106.23])
 by smtp3 (Coremail) with SMTP id G9xpCgBXQwDPLdhebUF6AA--.129S2;
 Thu, 04 Jun 2020 07:10:07 +0800 (CST)
Subject: Re: [PATCH] tests: fix a memory in test_socket_unix_abstract_good
To: Li Qiang <liq3ea@163.com>, berrange@redhat.com, marcandre.lureau@redhat.com
References: <20200603161409.54682-1-liq3ea@163.com>
From: xiaoqiang zhao <zxq_yx_007@163.com>
Message-ID: <e3a262a7-fbfb-14a3-f4df-7ccafc803d13@163.com>
Date: Thu, 4 Jun 2020 07:10:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603161409.54682-1-liq3ea@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: G9xpCgBXQwDPLdhebUF6AA--.129S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry3Jw1rXFW5Xw1rZF15twb_yoW8Gr1Dp3
 s8JayIkr48JrykWFWDG3WSgF48Aa1kG3yF9Fy0yw1UZFs8CrykGwn5KryUJ34DGr40vr4S
 yFyqgrn09w1jyFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNNV9UUUUU=
X-Originating-IP: [123.120.106.23]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbBEA84xlUMRk2odgAAst
Received-SPF: pass client-ip=123.126.97.3; envelope-from=zxq_yx_007@163.com;
 helo=mail-m973.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 19:10:08
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

在 2020/6/4 上午12:14, Li Qiang 写道:
> After build qemu with '-fsanitize=address' extra-cflags,
> 'make check' show following leak:
>
> =================================================================
> ==44580==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 2500 byte(s) in 1 object(s) allocated from:
>      #0 0x7f1b5a8b8d28 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded28)
>      #1 0x7f1b5a514b10 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51b10)
>      #2 0xd79ea4e4c0ad31c3  (<unknown module>)
>
> SUMMARY: AddressSanitizer: 2500 byte(s) leaked in 1 allocation(s).
>
> Call 'g_rand_free' in the end of function to avoid this.
>
> Fixes: 4d3a329af59("tests/util-sockets: add abstract unix socket cases")
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   tests/test-util-sockets.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index 2ca1e99f17..ca6671f9bf 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -312,6 +312,7 @@ static void test_socket_unix_abstract_good(void)
>       g_thread_join(serv);
>   
>       g_free(abstract_sock_name);
> +    g_rand_free(r);
>   }
>   #endif
>   

Reviewed-by:  xiaoqiang zhao <zxq_yx_007@163.com>


