Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC8B218AC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC8B218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdxX-0005FE-Ko
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izdwP-00044P-ID
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izdwK-0005WU-HU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:59:21 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:36797)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izdwK-0005Gr-8Z; Thu, 06 Feb 2020 04:59:16 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MCsLu-1iqoEZ1UJM-008oJT; Thu, 06 Feb 2020 10:59:11 +0100
Subject: Re: [PATCH] hw/bt: Remove empty Kconfig file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200123064525.6935-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <37d524a2-a67e-6eca-f75e-f9014c4d36b9@vivier.eu>
Date: Thu, 6 Feb 2020 10:59:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200123064525.6935-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nDPPkRfjEjaBvHzc2/brdD4FNmE81aq6kWYQk9UQcMsMHedMXUW
 4uns5E3088Wj9zfNy89R2cMCBTDGYO2LRUBl3hRKax1d66FgfC70hQFd1f54+7XkA1QerNs
 p+ssFR8NEf01iNe4JB4V1Eyn8bWkxg01ymjNqB6uP7R+JenWVPihhljMNK2CvBY/w4r16rY
 rQUBcNE1asN45MGIqwt2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ne37KLy3NBk=:sk+tu1jgfJSWCHPktWMU/n
 0IClP6R500ux970pZlvf5iqotLhbiGxuPA8mh+q2hje30eqF0IMKYVjBGa5vH0jM44f2uIoM6
 Bg0LiNfjStaeOTvsnB4MH7lh4tZg+YC6yWAj8Ecr+AekcvCMSyA/Ilj7fEsVZV2FgJcHrDp0L
 wjyDQZ1ovOaHbUcRFDXIz+30lSzDSDt8IzHBlfZu49Fu9gLueS0BSX6AXEuz+hOYuOzLLfntr
 jLgb3rDxozW/w0sjUK0DpPMrxOiQMUVhFjryOWRJ9FHFowqvFF/wGggMrqqzkNEhcaHNUfSc4
 URZHOdd08/Guq4wmbDHgs9QoUllSKy1ijjyWgIO/cFxFKMaIuHhTD8jGCKt54hGtq+4D7J0qE
 cT1afcUTMYh9RmjNaCulXLioN9HxVQ9miicHWagC/aZRrHz2vk0Op+ev61PVrbSvkBA/aOw/5
 8Hwk6QCnw9FVS4zDXlxeOcoGL21nLPuAOp9c31kkVfcffopqRj49vfDlbExT62aC3IwbTTE9J
 gU5QE1xNkIQ+Dt8zO0OaFUDVY1QnDZVGMXpRUz+qUzSUuTHNS+ZaguI+as6vWk4Sw5o/hQQtf
 eBWuxcz0DA+t+i6V0b5bNKT+peGTJpvOoEbAJ9oA0/iZ+vRaIH2H9vJk0fb83hQ3BX/ZOIZWQ
 YrTRuoxW1m8Fp10+1YqmfzgtWnrl0l2/BVitUyKwZRWUJk+tQdD3rLeMgJLUmWqfcwKQJj6HO
 QHTvhsOqe23VYAMHd7SLoZAGZKCNvsluA3pZy8knhtFOWtZlJit4iko+wzwx5oTtqxPA7GiW7
 XbjBARcrgKpsvXrsozp9AJlPTI7ho6RKC9sBx+Z0lYtjHGwkCPgJJJR6/yhcn8mEoc2mSqu
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/01/2020 à 07:45, Thomas Huth a écrit :
> While removing the bluetooth code some weeks ago, I had to leave the
> hw/bt/Kconfig file around. Otherwise some of the builds would have been
> broken since the generated dependency files tried to include it before
> they were rebuilt. Meanwhile, all those dependency files should have
> been updated, so we can remove the empty Kconfig file now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/bt/Kconfig | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 hw/bt/Kconfig
> 
> diff --git a/hw/bt/Kconfig b/hw/bt/Kconfig
> deleted file mode 100644
> index e69de29bb2..0000000000
> 

Reviewed-by: Laurent Vivier <laurent@vivier.Eu>

Applied to my trivial-patches branch.

Thanks,
Laurent

