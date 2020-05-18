Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE54C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA5E207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BN6CrBuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA5E207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaisz-0000Xv-DU
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaip0-0001wB-Lh
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:40:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:36861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaioz-0005pH-Kg
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:40:58 -0400
Received: by mail-pl1-x630.google.com with SMTP id f15so4451133plr.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uFTRRQZQW7zKIC58JAMoD76cKh/Xgd23HtxsN8e+2Qk=;
 b=BN6CrBuU1DRAEwPUwW5flubL4z1nKZQ9L5ZB+miR0mfZ9zyNi3WpsQhKOhc7tl6jJ+
 qZlIKK1Vwe1JLQJCtkvVCxAbqCMCm1VdVcV7vQemfaokSSJQEG60EUxIMJhxlmysVP/x
 E1KEaYXfYsFm9jQExDtslSPn6R12iI6Rm9iJk3CF2AUplAiqcheD8uuFROnOFvHrdeYt
 BsGlrBQ2rM4lwp0ayNXwmj52XvB3iqxj4eBkANgrBXWdI8n7ZvIdeLEyu2+++OtvzVkA
 ZIutUpJFGIpotVWYnitksSKQjZMhfOp+/OvHaC4hOSOLtuEBfVh4lZnU6DVlNbEFEIeC
 ETnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uFTRRQZQW7zKIC58JAMoD76cKh/Xgd23HtxsN8e+2Qk=;
 b=VXtrc8Fmqi0cZ1CP5Ew1EULcCBMqMetbrP6AHPDetUfQ6mTBOKdw4jCASmMYDfNVUb
 5KwRL4AN8yhuY3h3LQspk6PimdHPcQn2OgUjhRC0D76QCuVXPz4vXlR3KkXE3ycMUql0
 Yoez5gxVQKTEuAD74YVlmdAm2/QlR3Hl4/YBzA4lf6kAvo7syE2JM/Bk8T+nXFp1ED7e
 wkN2H2KnueAM+TsLUq1YBQq1ABQIpT8BmfJyIb+FfG/CQfqbM9lr1Juu1L4hOtr0hiNA
 r8cBeP1JzOQl0D6jscAzK51kdxn3o4u39YTUMgWpZoCrQ0MpX8phWV1fzB5/un9unwA1
 Jizg==
X-Gm-Message-State: AOAM532OMBxHXoVYTTKrNB5jSjWQmTKgeDi9T3hxYZf7ZtVzDfmvl/Vd
 rDsNH0PcIU4hdpB0ngTAmu/opCrbqhc=
X-Google-Smtp-Source: ABdhPJxuvDc/OGdYTXzl1bkX6q3cHugxdzrF/UVGZSOivxc+94gDcMqyOIo559rW5z7KFtLyma+emQ==
X-Received: by 2002:a17:90a:8c01:: with SMTP id
 a1mr255381pjo.127.1589820055721; 
 Mon, 18 May 2020 09:40:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x132sm5790610pfd.214.2020.05.18.09.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:40:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] decodetree: Remove python 3.4 check
Date: Mon, 18 May 2020 09:40:45 -0700
Message-Id: <20200518164052.18689-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518164052.18689-1-richard.henderson@linaro.org>
References: <20200518164052.18689-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are now guaranteed python 3.5 or later.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 46ab917807..f9d204aa36 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -75,13 +75,6 @@ def output(*args):
         output_fd.write(a)
 
 
-if sys.version_info >= (3, 4):
-    re_fullmatch = re.fullmatch
-else:
-    def re_fullmatch(pat, str):
-        return re.match('^' + pat + '$', str)
-
-
 def output_autogen():
     output('/* This file is autogenerated by scripts/decodetree.py.  */\n\n')
 
@@ -428,18 +421,18 @@ def parse_field(lineno, name, toks):
     width = 0
     func = None
     for t in toks:
-        if re_fullmatch('!function=' + re_ident, t):
+        if re.fullmatch('!function=' + re_ident, t):
             if func:
                 error(lineno, 'duplicate function')
             func = t.split('=')
             func = func[1]
             continue
 
-        if re_fullmatch('[0-9]+:s[0-9]+', t):
+        if re.fullmatch('[0-9]+:s[0-9]+', t):
             # Signed field extract
             subtoks = t.split(':s')
             sign = True
-        elif re_fullmatch('[0-9]+:[0-9]+', t):
+        elif re.fullmatch('[0-9]+:[0-9]+', t):
             # Unsigned field extract
             subtoks = t.split(':')
             sign = False
@@ -488,11 +481,11 @@ def parse_arguments(lineno, name, toks):
     flds = []
     extern = False
     for t in toks:
-        if re_fullmatch('!extern', t):
+        if re.fullmatch('!extern', t):
             extern = True
             anyextern = True
             continue
-        if not re_fullmatch(re_ident, t):
+        if not re.fullmatch(re_ident, t):
             error(lineno, 'invalid argument set token "{0}"'.format(t))
         if t in flds:
             error(lineno, 'duplicate argument "{0}"'.format(t))
@@ -621,13 +614,13 @@ def parse_generic(lineno, is_format, name, toks):
             continue
 
         # 'Foo=%Bar' imports a field with a different name.
-        if re_fullmatch(re_ident + '=%' + re_ident, t):
+        if re.fullmatch(re_ident + '=%' + re_ident, t):
             (fname, iname) = t.split('=%')
             flds = add_field_byname(lineno, flds, fname, iname)
             continue
 
         # 'Foo=number' sets an argument field to a constant value
-        if re_fullmatch(re_ident + '=[+-]?[0-9]+', t):
+        if re.fullmatch(re_ident + '=[+-]?[0-9]+', t):
             (fname, value) = t.split('=')
             value = int(value)
             flds = add_field(lineno, flds, fname, ConstField(value))
@@ -635,7 +628,7 @@ def parse_generic(lineno, is_format, name, toks):
 
         # Pattern of 0s, 1s, dots and dashes indicate required zeros,
         # required ones, or dont-cares.
-        if re_fullmatch('[01.-]+', t):
+        if re.fullmatch('[01.-]+', t):
             shift = len(t)
             fms = t.replace('0', '1')
             fms = fms.replace('.', '0')
@@ -652,7 +645,7 @@ def parse_generic(lineno, is_format, name, toks):
             fixedmask = (fixedmask << shift) | fms
             undefmask = (undefmask << shift) | ubm
         # Otherwise, fieldname:fieldwidth
-        elif re_fullmatch(re_ident + ':s?[0-9]+', t):
+        elif re.fullmatch(re_ident + ':s?[0-9]+', t):
             (fname, flen) = t.split(':')
             sign = False
             if flen[0] == 's':
-- 
2.20.1


