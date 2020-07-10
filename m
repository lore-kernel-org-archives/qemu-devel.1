Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC05FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850C82078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="0eUdUvdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850C82078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoi0-0004cl-Rj
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtohR-0004D9-5H
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:48:05 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:40403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtohP-0007SA-Oo
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:48:04 -0400
Received: by mail-ej1-x62f.google.com with SMTP id o18so5191457eje.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=c1cLKF3SHGXbXnZRiLQEn42WKnobKAK4OT9lMXO0b0E=;
 b=0eUdUvdgGruUC1d2C47zIyCUsiDDnM4iyc1IbxAP13s1FeNZ2oPDp8Cp+S3FGVa1bu
 Dn/nr19kqSBIIJx7uxp5elikZ4lowqgsjkWpnIMfC3dhqZ9tbAxmzb2iN/VfD7YtYWeN
 x9ZEA/GL5BwaSkxQ+K8He0uNlFjhk4UragzzfZPv3xV6YzwObo46SJXxbmeunI5ayXCh
 pEwgL3wxQGbwAbzcEGU41PT/f7CrtXwBrG6rEaX1gsMxvcr6nSPUlZWlWSqDfhIpoLZO
 sEuELYOicqSpRv39yYF7+MIz6PFg1tiBhfAu6FKxvVRmUrFddcDUsdMw0U6lIC9hS41e
 EzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=c1cLKF3SHGXbXnZRiLQEn42WKnobKAK4OT9lMXO0b0E=;
 b=ZMCqJGP43dM/B5mGKk9yjr8uJhVo4umTLA+OkAb2FUnrq0IW4coUOxvyuK1PaySBtj
 r41RbR/6EmOdwL2JdtzJ9JEE7Xz67A6Nfz93TVD9tueg+Ex/ZebVXZ3yLYgrhPgJnShQ
 Lyds2bkXEQAhCXf93lto25uMJbn3sgZ4O+dHFPePQAXwWrwuLmshubRx+Oaoppef7dR6
 CJhj6aD2U/s2bLoLOHUSgfOUyx9ZMqk7ofDaENvDBuO8086ifPuebeHTVx2678QRmcFY
 XWRyIh7sSy6zuFrckqr1DvTPbL2jLNNuB1eDZ6Liw53RakHdxtWmT3Oi9F7djH4fiDfE
 FTKw==
X-Gm-Message-State: AOAM5318O3bxPdXqC1QziBJsIFEdcrKn0kdKom6AgP2sh3gkLZ8yhjVc
 aLTfq1Dy03kNlxpt3yJkB5y9Ig==
X-Google-Smtp-Source: ABdhPJy5WURdg8uvRPpc76TT4UjB5M8mVRcgUbsHUlaOO5X/k3TutzVxKP24U99vFFH2946la1AWcg==
X-Received: by 2002:a17:906:6dd7:: with SMTP id
 j23mr44086163ejt.529.1594370882257; 
 Fri, 10 Jul 2020 01:48:02 -0700 (PDT)
Received: from wks.local ([86.121.22.151])
 by smtp.gmail.com with ESMTPSA id x16sm3918801edr.52.2020.07.10.01.48.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2020 01:48:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Separate notifications from list messages?
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <62f156e3-db58-e271-23de-ba2f95577252@redhat.com>
Date: Fri, 10 Jul 2020 11:47:59 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <974F803A-AD6C-49CA-8E9D-15F4AFEFB3C1@livius.net>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
 <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
 <62f156e3-db58-e271-23de-ba2f95577252@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: none client-ip=2a00:1450:4864:20::62f;
 envelope-from=ilg@livius.net; helo=mail-ej1-x62f.google.com
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
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 10 Jul 2020, at 11:43, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> On 7/10/20 10:32 AM, Peter Maydell wrote:
>> On Fri, 10 Jul 2020 at 09:25, Liviu Ionescu <ilg@livius.net> wrote:
>>>> On 10 Jul 2020, at 11:09, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>>=20
>>>> What sort of notifications are we talking about here ?
>=20
> qemu-ci-notifications@ for all our CI?

if you are sure that all notifications are related to CI. otherwise =
qemu-notifications.

I suggest you check the GitLab settings for all places where the =
qemu-devel is used.


regards,

Liviu


