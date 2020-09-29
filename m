Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B620C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EED2206E5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLHIJpLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EED2206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDxm-00027P-5E
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNDwk-0001Hh-PC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:37:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNDwi-0007eY-Kt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:37:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id a9so4454570wmm.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OYtwunWcPC2jU6LO8ktX9co8oc8UiZ2GkZzFZD0kI9k=;
 b=uLHIJpLEASOdj5b97hMwPw+hdT12R5NztR5R8MXqnt9MIigci5lb8LOhkLGhM2XBY9
 6HwjdgpBRggDMxU31aSlhqNVvGigLb4nxXsODUGgavxx9V7AJrM8T56HBcGkGGz1caqD
 mica8+v/e64x0rY/Lv6Lm99rNWyrT2fSeR09wB7qsuPkBKNeIGtzNcGlJoilo/XdaFc9
 T6KDw1XI8dUPivS1iG1CM5Tko7hZJS1vaQsrATHAwiTpMWi3GSRmi8DA5mfbZbi6xCU5
 ocXJ+2PDaMJAyc4B2hjcTKYdIzNuC2tkacp5K3G4pJkmqMMFMK1C9c+UvkGTIuNug15T
 0YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OYtwunWcPC2jU6LO8ktX9co8oc8UiZ2GkZzFZD0kI9k=;
 b=VVyiQeK522oCj4f4jHKN+wTPkWwIsS0OXvfjhnsJLsHrVxlHlXZAwh2iCgfU9lB8+6
 CANS0h8kVkk6Tp81d3AWF4THibh5OpRWMfMfMtAdfzSYbC9OkvKH7NxRknnRw6qjY9UC
 fiontObrfhSq/JeB/ilBxlTpVeV4waMBZnmxv6dmY3E5eYp3JGZ5ujIgBW9d5jxFJrgm
 JRejkM5XhPBK0dbnlxtsEC1m+a85d1qTSP4sPVCG/AM6bi2z6IAExAtJ4Z/gi50A49ym
 otSZe+tJzLXmonuNIlqRDj6Mo8/IGcLL8RIB2BZpzGEFtvzbBpB9OqQ5tD5heJJZkaod
 IDcw==
X-Gm-Message-State: AOAM5322S5xK84WwSnqPlw7XC+i+yLL1TQ1Smk5ow9ccxlvhY7M0A+PT
 lpAHwLIFY6HwJ3LADt+nnIA=
X-Google-Smtp-Source: ABdhPJxSTDNvvoQCCOrXRbh3Ame7glQVOCOzMmjMIX7lAZwF1a6thDCqfriKzv/PctJy0fNQbVOyaw==
X-Received: by 2002:a7b:c307:: with SMTP id k7mr4279689wmj.31.1601379443052;
 Tue, 29 Sep 2020 04:37:23 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d5sm6052221wrb.28.2020.09.29.04.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 04:37:22 -0700 (PDT)
Subject: Re: [RFC PATCH v4 19/29] Hexagon (target/hexagon) generator phase 3 -
 C preprocessor for decode tree
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-20-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4da7010-474f-6df3-a74a-2966c44df931@amsat.org>
Date: Tue, 29 Sep 2020 13:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601314138-9930-20-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

