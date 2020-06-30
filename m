Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D623C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B612073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B612073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDuO-0000CZ-Mz
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqDtk-0007me-Ec
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:53:56 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqDti-0004kz-Ra
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:53:56 -0400
Received: by mail-ej1-f66.google.com with SMTP id a1so20028236ejg.12
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qvZmXmCzoJs8e++lQW8aPezqDVriYPEc5XJQep48QVA=;
 b=FRBtvsda0aO384iBU/+L0CryfS8PTadeIb+MKsviuXRj5vhZnNjXl7NHRzTNygRFWP
 piUAQFuTl4V3ZBACdSevk9wXZwY+gcY0+yI2bn52l7bKv0zjaISEibOJjc/upfZnoq5T
 +xnfw+0TLMJDPMW9LEDACC2jn1KJeKbCeFFI+shPpGZ2gdOLvlKXUMFcpmitWUURjrQ5
 WEdbi9tUHjKWGGHCM9070yFrhZp/fIhUa6BqfmVPvdTS06czUOnXp9dKJXaaAddWNt7q
 QtgbS/uGNJ4r4BlfiHcct5SuLiWGSOx74A9HWNcIjv3rqPBwka0kzAXFpVNTVadzJYYJ
 uaPw==
X-Gm-Message-State: AOAM5319AmWmKrSB/2+pKFxfX1AQ16LBPaaxjgUlFEioNudBZjxou8ja
 IGRNjd0qXwWWoDqNWiPzDXAw2apBHkxlUpq+be4=
X-Google-Smtp-Source: ABdhPJxMdoxqnd4cmnUer1/VNLf0xnrDXr+n9RjZ7bmTtR804NVMdtFoGhBPoqf/AXmILIfNmlorMAPUZOhIZJNhb1U=
X-Received: by 2002:a17:906:a1c7:: with SMTP id
 bx7mr12167864ejb.388.1593514433347; 
 Tue, 30 Jun 2020 03:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
 <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
In-Reply-To: <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 30 Jun 2020 12:53:42 +0200
Message-ID: <CAAdtpL7MObRjk77ZFsNF4Xoghdj33mwufZ9s3L8fAC3XxkJCqA@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 06:53:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 12:52 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
> >
> >
> > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Phi=
lippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> > <mailto:f4bug@amsat.org>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >     Hi,
> >
> >     Following Jiaxun Yang's patch and discussion:
> >     https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>
> >
> >     - Rename the current machine as 'malta-virt' (keeping 'malta' alias=
ed)
> >       Suggestions for better names are welcome, maybe 'malta-unreal' or
> >       'malta-unleashed' instead?
> >     - Add 'malta-phys' which respects hardware restrictions (on RAM so =
far)
> >     - Unleash 'malta-virt' to allow more than 2GB on 64-bit
> >
> >     Philippe Mathieu-Daud=C3=A9 (7):
> >       hw/mips/malta: Trivial code movement
> >       hw/mips/malta: Register the machine as a TypeInfo
> >       hw/mips/malta: Rename 'malta' machine as 'malta-virt'
> >       hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
> >       hw/mips/malta: Introduce the 'malta-phys' machine
> >       hw/mips/malta: Verify malta-phys machine uses correct DIMM sizes
> >       hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
> >
> >      hw/mips/malta.c | 121 +++++++++++++++++++++++++++++++++++++++-----=
----
> >      1 file changed, 99 insertions(+), 22 deletions(-)
> >
> >     --
> >
> >
> >
> > Thank you, Philippe, for providing this series.
> >
> > However, in previous discussion on the patch you mention above, I
> > already expressed serious reservations on the approach taken in that
> > patch. These reservations stay today too.
> >
> > There is nothing qualitatively different between the original patch and
> > this series. Naming and related stuff are just cosmetic issues.
>
> OK, what about considering all patches except the last one?
> So we can run firmware on a real Malta board, not the QEMU
> imaginary one (in the discussion you said QEMU should respect
> real hardware, which I agree).
>
> >
> > The good thing about this series is that one can apply it dowstream, if
> > one finds it useful. However, it is not suitable for upstreaming

IOW, what is missing to have this series (except the last patch)
accepted upstream?

> >
> > Regards,
> > Aleksandar
> >
> >
> >
> >     2.21.3
> >

