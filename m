Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9804C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4A220789
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIoEY8I0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4A220789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNEhQ-0003D8-0D
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNEeQ-0000vM-Cj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:22:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNEeN-0006Gq-Id
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:22:33 -0400
Received: by mail-wr1-x443.google.com with SMTP id k15so5130067wrn.10
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TgqXiOB6xbvznaSSkEP9xgsd0/91yoqfXZsMzuwKTxg=;
 b=AIoEY8I0Vnvx9ab5zV5qFmao0/dvzkcycMkCGCdvFt3/mFvRgVZ+yJVp+BHTG+h+Op
 2cz3pNplvu6i5HroZ/udn0r1hn2aNttf0Fc7s8/k7HesvUXYjjx7cmz8KG5j8Bn0bc+8
 5+FoFRC0+H98cYIV8z+dzWsXapy8iCx5HNnyLmQLfYzxEyvV1qfZeKHXvNtwi0W3jNnQ
 iBnXnaTXhNEQNeAeiKG9EfhtlkiI29aosGC8wvpfoR1jzRSNFMhv1T+3f4kq7vbZP6ei
 cvez+LFEXBp40nk/LtVuQ+aMWE1BTGwgyyOrRpoTSHBFTPMX2aX9CZlDgMMXZ+0QM2jK
 lQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TgqXiOB6xbvznaSSkEP9xgsd0/91yoqfXZsMzuwKTxg=;
 b=MVpOtejFm8LcncztgVqgcXONtbwLxlpGKl5u9AlvZaBuhtDwGubOCJZuEC+9abYBMw
 I4W+cjvDGqZIbvpSLcyVHkUEN8quyvM5WgWhPK0JdzROEIoQA/fMSl/iCnCn5mLRS6qB
 9wtAQuT4h1Lwrin+pXx+PxL0K3cU4z8v2t+hErGfMcAFr9gxGI9YSvS2QBP2TSEss+w/
 Y+IMtfBXYHdg6VI8rj5yE873KM9Mr7PFAlfl+3yGzV/bOaVlnuDpH3+ETpmP1IiJJIIJ
 zFJPOkRs5IrhMgkSRGh/u7f4OMSereWiBG1xMMAW8sC1tDoB4VCcGwV5Z7khf4F7T6AL
 O3LQ==
X-Gm-Message-State: AOAM531EySFXCXMIoO9gCuljcG+IQT0eVrtHLqgOyHHqeTahvOzJ960v
 O2Iwu7iBMKWya/g4b6yAXAg=
X-Google-Smtp-Source: ABdhPJzwoguMek7FVhYk3fpyQBisDjl/tJ2wxR+sixkgyYcWpYDpyIyawXmqUy1jfPrzngDA4M2qjg==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr4162232wrl.54.1601382149684;
 Tue, 29 Sep 2020 05:22:29 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id b11sm5693950wrt.38.2020.09.29.05.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 05:22:29 -0700 (PDT)
Subject: Re: [RFC PATCH v4 00/29] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c4307aa4-f194-a02f-a4db-90b546a6024a@amsat.org>
Date: Tue, 29 Sep 2020 14:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Taylor,

On 9/28/20 7:28 PM, Taylor Simpson wrote:
> This series adds support for the Hexagon processor with Linux user support
> 
> See patch 02/34 Hexagon README for detailed information.
> 
> Once the series is applied, the Hexagon port will pass "make check-tcg".
> The series also includes Hexagon-specific tests in tcg/tests/hexagon.
> 
> The series is also available at https://github.com/quic/qemu on branch
> small_series_v4.
> 
> We have a parallel effort to make the Hexagon Linux toolchain publically
> available.
> 
> *** Known checkpatch issues ***
> 
> The following are known checkpatch errors in the series
>     target/hexagon/reg_fields.h         Complex macro
>     target/hexagon/attribs.h            Complex macro
>     target/hexagon/decode.c             Complex macro
>     target/hexagon/q6v_decode.c         Macro needs do - while
>     target/hexagon/printinsn.c          Macro needs do - while
>     target/hexagon/gen_semantics.c      Suspicious ; after while (0)
>     target/hexagon/gen_dectree_import.c Complex macro
>     target/hexagon/gen_dectree_import.c Suspicious ; after while (0)
>     target/hexagon/opcodes.c            Complex macro
>     target/hexagon/iclass.h             Complex macro
>     configure.sh                        Line over 90 characters
>     scripts/qemu-binfmt-conf.sh         Line over 90 characters
> 
> The following are known checkpatch warnings in the series
>     target/hexagon/fma_emu.c            Comments inside macro definition
>     target/hexagon/gen_tcg_funcs.py     Line over 80 characters
>     scripts/qemu-binfmt-conf.sh         Line over 80 characters

Using '../configure' '--target-list=hexagon-linux-user' '--disable-docs'
'--disable-tools' on Fedora 32 I am getting:

