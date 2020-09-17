Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E9BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62EB8221EE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EB8221EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyog-0001i8-E3
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIynV-0000Q9-RD; Thu, 17 Sep 2020 14:38:21 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIynT-00026n-H1; Thu, 17 Sep 2020 14:38:21 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M6ltQ-1kQ8Ss2WJK-008IV6; Thu, 17 Sep 2020 20:38:08 +0200
Subject: Re: [PATCH V3 04/10] scripts/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200917075029.313-1-zhaolichang@huawei.com>
 <20200917075029.313-5-zhaolichang@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8aff0726-da41-1af1-cfc0-bb8337bf51f1@vivier.eu>
Date: Thu, 17 Sep 2020 20:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917075029.313-5-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Eee1YnGsFN1q1+mq6B5Tngc4S1lmTRb3hl2ouolIoNWCTw1UhWx
 zvvy76+k4QxFNhxnExhSWBmfbNk8QyRlsKDhrVWXTK4OpaA/kHNKF3pFBQOxtYQ7w+WxuTb
 Qurt2u8Srq9TvP4QsIdx7rJ3Gt2VbDUIWBM3zaBSWSR5xeoG7quzohMjHGGTLbWDyeGSdbu
 fzVZFcOtq8zBbAq63QJdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EbLzqQwD/lA=:SJUlqMgXTQ8atkaG6Elutb
 RIDUr3K1eYVtOOQ2bJ+aXXrky8brtJqyWB4FFbRn/bVPLUloQvL16t1Q2gNzmr0kqB5sZkgYS
 6AzrggDdh3S44V10Ar3s1vCwnnNN0m5vfIW/LEoLdNO5X1hCpWAdnveA2ehdTKoyIqLRDPpji
 HxDED9gxayjnHB4I8Dkua5Y47QFgMjesTa/JCX3BgFLMNJy/3ZokrFLnjsmJSiQSoeQHUSOij
 iJcg7ZESGZjaCrT8Ew2HTgJJZKzJ0KDS7ZnhNfbjvBq17tN6lphwHDEPNqxobtDl8bg5zdjvs
 PCoIL7SWP6UHhS+yF40j6IL36++Ghclt43YC0qlbQG0wZFCWu+1E+ngybfpJj0rBOX3UvZihc
 pJK/M40Z65rl58E9VaQXkhTaglBLXU9ZbC/5bRAlu7tQKkisfxgicso8tX0jrT3f/CZTTA7Iu
 8OWCmBU1gYyGy4cDAXaSghfsQepEtIRSSesj0mrKZZEbOF+7xdVFsrBeuQlJd8m3wkHs9c7kR
 TCvygQDDVXwh2mLyLXte8oSjp2y29KexNQwIjVJVHnFjDN3kw61ZzFd4uxjU3FFMUyZb6Eb6l
 ko9erwR0WdwAj066AjxpQJ8K7CuA+qsQQdjIQG2TQ/yaPMsYGmMmRIAu6aC+LF6oDwqBIFdD4
 45K6IONasm/cZYyQpQAMLc6CcUtCM9LNhajuDf8MiAF182Gvs3RqbF+CRq067fMgEvnOFxTgQ
 4XEbbmIQig10oyGaoBEoCAdjahzd02r2j7X2dPRKHJDzImfgsRmbCNTkIt+7S+o9LXXVyA4Hn
 7nvAdbMmfBcpepx1J1mX0PQT19OL1t4zJurVZUyuGalIw/GntacIHJ7V/q4xP5RTcQvH83h
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 14:38:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/09/2020 à 09:50, zhaolichang a écrit :
> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the scripts folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/checkpatch.pl          | 2 +-
>  scripts/clean-header-guards.pl | 2 +-
>  scripts/decodetree.py          | 6 +++---
>  scripts/oss-fuzz/build.sh      | 2 +-
>  scripts/tracetool/__init__.py  | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bd3faa154c..50910899f2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1870,7 +1870,7 @@ sub process {
>  			substr($s, 0, length($c), '');
>  
>  			# Make sure we remove the line prefixes as we have
> -			# none on the first line, and are going to readd them
> +			# none on the first line, and are going to re-add them
>  			# where necessary.
>  			$s =~ s/\n./\n/gs;
>  
> diff --git a/scripts/clean-header-guards.pl b/scripts/clean-header-guards.pl
> index f47d673ad5..a6680253b1 100755
> --- a/scripts/clean-header-guards.pl
> +++ b/scripts/clean-header-guards.pl
> @@ -19,7 +19,7 @@
>  # Does the following:
>  # - Header files without a recognizable header guard are skipped.
>  # - Clean up any untidy header guards in-place.  Warn if the cleanup
> -#   renames guard symbols, and explain how to find occurences of these
> +#   renames guard symbols, and explain how to find occurrences of these
>  #   symbols that may have to be updated manually.
>  # - Warn about duplicate header guard symbols.  To make full use of
>  #   this warning, you should clean up *all* headers in one run.
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index c02de9865b..60fd3b5e5f 100644
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -94,7 +94,7 @@ def str_indent(c):
>  
>  
>  def str_fields(fields):
> -    """Return a string uniquely identifing FIELDS"""
> +    """Return a string uniquely identifying FIELDS"""
>      r = ''
>      for n in sorted(fields.keys()):
>          r += '_' + n
> @@ -814,7 +814,7 @@ def parse_generic(lineno, parent_pat, name, toks):
>      arg = None
>      fmt = None
>      for t in toks:
> -        # '&Foo' gives a format an explcit argument set.
> +        # '&Foo' gives a format an explicit argument set.
>          if re.fullmatch(re_arg_ident, t):
>              tt = t[1:]
>              if arg:
> @@ -903,7 +903,7 @@ def parse_generic(lineno, parent_pat, name, toks):
>      elif not (is_format and width == 0) and width != insnwidth:
>          error(lineno, 'definition has {0} bits'.format(width))
>  
> -    # Do not check for fields overlaping fields; one valid usage
> +    # Do not check for fields overlapping fields; one valid usage
>      # is to be able to duplicate fields via import.
>      fieldmask = 0
>      for f in flds.values():
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index d16207eb67..0c3ca9e06f 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -69,7 +69,7 @@ mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
>  
>  if ! make "-j$(nproc)" qemu-fuzz-i386; then
>      fatal "Build failed. Please specify a compiler with fuzzing support"\
> -          "using the \$CC and \$CXX environemnt variables"\
> +          "using the \$CC and \$CXX environment variables"\
>            "\nFor example: CC=clang CXX=clang++ $0"
>  fi
>  
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index 3ccfa1e116..3ee54be223 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -34,7 +34,7 @@ def error(*lines):
>  def out(*lines, **kwargs):
>      """Write a set of output lines.
>  
> -    You can use kwargs as a shorthand for mapping variables when formating all
> +    You can use kwargs as a shorthand for mapping variables when formatting all
>      the strings in lines.
>      """
>      lines = [ l % kwargs for l in lines ]
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


