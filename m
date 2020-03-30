Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B023C2D0F0
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2E2206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJyGUskf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2E2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvWn-0001kp-2b
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 10:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pankaj.gupta.linux@gmail.com>) id 1jIvVy-00013w-DJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pankaj.gupta.linux@gmail.com>) id 1jIvVx-0007Ud-Ig
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:35:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jIvVx-0007Tx-DT; Mon, 30 Mar 2020 10:35:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id a81so22183475wmf.5;
 Mon, 30 Mar 2020 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=16yctrKz6PeR//HmjBayt3TUQ0DvdcEV3/Db6mM3UiA=;
 b=qJyGUskfOMpBy+VqPJE+G7l7vN4wS7sqS5odb2u5Pzhk1TXXZWzKQBYuKIrx298YEB
 IsS4Qie9nkOYaoPXfXhpshI9MAynar56bvyqTbt1qwptIawwI3v4gAj7eKs3tun65iIi
 WfvCBd9sxk/y+nb9TowAEWcPtkLijihW+U11tjWkHPJza8Xu+4lj9cGSqWL3MtNr+1aK
 KwDiuTN3V4AVp8gR5By8fP6ucEIu1j/0Grnu2rn272B1gVtZ8ycjulQuCC3QglRGMXqV
 xczBaAZobDy3GrI2yG9Du/xXfKOKyeHu7TZ0xE9j/i+ASi8mkCrSoBhAkaYcWi+ogpZB
 X3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=16yctrKz6PeR//HmjBayt3TUQ0DvdcEV3/Db6mM3UiA=;
 b=FsNJ7HbyQghVratNIjXq5/+H/ucQPMYyXO6CW5LfOFYNTFiRfw3H2L7agmkgShkSIr
 Ejef1CIKJyIoewGwbAUA1jK/uTxO0Vpot3T0FN4SU+QsoUr9kgLcK1+m8mMFUNFy7zU+
 t3QZJCTSgudXYcOnMpDKWG4TQBXC61OyvpzQhE1jX73Np3v9ckjl2igd09OWM3rt+hRy
 IcRhdkiuMgMkeMQiW2AzC0Alp0mcYuFHFqeFxok9S02i98OCIgqvvCSAhYvuXM8U6Wea
 Qe9RMvBqyo1TTvYgVK22A6nVr6dKwUCDB0axX925h0GaJARUmgc2mi4MUAtZuc1c9xcp
 987w==
X-Gm-Message-State: ANhLgQ3mYGnBjoHL2zPkjUpA+Cyv1IYPjSZHgOnO0r4pdhtTzywMk3mw
 ETO2EcffHsT3ppiORybDNYWkmOghbA3Bvpk1BPg=
X-Google-Smtp-Source: ADFU+vvR1RuQ9JqDD2wjLSLFKuBc0IeHLNefbM7aBoxuFTgAQVTwNKlAplmuXWBP0WUebaAyNZyuzGpiLwuVKs+OaRU=
X-Received: by 2002:a1c:5506:: with SMTP id j6mr13771855wmb.127.1585578944241; 
 Mon, 30 Mar 2020 07:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200320103041.129527-1-stefanha@redhat.com>
 <20200329094907-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200329094907-mutt-send-email-mst@kernel.org>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Mon, 30 Mar 2020 16:35:33 +0200
Message-ID: <CAM9Jb+iXRKGJ4a-3e9B-qcFekQWk6EeXmGfNaoYu_NQOh_fcUw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 0/4] virtio-pci: enable blk and scsi multi-queue
 by default
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, slp@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For best case its really a good idea to configure default number of
queues to the number of CPU's.

For the series:
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

