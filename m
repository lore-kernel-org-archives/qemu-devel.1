Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0372EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DFE20732
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZMO2J1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DFE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY3Ce-0005As-1c
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 04:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kY3Bn-0004OF-Ed
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:21:43 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:42802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kY3Bl-0004nr-Ls
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:21:43 -0400
Received: by mail-pg1-x530.google.com with SMTP id k9so25648pgt.9
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JomJ1RIb8/Hqj8nt3YnCKvf/OuL+A23/4ZgfdVsIKcU=;
 b=RZMO2J1PIAKmayDB80aVTjBtYhPl7NiJQ+WKNjE/xNi5VT7/sfQex6fPVk2RN/ImlO
 gkmV/7avBGNBk+sZtatKdJsHrJbSCIYGJGo/sgklt0mQlguVZOAAUAGYrGbJ4zh+bHqn
 xY4wAppcE1077MU6r9/gUYGuXpyQSqnjIAuOhvOMTyeTCWDzK2/SBj/saOvs0rM9y8+F
 XAGcO6bn1HqNkH3cy7N0uPXsmY2ElRUCUhb3g1KuEpHpPljyu1YOh8oCASyUPBjFsdrk
 RqQ4fs927OzHQaGFA+m7mBnnXFAcDnnM3clApR1nw19dwsGYF0yp9iokz3LiEow0cZjd
 1SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JomJ1RIb8/Hqj8nt3YnCKvf/OuL+A23/4ZgfdVsIKcU=;
 b=gIuXKo6YBWcA3MrQnqGUvDsYiE2ayQg9gZqymp8uftw3rK+HBlyUs7rSX2kZLw1wAc
 SewHlP2XxfreUoe6znHq4koKvuRzKLEZ55BqNv3lGUEmT8jUjxGP2932yA8AU7R33SUr
 ohiN5xhvdu4zGUim7EQLKfx1Q9pLIL2dsF+Ugs/3XEhSJclESYs1r8Piy7OQ+rWLd1Ta
 iD3NWAsCyktRBcVTW4HjNHGW3irXiaJoZ0/FNfUdLiF+YZ61E2fkESAZPpXwWzKM1uJl
 MRXvnxesMPbvP4EETXgnsuyTW81hKVwEvGQwgdi0kkIV8XsdLc/Bd6fFPRiQNzUjDlBv
 ovMw==
X-Gm-Message-State: AOAM532BEq9gMvDdwdRwzEx4uoTlo8UVDOdYGQnBNueUI2mQ8ObSo6cB
 v6ITPCxOV0zBv9boNoXe7TkVAT7IODSnZ6Wbheo=
X-Google-Smtp-Source: ABdhPJyGp1TUk9zVqON1UCzmm28hnCxVDEPZ/8gJUWfNJQKAwUP6PwEtyj42orWw7I7agWIzAxCOFEPlaEK9MEIgcQQ=
X-Received: by 2002:a17:90b:3882:: with SMTP id
 mu2mr3155402pjb.112.1603959700110; 
 Thu, 29 Oct 2020 01:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201027151400.GA138065@stefanha-x1.localdomain>
In-Reply-To: <20201027151400.GA138065@stefanha-x1.localdomain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 29 Oct 2020 08:21:28 +0000
Message-ID: <CAJSP0QV05M6e8rHtRw5ua=5=knfu+BfL-UQ99-btXxuMUrpybw@mail.gmail.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>, Jag Raman <jag.raman@oracle.com>,
 Sergio Lopez <slp@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The session will be at 11:00 UTC. The meeting URL is
https://meet.jit.si/QEMUOoPDevices.

Stefan

