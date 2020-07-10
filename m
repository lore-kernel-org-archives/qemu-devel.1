Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF84C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 07:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CA3207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 07:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="c+S2x7nJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CA3207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtnTf-0002RY-A2
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 03:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtnSm-0001xa-Sc
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 03:28:52 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:45989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jtnSl-00065V-4H
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 03:28:52 -0400
Received: by mail-ej1-x62f.google.com with SMTP id a1so4945716ejg.12
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=WjqfAGkAksY6AYdZk+rXH7hH11A68G1QINHCHU5BUzk=;
 b=c+S2x7nJjBboxiPrGO1v2edxMENTswDxa5dZQxv4QWc3WHR51mlZ79aMC7c5oYhVfK
 uw7NEk66RH4oQdXqZa7v1rlrzDpTt1PUcOv51uzJs0cx3YaPDXkc6uvfzw7ACkuRXcvB
 ZaqAotqLYNmStE9RqzTLWi7WMNVHQRNkalCCEflmjw9ouFi+ZsJeHuUtnEkRBwB3etiw
 PX5e1pGwfYM1mLyCcA0f46b+hYvk3b+ho1m0kN92gHWKCk0DULfv5UlW592WmnB687R7
 DfxbTF+iv+vXvyPo7go33H8MgFSuB+1kjW5Rth3o+wD2jD2kgb4FesVIbQOvD3j+malT
 pVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=WjqfAGkAksY6AYdZk+rXH7hH11A68G1QINHCHU5BUzk=;
 b=Yq9/fFCRksINjR+Kos0nIw0yTLpdp8G397535Ewx08XGdSzDmY2CAE4Opq7aynV0+e
 hXxeevIsuJFW7ZFxvP4KObgT0PdHUovSE6MqXRkM+0wjXyIShvF4VFxiu6IxhkfDszi4
 lSG8lQ5oNG0rBkVTvygjAmcMlcS1P1bqaeFjMK//R+W3SJwQkCpntH/OF8k075ybewY5
 P7i10T9sa+VP2yVo6bdcUmobWH36nP+SyH3T6WobKTG6w89/lSGH2003EDZKiNJMxXAJ
 MTtePE1xMpQoKt5TYtK9cyQw6Swkdy44JMkPzl/MSkcLI0VZF9OxpG49Xb1z33TLgZK7
 OK6A==
X-Gm-Message-State: AOAM5302rUfrsTgdM4GvSyVklEltnD8TBHs8sXF1SFL3Gc3/keXpUtYr
 Hr26IDJ0Hiu5e2wY9rTX56uG1A==
X-Google-Smtp-Source: ABdhPJzUgdJ1GEdC2bsnOON6AqOVXFas6un6PKHLmIg2flaY7Mn68hh55Ukj/GIutraYDMcTtrH/+A==
X-Received: by 2002:a17:906:57c6:: with SMTP id
 u6mr58732850ejr.194.1594366129360; 
 Fri, 10 Jul 2020 00:28:49 -0700 (PDT)
Received: from wks.local ([86.121.22.151])
 by smtp.gmail.com with ESMTPSA id w3sm3705057edq.65.2020.07.10.00.28.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2020 00:28:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Separate notifications from list messages?
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
Date: Fri, 10 Jul 2020 10:28:47 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D50B226-B5C2-4AC5-AC95-C7BE716FFFBE@livius.net>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
To: Thomas Huth <thuth@redhat.com>
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
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 10 Jul 2020, at 07:19, Thomas Huth <thuth@redhat.com> wrote:
>=20
> ... creating a qemu-notify mailing list for notification e-mails?

In GitHub it is possible to 'Watch' projects, and when doing so, you get =
various notifications.

Isn't something similar available in GitLab too?


Liviu



