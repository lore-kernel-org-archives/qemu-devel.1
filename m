Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01BBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69852070B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69852070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj50U-0004p1-3s
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 13:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jj4zv-0004Oy-4h
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 13:58:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45343)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jj4zu-0001OU-4f
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 13:58:46 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MsaeR-1iux7R2NER-00u0MK; Wed, 10 Jun 2020 19:58:42 +0200
Subject: Re: [PATCH v2 4/6] linux-user: Add strace support for printing
 arguments of lseek()
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200608164357.25065-1-filip.bozuta@syrmia.com>
 <20200608164357.25065-5-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <762fc51c-a755-f8bd-43f2-d49f4ee246c3@vivier.eu>
Date: Wed, 10 Jun 2020 19:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608164357.25065-5-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:048EaimbS9bOLbyjvihnd1hbxMdqZXVQ4TyxFRZEAQoEMNpRYj7
 Ypj/kTu4It41+0v8g086duT1aihJ3VW+t3TpJeKcFVuagYrotHcb9jC5LwwjrAp45T7b2bx
 1Gm4p4P+n58LpnmaATRQEkGvpMZcMMSfNjR8zZG0nf7nYJs66OQcPKE4X4uZVQaaDwNwzGM
 GAs8gxmPA71dNRINqneow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kgaBg46VrYs=:P/+u+aYEF2NMH8o/VRTRsd
 gg3UKm4btMcKGbF5CopRgLuKc1RL3YhwYLL0yc1HW8Vs6iF16Yr234UsNcNMdkbJgE2CpJ4uK
 B/JDCvKsBXFh7Jky/YXE1+/bbrgepItMOsMRx0QDsrn65GMNtw3FZ3DKmDiLz7cK6hyw+B69k
 kcXdQDvAGqBRvDQoOZFgAGqL+XPZnPZ7WhK23MEj4C0XNtqK0OB2RzBN3eU40OXE/hQzonR4R
 FculI5X8Ths2ip9/f+7vfW30EnuRJM09CJc9MsYuudo4a/MvTWgM8KbyaaejMvpYI7m03s36q
 dexA0E33DETctt6/oKQSzpxWixgWFJt6QfLc+R4p4HJU+weGixfRaRpxgtQeqHg2WXEa0feeb
 289HBRp+g9vCPngaakohuit9wiDUcdnYiiNZqu2fXoA5jvAJqFav++qNWIpZcEuyhzt/XV+LO
 fQ2RLsaDh2I7P/XfSXHtKMCpESBNejRSB6umSB9XEI8CakaEQOu2ZimxJc0g1uMX77CR+lEkj
 2kmU4MvM3kOooP+dRWeNhsTnvgzFvnFxTk38StNXQt6ZEpsl/MMqBfN076Q+/hm3SIedJ1HTS
 iXA4s2zeveRyjmNCzR1Z4DVdu1yHxuvyBhvZ3vYTKUM+6SutViDuUgntfaKaGbnGC4PO2xhuO
 hxybDtCC6hlvtA34kQbXnqyUPMNBWZYSo36Ev8V3xs+fXKA0p7tLDYZT415t+Cm4r1m9bN3UG
 IfZ1RD13B1IHObTthEtfdsa1qzo0XWVHw7iMVYT2OjpeB0RazAEaBo/MBUHnYxrCKe11bWN5S
 rCLgGYAgE7OoRUfVUCtQFF/DhxUoiLwekCe3/dkfs3R5Z5RDr9NuaJ6g70IDsCjjMcyBtVV
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 13:58:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Le 08/06/2020 à 18:43, Filip Bozuta a écrit :
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
> 
> This patch implements strace argument printing functionality for syscall:
> 
>     *lseek - reposition read/write file offset
> 
>          off_t lseek(int fd, off_t offset, int whence)
>          man page: https://www.man7.org/linux/man-pages/man2/lseek.2.html
> 
> Implementation notes:
> 
>     The syscall's third argument "whence" has predefined values:
>     "SEEK_SET","SEEK_CUR","SEEK_END","SEEK_DATA","SEEK_HOLE"
>     and thus a separate printing function "print_lseek" was stated
>     in file "strace.list". This function is defined in "strace.c"
>     by using an existing function "print_raw_param()" to print
>     the first and second argument and a switch(case) statement
>     for the predefined values of the third argument.
>     Values "SEEK_DATA" and "SEEK_HOLE" are defined in kernel version 3.1.
>     That is the reason why case statements for these values are
>     enwrapped in #ifdef directive.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 31 +++++++++++++++++++++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 32 insertions(+), 1 deletion(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