In file included from target/hexagon/op_helper.c:24:
target/hexagon/helper_funcs_generated.h: In function ‘helper_S2_vspliceib’:
target/hexagon/helper_funcs_generated.h:9669:50: error: ‘*’ in boolean
context, suggest ‘&&’ instead [-Werror=int-in-bool-context]
 9669 |     { RddV = fASHIFTL(RttV,uiV*8,8_8) | fZXTN(uiV*8,64,RssV); }
target/hexagon/macros.h:234:28: note: in definition of macro ‘fZXTN’
  234 | #define fZXTN(N, M, VAL) ((N) ? extract64((VAL), 0, (N)) : 0LL)
      |                            ^
target/hexagon/helper_funcs_generated.h: In function ‘helper_S2_vsplicerb’:
target/hexagon/helper_funcs_generated.h:9677:58: error: ‘*’ in boolean
context, suggest ‘&&’ instead [-Werror=int-in-bool-context]
 9677 |     { RddV = fASHIFTL(RttV,(PuV&7)*8,8_8) |
fZXTN((PuV&7)*8,64,RssV); }
target/hexagon/macros.h:234:28: note: in definition of macro ‘fZXTN’
  234 | #define fZXTN(N, M, VAL) ((N) ? extract64((VAL), 0, (N)) : 0LL)
      |                            ^
cc1: all warnings being treated as errors
make: *** [Makefile.ninja:633:
libqemu-hexagon-linux-user.fa.p/target_hexagon_op_helper.c.o] Error 1

target/hexagon/decode.c:45:31: error: ‘DECODE_REGISTER_V__16’ defined
but not used [-Werror=unused-const-variable=]
   45 |     static const unsigned int DECODE_REGISTER_##NAME[ELEMENTS] = \
      |                               ^~~~~~~~~~~~~~~~
target/hexagon/decode.c:55:1: note: in expansion of macro ‘DEF_REGMAP’
   55 | DEF_REGMAP(V__16, 16, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22,
24, 26, 28, 30)
      | ^~~~~~~~~~
target/hexagon/decode.c:45:31: error: ‘DECODE_REGISTER_V__8’ defined but
not used [-Werror=unused-const-variable=]
   45 |     static const unsigned int DECODE_REGISTER_##NAME[ELEMENTS] = \
      |                               ^~~~~~~~~~~~~~~~
target/hexagon/decode.c:54:1: note: in expansion of macro ‘DEF_REGMAP’
   54 | DEF_REGMAP(V__8,  8,  0, 4, 8, 12, 16, 20, 24, 28)
      | ^~~~~~~~~~
target/hexagon/decode.c:45:31: error: ‘DECODE_REGISTER_R_8’ defined but
not used [-Werror=unused-const-variable=]
   45 |     static const unsigned int DECODE_REGISTER_##NAME[ELEMENTS] = \
      |                               ^~~~~~~~~~~~~~~~
target/hexagon/decode.c:53:1: note: in expansion of macro ‘DEF_REGMAP’
   53 | DEF_REGMAP(R_8,   8,  0, 1, 2, 3, 4, 5, 6, 7)
      | ^~~~~~~~~~
target/hexagon/decode.c:45:31: error: ‘DECODE_REGISTER_R_8S’ defined but
not used [-Werror=unused-const-variable=]
   45 |     static const unsigned int DECODE_REGISTER_##NAME[ELEMENTS] = \
      |                               ^~~~~~~~~~~~~~~~
target/hexagon/decode.c:52:1: note: in expansion of macro ‘DEF_REGMAP’
   52 | DEF_REGMAP(R_8S,  8,  0, 1, 2, 3, 16, 17, 18, 19)
      | ^~~~~~~~~~
target/hexagon/decode.c:45:31: error: ‘DECODE_REGISTER_R_4’ defined but
not used [-Werror=unused-const-variable=]
   45 |     static const unsigned int DECODE_REGISTER_##NAME[ELEMENTS] = \
      |                               ^~~~~~~~~~~~~~~~
target/hexagon/decode.c:51:1: note: in expansion of macro ‘DEF_REGMAP’
   51 | DEF_REGMAP(R_4,   4,  0, 1, 2, 3)
      | ^~~~~~~~~~
target/hexagon/decode.c:45:31: error: ‘DECODE_REGISTER_R__4’ defined but
not used [-Werror=unused-const-variable=]
   45 |     static const unsigned int DECODE_REGISTER_##NAME[ELEMENTS] = \
      |                               ^~~~~~~~~~~~~~~~
target/hexagon/decode.c:50:1: note: in expansion of macro ‘DEF_REGMAP’
   50 | DEF_REGMAP(R__4,  4,  0, 2, 4, 6)
      | ^~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [Makefile.ninja:638:
libqemu-hexagon-linux-user.fa.p/target_hexagon_decode.c.o] Error 1

$ gcc --version
gcc (GCC) 10.2.1 20200723 (Red Hat 10.2.1-1)

Regards,

Phil.

