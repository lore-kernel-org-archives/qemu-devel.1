Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618AC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E622087D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H60SjOa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E622087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1U2-0004zx-L1
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kS1Qu-0002jj-Uv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:16:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kS1Qs-0003dp-U4
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:16:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id t9so20035926wrq.11
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=q0IJAeFhEPdGKkF1Q3nAsfliOreCWd6cakg1ko1efZM=;
 b=H60SjOa8i7pod9Fj6M3G0bNtj2VgJGeIU3piKlExXMygSPehY1uma8IRx6l3fYN9OI
 b7eviwPfg//GdCvvwZg7lAT2NHj75AzQcoqxB8iSrlBJDWlQaN8rStQF+QXEd86vchZA
 rvlxCC1ika9zqy1uufTN0evAsTCfMRyraRaCIZ440WMhj/EX4Fn59S9GNvmgGS5tz26I
 5TtO6MQrWpH6yXbF+79GMGaAu3wMcDUd6Jj/rWRyAz9ur8vf7Y0u+9u8Ab75uIRDx1+t
 zi9ubZnLqHhghXWZDREFvdASIWw+yBhib0MrRxJCV70ecw5UUnIp15yTStBwsp2hZA7I
 HIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=q0IJAeFhEPdGKkF1Q3nAsfliOreCWd6cakg1ko1efZM=;
 b=PS17bTgaGl70rx4qMvHNx9BFFx5Mcb0wTINmLS0R/fjI/qG6mLsppmauvbuFMUyVpl
 TulM9nOffgInu0KlynCwM2EBuku0Tcp4oZyfNiikpCagmvtICF2BeFM+fC+9rf/aD7kQ
 952/OHzFL29iZkJ8PPSRyfXNPo+KNg9bbjXLVplDONJWz712KpdUyXP2ieLPPHTdBSC7
 h0AHBclMKFURqebMeEMMZ4p7vvZJ/PqJjU4IOjBeq+VZfECpWz/nL9VhREUWyEjXs7Gk
 u0UhhTPXNhPpU/zokRDIT1yy7Q33qyFURpBZxh3RmJTOuESu50+KFx6Me0b0gTZtAb1L
 XCyQ==
X-Gm-Message-State: AOAM531/DZa4dhkbWV2Ud06XuYwDyE/mFM45yFV/sFFJR6qY78q+FEnD
 Hozj3nBTa6ONoWm2up08Z2/wNg==
X-Google-Smtp-Source: ABdhPJyViCBoPU2YTkS/89w6vM/QDIa6heLxn3qBGuQOEnjP383UNrFduFQujbtbQjq3Rf7O6r8xtA==
X-Received: by 2002:a5d:6149:: with SMTP id y9mr31585132wrt.352.1602522980801; 
 Mon, 12 Oct 2020 10:16:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z191sm23860909wme.40.2020.10.12.10.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:16:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 803E71FF7E;
 Mon, 12 Oct 2020 18:16:18 +0100 (BST)
References: <20201009161815.GA321402@stefanha-x1.localdomain>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Requirements for out-of-process device emulation
In-reply-to: <20201009161815.GA321402@stefanha-x1.localdomain>
Date: Mon, 12 Oct 2020 18:16:18 +0100
Message-ID: <87ft6jz7od.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Daniele Buono <dbuono@us.ibm.com>, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Hubertus Franke <frankeh@us.ibm.com>, rust-vmm@lists.opendev.org,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> I just posted the following on my blog to outline the requirements that
> have been discussed over the past few months around out-of-process
> device emulation (vhost-user, vfio-user, etc). I hope it's helpful for
> covering various angles of out-of-process device emulation.
>
> It's long, so no worries if you don't want to join the discussion.
>

Nice post.

> Security
> --------
> The trust model
> ```````````````
> The VMM must not trust the device emulation program. This is key to
> implementing privilege separation and the principle of least privilege.
> If a compromised device emulation program is able to gain control of the
> VMM then out-of-process device emulation has failed to provide isolation
> between devices.
>
> The device emulation program must not trust the VMM to the extent that
> this is possible. For example, it must validate inputs so that the VMM
> cannot gain control of the device emulation process through memory
> corruptions or other bugs. This makes it so that even if the VMM has
> been compromised, access to device resources and associated system calls
> still requires further compromising the device emulation process.

However in this model the guest intrinsically trusts device emulation
because it currently has full access to the guest's address space. It
would probably be worth making that explicit.

There are security models where the guest doesn't need to trust the VMM
or particular device emulations.


> Conclusion
> ----------
> This was largely a brain dump but I hope it is useful food for thought
> as out-of-process device emulation interfaces are designed and
> developed. There is a lot more to it than simply implementing a protocol
> for device register accesses and guest RAM DMA. Developing open source
> libraries in Rust and C that can be used as needed will ensure that
> out-of-process devices are high-quality and easy for users to deploy.

A useful exercise ;-)

--=20
Alex Benn=C3=A9e

