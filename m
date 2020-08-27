Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E00C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0755F22B4B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HI98HMia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0755F22B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJNc-0008NC-7A
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBJN1-0007lI-OM
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:59:19 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBJN0-0000cR-1v
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:59:19 -0400
Received: by mail-ej1-x643.google.com with SMTP id d26so8120904ejr.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eJPCQsEVj/uzac7TJpxpcg8sx844iloiU6ZivC4lvqw=;
 b=HI98HMia3IwrpoNV4cM2etfvd4E1PJUVIvcBSr8OVLiGXgPHBXzJeHRPA7fpNsPRHy
 Nd+/Vcc4QAzIQkBkRhjxTd1vl49ivYRD/tCbjy705bHzWI45nsSi+oNeMfu4+5GtYgsa
 APKVgGPWodRpiYLrWvJ1AmHZn/kp6iXwN6Rm9nxSX8KKEdTYgvEeG/gVBklWz18RwCfX
 ZCkfY3USEJhW8SWhCjsuhjvdLpB45VVQmA6Pty7Csz+7N+Nm44jtbbc8vZG3+VKW1C54
 /1+rcSiby40Kns89Ix5ZMSR7Y5RplKu7WIN8/lgxlg1N0U+4stAOicaroNfkHBiHXXXT
 KssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eJPCQsEVj/uzac7TJpxpcg8sx844iloiU6ZivC4lvqw=;
 b=WRxUMjUecYullZvYdZ31wcNpytttau2kmRMcsQuNKRR1UfFeGXHymht8XYu4UcsNc7
 6g+k4wWB/X/yfnVZvn3pBhitMTUnd/5msd0aXlMOGPklJuU2CutMew3XoG9JUNFZYthV
 M+gkdp+lZWVFQk4Afe0CZUXdEQ8rDinigvti7NKS6ib4KiQ3DPk/V70Iy51fAzC8ttHs
 h96Q/xC+wuXIPUUEN+8i44D4mcVtvVwKYJVAq+/JJPYWOAgPcClsbE/kkqq9aC/Elslr
 nuGyPsK0dCuTB1lzuv/KGt1M9AaV2uo9C7Bgf2IPLBUnHvIMPZDuF79DwsGm4x8womdh
 jnuw==
X-Gm-Message-State: AOAM531/I2QIwI3x9it1AkQwAX45pUKA0JZ8B5oxPtdpYiAJNZvBCeTK
 K3PPR4jHZdqtZermVAnw5gkiryDxwy7HkpG1kdGyHQ==
X-Google-Smtp-Source: ABdhPJyf+tqGVF6eipuHIiy+/r5HxLLHkEWeomk88b1po6yMGZE16hMFlb72hMgcK+iZvtQomDnfwavoOvQEy1PxKwk=
X-Received: by 2002:a17:907:2066:: with SMTP id
 qp6mr12080427ejb.85.1598540355994; 
 Thu, 27 Aug 2020 07:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200827142915.108730-1-stefanha@redhat.com>
 <20200827142915.108730-5-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-5-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 15:59:04 +0100
Message-ID: <CAFEAcA-B_HC-uRBchjtjKx=Zo5fj0Wf3yJA_1h1Rr8-rZm=V0Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] tracetool: show trace-events filename/lineno in fmt
 string errors
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 15:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The compiler encounters trace event format strings in generated code.
> Format strings are error-prone and therefore clear compiler errors are
> important.
>
> Use the #line directive to show the trace-events filename and line
> number in format string errors:
> https://gcc.gnu.org/onlinedocs/gcc-10.2.0/cpp/Line-Control.html
>
> For example, if the cpu_in trace event's %u is changed to %p the
> following error is reported:
>
>   trace-events:29:18: error: format =E2=80=98%p=E2=80=99 expects argument=
 of type =E2=80=98void *=E2=80=99, but argument 7 has type =E2=80=98unsigne=
d int=E2=80=99 [-Werror=3Dformat=3D]
>
> Line 29 in trace-events is where cpu_in is defined. This works for any
> trace-events file in the QEMU source tree and the correct path is
> displayed.
>
> Unfortunately there does not seem to be a way to set the column, so "18"
> is not the right character on that line.

It's been pointed out to me that you could do this by
making the generated code have suitable line breaks, padding,
etc, so that the format string in the output ends up starting in
the same column it was in the input trace file. Whether this is
worthwhile I leave up to you :-)

(The argument number (7 in your example) is also of course off,
and that I think we're also stuck with. Getting the file and line
number right is a solid improvement on the current situation.)

thanks
-- PMM

