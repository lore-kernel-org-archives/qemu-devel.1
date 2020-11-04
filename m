Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4AAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B6120825
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B6120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaQIw-0000v6-Et
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaQIG-0000W0-Bm
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:26:12 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaQID-0005gk-Qk
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:26:12 -0500
Received: from [192.168.100.1] ([82.252.154.198]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2fQ9-1kct843Iel-004D8M; Wed, 04 Nov 2020 22:26:07 +0100
Subject: Re: [PATCH] linux-user: Use "!= 0" when checking if
 MAP_FIXED_NOREPLACE is non-zero
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201103142636.21125-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3768e360-2e14-8f45-3b97-7ec6517b9dc3@vivier.eu>
Date: Wed, 4 Nov 2020 22:26:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103142636.21125-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y+1JDIS9JAdJs6u8HmudHn13MGlclxhj4mp3e59Inr+sN5fCZT5
 YThdN8+FBndRrr6oPWXf63+jTs6SMPLEY9wfXc/G1gp4aIhUdZrTiEGwfvp8VDZ1hOx8ce2
 9CxSTerIIFqBiljm8b4+6s4+/FDOGJJ3Lg069ml2TmkZ+pk2FUAEvn9HkU5hw3jyJP1ceWF
 AG7W3SlBIMlz3+Mm0ZxlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9yC4m2g8dO8=:IPWyNakblHQ/rDC9xg84Sr
 1i9Tainiz+biZbxpoan1Y2y/BJ2Co0I82lSufjgAZ7O2zlsfqFb3YeWMS3h6DjnHQItT+Ag1W
 zOUZWpk4Py58XhvBjs/uJUVCFbx0eX7kKzKgOKW9AgBRO2/fud/B0aWsKzVdjdPGwNemWCco5
 iUmuKhCkpXvVDk3O8hsbqXPQ7eRoer4mAWYSmClpJivf/3EySeoW6c3VaVKD/mYkvzjNlxcgW
 Nm+8QqkUW5tb/4NhQyI9Xf86RNOfImBUnG4KHwl3zAcyIUVyzqQ3Fh6dhU76QqdAtg0dKy+ID
 sqvFAYEJRSZj+XyfYGGBoKZ5jo5xPI8OrUy0cBr/bWO60SgCtBVrDcfyQz1BfRpxyiZlFFKHX
 AKCAPiJnWh7RORn3JlfKaGKASU15CDhfBkG7F3Pmx/Zknia3lrdkAwcYpOxbp
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 16:26:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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

Le 03/11/2020 à 15:26, Peter Maydell a écrit :
> In pgd_find_hole_fallback(), Coverity doesn't like the use
> of "if (MAP_FIXED_NOREPLACE || ...)" because it's using a
> logical operator on a constant other than 0 or 1 and its
> heuristic thinks we might have intended a bitwise operator
> instead.
> 
> The logic is correct (we are checking whether the host really
> has a MAP_FIXED_NOREPLACE or whether we fell back to the
> "#define as 0 to ignore" from osdep.h); make Coverity
> happier by explicitly writing out the comparison with zero.
> 
> Fixes: Coverity CID 1431059
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/elfload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index e19d0b5cb05..0b02a926025 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2188,7 +2188,8 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
>                                       PROT_NONE, flags, -1, 0);
>              if (mmap_start != MAP_FAILED) {
>                  munmap((void *) align_start, guest_size);
> -                if (MAP_FIXED_NOREPLACE || mmap_start == (void *) align_start) {
> +                if (MAP_FIXED_NOREPLACE != 0 ||
> +                    mmap_start == (void *) align_start) {
>                      return (uintptr_t) mmap_start + offset;
>                  }
>              }
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


