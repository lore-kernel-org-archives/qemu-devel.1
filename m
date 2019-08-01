Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B52C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F6F2084C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvhsXrh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F6F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htGzW-0000Px-Ig
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htGxq-0007Yy-Ag
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htGxp-0007lB-9h
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:42:14 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htGxm-0007jp-Oh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:42:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id r1so34640108pfq.12
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ledcoNNfQ5hd1Tjl5R5fjn7yMdh37Q5ksHeGD610sVw=;
 b=fvhsXrh+44KSvCtPFB4oxose0sfhi6lCMm32wMkig0Yf0FQfv7bRs0g6f3+CFSabGc
 lLfan56a3dLOeepO2lVcq7ruk+hYwi5DrvsIUJtgoTxnMotFGnXiR35vC8WTstkKEf6m
 vUn1wIx96nBjmD2+PDKiwhVgZgy0pYmYep8TnxX23e/2o9Zb7zLWHPMSjYUuUvl2hPwa
 YB9m0sRoNOPNkiYNHOpDZIvcZC4KmpCIRio9KcCWGwX71mF0vFDPxEI662N1rqJxJDqe
 eWEmcJ+rNprejWM8MOYcg7ud5mwq3Rm3Y/S7iN0rrs47F3MCL6r2fl04sfrQwGH/7O5A
 t33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ledcoNNfQ5hd1Tjl5R5fjn7yMdh37Q5ksHeGD610sVw=;
 b=OUetmnpmO4rxYHgR+cCM/jaYu4iZAGZfE+EXwwGeQHrc/aEGYRtWkO514yiLrIlBVj
 xEypbun3Kx/GJKGtnC2ikpeXWSNKoDeuzCo8Ft1NnMulDMwk1wLQ+c5y6irTPkb/kluo
 moUsLc/cf6b1YWGWA1EsSem9AKO7MHo83XmIJEVaz5HCKLUXaF81JqFtcMo/DVPvAyMS
 Ixh+XP3HsSpkC/ORh1J26yHV+Iu7WvDGBACYAk+zXJjyMmgwUmcUZgGGwCGyw880ZBlg
 Yx7L2LT1yY9+8y2E1gTwmwcz9oWyRX0HXnTw6IqICgnWzHKzY/YRJ4JhZn48c3HZRN9F
 e/OA==
X-Gm-Message-State: APjAAAU4vT3XibIUMVPrem4sf9WFCWPy9QJbdxFGdgwaBBMji6/Rnv64
 zYpsMO4rzoKalgiUdawqhRZFqg==
X-Google-Smtp-Source: APXvYqz/sG8ucCLcXi9YaAgnksCH2r9NkDuJzUGQhhO0Hec3o/MPS6I1HHA4sKXlx40MMBHqm3ZX5A==
X-Received: by 2002:a63:5648:: with SMTP id g8mr4433427pgm.81.1564688529116;
 Thu, 01 Aug 2019 12:42:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s7sm4665788pjn.28.2019.08.01.12.42.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 12:42:08 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-44-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1f317f65-289d-659b-735b-d527908140f8@linaro.org>
Date: Thu, 1 Aug 2019 12:42:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-44-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v4 43/54] plugin: add API symbols to
 qemu-plugins.symbols
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:07 AM, Alex Bennée wrote:
> +#########################################
> +# See if --dynamic-list is supported by the linker
> +
> +cat > $TMPTXT <<EOF
> +{
> +  foo;
> +};
> +EOF
> +
> +cat > $TMPC <<EOF
> +#include <stdio.h>
> +void foo(void);
> +
> +void foo(void)
> +{
> +  printf("foo\n");
> +}
> +
> +int main(void)
> +{
> +  foo();
> +  return 0;
> +}
> +EOF
> +
> +ld_dynamic_list="no"
> +if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
> +  ld_dynamic_list="yes"
> +fi
> +
> +#########################################
> +# See if -exported_symbols_list is supported by the linker
> +
> +cat > $TMPTXT <<EOF
> +  _foo
> +EOF
> +
> +ld_exported_symbols_list="no"
> +if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
> +  ld_exported_symbols_list="yes"
> +fi
> +
> +if  test "$plugins" = "yes" &&
> +    test "$ld_dynamic_list" = "no" &&
> +    test "$ld_exported_symbols_list" = "no" ; then
> +  error_exit \
> +      "Plugin support requires specifying a set of symbols that " \
> +      "are exported to plugins. Unfortunately your linker doesn't " \
> +      "support the flag (--dynamic-list or -exported_symbols_list) used " \
> +      "for this purpose."
> +fi
> +
>  ########################################
>  # See if 16-byte vector operations are supported.
>  # Even without a vector unit the compiler may expand these.
> @@ -7318,6 +7371,22 @@ fi
>  if test "$plugins" = "yes" ; then
>      echo "CONFIG_PLUGIN=y" >> $config_host_mak
>      LIBS="-ldl $LIBS"
> +    # Copy the export object list to the build dir
> +    if test "$ld_dynamic_list" = "yes" ; then
> +	echo "CONFIG_HAS_LD_DYNAMIC_LIST=yes" >> $config_host_mak
> +	ld_symbols=qemu-plugins-ld.symbols
> +	cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols
> +    elif test "$ld_exported_symbols_list" = "yes" ; then
> +	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=yes" >> $config_host_mak
> +	ld64_symbols=qemu-plugins-ld64.symbols
> +	echo "# Automatically generated by configure - do not modify" > $ld64_symbols
> +	grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed 's/;//g' | \
> +	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
> +    else
> +	error_exit \
> +	    "If \$plugins=yes, either \$ld_dynamic_list or " \
> +	    "\$ld_exported_symbols_list should have been set to 'yes'."
> +    fi
>  fi
>  

How much of this should be skipped if --enable-static?
Or perhaps just dependent on --enable-plugins and let
that switch detect the conflict?


r~


