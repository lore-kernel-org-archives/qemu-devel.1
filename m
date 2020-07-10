Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6D1C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBBD2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="MgxSH2Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBBD2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtrg6-0000jh-2p
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 07:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtrfH-0000IS-GU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:58:03 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:44717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtrfF-0007Q7-Og
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:58:03 -0400
Received: by mail-ej1-x636.google.com with SMTP id ga4so5726364ejb.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=DoqPCNiRSXL12p7webWUWk7PRO1X5BZfTyKbFD4kzLA=;
 b=MgxSH2Sl0HE0JpUHNW4Z2ZY45FsgAtwV9+H2Y5sdEKmnmGbnTERZf6FsbbPZUN7LhA
 KxntWTmEo25lWNhGaK2RV8Xc8EdjxKWqpXiGCi2dyBPttQxZ4hHeQwhqmYxGavqsJaIB
 C0XftwuC5UOXKX6an2WiBWoaDgUbzSyfzECqxSIQFf9FdoUcr48deuT1CxYvj28SDVpN
 y7NJ1eTsgbPhMPva8Vmj8PZbusHuRr0gWdKQ4m52EFpst8nGNMwZRLwxvYlSfn+zwTVw
 muZ1Kk95bdONVt0bM5ey7KgzKtNVcHwAsCuEMFNrF8EqL5d0gqzVYGv2YvvAzUdlcW4m
 Elxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=DoqPCNiRSXL12p7webWUWk7PRO1X5BZfTyKbFD4kzLA=;
 b=pTUb/RKaPiIGrFG8+PJNSXPdrFU4PSCkLXgqHRjcWmaNCJq3E0tIL5YOW/oVDmTqXm
 KrOZ2U43UVTIHFaArPiwmO5NIXVmCyn/8eKMNbCd13elsScuBnK4slVK4h4u2a1aQfBp
 BB80bIvphTP3Vy1mY/0IolqxbBL5Y3O2XKv2EYl/vtW9kgHfOyESRUdxkdaoiDao5TDO
 +g2EwhuEPniaYh/DNDOhszysluKQp4ipdG6kFyl6atD5u4GVKferGlWvu97d5LlJJIua
 7UdUD4ZZe1QT7dqUcWUo0bSRS+ERFvvDBX8p1q8rnj8EjFYDBODPF/xI+kshy3zviToY
 hkLw==
X-Gm-Message-State: AOAM530odEUTC9dxF1atZdNNxgprCB2NghNaQmV3GMjxqseG2ptfvBES
 6OSlAQrLF4CnLHO+LA5v14BH3A==
X-Google-Smtp-Source: ABdhPJwlj1c3aXnPe3rSw4yEtZyTAvAuanw/PtIfWAAqmqzTP6Z/2QYYvtHDYUQHgCG1k/1r41UUfg==
X-Received: by 2002:a17:906:7e04:: with SMTP id
 e4mr53533541ejr.83.1594382280051; 
 Fri, 10 Jul 2020 04:58:00 -0700 (PDT)
Received: from wks.local ([86.121.22.151])
 by smtp.gmail.com with ESMTPSA id x4sm3492693eju.2.2020.07.10.04.57.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2020 04:57:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Separate notifications from list messages?
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <663720e1-7ee1-8d0b-df6e-ada96bfc3e8a@redhat.com>
Date: Fri, 10 Jul 2020 14:57:58 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <CFE41710-0440-4D27-BD1B-4FD47F2F41A2@livius.net>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
 <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
 <008CCEB6-D3F4-4F1A-80DE-83F47873851F@livius.net>
 <20200710085454.GD4017912@redhat.com>
 <94ACA177-24F6-461F-B12E-79958D713BF1@livius.net>
 <663720e1-7ee1-8d0b-df6e-ada96bfc3e8a@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 10 Jul 2020, at 14:43, Thomas Huth <thuth@redhat.com> wrote:
>=20
> ... The Gitlab messages that you
> can see currently on the list are from the main repository, not from a
> contributor's private repo!

I don't know why we should worry about contributor's private repos, but =
anyway, the GitLab workflow seems different from GitHub, probably not =
using pull request, and I hope you all master it, since I don't. :-(

> Now these problems
> get at least some more attention ;-)

sure, but is there anything the members of this list can/are expected to =
do to fix them? do these messages increase the people knowledge on the =
project? are these messages useful in any way to the list members?


regards,

Liviu


