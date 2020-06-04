Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52EAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 22:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D612206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 22:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3nEBNQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D612206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgyMr-0007EY-Ox
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 18:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>)
 id 1jgyMB-0006hy-R2; Thu, 04 Jun 2020 18:29:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>)
 id 1jgyMA-0007sH-Bx; Thu, 04 Jun 2020 18:29:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id s23so2596906pfh.7;
 Thu, 04 Jun 2020 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KwGXHKr9Ghopz3flMsgRdk+TyOFUZwUzeN0RP8Ztuyg=;
 b=a3nEBNQki38fWRghvGtY9IBkmg6EcsAp+3TNVJbO6cMUJx9MQq9uopeOU1YTSoicFO
 +xkCecPagDWvF9RgXIBXvDLX19xdreaubRdTjABLmlxbslWl4PUO7UvzCizodkY0+a0w
 +Vs0V6LIvg9PP+xvE+C9z1BKgzNW0pbTNth9Dix35TqoJnzSBNa6BAqyzXrst6tVsoiP
 e/8OGuevaat9Rz3dCQTaqaaSLeBs7gyz0ZBouVk4godc0SnDX232BeD9k7crheAs5NMk
 6EHSAvHuVX9Lh+tpkzA0HB0/ADzscQ21bJfud0Wkl+c2OHaQxG3SyjSn59773Q9Ysvv6
 QkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KwGXHKr9Ghopz3flMsgRdk+TyOFUZwUzeN0RP8Ztuyg=;
 b=YsbPy68t2sQqsb1l+dnIyHH/5+efVm9g/IWqrlkhEyBvMg10QivluJ3GwVl4RBpzxb
 vm1eBstik6pj7K2bHawMoPuoErAcurLs6mRSXeBf6Ju2nnWKge3gKXONPNMAaqefqKHS
 W2R4tyoQp1+D22f3EWN2YYqAwKfT5QshlcLsbkEidnL7+n+VA65D52+gFPrHRRCjt/Pt
 SprBqW1ENHiKcuAitl75hOHqVY8Q/sIkpVL3LYcNDnqKRbvUDVXvws7aLehBQQiut6Sb
 qV0I9LSpZEXSbrQBGdIjk/vGX8GgdgCSse0oEUdmZfEwFHsv6D5AVBJMFBE9cca++Ij5
 5eXA==
X-Gm-Message-State: AOAM531DBPpoME10iDVdrIHaVO3Vr5E5wREVHwuY8pOd+M0JvvyVb06g
 Jyoe2ZMS4Kb2UfwjcEcVs30uQuYu
X-Google-Smtp-Source: ABdhPJz0DMAKulTJCQuZ7YJbVtgzxef1lW+zn0m6l+ReAoIWmqy3gX0i4RAz9anVXngQ9ZU5BOoy3Q==
X-Received: by 2002:a63:e60a:: with SMTP id g10mr6736032pgh.210.1591309739575; 
 Thu, 04 Jun 2020 15:28:59 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.googlemail.com with ESMTPSA id u7sm5662864pfu.162.2020.06.04.15.28.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 15:28:58 -0700 (PDT)
Subject: Re: [PATCH v4] osdep: Make MIN/MAX evaluate arguments only once
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200604215236.2798244-1-eblake@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFYBBMBAgBCAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAIZARYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweUY
 BQkP1h/pAAoJEK0ScMxN0CebqDsH/0YyfnXk+Dc++H37VCEKgRet2i1ATFzxRnifkvmdxha0
 V+PVptQ2fwSe+w3KxoFecD8W75nysmUjrU/FicW9yU5YRlGONPZjruG02/KzmhA5PzWJdYO3
 i/t0qRayvWIcX2qA/flsXEbmb/BbAFM05LQIdcOu74eiBFe5CBCOWBDJeneE1urIE0hSYxoh
 nCcG60ULrNj13ohZ4zAEluoY32qIo7/OPWmtR88cPrEbZT8k+RqgZbsotzaPT1/RlL74fL8k
 ofYfTgKAFH7eEy6fF2nzDp2GThVn+3sA62xtpSXUf/X1m75B40KOcq1EQbHypNTmBc1wt13e
 ibhPNEVX2am5AQ0EUa4sLwEIALITHfH3gciRNfQIe7awDTDvn6H3C6gDyCAnv5LiuLTLZiyK
 NZp3lNO3rPowyKrGT2RIDlumlqPgdeHzqEEX91YK0yk2vdFvwU04rJ4D+qRgdUPoeICLD1zo
 PwOv2FaY6Tf8dKYas1RHF5QU5yQNey8j7IYYoE2yGPn2PtBmvtmK4iLataUEvx0U385Zr+jf
 HscqwTiToryeDC8Io/9BsMvAssE5Yf5URS2nJ7LFOvc4njsQJPF1i9egBXaIloqv7p2hVCKJ
 Hl5UWIxitQ9QQIl6iU4LCpz8mVYTXwv48IAVpbUf7+ak9V9Kk3jCeQnlxCJBUHjUhoIzinbS
 JHPHtkkAEQEAAYkBPAQYAQIAJgIbDBYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweVIBQkP
 1iAZAAoJEK0ScMxN0CebGHUH/RtouOlWl6To97tQsTJUq/2YwmRpFOsvV0/zCX4fKBGAbeZi
 VaELSt2+3UEErA+n8HwbQmjJ6IrdhA9GustOpOyCcbLVSMwql/OlAwBtDzCcC8dTU4zcuY2a
 rGG2A8i5krU85G9r1wowVcWZBsdmW7/dKiNoadLQiig4bHNiSaV4ograas5efyEjqTxiY+yG
 hzPw5DK2kbp2co8iDF1vW0LWPeLFBinCgItcI9LvgHWaB3rwjOfvNpMn5m64SoQYHB8wbnid
 erAjOzkBzmqnfS1tAUr8mtESStEwrEmNv0ZoA6S0Wt+c9pyTr+BpG4OFlhj7ZI+Eh7zOrr33
 q9OBIdA=
