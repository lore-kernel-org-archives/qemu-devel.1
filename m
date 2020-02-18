Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A20FC34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCD62067D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCD62067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j49EH-0005K6-Lv
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j49D8-0004TC-K3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j49D7-000257-Ew
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:11:14 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:57727)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j49D7-000223-64
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:11:13 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MhlbM-1jhtnn4Ay0-00dlUO; Tue, 18 Feb 2020 21:11:00 +0100
Subject: Re: [PATCH v3 0/4] migration: Replace gemu_log with qemu_log
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200204025416.111409-1-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <bb0d64bc-08b4-b3c8-6ff1-b3dc096d1d3f@vivier.eu>
Date: Tue, 18 Feb 2020 21:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204025416.111409-1-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xAg4+yAHNcNd9XQjIIF6WV3CxkLQ7v7q+DIoQoQpwftzvQgLCrg
 te6qvJq6pQlUehCFAn+cJwlTYtDtZm+TuSZlvNTFqQ57J6aDK0vObSg/oUTSMXKPay9/KOV
 1BYNgXVNqIraO/Cr8g3oA3LHrX/OwE0XoxXx0fne2SYUWJPk3XOitckr8FBGIKwBIiwbtN9
 /tHkMGv5j9m84fk584oUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W2TiHUb/YlE=:H41vacGrAWuoLa9waLnIGV
 nermD37Dnau/nE3q+y+07W6hIDQIStLo4aOzMxoiLj/9mVWHuFvd/iTPkFoq61UJKt7ouDQrH
 5TbGv6qEQWMIStVpNlcjtbrQmmIQkZMjhwU8KqfT9FVXYTIs65MeAFMU/DtFUVbZOe4o+Kf34
 Jhz0LiQI1rxPENgaRWhcNG/ojR+zn2+HpcLFZhzo4U9VGcth6ATgiO4pGK2YKtq60cfVKsg0d
 ExmMppxNN16W7ICTlE+9iGZJ3Qfxx6xyZVvdHb3xjZ5kmu6L+9LVbRoIsV0TVuMVY2enaWfvv
 o57LIPDeHZUoKVxuBKaIhCPyppolkvpw1WTrtvCPK80VflkfNF0VDctLhcN+ZbTOvOSOVh7in
 JAwTj1K2YQes9vcjTILc0V1JsXkD1Zup6sR4FmtWqfQmaa5Ad39VGFf/Fw/cfvRL7rjxc0CsB
 y6RSQVcbBOeqkLprEvcz6sdUND+S7u2Xz0PBh0sTsRQPPGxZU628PNvXeM9+HJLcnr23WMQar
 dk8UTHYbG4FhILisgUp6v+l6DP8WSZsdVXGcghJZ+wUTxERv5oF8YKziiNtQFKcjueJCtvNQ2
 2PKig60KP5kXRsnfax7MtH52vrNFezHiApNWdK2XHNt3vRqh9jd7A/5yWbro93xZT15qMEs+n
 XQbI78iyEuYo91S0hKewl5EYBOFfJOZRxNLHv/2oQ1Lj20eZs+5gTooZJqC+0lhIZHtMs9dfd
 ZuAw/jsZFH9/6GbP1JX4Di6BT5QcLERmr9mgGofaqZUjBY4ArclJo+zLyze/msgEraAbLDZpU
 PC6Xk99AC7SuxWJkUQBHqY4hUQ+VYKWDn3/ef2dtH50rtt6p7SsqYLqFRh5TIfcJvthhWXj
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: riku.voipio@iki.fi, alex.bennee@linaro.org, armbru@redhat.com,
 imp@bsdimp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/02/2020 à 03:54, Josh Kunz a écrit :
> Summary of v2->v3 changes:
>   * Removed assert for CMSG handling, replaced with LOG_UNIMP. Will
>     switch to assert in follow-up patch.
>   * Fixed BSD-user build (dangling references to qemu_add_log), and
>     verified the user-mode build works.
> 
> Summary of v1->v2 changes:
>   * Removed backwards-compatibility code for non-strace log statements.
>   * Removed new qemu_log interface for adding or removing fields from
>     the log mask.
>   * Removed LOG_USER and converted all uses (except one) to LOG_UNIMP.
>     * One gemu_log statement was converted to an assert.
>   * Some style cleanup.
> 
> The linux-user and bsd-user trees both widely use a function called
> `gemu_log` (notice the 'g') for miscellaneous and strace logging. This
> function predates the newer `qemu_log` function, and has a few drawbacks
> compared to `qemu_log`:
> 
>   1. Always logs to `stderr`, no logging redirection.
>   2. "Miscellaneous" logging cannot be disabled, so it may mix with guest
>      logging.
>   3. Inconsistency with other parts of the QEMU codebase, and a
>      confusing name.
> 
> The second issue is especially troubling because it can interfere with
> programs that expect to communicate via stderr.
> 
> This change introduces one new logging masks to the `qemu_log` subsystem
> to support its use for user-mode logging: the `LOG_STRACE` mask for
> strace-specific logging. Further, it replaces all existing uses of
> `gemu_log` with the appropriate `qemu_log_mask(LOG_{UNIMP,STRACE}, ...)`
> based on the log message.
> 
> Backwards incompatibility:
>   * Log messages for unimplemented user-mode features are no longer
>     logged by default. They have to be enabled by setting the LOG_UNIMP
>     mask.
>   * Log messages for strace/unimplemented user-mode features may be
>     redirected based on `-D`, instead of always logging to stderr.
> 
> Tested:
>   * Built with clang 9 and g++ 8.3
>   * `make check` run with clang 9 build 
>   * Verified:
>     * QEMU_STRACE/-strace still works for linux-user
>   * `make vm-build-netbsd EXTRA_CONFIGURE_OPTS="--disable-system" \
>      BUILD_TARGET="all"` passed.
> 
> Josh Kunz (4):
>   linux-user: Use `qemu_log' for non-strace logging
>   linux-user: Use `qemu_log' for strace
>   linux-user: remove gemu_log from the linux-user tree
>   bsd-user: Replace gemu_log with qemu_log
> 
>  bsd-user/main.c           |  29 ++-
>  bsd-user/qemu.h           |   2 -
>  bsd-user/strace.c         |  32 ++-
>  bsd-user/syscall.c        |  31 ++-
>  include/qemu/log.h        |   2 +
>  linux-user/arm/cpu_loop.c |   5 +-
>  linux-user/fd-trans.c     |  55 +++--
>  linux-user/main.c         |  39 ++--
>  linux-user/qemu.h         |   2 -
>  linux-user/signal.c       |   2 +-
>  linux-user/strace.c       | 479 +++++++++++++++++++-------------------
>  linux-user/syscall.c      |  48 ++--
>  linux-user/vm86.c         |   3 +-
>  util/log.c                |   2 +
>  14 files changed, 387 insertions(+), 344 deletions(-)
> 

Applied patches 1 to 3 to my linux-user branch.

Thanks,
LAurent

