Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885CCC2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F002078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="gMkFHFMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F002078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJlw-00029f-9B
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kGJkg-00013T-Vt
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:24:26 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:39717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kGJkf-0001nu-2p
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:24:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id p9so7923193ejf.6
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=+HBcZmOCz4+yOe2VI8CHY572Ns1Lj2c3OZKQ2k85hu0=;
 b=gMkFHFMHukLtgIS4NXfvEc3Nx/r0N7dD71SxDt8DoPk73pRsZUFS/VMxCKrfQo66ff
 mvEqBpsNXeZa+vhBVOmN91dOHc9TJ8VqhRN3tM94yM2v1KlIrLa9LyoSz4e36LzoZq02
 KLDhMWQpNwPKYWD/HBWnJtA9EKsTOOoZ7ZCRPwdY5xSsT7c3Kf+/UEJNtxSyGIqrEh5W
 S/hh3tlE+Dgy6NjRdJO9z+31Jsz2K3geXgGtDl0xpJsn8+QhOSDJiM+czoRUjUyD1Fpl
 EJFhO2jsNp4l6JrmSMfemqZ51qwXJRi/wjxEwgxAif6zb6A2Ad0R+amK51j62JBAZ2nM
 3ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=+HBcZmOCz4+yOe2VI8CHY572Ns1Lj2c3OZKQ2k85hu0=;
 b=dFjbPfuUbj3fjdyi5xLJJHg/dq+bDKoNxSLTO03rLEdrKbwcby6Er+8WBwJwTc4W6f
 7utGxyL1qGIdMpKcrKuo+wkQY2K5A9EwfzzRc6VbBtwy1K0nmO7ko3PNVttxYX4hkAb3
 FEo/DOo7WeJKMb2rLegh9wPX6/BIIxnBB39xTeylrLSOOhlXmotemyi3htl8Z32HxxuI
 h6fp1p0UQjKT4yBxmiXize4Jw7tLrb2OUsmstkSnqL/S/S2aDHH+lxewRY0mvTC8fnYZ
 Yj+Z7ub2HSRoO9ZL4eTrMafROaoKG468w4ITB7QEgVj/ShjMPd9nUiHgMdkj8qSjCF0W
 7qEQ==
X-Gm-Message-State: AOAM530HLzRRyueByXVGCaOiO5xteBHnrOPA6ssuQsKqP3m9gcaJveRq
 J7BvcuORMKUv1OeqsHoDQ3zwnQ==
X-Google-Smtp-Source: ABdhPJzMZFZZxsYo00DAcV2Cq2ZCJiNLUvAo7ZA27vwP3kVijH1QtAvVqdRLFcAfbrrUAKwGMwUKGw==
X-Received: by 2002:a17:906:46d5:: with SMTP id
 k21mr7783720ejs.247.1599733462854; 
 Thu, 10 Sep 2020 03:24:22 -0700 (PDT)
Received: from wks.local ([86.120.181.246])
 by smtp.gmail.com with ESMTPSA id s19sm6446196eja.54.2020.09.10.03.24.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Sep 2020 03:24:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [RFC] QEMU as Xcode project on macOS
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <4878996.4JzhbN1UZ4@silver>
Date: Thu, 10 Sep 2020 13:24:21 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD8F8921-C3C6-435B-8D92-9DC1B4A504A6@livius.net>
References: <2764135.D4k31Gy3CM@silver> <2421928.3WNMogbLRJ@silver>
 <20200910093910.GG1083348@redhat.com> <4878996.4JzhbN1UZ4@silver>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: none client-ip=2a00:1450:4864:20::636;
 envelope-from=ilg@livius.net; helo=mail-ej1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 10 Sep 2020, at 13:14, Christian Schoenebeck =
<qemu_oss@crudebyte.com> wrote:
>=20
> The way to go for devs on Mac is: 3rd party libs should not be =
installed into=20
> global space, rather be built & linked either as dynamic frameworks =
(including=20
> assets) or as static libs. Then apps always run with the precise =
version and=20
> flags of libs they were tested with and never conflict with another =
app's=20
> version/config of libs.

Fully agree.

Just that I use the same concept for all my builds (Linux & Windows), =
not only the Mac builds.

Liviu


