Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8008C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6F62075B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6F62075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irIDS-0006d1-LI
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irICl-000624-Cf
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irICh-0001AC-Cz
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:09:43 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54873)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irICf-00019Y-NY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:09:39 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYvoW-1jDPZC0CgK-00Unvs; Tue, 14 Jan 2020 10:09:22 +0100
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200114030138.260347-1-jkz@google.com>
 <20200114030138.260347-3-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/4] linux-user: Use `qemu_log' for strace
Message-ID: <af635ec8-b1a7-30c3-958a-6fdb0ab8d202@vivier.eu>
Date: Tue, 14 Jan 2020 10:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114030138.260347-3-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:76V9oGSDL8xkN1On4ZOPhIlqgdLWRKR0oaXtkgCcBx8Ffccb2Op
 WtaRlCWqMeFMZ0MpRLEHsosQIXNShU8IEspdwxx0eWNMbXUJ4W2OXyk6JKMO4rUNT9sYuXE
 wfp3jH45R2shaK819gv3Z/oct1Z0uf4EfDBOtVA4/f2tHxdkBjwYZLO0Jgb5DLIw//y/S7E
 IDoEHss80H8YbVdd2GbYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F0ULjIc0EA0=:aqUtkNzeejbgkDWf9z9/4o
 Ico1En2cww1GJGjOT60bzpfU1ELvMhB065Awur0lvEdLDrx+N6H3yDLp1b1RSM9oj+euD4HGc
 B7qv2W/jSQhKijBjSHMSvbIcEMdU4As4aWbI18vohGXivfo9tSq1FRz6wKj8ynNKpHtZ90wtN
 V0t4RwAPEmNm9nIlyOxFyxyliRqZwqj2frs83ax8gNXy0/lKjgmNiXAg3rjM7rcrlMG1LFS8P
 N/ngssFMWmts8TBA/9KuXpVE91EDMw1z2u8VBuswXMPpqgMfGrJAUFqnm8jaZOoVCFLtGHjdo
 gmJAkqtxgNHciO7IKv3tfyWdMadj+np1OpFojCK5z89qTmZDAoR638h7pJiHLYkPEqTqwFY3P
 h9EmYEj8ENUyKnQjc5lQuyacQ9XAY0khBjs/fH9EVaMhSHflFDOfB4oIpAcWebs11chwOBNku
 hAAYYwcLFrVRL0lgKuCbJcWpkiBwjUaGABLkADjL7/u8X8nnCgZ6/pDEbKLcSi0vxwKSWJRG+
 2biYbRBt6q7Qm8YYWHb2ddgOOxraolBJkUqMqmPOPlui2051dh42KtyScXPfJR1Rg8tDo7x/I
 pFKJraHiq0OBhoTEQWJET7N2k3fXZI8cXE4fy7UyjjQO9lO/3gbZ0H2RCMW+wjRv4FFRX6Pwi
 R8kgHV1DOtw9ZFN5HYny//XAIzBL+AbxJyrqHqwKl6pu3DP0m0EX4vvlmKGy7HX82LJrAQ0QW
 yFDl5uC4Qphg4T3hkH3qMlEOQVKPt9qwKPiW92Lg7Sc0fWmW3+NAvIi+yNCq6StdJlOu54KAN
 7tyo0ydFb+8q4r5IwJOxAYj9AvuE4JetfFQ46kNIvsdwzXHaqtPPNL2d1dddVbWfwI/RKR1SQ
 TI7TZT9ocmD6uO5Ocm5v+YV5ex988Zzy3mKD/8uDo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, riku.voipio@iki.fi,
 alex.bennee@linaro.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/01/2020 à 04:01, Josh Kunz a écrit :
> This change switches linux-user strace logging to use the newer `qemu_log`
> logging subsystem rather than the older `gemu_log` (notice the "g")
> logger. `qemu_log` has several advantages, namely that it allows logging
> to a file, and provides a more unified interface for configuration
> of logging (via the QEMU_LOG environment variable or options).
> 
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  include/qemu/log.h   |  13 ++
>  linux-user/main.c    |  17 +-
>  linux-user/qemu.h    |   1 -
>  linux-user/signal.c  |   3 +-
>  linux-user/strace.c  | 479 ++++++++++++++++++++++---------------------
>  linux-user/syscall.c |  13 +-
>  util/log.c           |   2 +
>  7 files changed, 282 insertions(+), 246 deletions(-)
> 
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index 503e4f88d5..8f044c1716 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -64,6 +64,7 @@ static inline bool qemu_log_separate(void)
>  #define CPU_LOG_PLUGIN     (1 << 18)
>  /* LOG_USER is used for some informational user-mode logging. */
>  #define LOG_USER           (1 << 19)
> +#define LOG_STRACE         (1 << 20)

Perhaps we can use flag LOG_TRACE? (cc Paolo)

>  
>  /* Lock output for a series of related logs.  Since this is not needed
>   * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
> @@ -154,6 +155,18 @@ void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
>  bool qemu_log_in_addr_range(uint64_t addr);
>  int qemu_str_to_log_mask(const char *str);
>  
> +/* Add (union) the given "log_flags" to the current log mask. */
> +static inline void qemu_add_log(int log_flags)
> +{
> +    qemu_set_log(qemu_loglevel | log_flags);
> +}

This is really a special case as the flags are all given at the same
time, could you use directly qemu_set_log() in main()?

> +/* Remove (subtract) the given log flags from the current log mask. */
> +static inline void qemu_del_log(int log_flags)
> +{
> +    qemu_set_log(qemu_loglevel & ~(log_flags));
> +}

Unused and unneeded.

Except that, the patch seems good.

Thanks,
Laurent

