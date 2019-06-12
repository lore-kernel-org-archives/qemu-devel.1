Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A2C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E247F2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRrl6hss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E247F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6XE-0007dT-Pb
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hb6QN-0003F4-Tu
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hb6QM-0002UX-L8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:48:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hb6QM-0002TS-Cs
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:48:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id c2so17675902wrm.8
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KRwVLTXtlmRy5bNH/Ik5AZWTDso/oz5aQwRrbGmZSU0=;
 b=MRrl6hssBZFy7WKNNFUGWBsZWr48TeU5lNW5LapnpjZfUv8j9X1SYbvZLxuumx24Uy
 9bvdiAw5WvHzwzHZcgrJozK2sgsRR2L7NiajJnwmoN0xzgJ85vtWC7OnQd+AXOYxCMQP
 owW2b/HqW/PH5NcNPnXAr91X+6uI1WWv1zupa2a5sdJzK5bMglzK2mFYxJXKiyGJ77B5
 YlhJ9J9sEAm9JcRuWLOko+DHf4ic53nVmbtg2VyNNKrnsmaOsx6a0MHaKIH4U1vxnmf5
 P4p133+hGSxhtuoZJN/k9DDVrU7P1933N0QgKKbrirQBCETFmIZyn1XVZCamM76dH/u1
 w+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KRwVLTXtlmRy5bNH/Ik5AZWTDso/oz5aQwRrbGmZSU0=;
 b=LxLfTorQpEWlqo+mQ3dAbL+aKtt0yXiXBxq4HsAx+19N4ZKUbVDgdRwXCvTkMYcaEB
 gs0exnMccTJY+dUXBHpLhLnpmUQEKVFzIlVVxpuFNkCRdXXwUjFvFgCiSkFKD+o7eMKH
 a8HxfUam3PU2/yxFjRweHWvqgDyGdUNX8UIv4o2vgzfD4PkfNAMrvPWojaVt2V5ujM2J
 dt4yRAgvoZUKk3c8FFeZMMilDoXA1mwmYHC7NKZMpXTA67mX56RJ55TsEgTix/t/aI8E
 BXCYThDPiasuPX7Bmd2Pp2QtssNJYRvRMYST5ej+6YIQTCukyo/Nu6k5t5KAzzw3crhE
 xRaA==
X-Gm-Message-State: APjAAAWFTRYIkk2rcLgnh09wAvgnC3KoQRhWmRYwpwItWjDfuFsL+8L/
 rNdvlDMUhuxYVlECgwV4J7rgV19NnUq3wwQxnuzdig==
X-Google-Smtp-Source: APXvYqyk1IFIwcqB9pkpYWe13eFA0bvcOFgs9bTbvAUK7Ao+mEufCSHnxEX6oELFBizfX6hLjep1MF+CkpD9cJAZ7v4=
X-Received: by 2002:a5d:4603:: with SMTP id t3mr7548020wrq.315.1560358112698; 
 Wed, 12 Jun 2019 09:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOJt3afDmLtb1328ZWRvbO=SYgqtGZYX-aApTMoDPffiErygGg@mail.gmail.com>
In-Reply-To: <CAOJt3afDmLtb1328ZWRvbO=SYgqtGZYX-aApTMoDPffiErygGg@mail.gmail.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Wed, 12 Jun 2019 17:48:21 +0100
Message-ID: <CAHDbmO2cxxAv2Fqotfw8S8DBh7J+9oa67N8K_Ps_25vRbtpe3Q@mail.gmail.com>
To: Ryan Boyce <ryanpboyce12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

You've actually contacted the development list but I can answer the questio=
n.

QEMU is multi-threaded so there will be a thread per KVM based vCPU
(and also for TCG based vCPUs where MTTCG is enabled). There will also
be a number of additional threads created including at least one for
the main monitor thread and potentially additional threads for
servicing IO requests. So expect to see $SMP + 1 + n threads for each
QEMU instance.

On Wed, 12 Jun 2019 at 16:32, Ryan Boyce <ryanpboyce12@gmail.com> wrote:
>
> Hi Stefan,
>
> I am a big fan of your blog! In relation to your blog post,
> http://blog.vmsplice.net/2011/03/qemu-internals-big-picture-overview.html=
,
> I have a question I am really hoping you can answer:
>
> When I start a VM, I see that the qemu-kvm processes start and run as
> "qemu-kvm..... -name "something1"...."
> My issue, though, is I see multiple processes running as "qemu-kvm.....
> -name "something1"...." and each of these processes has memory/cpu/disk
> mapped to it.
> Does qemu-kvm run VMs on a one-to-one VM-to-host process basis? Or does
> each virtual cpu on the guest get its own process on the host?
> For example, If I have a VM that has 4 virtual cpus, will I see 4 process=
es
> (PIDs) on the host or should I see just see one for the VM itself.
>
> Any help you can give would be GREATLY appreciated. Thank you!
>
> Ryan



--=20
Alex Benn=C3=A9e
KVM/QEMU Hacker for Linaro

