Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEA6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6412078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="NQxX4J+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6412078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoaN-0001Kr-0n
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtoZn-0000qt-8w
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:40:11 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:46266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtoZl-0006O2-Di
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:40:10 -0400
Received: by mail-ed1-x532.google.com with SMTP id dm19so3973145edb.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=iOINYIUyXbJTQ3jcGfUegyB4MH3EqczJWuknOqk0eS8=;
 b=NQxX4J+M32B+scsaAprxOGeBsMWTntptdH5Owfd1t/84UHO4as2QExX8B600pJGVBL
 BENQFdHxDK0zZnyI2I/Sq8h7fwrIkdMVFPkpWcI4evO9pjUTrZZ8uu4HM4Xtvg8dxrXD
 A0m+UFH6nXYnjhUJ8HSQtteUu6iqZXfjkMxDHbLEBbB7T5OcV5wC8OgKnKOcXPtXjokq
 ZXjBrt9/x6TwBpE70huNXsZ8h/hJIBl77SzfXWMSFafqJ6nqOb1OtKfsVVt2NGa1k+Ie
 psuaTkKvPBA7vAL/LSjXrmSwAILUwfVOFUKWZeb6eubu8ROiYDDF3Pd2hy8qzwTULi+n
 EBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=iOINYIUyXbJTQ3jcGfUegyB4MH3EqczJWuknOqk0eS8=;
 b=eD/mjJ1EFC2z2XxSnFOAnzyhu2LEFCiEcHuVxR/fG4N0/gBVpYJNNiV7u52nOEt+E+
 OAgOkmi1SY3umkk3wZEwS+7RvpQRSNI07z2hE/BfnmsrMHuEn8Hd/mhSkr1OLC27yjoc
 jo5eVG7wGfYgdymdINwrScdGc0BvaT5hHLRrf3SQNQkqky4t7iAdDdQNPhwhXHC5tjqK
 BEXkNS3DfxrY1y7OegXwBGX57C7WX4cqIFl3g1RmlLBLqhH7uiAYm+UPyvq1kHVl2Px+
 ojs71HniLlenGjjVmRhxp872AlqU8cfSCB+5fZJQ1Qw88lNSd4OyqwtYtaMLSGPD57Mc
 7mOA==
X-Gm-Message-State: AOAM530K0heHcJqNnt9I8EAVB3fpFsLxI3VMOGBiMkNhPSh5hFkUWEIH
 luqeox/AVisw6mKGN2W4BUMQ+A==
X-Google-Smtp-Source: ABdhPJzWX/A8rRllVOZj3yGe5Uo45GdX6zqEmleTxwLQwhWJjL+04wjGSUx5DV3ALsHW9F9vIW8qkg==
X-Received: by 2002:a05:6402:1c07:: with SMTP id
 ck7mr64636640edb.297.1594370407248; 
 Fri, 10 Jul 2020 01:40:07 -0700 (PDT)
Received: from wks.local ([86.121.22.151])
 by smtp.gmail.com with ESMTPSA id x64sm4226197edc.95.2020.07.10.01.40.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2020 01:40:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Separate notifications from list messages?
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
Date: Fri, 10 Jul 2020 11:40:05 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <008CCEB6-D3F4-4F1A-80DE-83F47873851F@livius.net>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
 <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: none client-ip=2a00:1450:4864:20::532;
 envelope-from=ilg@livius.net; helo=mail-ed1-x532.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 10 Jul 2020, at 11:32, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> ... Do we expect any other
> kinds to appear as we make more use of gitlab?

I have zero experience with gitlab, but on github yes, most project =
activity can trigger notifications.

this is not a problem in itself. the problem is that, instead of using a =
personal email address, the qemu-devel list was used somewhere in the =
project settings, and all notifications go to the list.


regards,

Liviu


