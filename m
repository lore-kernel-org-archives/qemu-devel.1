Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B4C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB9F216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIY5245p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB9F216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmhS-0005lJ-Nj
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHmgW-0005C8-6b
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:30:12 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:46409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHmgU-0000Uw-9d
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:30:11 -0400
Received: by mail-ej1-x630.google.com with SMTP id z23so22661262ejr.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=blHsvFw9gdlv5ubJw3Vv1ujopUP/APf4AYDfP+XOTQk=;
 b=XIY5245pBGbtMI/w/11hsnqTCCU1D1/AKp90fzUnehMrewb9516N8uQ/PaHV3B/dMX
 230+yPuJM3c9HmtVnqHLVZNU3VOfol1IiXBw4PECYZn1lKIHPxYqFX6xMb9BfQWQc2pP
 mClOeCFbVqMrGH1o6aGvJCoHL8kXNMJbtyzbmptgOKLzvOgxvO7gm/mh4NQ7iP6a8WjO
 tHCf87xgs1zQJLsSpfbPKlTq6KADV7snPw3ZVOChvSfYA5H/3yayvSsVEJbSytEXyTfQ
 d9eCFwYSMGmQf4q4MBiyJLnX/rlKQ5JyylTCPsBGZZMSs1TSDszXlGbb+i4SbbKMx4rz
 /QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=blHsvFw9gdlv5ubJw3Vv1ujopUP/APf4AYDfP+XOTQk=;
 b=tIdEXnI09glGZZee5be5dAmQYHQKjnz/CYbrbTm+llPblMhoWFm4wxCwPyn5Zkt9Gb
 zLnRl6WeGw/A0CM6V0raaZk5ENnfJr41f37kt/NdOHdgJa0uCrUUQTGtiFnnYh4xBpco
 3A5BBcIySBrV1Ckq+rkWKWdw3FcfsYkLbyV2eWKtZIMkJyKH6cHNewPtWaSyujf+HDeX
 9/dnpc8anXlo/fungTzNFPk0KhZJg4bdOFOgZpsD1KArgGpgyG1ZerNdcuGx/a+HzW6J
 8PMrQ+HBsT1fN/s/cUfTI3zvNUUe0teFtHYHHHjf8G23yKtxZkv9xeq/4jntqiPF68KA
 WKUA==
X-Gm-Message-State: AOAM533+KsdN8FfZ2GmSqy68tJeER5QMBlNP/JreBUiVnQu1DxO2LWnB
 Vvna9OPBd8r7ZBaEW0Rd+WcBz2kqcuK2RIgs9sInLw==
X-Google-Smtp-Source: ABdhPJzeJNeqDWztxnrKFXaA9sVDRp+rPDJqiEWnw0jBMhiWEoVDq5L1lLUyRB4H2ftwNvzV4495YGFghpijVLNJpN0=
X-Received: by 2002:a17:906:552:: with SMTP id
 k18mr2190124eja.482.1600083008112; 
 Mon, 14 Sep 2020 04:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8yfPdJLmek=+1VOWY4DQGP0yhmbtTiARw+qMuENKet+w@mail.gmail.com>
 <bb48e978-71e3-8ea8-44da-36c7d540ec1b@linaro.org>
In-Reply-To: <bb48e978-71e3-8ea8-44da-36c7d540ec1b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 12:29:57 +0100
Message-ID: <CAFEAcA8u5pOd2RyU+MzYJqyp=PypRCEzT-kwesSSppve5sg-ow@mail.gmail.com>
Subject: Re: qemu disassembler status
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 at 22:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I've spent a couple of days poking at the llvm disassembler.
>
> As a general-purpose disassembler, it's less than ideal.
>
> (1) The disassembler is not "inclusive".  You present it with
>     a specific cpu configuration, and anything that cpu does
>     not support is considered invalid.  There is no "maximum"
>     configuration that attempts to decode any insn in the ISA.
>
> (2) All configuration is done via strings, so you can't
>     programatically tell what's supported.  I think they're
>     expecting all of these strings to come from the
>     command line.
>
> (3) If you include a unrecognized cpu feature, an error is
>     printed to stderr.  Which suggests that we would easily
>     wind up with problems between llvm versions.
>
> (4) "Probing" what is supported with a particular version is
>     done via "+help", which prints what is supported to stdout.

My contacts who work on LLVM suggest that upstream would probably
be open to patches improving the API here, if we were interested
in making the effort.

thanks
-- PMM

