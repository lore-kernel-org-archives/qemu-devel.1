Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C838C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF7A2166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0eluZal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF7A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjz9-0001ui-Sn
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSjxo-0000yg-0N
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSjxm-0002Ue-Qc
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:44:47 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d]:45511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSjxm-0002UU-Mh
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:44:46 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id g12so945249qvy.12
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EMmd4iKH/4s5U3pWYWke9TyQHktktE8Mv42vUiBcIvI=;
 b=N0eluZalvP+mjleI8b6i4pdWaZUxffFaajUnpHk75QsyQN7uz/SUY2vVln9Te9Eh5l
 pHKAD2s8WRQ+NsMsVOEkkuF0GLJMcpkF19KGoWSPJjGJYaOsddLQmFypDoW7xc+zLnuy
 9FZPlatoj3rVdxpCpFzVVoZLaFzbxZyNKUexwhfy+mUN4+WP1j15kChR6Ujk8ShdjEwI
 AMRsjM1rSdPSqGpNZtbQid39860jK6qZucNUfSRkB+Pcc0OO0tGapq9rY7SA2GRubil0
 RpzabaDse0t5puoVcZmKSe+/knM9DJF3mKR1L29tW5G9VTLd6J4o4tybSLOV+XSxeA2j
 VeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EMmd4iKH/4s5U3pWYWke9TyQHktktE8Mv42vUiBcIvI=;
 b=idX6xK2pSQTqmvXAGHf7c6NeYIFLCDtBI5BG/V53XVRro49RxTKV6MAylu+3s9g039
 Vm5rs1Z0w7vCF2eEx3luekuKNXw0j+9BzRTstAFnQM+MjDSLPL9/knPF0W5gaFeotNds
 E0hIV7JlPysa2LmlnI+CA9affPhUjXkbDGRcjQoP+DRn5ISHT1oON2kkbB0Eb85rZdMD
 fRqYUhTqCYPlDdPqLhLGNaeZtg75UC4j25N9MWurPdSGtsWA8bZZdJ3augl1nkATEeDT
 XX1zGoQ7u9QtqCjgANFPm7igIfiXwr4gRnN90ViorQmvrxVmZlQ6ebgRY0IG/pGSY8eu
 76Kg==
X-Gm-Message-State: APjAAAULzaIr2F9jDYEpYIXoHFIeiAOGFgC1/QSkKE+K5FgTcirE4Ls5
 f3qWdpCJZHmsLvob7XwOvZleW2o5AcDCfUjHD3M=
X-Google-Smtp-Source: APXvYqxf+Cc01boqevYVff7E/f3zUvuGVm5EWL58TdyZXIX4kb0bl4VaawM/rpFdD8hXjdII+bPuCPvGAYKkXW6R/FY=
X-Received: by 2002:a0c:9637:: with SMTP id 52mr3959070qvx.174.1573141485881; 
 Thu, 07 Nov 2019 07:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20191106161928.GA353373@stefanha-x1.localdomain>
 <20191107100606.GA120292@redhat.com>
In-Reply-To: <20191107100606.GA120292@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Nov 2019 16:44:34 +0100
Message-ID: <CAJSP0QX6awKBSx_idYfXB85e09Tp6gKLRvO+zrk-+zrOiySC-w@mail.gmail.com>
Subject: Re: QEMU HTML documentation now on qemu.org
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f2d
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 7, 2019 at 11:07 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Wed, Nov 06, 2019 at 05:19:28PM +0100, Stefan Hajnoczi wrote:
> > Hi,
> > You can now access the latest QEMU HTML documentation built from
> > qemu.git/master nightly at:
> >
> >   https://wiki.qemu.org/docs/qemu-doc.html
> >   https://wiki.qemu.org/docs/qemu-qmp-ref.html
> >   https://wiki.qemu.org/docs/qemu-ga-ref.html
> >   ...as well as interop/ and specs/
> >
> > Feel free to link to the documentation from the QEMU website and/or
> > wiki!
>
> What's the reason for putting on wiki.qemu.org URL ? It feels like
> having it under www.qemu.org would be a more natural home, especially
> if we can then make it pick up the jekyll theme around the pages.
>
> Ideally we should publish the docs under versioned URL when we
> make a release. eg  /docs/latest/....  for current GIT master
> which I presume the above is tracking, and then a /docs/$VERSION/...
> for each major release we cut.
>
> That way users can get an accurate view of features in the QEMU
> they are actually using.

Versioned release docs should be generated during the release process.
I have CCed Mike Roth.  That way the docs are available as soon as the
release drops.  This container image only runs once a day and would
leave a window when users cannot access the docs yet.

Moving from wiki.qemu.org should be possible.  How does the jekyll
theme you mentioned work?

Stefan

