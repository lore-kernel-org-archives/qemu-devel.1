Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE16C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35459207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="g1hiiQaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35459207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtopK-0001yi-GH
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtooU-0000nB-Pt
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:55:22 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:35711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtooT-0008Nv-7F
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:55:22 -0400
Received: by mail-ej1-x631.google.com with SMTP id rk21so5232239ejb.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=tFGB6pN/nzVO8AjRQQp5DIc0iLyGvJLmglzxJRXFK14=;
 b=g1hiiQaOgd0abBVZjtqnPn3HvWnG9UVIYFe/Ctg7Ci0xGMtPoWCA+lwkHJac6Qfjqz
 8uljls/m4d8hYFp2vZLcthL2WV03onHGxWSvQROhejGxm+Z71SIjucPjTGZvez1ABdsk
 KUxPKQ0SqGmoWP8/MQj/NUUMALRuUn0jNqDMXnKp0c1ZSWthZZj6sDD+kifzuJI1M6AF
 Mei9Olr6SbV8OczCwrMvv3y7tQhVlIYBqdXpyYTuW5YqKy1Zse/dtRFkJkX1hLod00hg
 lvs97WbavBswRrb848/hLqPhbYrSgPUjpMJ+y67WCeVhi8DUeEdCw+6GYZ3gIFMAcBGs
 is+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=tFGB6pN/nzVO8AjRQQp5DIc0iLyGvJLmglzxJRXFK14=;
 b=TBSkwF4D0FZU+L1GprY2GIlLjmFzfy1mEXO9Kkr9NNA39Tp0pocIaQ6TDeaxNbTWl3
 fSyyd9q92s+c6LeLoOG4TND64/mtGw/fPGNVBnAyFPOPVneYOeqNUPnKrq00nXbqq4A9
 7gK/qt6DVqq54YXy+wfMiOlNheE3TUvoEDGnGY9WPW5bF9Dck63EyKIv1TtuVZRKUQjg
 pCnkso8pLUH3qzV18ua1nay98AnDO5xcBsAkxk4glm0Fn62/FTwLRSSlJVufPJLjV8BS
 tQafsdy+ZBdXMPxa/8LZFsmmrRgWL+F3AkXp2n2CIuM4D/fstl9MLVLXFQ21cmFJPEkA
 Ehxw==
X-Gm-Message-State: AOAM533rCowrx2cme5lCtwrPFiXlHfZUYD6ayYdgP8Z4dHlISa30p5J8
 24yAKvMJ2rGxFR0HmjvGOdSv0w==
X-Google-Smtp-Source: ABdhPJzmbWlehQhLHWZMBkDK+XrMI1rWeQr/Q++2oDmeN8p0RZKXqku/R5qpaSHaK34Lq6dN1/EKWQ==
X-Received: by 2002:a17:906:414c:: with SMTP id
 l12mr40938256ejk.417.1594371319667; 
 Fri, 10 Jul 2020 01:55:19 -0700 (PDT)
Received: from wks.local ([86.121.22.151])
 by smtp.gmail.com with ESMTPSA id 23sm3954080edx.75.2020.07.10.01.55.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2020 01:55:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Separate notifications from list messages?
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20200710084954.GC4017912@redhat.com>
Date: Fri, 10 Jul 2020 11:55:17 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FAC9C6F-68F0-4EE9-A4F0-9D7CE56FD932@livius.net>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
 <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
 <20200710084954.GC4017912@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: none client-ip=2a00:1450:4864:20::631;
 envelope-from=ilg@livius.net; helo=mail-ej1-x631.google.com
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
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 10 Jul 2020, at 11:49, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> This was an explicit configuration choice to make the CI failure =
reports
> appear on the list, rather than expecting one or two people to be
> responsible for watching the CI.=20

I'm not familiar with your workflow, it might be so, but normally only =
those who submit changes (pull requests on GitHub) should be notified on =
the results.


regards,

Liviu


