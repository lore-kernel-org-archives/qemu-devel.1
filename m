Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39245C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 20:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA152054F
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 20:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHWgVOz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA152054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCqfi-00019R-5c
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 16:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCqep-0000iQ-6V
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 16:44:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCqel-0005X7-7c
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 16:44:02 -0400
Received: by mail-pf1-x444.google.com with SMTP id f18so1316584pfa.10
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ze6htxbaSCIVkzRP7sFcFMNAbxMfwQybCVuTdLntVyg=;
 b=UHWgVOz29X1GodXvsHAGEZ7cRTDoX5SoSQ3D2AMDeZiahzEjcBUIts7vu3KCjCuAeY
 c37q81nJlBotWOkc0ynVtrkR5+oiYx4RAhvxkKzaMoy5gRnxm1se+Zt95dklVIirCY7q
 hxQGSrqaCJvVihGnbUEs3eDC60d+xsaKK/N1/A6TRUkG4ImIRM06RJFlXkvugQRzkv3l
 JZxCxQq96tLn5q/hDTmspjdyoQKSFdCcpqhdqWufitfNDdwABDooLpBUCXmF/dQtZVNO
 lUAUJIzH09H7naIXzAt8HIvrVRS8wJr/MOqGrxBYWWrjC9j51h8gwjP/6nRm/07PHPFs
 BY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ze6htxbaSCIVkzRP7sFcFMNAbxMfwQybCVuTdLntVyg=;
 b=e2bCH1rz498ppYwgIyXe0glm5+BTggNbzgfju85r7C/+YQ6NV1OL5s4xC+R5zU6aNK
 mnQBDjOmx6HSSc/MBYDpWKNZGF/VNNVX6QthbObbB92CnB0i8+kjNVLG/saavM4AAs2h
 X/atf0ZTxMW9G+aRddPavu9GF4aCFe9zsn4oCB+DbIyh/FBlmf8UOXeeP9VKk8dpSMKQ
 brMy7dufPlOMMxumUcdPrKrQDA/Zlpepf5Bx0LbUr6N3HZ/BVD8GZhMI+lvKul0myLgm
 oYYXU74Q+TcQNel9ArwDYuzRCFyhpVUBwTrNnohkmzvhtfbXzQwVV5Rn6ndKubWw89aQ
 Pteg==
X-Gm-Message-State: AOAM533DX1giyiDd+mD9JCsPSNTJO8QmbtMYGpTf0MkubMkS3hr+Blm6
 nlf7j5mdNzanzy56por2Cs4MWw==
X-Google-Smtp-Source: ABdhPJxNGo2qGEwaywx0SPi/PuR2aT4XKzdBmfFREJiemJV07ejo2LsIRJ0XgzT/Fzocx7tSSkuQbg==
X-Received: by 2002:a62:7a97:: with SMTP id v145mr2629506pfc.19.1598906637405; 
 Mon, 31 Aug 2020 13:43:57 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id in12sm461807pjb.29.2020.08.31.13.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 13:43:56 -0700 (PDT)
Subject: Re: [RFC PATCH v3 00/34] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <fbb5a85b-6208-1791-0d3e-7e741e674a70@linaro.org>
 <BYAPR02MB48862BC00AD7217B715EBFC7DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <78e5b8be-e7f4-a1b9-2810-e0855da23f00@linaro.org>
 <BYAPR02MB488699D87ED9C3ADBCF155BADE510@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97b529f8-6dff-8cd1-bed2-5ce450fe4b64@linaro.org>
Date: Mon, 31 Aug 2020 13:43:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488699D87ED9C3ADBCF155BADE510@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/31/20 10:57 AM, Taylor Simpson wrote:
> OK, here's the list of items.  Let me know if I missed anything.  I'll 
> indicate which ones can be done quickly and which ones would take more time.
> I added a column for blocker if you or anyone else has input on that.
> 
> PatchItemEffortBlocker
> Use qemu softfloat??Yes

Hmm, this table didn't render.  Below, yes/no for blocker column.

> Use qemu decodetree.py??

no

> SeveralUse const when appropriatesmall

yes

> SeveralRemove anything after g_assert_not_reachedsmall

yes

> SeveralFix log_store32/64 add/remove/add in patch seriessmall

yes

> SeveralFollow naming guidelines for structs and enumssmall

yes

> 04Move decls to cpu-param.hsmall

Yes.  The only reason this even compiled is that you don't do system mode yet.  ;-)

> 04Remove CONFIG_USER_ONLY ifdef'ssmall

yes

> 04Remove DEBUG_HEXAGONsmall

yes

> 04Remove stack pointer modification hack, use qemu mechanismsmall

yes

> 04Add property x-lldb-compat to control output in logsmall

yes

> 06Include instruction and raw bytes in disassemblysmall

yes

