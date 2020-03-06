Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B93C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC702072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVYuRnhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC702072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGwn-00049v-3t
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGns-0003cn-IC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGnq-0002lk-WB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:30:28 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGnq-0002ka-Or
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:30:26 -0500
Received: by mail-ot1-x344.google.com with SMTP id i14so3191728otp.5
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BvCQy0kyPwALTUk5RFGZrnw8ZEltk1JAwNW0S3Tg67o=;
 b=gVYuRnhmTvt6eFKZZOr71jtPdXNvXYg+wA6b9PKOOFEmSYhAYy0EJoQ5/ZsWFmD/cB
 BvjTVvyxo2vh/aAvM+2TxD3F8JO1pK6XxcjUdi4ecLuA57H+GOjfu35Om2PRnSS8xT2+
 tEdIdhOwrDfexQ7cVakBZi2fzUb27ywrJiMa3oqJRXE6yww3xxzXPbSpf68KM2mrXs6q
 uJVGaB/f9odRG5yOvqZYY8D1KSGmyrepxnFQYg69/DBJAzPs1ONTWCl5W0ILtCCEqsAH
 t4mjm42cqARKtm39eMy3Jb4PRwgTWWwdqphBJVRwo+j1w/AU+8KqlKGDwzEIeEIt+Tmn
 oEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BvCQy0kyPwALTUk5RFGZrnw8ZEltk1JAwNW0S3Tg67o=;
 b=kqOQNFFlD9XbI/kDFsTtVQPqREfZuozUo8zIVgIqSHdqb2FlDSQxa2StRMw3/dE3Q8
 YOGZXLODWDmT4FbWNs1b5xr82MxmhZV3iRISUkMeiXDVTG50H1GSzXKyNAB20IxmE8QA
 OcP3lYRFyr0syG0+fpXZIixfnhckP5Zq9ytd1SO947TBigaY7Ee0ZoimXiQWgWp2aMqF
 /E5cIUCWEFUV/7urmZWwIILr7oQR33ihSZ9Im55fMDFzHV9BnlFMk15mRX8pmpmwJorB
 /vDuM6Rf63Mr3DZ8YL0tnunl3dHOpW+Cai3fQaKHYz8EQfTQkFqRs5xE3HULMKl0RjJK
 b3Wg==
X-Gm-Message-State: ANhLgQ2KB41muPuPEj42ZHx5EOPyhiJsCUxel5lZi2dVF06GDEvbJm0N
 uXEVk2PNW+pU5RKvhNSkzQZNRpTgHW2g+XJEmWEowmM2THg=
X-Google-Smtp-Source: ADFU+vsywG79mCIJd6ycdD303RuOEgTBjTXNrAXXRA/3zBrh8MMSeacsHvLqkevvNoH4lKWJW8+uhSrBh5L30aXAONg=
X-Received: by 2002:a9d:75ca:: with SMTP id c10mr3240502otl.97.1583515824698; 
 Fri, 06 Mar 2020 09:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20200225140437.20609-1-peter.maydell@linaro.org>
In-Reply-To: <20200225140437.20609-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2020 17:30:13 +0000
Message-ID: <CAFEAcA8w8_P4-qkDnh8uM7YdumXb_fQTNVZN8yOj=J2NG4WKLw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Convert QAPI doc comments to generate rST
 instead of texinfo
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 14:04, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This series switches all our QAPI doc comments over from
> texinfo format to rST.

> Git branch of this series also available at
> https://git.linaro.org/people/peter.maydell/qemu-arm.git sphinx-conversions

I've just updated this git branch with a rebase on top of:
 * current master, which has the qemu-doc conversion
 * the minor-cleanups patchset I just posted

No serious changes to the meat of the series:
 * some new text in migration.json needed indenting to
   match this series' stricter requirements
 * fixups of (textual) makefile conflicts
 * five new patches at the end which delete all the
   texinfo machinery since once the qapi generation
   is converted we don't need texinfo at all

I'll probably send a new set of patches to the list next
week; this set should still be fine for review though.

thanks
-- PMM

