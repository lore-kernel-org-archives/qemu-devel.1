Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A47BC2D0DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 13:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A5F206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 13:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlTA/6ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A5F206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikT5w-0008PC-45
	for qemu-devel@archiver.kernel.org; Thu, 26 Dec 2019 08:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xtay.haibin@gmail.com>) id 1ikPdT-0005M9-9X
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 04:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xtay.haibin@gmail.com>) id 1ikPdS-0005UZ-0T
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 04:40:51 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:38798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <xtay.haibin@gmail.com>)
 id 1ikPdR-0005UL-SR
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 04:40:49 -0500
Received: by mail-io1-xd33.google.com with SMTP id v3so22841194ioj.5
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2019 01:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wCLA/PSGT41lqfZjAzBzt7VOUHSCAs3pEfyu9//foac=;
 b=PlTA/6uedB4E86rmMG6HvL/My91PmkdsU2778kXIIeFpvyNVeY5uXVYedrVy2nSqZN
 CN99YHTztJjWo6Ol/TXlyNoRFZ+p71yazf+Z1BjL3nowYkG4m9hTsq1qtyZUINa+Z+8K
 SqukWRQqOw6zdTE6PJZtHGk+CxWkC9W29oKgx9dLpQsnuRpCRnxAzqk0Ivsjq71YrC8V
 P1E0Y50dFk9a3Pv22qIuvMAnI+1NUlcBR4uxILJfz6bmXqvvkZdS5J4W8sxNcoRi9txD
 kv7cnMMsN10mKfXHDHlcbt1h3i7eka1haYEjn/Rwe7QS30ruzw/4pB05/G6vnVM4V0yx
 qsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wCLA/PSGT41lqfZjAzBzt7VOUHSCAs3pEfyu9//foac=;
 b=CjeIhGa21vhs1yqeq8cYEb4h9iUnn/X0KzIbnRY9XS9IPonQ3minq2axdiIDDf0lHd
 8EPz47mpbKnbET6oXsGMvP0u/h0c8j0SEU4IaL/yDlDXQaSYpUDVINEqH5ny2JkQyNa6
 8x/C0FdmsX6/qQUmfEN8Kb+bbmfjhEzMmKLLrogeRp8P4c4Faka+9Sd17Fzb4z49dzSe
 RPimeJAow5SwqeuOO0Do0T5RvMb7epEW2TSlB+qs3k4KmRnB/MZYigR40/4EyUQEgij+
 Frw6tf9LcgE1WULAp88YBA9YYGkFz96kcO/vjubmKY1IKtZr+UDC5xCgZI0Sm29iZKBg
 VXQg==
X-Gm-Message-State: APjAAAWGG0dyXrjv62LAbHde1M8GGvWX+8jKzy2z6Zk0JLwycQj16ojQ
 CYKyul9gi4rPo2ZK0mau7t0l86NvUlmeCNZhkqG7pQ==
X-Google-Smtp-Source: APXvYqwLijKVeACBda1sUxVcrEYPMIeR266mkrvS6hDFt1MbQxGIYei2D/6c6603iTPvP9TcUl/WD5b5pb3qoSGPGHo=
X-Received: by 2002:a5d:9309:: with SMTP id l9mr29990312ion.202.1577353248503; 
 Thu, 26 Dec 2019 01:40:48 -0800 (PST)
MIME-Version: 1.0
References: <CAP0gKjUf4+Jf2GSZy8u5fwQAU2V9bk-viuSBByB5bo78NWHpbQ@mail.gmail.com>
 <20190328170759.GH18536@stefanha-x1.localdomain>
In-Reply-To: <20190328170759.GH18536@stefanha-x1.localdomain>
From: =?UTF-8?B?5byg5rW35paM?= <xtay.haibin@gmail.com>
Date: Thu, 26 Dec 2019 17:40:22 +0800
Message-ID: <CAP0gKjVqMEKF2gq4Xq8hX=zo-cM3vw2Xw70pajfQOvFj4-wvbA@mail.gmail.com>
Subject: Re: How to impove downtime of Live-Migration caused bdrv_drain_all()
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d33
X-Mailman-Approved-At: Thu, 26 Dec 2019 08:21:55 -0500
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2019=E5=B9=B43=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Mar 28, 2019 at 05:53:34PM +0800, =E5=BC=A0=E6=B5=B7=E6=96=8C wro=
te:
> > hi, stefan
> >
> > I have faced the same problem you wrote in
> > https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg04025.html
> >
> > Reproduce as follow:
> > 1. Clone qemu code from https://git.qemu.org/git/qemu.git, add some
> > debug information and compile
> > 2. Start a new VM
> > 3. In VM, use fio randwrite to add pressure for disk
> > 4. Live migrate
> >
> > Log show as follow:
> > [2019-03-28 15:10:40.206] /data/qemu/cpus.c:1086: enter do_vm_stop
> > [2019-03-28 15:10:40.212] /data/qemu/cpus.c:1097: call bdrv_drain_all
> > [2019-03-28 15:10:40.989] /data/qemu/cpus.c:1099: call replay_disable_e=
vents
> > [2019-03-28 15:10:40.989] /data/qemu/cpus.c:1101: call bdrv_flush_all
> > [2019-03-28 15:10:41.004] /data/qemu/cpus.c:1104: done do_vm_stop
> >
> > Calling bdrv_drain_all() costs 792 mini-seconds.
> > I just add a bdrv_drain_all() at start of do_vm_stop() before
> > pause_all_vcpus(), but it doesn't work.
> > Is there any way to improve live-migration downtime cause by bdrv_drain=
_all()?
> >
> > haibin
>
> Thanks for your email.  Please send technical questions to
> qemu-devel@nongnu.org and CC me.
>
> That way the discussion is archived and searchable for the future.  It
> also allows others in the community to participate and double-check any
> answers that I give.
>
> Stefan