> 07Use DEF_HELPER_FLAGSsmall

no, but should be easy.

> 07, 26Endianness of merge_bytessmall

Yes, one way or another; hopefully by removing all of the merge_bytes and using
probe_read.

> 07Fix overlap testsmall

yes

> 07Remove HELPER(debug_value)/HELPER(debug_value_i64)small

yes

> 09Include "qemu/osdep.h" instead of <stdint.h>small

yes

> 10 (and others)Stick with stdint.h types except in imported filessmall

yes

> 11Remove description from reg field definitionssmall

yes

> 13Move regmap.h into decode.csmall

yes

> 14, 27Use bit mask instead of strings in decodingsmall

no, but should be easy.

> 14Add comments to decodersmall

yes

> 16Use qemu/int128.hmedium

no

> 17Squash patches dealing with imported filessmall

yes

> 24Use qemu/bitops.h for instruction attributessmall

no

> 24Fix initialization of opcode_short_semanticssmall

yes

> 24Change if (p == NULL) { g_assert_not_reached(); } to assert(p != NULL)small

no

> 25Expand DECL/READ/WRITE/FREE macros into generated codesmall

Yes.

In the end I think some of these will in the end want to be helper functions.
As I was thinking how to best write A2_add, I was thinking

/* TODO: You currently have an "offset" parameter to
   DECL_REG.  I can't see that it is ever used?
   I would *hope* that this could be resolved earlier,
   so that by this time insn->regno[*] is absolute.  */
static int resolve_regno(Insn *insn, int slot, int off);

/* Return hex_new_value[regno]; log the write. */
static TCGv reg_for_write(DisasContext *ctx, int regno);

/* Return hex_reg[regno]; force up-to-date value for PC. */
static TCGv reg_for_read(DisasContext *ctx, int regno);

/* if (preg) hex_new_value[regno] = hex_reg[regno],
   or !preg if !test_positive.
   Leaves hex_new_value[] canonical for gen_reg_writes,
   no extra temporary required. */
static void gen_cancel_reg(DisasContext *ctx, int preg,
                           int rreg, bool test_positive);

DEF_TCG_FUNC(A2_add)
{
    int rd = resolve_regno(insn, 0, 0);
    int rs = resolve_regno(insn, 1, 0);
    int rt = resolve_regno(insn, 2, 0);

    tcg_gen_add_tl(reg_for_write(ctx, rd),
                   reg_for_read(ctx, rs),
                   reg_for_read(ctx, rt));
}

DEF_TCG_FUNC(A2_paddit)
{
    int pu = resolve_regno(insn, 0, 0);
    int rd = resolve_regno(insn, 1, 0);
    int rs = resolve_regno(insn, 2, 0);
    int rt = resolve_regno(insn, 3, 0);

    tcg_gen_add_tl(reg_for_write(ctx, rd),
                   reg_for_read(ctx, rs),
                   reg_for_read(ctx, rt));
    gen_cancel_reg(ctx, insn, rd, pu, true);
}

However, I don't think we have to have a comprehensive set of these now.  We
can expand everything into the generator to start, then adjust the generator as
we add helper functions and use them within the overrides.

> 26Rewrite fINSERT*, fEXTRACT*, f?XTN macrossmall

yes

> 26Investigate fRND macrosmall

no, but should be easy.

> 26Change REG = REG to (VOID)REG to suppress compiler warningsmall

yes

> 27Remove multiple includes of imported/iclass.defsmall

yes

> 28Move genptr_helpers.h into genptr.csmall

yes

> 28Remove unneeded tempssmall

no

> 28Use tcg_gen_deposit_tl and tcg_gen_extract_tl when dealing with p3_0small

no

> 29Size opcode_genptr[] properly and initialize with [TAG] = generate_##TAGsmall

yes; i think this will fall out of other changes.

> 30Don't generate helpers for instructions that are overriddensmall

yes

> Don't include "gen_tcg.h" in helper.h

yes

> 31Use bitmask for ctx->reg_log instead of an arraysmall

yes

> 31Use tcg_gen_extract_i32 for gen_slot_cancelled_checksmall

yes

> 31Properly deal with reading instructions across a page boundary and toomedium
> many instructions before finding end-of-packet

Yes, this should be easy.  Unless there's some surprise in the code I have
already suggested code.

> 31Don't set PC at the beginning of every packetmedium

no

> 31Don't set slot_cancelled unless neededsmall

no

> 31Don't set hex_pred_written unless neededmedium

no

> 31Change cancelled variable to not localsmall

yes

> 31Remove unnecessary tempsmall

yes

> 31Let tcg_gen_addi_tl check for zerosmall

yes

> 31Move gen_exec_counters to end of TB instead of every packetmedium

no

> 31Move end of TB handling to hexagon_tr_tb_stopsmall

yes


r~

