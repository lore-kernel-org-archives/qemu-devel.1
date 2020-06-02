Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D9BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 18:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D2D20734
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 18:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ul2nTHtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D2D20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgBmM-00018u-Fl
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 14:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jgBlh-0000EI-25
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 14:36:09 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jgBlf-0003VU-Um
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 14:36:08 -0400
Received: by mail-io1-xd41.google.com with SMTP id h4so8633366iob.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=E5kB349qPSwX27+o8Rqn2/Bjfsyq6rA2EO1yuyc7SpA=;
 b=ul2nTHtuF8gusCJZLu83Lv3b+fZkn1KOH36ssL+MMu+a93ukM8Rkk9ux9F3X5Ubeg1
 rPZUYwVr7yl7XJWBC00wADV+p3r5sn6DlPhDxxx26vL0JQGnHNKO+4bbrdeyaamdgc0G
 dXbJxdo9qR93AEyo8Fcm/3qGYHam2bt9FrUES0wL4sk7GIYgLlQwSTBHkx7lhkdXdHuC
 inhkPKhQD/62av2Z8QU3VKcsa0ao8qwSDZxTCRwsk+0jKeyo6wC0pTTdvNL0hCj5P4Ul
 b+biIaxDPxDQeg9A1fDxZ66gZ5LtDjp/SimARivrgO38xJdemxhN7DStgMHo0nrO7oAR
 mmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=E5kB349qPSwX27+o8Rqn2/Bjfsyq6rA2EO1yuyc7SpA=;
 b=la6pcULUlao2EBTQzP1+SplWMOboGhHCgP7rm6bNi/xyFi43jGdp2Na/PpbbzGUQf4
 /j/rWnEAbG9jNDkWKpyo9OE0j7HyNkX9i3aCzYrNBanfcCvgEiHMYaGq660cfu2aRXMY
 mkltznw3dAGyEIT8ffF72amssA2jvjLAo3A83ZMYvxzgFRRqMS4CxtCmZJbHS4IMrh9h
 UJv2Xb9HcsHdEW4TWW8xeWYphkakrLNJiaCBEGQHggBOwzY452lZiJztSmzvdSVTBLND
 3+N1Qe0oHij9ogeaU0p7rSZl/wBCuAnf4DyjoSVgKA0aVzwdRaCXT7Mo9HJmetgrN2tg
 eDXA==
X-Gm-Message-State: AOAM53344XNwqhmpISEg1ZVQZg0bGAO6dMJRUb19VY/MkxT8H9Iu/HKM
 mupH2+16oPbdMf3nrzHTetKvyHQlBDc/75VNXq0=
X-Google-Smtp-Source: ABdhPJxUXq5CEVyt0HJ4kxbmuFH9U/Oab5TklJwR1+1uzVNnhBSTGuPIMBzdX0LEKtgW2KPaHn5jTsK9gswLePrj9SU=
X-Received: by 2002:a05:6638:dd3:: with SMTP id
 m19mr27212294jaj.106.1591122966438; 
 Tue, 02 Jun 2020 11:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <CALQG_Wh7eMt9U3gWkZZGDq0RFvWfuSVoiNBRNnPS_cDVfUc30w@mail.gmail.com>
 <CAFEAcA_1+rDcjD7Lyk9ESSkPAKmJwF=0ZdwkgQYUDp8Gtn6jHA@mail.gmail.com>
 <CALQG_WgP=ZebEMrXh_EpQJXqJPi48i6nwZU_yWq7VqhV_=eTVQ@mail.gmail.com>
 <CAFEAcA_iW_0jTk=9hCh+UatyhY_HFgzmZeSxqqyUCH19Vv1jCA@mail.gmail.com>
In-Reply-To: <CAFEAcA_iW_0jTk=9hCh+UatyhY_HFgzmZeSxqqyUCH19Vv1jCA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jun 2020 11:26:56 -0700
Message-ID: <CAKmqyKPHsLtp09kmydg+JawJm67ryW5h+Am3hu2Jx-T0K_xtDg@mail.gmail.com>
Subject: Re: gdbstub.c CPU clusters not handled for ThreadInfo packets
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Luc Michel <luc.michel@greensocs.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 2, 2020 at 10:27 AM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Tue, 2 Jun 2020 at 18:19, Fabien Chouteau <chouteau@adacore.com> wrote=
:
> > Le mar. 2 juin 2020 =C3=A0 18:44, Peter Maydell <peter.maydell@linaro.o=
rg> a =C3=A9crit :
> > >
> > > By default gdb does not attach to all clusters (this is IIRC somethin=
g
> > > that can't
> > > be influenced on the QEMU end);
> >
> > You mean I cannot have QEMU attach all clusters by default?
>
> I mean that the end of the gdb remote protocol connection that
> decides what to attach to is gdb, not QEMU. In theory gdb could
> be improved to automatically attach to all available inferiors,
> or the remote protocol could be improved to allow the QEMU end
> to say "I recommend you attach to inferiors X, Y and Z". But
> at the moment that doesn't exist so the best you can do I suspect
> is going to be to script gdb to do the attaching without you
> having to type the commands yourself.
>
> > > are you explicitly asking it to attach to the second cluster?
> >
> > So far the behavior that we had was to see all the CPUs without asking
> > explicitly.
> > I want to go back to that behavior because the current situation is a
> > huge drawback for our users.
>
> That works when there's only one cluster. When there's multiple
> clusters, by default gdb will show you all the CPUs in the first
> cluster. Would the behaviour be better if the other cluster in
> this machine was the first (default) one?
>
> > > https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg07035.htm=
l
> > > is a mailing list post from January which gives the gdb commands whic=
h
> > > ought to cause it to attach to the second cluster on this machine.
> >
> > The commands:
> >         target extended-remote :1234
> >         add-inferior
> >         inferior 2
> >         attach 2
> >         set schedule-multiple
> >         info threads

I just updated the QEMU RISC-V wiki to include these steps:

https://wiki.qemu.org/Documentation/Platforms/RISCV#Attaching_GDB

Alistair

> >
> > Do not work for me, "attach 2" in GDB asks me to kill the debugged prog=
ram.
>
> Hmm. That's the behavior for 'target remote' but 'target extended-remote'
> ought to support multiple inferiors. What gdb version is this?
>
> thanks
> -- PMM
>

