Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29408C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46A720665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfLt3rUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46A720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOgu-0008If-Pc
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOOfp-00073A-SO
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:16:49 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOOfn-00016Y-Ot
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:16:49 -0400
Received: by mail-ot1-x342.google.com with SMTP id h17so2097093otr.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TIlz5u8StRwhLPT+BwCkla9BZgqpT5kFw3brQxVWEIo=;
 b=wfLt3rUyrvLyvA1Dc4Vs9AY5rDy+Lbfc24J/6YlphuTrGlhsVPWjj6ZmQC8hwnAU5d
 6sP7PZQ/La/knrme7wly2OiEABb/pYembnKQkrGhVgjwglxKmfV/JMEvMi5BV041DLD7
 gQo9cr8/2cXov43Baj/SxgDW52zNezqIENo47JCzhzUSFzc39jwoT6cFjF4xdtnuvj6C
 1tDfBzo/bMryZ+a3ZbXNMtBe1KyVYyvEkKoBI6i4VpNxNWhJwd4YYpa9RvKUqGXChUSM
 HLW3HG1I+flH5tDplxY61w3M+4dQlkAMKbD7YUdHoqYP0RYR+C/XG4spzYC6lr8iYsJK
 /54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TIlz5u8StRwhLPT+BwCkla9BZgqpT5kFw3brQxVWEIo=;
 b=CzGYLgvVL8E74wgBpXBiJJ4K550mJk7yWPhYZ1bicRU+GX0mbmcAGvNkcP6UJXMNFv
 dpCpS3v0iePZcDqRIP1uslz6s8KEJJ6Y61PQQo3iv5z8ijgYkjdmgOEvxiE45lzsMVXO
 GF1m3I9kPUcr1ZmLQRVvYJ3JxWJKQCGu73ccnIQzeUg/400j+cbNYDsMhrYiP6lctWpB
 QfT8akRRRW1U7sQnDZ8xgGZvswnYrvVoeVHT5rzSXxzGkhXvIq2nR8q2QxY3eYqqpDXV
 WnYDGGkoonsXTGhoVQGG0BBtbKxfCRbBTntD7xoB1fVFA+FX61grpxSs/jJcU5d5fzpa
 X98Q==
X-Gm-Message-State: AOAM5332zfJPwzI/Wl1pHFUnNbhdqaf48qKZfLA08qK1RzwZrvOkrqX3
 DKga7oh1m1Bw5MIFIA7SOkGvFQ==
X-Google-Smtp-Source: ABdhPJxZP3ejcREhCQJ/udSzYI/0BuL2NLMZWu8JouBJqApWA1e9MOoQCUnKEC1w4WyTproXKrigTg==
X-Received: by 2002:a9d:37c8:: with SMTP id x66mr2478336otb.290.1601659006443; 
 Fri, 02 Oct 2020 10:16:46 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id 187sm387145oie.42.2020.10.02.10.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 10:16:45 -0700 (PDT)
Subject: Re: [RFC PATCH v4 00/29] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6fb34615-46c3-5b4f-81c6-99b6b4c0c12b@linaro.org>
Date: Fri, 2 Oct 2020 12:16:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 12:28 PM, Taylor Simpson wrote:
> This series adds support for the Hexagon processor with Linux user support
> 
> See patch 02/34 Hexagon README for detailed information.
> 
> Once the series is applied, the Hexagon port will pass "make check-tcg".
> The series also includes Hexagon-specific tests in tcg/tests/hexagon.
> 
> The series is also available at https://github.com/quic/qemu on branch
> small_series_v4.

BTW, some whitespace warnings when applying this series.


r~


> Applying: Hexagon Update MAINTAINERS file
> Applying: Hexagon (target/hexagon) README
> .git/rebase-apply/patch:247: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: Hexagon (include/elf.h) ELF machine definition
> Applying: Hexagon (target/hexagon) scalar core definition
> Applying: Hexagon (disas) disassembler
> .git/rebase-apply/patch:87: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: Hexagon (target/hexagon) register names
> Applying: Hexagon (target/hexagon) scalar core helpers
> .git/rebase-apply/patch:431: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: Hexagon (target/hexagon) GDB Stub
> Applying: Hexagon (target/hexagon) architecture types
> Applying: Hexagon (target/hexagon) instruction and packet types
> Applying: Hexagon (target/hexagon) register fields
> .git/rebase-apply/patch:132: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: Hexagon (target/hexagon) instruction attributes
> .git/rebase-apply/patch:149: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: Hexagon (target/hexagon) instruction/packet decode
> Applying: Hexagon (target/hexagon) instruction printing
> .git/rebase-apply/patch:136: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: Hexagon (target/hexagon) utility functions
> .git/rebase-apply/patch:512: new blank line at EOF.
> +
> .git/rebase-apply/patch:887: new blank line at EOF.
> +
> .git/rebase-apply/patch:1670: new blank line at EOF.
> +
> warning: 3 lines add whitespace errors.
> Applying: Hexagon (target/hexagon/imported) arch import
> .git/rebase-apply/patch:598: space before tab in indent.
> 	  		fSETBYTE(i,RdV,fSATUB(fGETHALF(i,RssV)+fGETHALF(i,RttV)));
> .git/rebase-apply/patch:1329: space before tab in indent.
>  	 		 RdV = RsV;
> .git/rebase-apply/patch:6793: space before tab in indent.
>    	sys_icinva(thread, (REG),insn->slot);
> .git/rebase-apply/patch:7280: space before tab in indent.
>          		   fMPY16SS(fGETBYTE(1,RssV),fGETUBYTE(1,RttV)))));
> .git/rebase-apply/patch:7282: space before tab in indent.
>          		   fMPY16SS(fGETBYTE(3,RssV),fGETUBYTE(3,RttV)))));
> warning: squelched 41 whitespace errors
> warning: 46 lines add whitespace errors.
> Applying: Hexagon (target/hexagon) generator phase 1 - C preprocessor for semantics
> Applying: Hexagon (target/hexagon) generator phase 2 - generate header files
> Applying: Hexagon (target/hexagon) generator phase 3 - C preprocessor for decode tree
> Applying: Hexagon (target/hexagon) generater phase 4 - decode tree
> Applying: Hexagon (target/hexagon) opcode data structures
> Applying: Hexagon (target/hexagon) macros
> Applying: Hexagon (target/hexagon) instruction classes
> .git/rebase-apply/patch:141: new blank line at EOF.
> +
> .git/rebase-apply/patch:199: new blank line at EOF.
> +
> warning: 2 lines add whitespace errors.
> Applying: Hexagon (target/hexagon) TCG generation
> Applying: Hexagon (target/hexagon) TCG for instructions with multiple definitions
> Applying: Hexagon (target/hexagon) translation
> Applying: Hexagon (linux-user/hexagon) Linux user emulation
> .git/rebase-apply/patch:405: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: Hexagon (tests/tcg/hexagon) TCG tests
> .git/rebase-apply/patch:1314: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: Hexagon build infrastructure

