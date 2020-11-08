Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5EDC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 12:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137D0206ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 12:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffG9grne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137D0206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbjj9-0006nN-44
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 07:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshavardhan.unnibhavi@gmail.com>)
 id 1kbjhc-00065I-0v
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 07:21:48 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b]:45010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harshavardhan.unnibhavi@gmail.com>)
 id 1kbjha-0004zr-3K
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 07:21:47 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id i186so5568658ybc.11
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 04:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TKRjSusmbFE97CfGY7ez/BiODtxZr8rPRCt8YvgkDF0=;
 b=ffG9grnePX7xhpf+T3lTNg+2ek88JyZA9Nrcs1Z5wHuo84MW0fMyeUMhAN98++n+PB
 +bALch5G/KuTJvZTuFMNlw5b3c7HRcUbtB9GZ1oyPsEs8v9I/u/zs8i6q4Ezs2ZK2UbC
 tG6WtHYRp8aPenmzm7oM/3r/HwFUBGZ6K9ndTx1X2YVse4SA1r4HNTnHQxO+ioeXwdGi
 MHGIWDb6YL4zkZ6DSXBZXu7J94LLXAvDlD5KkRoAEbJ4VXvRa1/Lhg4Z1J2Nq6yhWd4J
 uGrnDWifc3NpVg2oQNgyw6VH9Ef/XXPk5InDCuMePnLaj6pHOvRXerfsV0D9dnRhJmZh
 hTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TKRjSusmbFE97CfGY7ez/BiODtxZr8rPRCt8YvgkDF0=;
 b=i8NBEa+vpDw1vM+dPeFOpAKe7pVnCTIeK6x7lB1OMj9drv6iMDyTpIEKN8+MNko5Xl
 1qETG+IaAex3wu6HKpzEAANNItMCw57WI1U+ivD9gnzgaNkNWFnI49TiIdj7Bki/8XaA
 3xV2ekiwIZdngo2Ox4mUVKtMQLm8+MbLNCeJt7zyyahJXTIOaq8/296Nk0lw2KDpyub/
 UR8SOsIk5LThknX35QEPKkyubfpCO+8tS5QH5LJfd6kpFSHVmyVD13+cu0OqSWG1HaUr
 C8LXBXKLmLOLzkPosp+/n+M0YBm//GMJcXldZ6nbKGUZTDu20DpnttWFMVK2TIkURFr3
 1fUA==
X-Gm-Message-State: AOAM533LcWaGbNK9fZejn3J299749wz/5I2DpM1tFPyLB+AMYKD7Yzvj
 76V9w+6zAIouUpO8RpLIAMMt6T2mJL7qRAAYWkk=
X-Google-Smtp-Source: ABdhPJwLhvYITxSENTkQNc4HPBsBoHoNJpTsytK1JUn0xu1JGvPhsNSf4QfmGE/MAnhszPWfgXchc1y/BNgUdTM878Y=
X-Received: by 2002:a25:8c8:: with SMTP id 191mr13858691ybi.121.1604838103771; 
 Sun, 08 Nov 2020 04:21:43 -0800 (PST)
MIME-Version: 1.0
References: <CA+8xkr4ABLeYam6EPBdMKkX=HB3gik079zxUyo1TF91sCXmoQg@mail.gmail.com>
 <e84575ae-4eee-ca5a-e4ca-9b1660a8799d@redhat.com>
In-Reply-To: <e84575ae-4eee-ca5a-e4ca-9b1660a8799d@redhat.com>
From: Harshavardhan Unnibhavi <harshavardhan.unnibhavi@gmail.com>
Date: Sun, 8 Nov 2020 12:21:33 +0000
Message-ID: <CA+8xkr4t4s8=dCp6MjcH59y_6KPO0a7-pNi0-A-8Ft14kP6F2Q@mail.gmail.com>
Subject: Re: Qemu first time contribution
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=harshavardhan.unnibhavi@gmail.com; helo=mail-yb1-xb2b.google.com
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Thank you for the reply! Yes, I understand that gsoc is over for 2020,
and projects for 2021 will come up next year. I was thinking of
contributing outside of gsoc(for which I won't be eligible anyways for
next year). Anyway, I will work on some of the bite sized tasks, and
get back to you for some other concrete project ideas that require
somebody to work on, in qemu.

Best,
Harsha

On Sun, Nov 8, 2020 at 8:44 AM Thomas Huth <thuth@redhat.com> wrote:
>
> On 07/11/2020 20.18, Harshavardhan Unnibhavi wrote:
> > Hi,
> >
> > I am looking to contribute code to QEMU, a software I have enjoyed
> > using for my own projects. I want to contribute to developing a
> > specific component in the project. I was looking for possible project
> > ideas and came across this page:
> > https://wiki.qemu.org/Google_Summer_of_Code_2020 . Is it ok to start
> > working on a project I pick from here? For example I am interested in
> > the " TCG Plugin Cache Modelling"  and "NVMe Emulation Performance
> > Optimization".
> >
> > If not do you maintain a list of components(or issues) that require
> > some work or new features to be added?
> >
> > Looking forward to your replies.
>
>  Hi,
>
> thanks for your interest in QEMU! However, GSoC 2020 is already over, and
> the projects for 2021 haven't been defined yet (as far as I know). But if
> you want to have a try with a small task first, we keep a list of rather
> small and easy tasks here:
>
> https://wiki.qemu.org/Contribute/BiteSizedTasks
>
>  HTH,
>   Thomas
>

