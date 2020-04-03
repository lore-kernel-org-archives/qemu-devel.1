Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024D5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50F52073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASkpleTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50F52073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKM1y-00033b-Tp
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 09:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <singhalsimran0@gmail.com>) id 1jKM0z-0002No-Bp
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <singhalsimran0@gmail.com>) id 1jKM0y-0006s9-3T
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:05:41 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:36536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <singhalsimran0@gmail.com>)
 id 1jKM0x-0006rA-Po
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:05:40 -0400
Received: by mail-lj1-x231.google.com with SMTP id b1so6875852ljp.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k5Hzy6rwpNvfq3Ww4WBkDY/9rq13JFNlYwuihUKT0k0=;
 b=ASkpleTRKtC/4KgbFC49qrFImemqZGX875fri7W373gDY16HFqwVjIK/i4RRlYquru
 Zsvr+snW79YgR7x6/yQRtR1d66KDpZQ4RvMH7kfhXKWwOB/TJE+5AUQ3Jna4F0pjw50B
 tCok+b1uETOLUQngNXjGWip1cnxFHLxQgFZB7npEjISZhTbGtU1/ReIV5NL8R7OME/ES
 U7AH5tzPK772+FmWGOEBRxzmSRhYAZ+vbIntPManos4sYQtZuTxrTVOaPhVVgV3ao6cH
 d/zbtntsCoXEawkkNxMU8cuZIa8Nv+os3VFPYqlpzdNMgHgWboSLKdUSl5vjNQGHp8Ng
 q/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k5Hzy6rwpNvfq3Ww4WBkDY/9rq13JFNlYwuihUKT0k0=;
 b=SwioOkiVMerIPd7pAuBTIFnFiGxaGPrYlu0mttIKKEO+LC27i/BEmRdBuPUJ4Ah6ly
 Cs5QeM7v7w8nI3y76OUh7Zr58KU8XlRxv7I4q+LR/myoLFPRK2MagOBtDYuIpTJcpNQs
 79e+PJ9esaFqdqKjJAuggos8zWiD081y4NT2K83LNMyPAUTLFDhXyHgbkUrJk6Zd+iz5
 NtdVYv3JzwP4xNV8EVL53IacnSiG0F3tiMQvVdDgAfGfuT3dKbSBrJY3YxML85aMhTQ1
 3amH2alcOkf54Qr6SSHEiyb23xKiZKj20gefRSkvpMhAI6BHDx5tbxXn3FA/8PEvBKr6
 6gjw==
X-Gm-Message-State: AGi0Pua0hxur8cnhCGuG9jRBhpF4xRUJXK+DqW1T6ahIYNXFMNR86VuW
 x1+oz7qyXhQDrpULK7TF5U3EcoXJ+7k1xZbfnBs=
X-Google-Smtp-Source: APiQypKvPEV1VHdq0cgHaFjpzkZsq/l5jStFQeM3SMfMRHXSlGx1P9ZLp5v/y+MLWnYmLPJ2kn6PhuGySBLGlRva0jE=
X-Received: by 2002:a2e:8954:: with SMTP id b20mr4671099ljk.176.1585919137880; 
 Fri, 03 Apr 2020 06:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200401162023.GA15912@simran-Inspiron-5558>
 <158576745359.20436.14792001046810935798@39012742ff91>
 <20200403130013.GE146016@stefanha-x1.localdomain>
In-Reply-To: <20200403130013.GE146016@stefanha-x1.localdomain>
From: Simran Singhal <singhalsimran0@gmail.com>
Date: Fri, 3 Apr 2020 18:35:24 +0530
Message-ID: <CALrZqyOuw1vxivEJhT2g3Qb9UAdKT9xKekJjyn4zTTcDYuq6tg@mail.gmail.com>
Subject: Re: [PATCH] lockable: Replace locks with lock guard macros
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000db1c7b05a262920d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::231
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
Cc: Daniel Brodsky <dnbrdsky@gmail.com>, Julia Suvorova <jusual@mail.ru>,
 qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000db1c7b05a262920d
Content-Type: text/plain; charset="UTF-8"

Hello Stefan

