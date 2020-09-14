Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A03C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DF020829
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJDbx9lM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DF020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpkO-0000wY-Uo
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHpfg-0005xu-Bj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:41:32 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:41521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHpfd-00040V-95
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:41:31 -0400
Received: by mail-ej1-x641.google.com with SMTP id lo4so294219ejb.8
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4nwERILA7b9Xpydmv48s8OUFv2ib10tP646OF3d5TYU=;
 b=pJDbx9lMiK2wxN23UFzHqLRLFBAddBP0xsCdoXj/qNw05q2ecK1YYEL63CQeUyEHgJ
 rcZJdlq2uopwpJMAHG+rZ3xCKk9mKqJcvDIpccl9+0REm9reOjA4ua5RCvtpHDU7sDvn
 zC1pu4QcIrpahdEBgwKmvZYRqVaj/GbYQZOizWkP7WKgeE9263klLzDPSPvujsYQihCX
 s/XNSpivrQelxfqH9m+35vyucpKEUn9iyu3r8fg0aPQIbTnHfv4kVhSJk3c44sKjZJgg
 2J0VanY+PNgB9I5W20/bjCrBqekbvkp4l5bvXMLnyS3DjGEPxtMLligyGshHZf2UaGtF
 h8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4nwERILA7b9Xpydmv48s8OUFv2ib10tP646OF3d5TYU=;
 b=fEB3uH2xpJyw2nwIjaQFB8qu7AHbouzOkopI8WD4uYGbZesKBs0FhK7KGSz/eWRs/V
 IpeEznkyxUy936VU8ar+xrKGR2PsPnAXrd7P+jMGT27Hl6uW+wJQclZNiIVjTwwlD907
 iU3OZ28iveA2tJsOsP7bPc9DjPDqMEx/pBVl3ZkBFPRnOVqb/YbIJt2lesAyGDJcwpg6
 yg5c5paE9Kf+BIZFkLlM9tCcpjaNrrdc/qN4RhrCAneWry04jDsKyAKaz8Mqa6daFAUh
 cA4PdutgG1mgWswgLDp4EENbnWePTeCPIPv1Ni3gHsqHQ7mB3iWJ5PQn7ZvMRoNC33KS
 HgGA==
X-Gm-Message-State: AOAM533yVS5ZTLUbFuxYS4R7IsvQXjAKh2YV9hvKW0vbaTtKkcAYKZiQ
 3Xg2r6G3eCcLI9ZlHGf8IvLfcs8t86JXcJSTYtqi4w==
X-Google-Smtp-Source: ABdhPJwd78IedPyB2UtJnaQBtcO72sLbnPj4Gteow/UY6lp/E6MlCCT5JItwsnnkSyQfxzAdcSbEE8JNWNqLuLtJ1tw=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr14656899ejk.407.1600094487603; 
 Mon, 14 Sep 2020 07:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-12-luoyonggang@gmail.com>
 <c6ed5abf-2c71-bded-7efc-33baa0b415af@redhat.com>
 <CAE2XoE-mFPm=chadNahHgCsa3tSjxRXMH3te29ODV=emWdLjYA@mail.gmail.com>
 <d6dd1c31-4bf0-3fd0-4c32-7216c8b3435c@redhat.com>
In-Reply-To: <d6dd1c31-4bf0-3fd0-4c32-7216c8b3435c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 15:41:16 +0100
Message-ID: <CAFEAcA98VD2f3TQBDrfFv4swwu2Txhs2KXXKiHgFGsN7P_B3AQ@mail.gmail.com>
Subject: Re: [PATCH v8 11/27] meson: Use -b to ignore CR vs. CR-LF issues on
 Windows
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 13 Sep 2020 at 19:51, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 9/13/20 6:01 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >
> > On Sun, Sep 13, 2020 at 11:35 PM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >     On 9/13/20 12:44 AM, Yonggang Luo wrote:
> >     > On windows, a difference in line endings causes testsuite failure=
s
> >     > complaining that every single line in files such as
> >     > 'tests/qapi-schemadoc-good.texi' is wrong.  Fix it by adding -b t=
o
> >     diff.
> >
> >     Isn't '--strip-trailing-cr' more adapted?
> >
> > er, I did that before.....
>
> So, yes/no? We can not follow all patches, so better if you
> add a note about your changes, either in the patch description
> if you think it's worthwhile keeping that information in the
> git history, else below the '---' separator, so that information
> is stripped from the patch when applying.
>
> Looking at the archive I see Thomas said this option is not
> POSIX thus not portable.
>
> What about adding this?
>
> "Ideally we would use the '--strip-trailing-cr' option, but not
> being POSIX is a portability problem (i.e. BSDs and Solaris
> based OSes). Instead use the '-b' option which, although doing
> slightly more, produce the expected result on Windows."

The other important point to note here is that because
texi output is mostly not case-sensitive, we are not
losing important test coverage by not checking for exact
whitespace matches between the known-good output and
the generated output. If we were checking the doc-good.out
text file, -b would be bad because there whitespace is
important and is part of what we need to be checking.

(Also the texi stuff is going to go away soon I hope :-))

thanks
-- PMM

