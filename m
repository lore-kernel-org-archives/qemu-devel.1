Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0842C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9905F2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWDHt0ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9905F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVXon-0000oN-TK
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 04:50:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVXnq-0000R4-8s
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVXno-0007Fm-V2
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:49:50 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hVXno-0007FL-R5
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:49:48 -0400
Received: by mail-oi1-x243.google.com with SMTP id y10so13649822oia.8
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=IZH0g2hdFiZAUchQCHE1dIygnMBF9Wc7c0QsC3o/rLI=;
	b=ZWDHt0ZJSTVG02p6fvAwPqVyu71ZLMNCrdJyYRiyR3BkEJUvt3gSsvK+698axv8xlE
	WQEhH8NCbYyySX/sXTWaRtjrsINTIkWOdtkpevhhoC2prxh4qRKBd7Gnv1gzPRc0zoAB
	hu+t0eSKILBBO+8t1nNEFxMOgPCdMnzIRr5TRwrjY+qnl9tv1r5gH0pJPA/MFn01OZqs
	vfUDirE3LszU3m5vp3K4MtitRrcWaUejTMqbM6yz/xB8rOm+4Wl/fr50qwO/CbQNbsGp
	RrVh82milc7O4pattTIU9VCIdJBL5QGa9q7TBONEFRdM1aUsKOKpm7mMITNYto/I7six
	d6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=IZH0g2hdFiZAUchQCHE1dIygnMBF9Wc7c0QsC3o/rLI=;
	b=anXfRflhzt8Hu2s1O/jNGFg/zTVLXJq+w2kejrMPfpa2sMpgkRfZFdGjxE7F8MWy2r
	YxwfdvosLHgERY3hKgih4cTAsq4cpS5gRHpkHOET2ds1WGH4Mpf71QiJttDTnuNThNQt
	xknRGwI2W6t0EnJBhWSpGJW8MeuU79+XrVtx9usHA5wdBdaGrEUHdw4qzT3cUMmpudn4
	seiIeOOF+Cqxmv03wRLm1Dzv63+19MZAq9uy5/wnuneKyb31qCDrKeofCyFzEJ2/4I09
	3icHw3iJGJnMYo63BcdmKaXxiNCsn3/lIUYeQa5Q+dxzrGuRNy9g2iE2RFBYKqfcElue
	bmUg==
X-Gm-Message-State: APjAAAX+IZHQfZpaoISiINQw2O3sYbXXtpFSCg+X0pyS21EYIhNnzS+K
	Q+BfkpJDnYw2yHJMTCjcQr4J3GK22b9YsG9F53E=
X-Google-Smtp-Source: APXvYqyncQz31QE9Sa0W1AajJxc6Vvfi49WlpU4SYPM5rOsh3yOk0GSQuMNLXWIxR93GiWeVmdoNblZmaGFwE4XH2U4=
X-Received: by 2002:aca:1916:: with SMTP id l22mr1994808oii.136.1559033387945; 
	Tue, 28 May 2019 01:49:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 28 May 2019 01:49:47
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 28 May 2019 01:49:47
	-0700 (PDT)
In-Reply-To: <CAP+75-W5TEV1i+qAkQCg2pwgeGLN18vbaHpsin+cGFNJywTAcQ@mail.gmail.com>
References: <20190311005618.19007-1-philmd@redhat.com>
	<CAL1e-=hJVsaMDFyB5O-7JWtNEZ8JE7hbe8-n35yDxKD=znT=XA@mail.gmail.com>
	<6781ecbf-27b8-8925-11f9-6b746f14ef9d@redhat.com>
	<CAP+75-W5TEV1i+qAkQCg2pwgeGLN18vbaHpsin+cGFNJywTAcQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 28 May 2019 10:49:47 +0200
Message-ID: <CAL1e-=hKtn10+9cGB3dPT3uC7nDTr8EfSF1JJ0-k8aoOzx3SwA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Kconfig dependencies for MIPS
 machines (but Malta)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>,
	Thomas Huth <thuth@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
	James Hogan <jhogan@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 28, 2019 8:49 AM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =
wrote:
>
> > On 5/27/19 8:31 PM, Aleksandar Markovic wrote:
> > > What would be the status of this series? I am willing to integrate al=
l
> > > this, including all followups, but have hard time sorting out what
> > > happend after this submission, what is the most complete version etc.
> > > Can you enlighten me please?
> >
> > Thanks for your interest in this series :)
> >
> > I was chatting with Thomas about this series earlier today!
> > I addressed your comment about the ITU/CPS devices, then wanted to join
> > all the Malta patches in the same series, but there are too many for a
> > single series so I'll keep them separate.
>
> After some sleep I could remember why I postponed this series:
>
> 1/ making the ITU selectable gives:
>
>   /usr/bin/ld: target/mips/op_helper.o: in function `helper_mtc0_saar':
>   ./target/mips/op_helper.c:1614: undefined reference to `itc_reconfigure=
'
>   /usr/bin/ld: target/mips/op_helper.o: in function `helper_mthc0_saar':
>   ./target/mips/op_helper.c:1631: undefined reference to `itc_reconfigure=
'
>   collect2: error: ld returned 1 exit status
>
> Anyway it is now selectable but has to be always selected.
>
> 2/ I thought only the Malta board was deeply mixed with the X86 ACPI
> code, but I later noticed the Fulong is too.
>
>   /usr/bin/ld: ../hw/isa/vt82c686.o: in function `vt82c686b_pm_realize':
>   ./hw/isa/vt82c686.c:381: undefined reference to `acpi_pm_tmr_init'
>   /usr/bin/ld: ./hw/isa/vt82c686.c:382: undefined reference to
> `acpi_pm1_evt_init'
>   /usr/bin/ld: ../hw/isa/vt82c686.o: in function `pm_update_sci':
>   ./hw/isa/vt82c686.c:195: undefined reference to `acpi_pm1_evt_get_sts'
>   collect2: error: ld returned 1 exit status
>
> Both VT82C686B/PIIX4 southbridges require considerable cleanup.
> I think I now have something workable, but I have to sell my patches
> correctly to the different subsystem maintainers ;)
>

I appreciate all this very much!

I don't want to rush you in any way, but just want to tell you that the
next MIPS pull request is planned for mid or end of the next week - so if
you judge some parts can be independently wrapped up by that time, by no
means send such set of patches. But again, it is up to you, no obligations
and no questions asked.

Au revoir,
Aleksandar

> Regards,
>
> Phil.