On Fri, Apr 3, 2020 at 6:30 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Apr 01, 2020 at 11:57:34AM -0700, no-reply@patchew.org wrote:
> > Patchew URL:
> https://patchew.org/QEMU/20200401162023.GA15912@simran-Inspiron-5558/
> >
> >
> >
> > Hi,
> >
> > This series failed the asan build test. Please find the testing commands
> and
> > their output below. If you have Docker installed, you can probably
> reproduce it
> > locally.
> >
> > === TEST SCRIPT BEGIN ===
> > #!/bin/bash
> > export ARCH=x86_64
> > make docker-image-fedora V=1 NETWORK=1
> > time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14
> NETWORK=1
> > === TEST SCRIPT END ===
> >
> >   CC      x86_64-softmmu/hw/i386/x86.o
> >   CC      x86_64-softmmu/hw/i386/pc.o
> >   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
> > /tmp/qemu-test/src/hw/rdma/rdma_utils.c:74:5: error: unused variable
> 'qemu_lockable_auto__COUNTER__' [-Werror,-Wunused-variable]
> >     QEMU_LOCK_GUARD(&list->lock);
> >     ^
> > /tmp/qemu-test/src/include/qemu/lockable.h:173:29: note: expanded from
> macro 'QEMU_LOCK_GUARD'
>
> This patch series depends on Daniel Brodsky's "[PATCH v4 0/2] Replaced
> locks with lock guard macros" patch series.  I think Daniel intends to
> fix the unused variable warnings.
>

Yes, I saw that patch series.
I'll send the next version after Daniel Brodsky fixes the unused variable
warnings.

Thanks & Regards
Simran Singhal

>
> Stefan
>

--000000000000db1c7b05a262920d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello Stefan</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 3, 202=
0 at 6:30 PM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stef=
anha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Wed, Apr 01, 2020 at 11:57:34AM -0700, <a href=3D"mailto:n=
o-reply@patchew.org" target=3D"_blank">no-reply@patchew.org</a> wrote:<br>
&gt; Patchew URL: <a href=3D"https://patchew.org/QEMU/20200401162023.GA1591=
2@simran-Inspiron-5558/" rel=3D"noreferrer" target=3D"_blank">https://patch=
ew.org/QEMU/20200401162023.GA15912@simran-Inspiron-5558/</a><br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; This series failed the asan build test. Please find the testing comman=
ds and<br>
&gt; their output below. If you have Docker installed, you can probably rep=
roduce it<br>
&gt; locally.<br>
&gt; <br>
&gt; =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D<br>
&gt; #!/bin/bash<br>
&gt; export ARCH=3Dx86_64<br>
&gt; make docker-image-fedora V=3D1 NETWORK=3D1<br>
&gt; time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14=
 NETWORK=3D1<br>
&gt; =3D=3D=3D TEST SCRIPT END =3D=3D=3D<br>
&gt; <br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 x86_64-softmmu/hw/i386/x86.o<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 x86_64-softmmu/hw/i386/pc.o<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 x86_64-softmmu/hw/i386/pc_sysfw.o<b=
r>
&gt; /tmp/qemu-test/src/hw/rdma/rdma_utils.c:74:5: error: unused variable &=
#39;qemu_lockable_auto__COUNTER__&#39; [-Werror,-Wunused-variable]<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMU_LOCK_GUARD(&amp;list-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0^<br>
&gt; /tmp/qemu-test/src/include/qemu/lockable.h:173:29: note: expanded from=
 macro &#39;QEMU_LOCK_GUARD&#39;<br>
<br>
This patch series depends on Daniel Brodsky&#39;s &quot;[PATCH v4 0/2] Repl=
aced<br>
locks with lock guard macros&quot; patch series.=C2=A0 I think Daniel inten=
ds to<br>
fix the unused variable warnings.<br></blockquote><div><br></div><div>Yes, =
I saw that patch series.<br></div><div>I&#39;ll send the next version after=
 Daniel Brodsky fixes the unused variable warnings.</div><div><br></div><di=
v>Thanks &amp; Regards</div><div>Simran Singhal<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Stefan<br>
</blockquote></div></div>

--000000000000db1c7b05a262920d--