On 9/28/20 7:28 PM, Taylor Simpson wrote:
> Run the C preprocessor across the instruction definition and encoding
> files to expand macros and prepare the iset.py file.  The resulting
> fill contains python data structures used to build the decode tree.
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  target/hexagon/gen_dectree_import.c | 191 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 191 insertions(+)
>  create mode 100644 target/hexagon/gen_dectree_import.c
> 
> diff --git a/target/hexagon/gen_dectree_import.c b/target/hexagon/gen_dectree_import.c
> new file mode 100644
> index 0000000..237726e
> --- /dev/null
> +++ b/target/hexagon/gen_dectree_import.c
> @@ -0,0 +1,191 @@
> +/*
> + *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * This program generates the encodings file that is processed by
> + * the dectree.py script to produce the decoding tree.  We use the C
> + * preprocessor to manipulate the files imported from the Hexagon
> + * architecture library.
> + */
> +#include "qemu/osdep.h"
> +#include "opcodes.h"
> +
> +#define STRINGIZE(X)    #X
> +
> +const char *opcode_names[] = {

Richard will probably ask to use "const char *const opcode_names[]".

> +#define OPCODE(IID) STRINGIZE(IID)
> +#include "opcodes_def_generated.h"
> +    NULL
> +#undef OPCODE
> +};
> +
> +const char *opcode_syntax[XX_LAST_OPCODE];
> +
> +/*
> + * Process the instruction definitions
> + *     Scalar core instructions have the following form
> + *         Q6INSN(A2_add,"Rd32=add(Rs32,Rt32)",ATTRIBS(),
> + *         "Add 32-bit registers",
> + *         { RdV=RsV+RtV;})
> + */
> +void opcode_init(void)
> +{
> +#define Q6INSN(TAG, BEH, ATTRIBS, DESCR, SEM) \
> +   opcode_syntax[TAG] = BEH;
> +#define EXTINSN(TAG, BEH, ATTRIBS, DESCR, SEM) \
> +   opcode_syntax[TAG] = BEH;
> +#include "imported/allidefs.def"
> +#undef Q6INSN
> +#undef EXTINSN
> +}
> +
> +const char *opcode_rregs[] = {

Ditto '*const'.

> +#define REGINFO(TAG, REGINFO, RREGS, WREGS) RREGS,
> +#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)  /* nothing */
> +#include "op_regs_generated.h"
> +    NULL
> +#undef REGINFO
> +#undef IMMINFO
> +};
> +
> +const char *opcode_wregs[] = {

Ditto '*const'.

> +#define REGINFO(TAG, REGINFO, RREGS, WREGS) WREGS,
> +#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)  /* nothing */
> +#include "op_regs_generated.h"
> +    NULL
> +#undef REGINFO
> +#undef IMMINFO
> +};
> +
> +opcode_encoding_t opcode_encodings[] = {

'const'.

> +#define DEF_ENC32(TAG, ENCSTR) \
> +    [TAG] = { .encoding = ENCSTR },
> +#define DEF_ENC_SUBINSN(TAG, CLASS, ENCSTR) \
> +    [TAG] = { .encoding = ENCSTR, .enc_class = CLASS },
> +#define DEF_EXT_ENC(TAG, CLASS, ENCSTR) \
> +    [TAG] = { .encoding = ENCSTR, .enc_class = CLASS },
> +#include "imported/encode.def"
> +#undef DEF_ENC32
> +#undef DEF_ENC_SUBINSN
> +#undef DEF_EXT_ENC
> +};
> +
> +static const char * const opcode_enc_class_names[XX_LAST_ENC_CLASS] = {
> +    "NORMAL",
> +    "16BIT",
> +    "SUBINSN_A",
> +    "SUBINSN_L1",
> +    "SUBINSN_L2",
> +    "SUBINSN_S1",
> +    "SUBINSN_S2",
> +    "EXT_noext",
> +    "EXT_mmvec",
> +};
> +
> +static const char *get_opcode_enc(int opcode)
> +{
> +    const char *tmp = opcode_encodings[opcode].encoding;
> +    if (tmp == NULL) {
> +        tmp = "MISSING ENCODING";
> +    }
> +    return tmp;
> +}
> +
> +static const char *get_opcode_enc_class(int opcode)
> +{
> +    return opcode_enc_class_names[opcode_encodings[opcode].enc_class];
> +}
> +
> +static void gen_iset_table(FILE *out)
> +{
> +    int i;
> +
> +    fprintf(out, "iset = {\n");
> +    for (i = 0; i < XX_LAST_OPCODE; i++) {
> +        fprintf(out, "\t\'%s\' : {\n", opcode_names[i]);
> +        fprintf(out, "\t\t\'tag\' : \'%s\',\n", opcode_names[i]);
> +        fprintf(out, "\t\t\'syntax\' : \'%s\',\n", opcode_syntax[i]);
> +        fprintf(out, "\t\t\'rregs\' : \'%s\',\n", opcode_rregs[i]);
> +        fprintf(out, "\t\t\'wregs\' : \'%s\',\n", opcode_wregs[i]);
> +        fprintf(out, "\t\t\'enc\' : \'%s\',\n", get_opcode_enc(i));
> +        fprintf(out, "\t\t\'enc_class\' : \'%s\',\n", get_opcode_enc_class(i));
> +        fprintf(out, "\t},\n");
> +    }
> +    fprintf(out, "};\n\n");
> +}
> +
> +static void gen_tags_list(FILE *out)
> +{
> +    int i;
> +
> +    fprintf(out, "tags = [\n");
> +    for (i = 0; i < XX_LAST_OPCODE; i++) {
> +        fprintf(out, "\t\'%s\',\n", opcode_names[i]);
> +    }
> +    fprintf(out, "];\n\n");
> +}
> +
> +static void gen_enc_ext_spaces_table(FILE *out)
> +{
> +    fprintf(out, "enc_ext_spaces = {\n");
> +#define DEF_EXT_SPACE(SPACEID, ENCSTR) \
> +    fprintf(out, "\t\'%s\' : \'%s\',\n", #SPACEID, ENCSTR);
> +#include "imported/encode.def"
> +#undef DEF_EXT_SPACE
> +    fprintf(out, "};\n\n");
> +}
> +
> +static void gen_subinsn_groupings_table(FILE *out)
> +{
> +    fprintf(out, "subinsn_groupings = {\n");
> +#define DEF_PACKED32(TAG, TYPEA, TYPEB, ENCSTR) \
> +    do { \
> +        fprintf(out, "\t\'%s\' : {\n", #TAG); \
> +        fprintf(out, "\t\t\'name\' : \'%s\',\n", #TAG); \
> +        fprintf(out, "\t\t\'class_a\' : \'%s\',\n", #TYPEA); \
> +        fprintf(out, "\t\t\'class_b\' : \'%s\',\n", #TYPEB); \
> +        fprintf(out, "\t\t\'enc\' : \'%s\',\n", ENCSTR); \
> +        fprintf(out, "\t},\n"); \
> +    } while (0);
> +#include "imported/encode.def"
> +#undef DEF_PACKED32
> +    fprintf(out, "};\n\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    FILE *outfile;
> +
> +    if (argc != 2) {
> +        fprintf(stderr, "Usage: gen_dectree_import ouptputfile\n");
> +        return -1;

Again, 'return 1;'?

> +    }
> +    outfile = fopen(argv[1], "w");
> +    if (outfile == NULL) {
> +        fprintf(stderr, "Cannot open %s for writing\n", argv[1]);
> +        return -1;

Ditto.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    }
> +
> +    opcode_init();
> +    gen_iset_table(outfile);
> +    gen_tags_list(outfile);
> +    gen_enc_ext_spaces_table(outfile);
> +    gen_subinsn_groupings_table(outfile);
> +
> +    fclose(outfile);
> +    return 0;
> +}
> 


