Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5669C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518AB215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K12kRcUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518AB215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6c5-0005N0-QG
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57238)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ryanpboyce12@gmail.com>) id 1hb6S3-0004S5-1n
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ryanpboyce12@gmail.com>) id 1hb6S1-0004de-ND
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:50:18 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729]:34589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ryanpboyce12@gmail.com>)
 id 1hb6S1-0004c5-Hy
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:50:17 -0400
Received: by mail-qk1-x729.google.com with SMTP id t8so7101218qkt.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xqIVbIzYsqovppDRqXJiYVwSyt0hLDqAMfuJFn9u9nE=;
 b=K12kRcUwVjilN49bER95HfBMYKfS3MpzNZqB+F8ZjwUJdsC3RJT+XKD0Xecpfk4LTR
 /q+fEgIW8cRp568PZqFJvq0gITrTIXAKsgNIEmQSOQ6HL11PzeuKhxwZEOUmy2ByVxiP
 oMoAzEAtMI07gF+7Y/yHWpzgtBa0QbvTnNcxWwjaG53lfVCSpKWCNdQXr1JnP7D/Ms3x
 AuJnFSUSdXx3ss54LVTCR0tmGO8ri+beb27Q07vDhLIsy39pHN4mlNiBjOD+9FtI2nWw
 Rw0tRFN8hxL7zrCeSiVRdxUTM/NsDXmuP0PCGLGf4SUVeUuorhpGH3jmKlIqPJMye/1V
 W6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xqIVbIzYsqovppDRqXJiYVwSyt0hLDqAMfuJFn9u9nE=;
 b=W9FJyTvn4L+NFHwa3ghffEEeokP+Z4rjDmz/gY8Hc9deUrTNzjK5tJpE086mWNlPBO
 e8wbFk1aRIY+ejFX1YiTlsysuk+j1qYX9UbPvlx4qWP99rQ3ljV1c5Ld8WIr3ncDbrL6
 MxuzC1xeZANeaP9WKvprbz6CAwJorRBLlOPQvWSVvvmH/LfSmJxrx0RiB516sNMFxfuz
 aIY+9ktTyt7DrpbBV52V0WyZZDOU4iQ2Ht8E44dQNKrhQ0+tGyObe8eD4kenb9B0z16k
 cc2ogsH//dJUh0CKel+5wSlGTI+XcrrUwxrwMBNJtGvMUj/AdQNed2gq57zUsEI7zfSv
 c4+Q==
X-Gm-Message-State: APjAAAVTyZVkCerOPv8EFG5M5NbyVvuJtvJSuQ5Pt872u3pF+U+444tk
 nq/xUdtHe/KaYAboMVfS3RQ2h44pKGtmohL466s=
X-Google-Smtp-Source: APXvYqwgTcN/+ZX3xizAR6HE5kkm9l1mcgwq6YvQM4Wwzfb2C34zXwh0W8A59okjwXPSTLaegyez00QcTdAc4J4wFPk=
X-Received: by 2002:ae9:e30d:: with SMTP id v13mr47399925qkf.148.1560358216856; 
 Wed, 12 Jun 2019 09:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOJt3afDmLtb1328ZWRvbO=SYgqtGZYX-aApTMoDPffiErygGg@mail.gmail.com>
 <CAHDbmO2cxxAv2Fqotfw8S8DBh7J+9oa67N8K_Ps_25vRbtpe3Q@mail.gmail.com>
In-Reply-To: <CAHDbmO2cxxAv2Fqotfw8S8DBh7J+9oa67N8K_Ps_25vRbtpe3Q@mail.gmail.com>
From: Ryan Boyce <ryanpboyce12@gmail.com>
Date: Wed, 12 Jun 2019 12:50:05 -0400
Message-ID: <CAOJt3ad2HbohoBRv8Ey9fknBRGeiN1SJ7wAk9gX+Vpf4pig_KA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::729
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] qemu processes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you my friend!

On Wed, Jun 12, 2019 at 12:48 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:

> You've actually contacted the development list but I can answer the
> question.
>
> QEMU is multi-threaded so there will be a thread per KVM based vCPU
> (and also for TCG based vCPUs where MTTCG is enabled). There will also
> be a number of additional threads created including at least one for
> the main monitor thread and potentially additional threads for
> servicing IO requests. So expect to see $SMP + 1 + n threads for each
> QEMU instance.
>
> On Wed, 12 Jun 2019 at 16:32, Ryan Boyce <ryanpboyce12@gmail.com> wrote:
> >
> > Hi Stefan,
> >
> > I am a big fan of your blog! In relation to your blog post,
> >
> http://blog.vmsplice.net/2011/03/qemu-internals-big-picture-overview.html=
,
> > I have a question I am really hoping you can answer:
> >
> > When I start a VM, I see that the qemu-kvm processes start and run as
> > "qemu-kvm..... -name "something1"...."
> > My issue, though, is I see multiple processes running as "qemu-kvm.....
> > -name "something1"...." and each of these processes has memory/cpu/disk
> > mapped to it.
> > Does qemu-kvm run VMs on a one-to-one VM-to-host process basis? Or does
> > each virtual cpu on the guest get its own process on the host?
> > For example, If I have a VM that has 4 virtual cpus, will I see 4
> processes
> > (PIDs) on the host or should I see just see one for the VM itself.
> >
> > Any help you can give would be GREATLY appreciated. Thank you!
> >
> > Ryan
>
>
>
> --
> Alex Benn=C3=A9e
> KVM/QEMU Hacker for Linaro
>