Message-ID: <22581360-32c2-d7b5-9e9d-bd50a3ceb8e0@twiddle.net>
Date: Thu, 4 Jun 2020 15:28:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604215236.2798244-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=rth7680@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 crosthwaite.peter@gmail.com, quintela@redhat.com, f4bug@amsat.org,
 dgilbert@redhat.com, kraxel@redhat.com, dirty.ice.hu@gmail.com,
 pbonzini@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 2:52 PM, Eric Blake wrote:
> I'm not aware of any immediate bugs in qemu where a second runtime
> evalution of the arguments to MIN() or MAX() causes a problem, but
> proactively preventing such abuse is easier than falling prey to an
> unintended case down the road.  At any rate, here's the conversation
> that sparked the current patch:
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05718.html
> 
> Update the MIN/MAX macros to only evaluate their argument once at
> runtime; this uses typeof(1 ? (a) : (b)) to ensure that we are
> promoting the temporaries to the same type as the final comparison (we
> have to trigger type promotion, as typeof(bitfield) won't compile; and
> we can't use typeof((a) + (b)) or even typeof((a) + 0), as some of our
> uses of MAX are on void* pointers where such addition is undefined).
> 
> However, we are unable to work around gcc refusing to compile ({}) in
> a constant context (such as the array length of a static variable),
> even when only used in the dead branch of a __builtin_choose_expr(),
> so we have to provide a second macro pair MIN_CONST and MAX_CONST for
> use when both arguments are known to be compile-time constants and
> where the result must also be usable as a constant; this second form
> evaluates arguments multiple times but that doesn't matter for
> constants.  By using a void expression as the expansion if a
> non-constant is presented to this second form, we can enlist the
> compiler to ensure the double evaluation is not attempted on
> non-constants.
> 
> Alas, as both macros now rely on compiler intrinsics, they are no
> longer usable in preprocessor #if conditions; those will just have to
> be open-coded or the logic rewritten into #define or runtime 'if'
> conditions (but where the compiler dead-code-elimination will probably
> still apply).
> 
> I tested that both gcc 10.1.1 and clang 10.0.0 produce errors for all
> forms of macro mis-use.  As the errors can sometimes be cryptic, I'm
> demonstrating the gcc output:
> 
> Use of MIN when MIN_CONST is needed:
> 
> In file included from /home/eblake/qemu/qemu-img.c:25:
> /home/eblake/qemu/include/qemu/osdep.h:249:5: error: braced-group within expression allowed only inside a function
>   249 |     ({                                                  \
>       |     ^
> /home/eblake/qemu/qemu-img.c:92:12: note: in expansion of macro ‘MIN’
>    92 | char array[MIN(1, 2)] = "";
>       |            ^~~
> 
> Use of MIN_CONST when MIN is needed:
> 
> /home/eblake/qemu/qemu-img.c: In function ‘is_allocated_sectors’:
> /home/eblake/qemu/qemu-img.c:1225:15: error: void value not ignored as it ought to be
>  1225 |             i = MIN_CONST(i, n);
>       |               ^
> 
> Use of MIN in the preprocessor:
> 
> In file included from /home/eblake/qemu/accel/tcg/translate-all.c:20:
> /home/eblake/qemu/accel/tcg/translate-all.c: In function ‘page_check_range’:
> /home/eblake/qemu/include/qemu/osdep.h:249:6: error: token "{" is not valid in preprocessor expressions
>   249 |     ({                                                  \
>       |      ^
> 
> Fix the resulting callsites that used #if or computed a compile-time
> constant min or max to use the new macros.  cpu-defs.h is interesting,
> as CPU_TLB_DYN_MAX_BITS is sometimes used as a constant and sometimes
> dynamic.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

