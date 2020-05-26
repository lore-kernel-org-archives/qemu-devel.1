Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BD3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987D7207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgKtbCWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987D7207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdaMM-0005fu-Rl
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdaLm-0005GH-Qb
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:14:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdaLl-0006yX-TE
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:14:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id c71so3297248wmd.5
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AAdDYR5Itr9GAkCRDDTLQfGsSSnaAVAPyR+fCDWnBxc=;
 b=QgKtbCWQo05EGrR59jIGn24UatnnSloYyQ+VENwHMWfd3iqsQT6D5KBHYNCo2HzrSG
 dTogQ7OttyfeoimZbBC3uony1CNTBWvyA6k5AWgvn61ixPmqPprlvvfJvtIPsHfmn+xi
 WA6v2IIyqYNmPolGJE6FkiUckCe4Hs2ccbaYvVRMpaI09XdkqFQtEvpjo9pceXiKb2WX
 IvGB8U9FQRLPi6yGiXhKSKxBM5iUcmAOL5K+qtHreMSx/xfY9lGwteDH90HEGDMkIEvq
 AfRZd+AZkWOODSLaVdDCI18MPuNvmexUzfSm/+h8EYBZlPd3cu22m0sIfCSRI3y2zd9Q
 +muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AAdDYR5Itr9GAkCRDDTLQfGsSSnaAVAPyR+fCDWnBxc=;
 b=bb3TmOhPhOE3Gs6dYAmvSjLjlc7nJX8r83Qka7zElW3d2CIycg896bwIt5S13/jlbC
 BTGIlAriCAKXRlu0FWPIzn/NWK+TU98M8mpNpTGAv9YaKMvx6rwpSU/xM9/ormrhOK8D
 PBa7S9er2IdgmijDbhSfzmlOvErdcDls3GnzkxhU8xpFTm5Pru0yBlR3+gm/SHXqgU5o
 lCW/28Q9vVRFwaBeJ5VwTzEz69FOMUhhd8JwHFY7lyFDD6PkuXfylgBq4/vllx+6+Hry
 AhxReBvpGEr0eg1WzSq2XAqpDEmveye3RXNk6oogplMkSMHnlInb5LVusmqYNwV30W4D
 Et3A==
X-Gm-Message-State: AOAM531PCaSz75jQLbJBDQWtdYO8gjT+44Kcfj567fJk+1LEcKJ3bcGY
 zXBysN7TaPqDQyOg/nySsjNGpRk49q5QDdC17dg=
X-Google-Smtp-Source: ABdhPJxhEcyqjhUEfApSbySMllK28pMM4KccnyDnlvzICuepkwQ9oatGIWa2xbjr5pjuEqO+aXuU0HeQSSfPPTvIiRc=
X-Received: by 2002:a1c:2e16:: with SMTP id u22mr1724748wmu.168.1590502475274; 
 Tue, 26 May 2020 07:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
 <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
 <CALTWKrVGqVb1mjsaoxYm4Y1iQoXYwz7ToC7T6r2EDPp-_LO=LQ@mail.gmail.com>
 <4e78400c-42be-08c6-492d-dc5596551efd@linaro.org>
 <CAHiYmc6zKmxgyKHzT4gazvJvPsX3SQYLjSXwK50_2eURkR3_NA@mail.gmail.com>
In-Reply-To: <CAHiYmc6zKmxgyKHzT4gazvJvPsX3SQYLjSXwK50_2eURkR3_NA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 16:14:22 +0200
Message-ID: <CAHiYmc7z+OfvE7nN1j14n2O8seVtqem_hsBwq=WyFgeo=WfybA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000da57c05a68db739"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000da57c05a68db739
Content-Type: text/plain; charset="UTF-8"

> If nobody objects, I will instruct Ahmed to file a bug in QEMU Bugzilla.
>

Ahmed, please follow the instructions on this page: How to report a QEMU bug
<https://www.qemu.org/contribute/report-a-bug/> and file the bug related to
the discussion, to the best of your abilities, if possible, today.

This can be viewed as a part of your community bonding period.

Thanks,
Aleksandar

--0000000000000da57c05a68db739
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>&gt; If nobody objects, I will instruct Ahmed to file =
a bug in QEMU Bugzilla.<br>&gt;<br><div><br></div><div>Ahmed, please follow=
 the instructions on this page: <a href=3D"https://www.qemu.org/contribute/=
report-a-bug/">How to report a QEMU bug</a> and file the bug related to the=
 discussion, to the best of your abilities, if possible, today.</div><div><=
br></div><div>This can be viewed as a part of your community bonding period=
.<br></div><div><br></div><div>Thanks,</div><div>Aleksandar<br></div></div>

--0000000000000da57c05a68db739--

