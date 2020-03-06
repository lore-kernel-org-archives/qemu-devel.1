Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3BCC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855032084E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855032084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAD1k-0004jJ-O6
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jAD0r-0003y7-WB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jAD0r-0003la-22
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:27:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jAD0q-0003fw-RO
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:27:37 -0500
Received: from mail-vs1-f70.google.com ([209.85.217.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jAD0p-0001zF-Ta
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:27:36 +0000
Received: by mail-vs1-f70.google.com with SMTP id 123so248008vsg.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 05:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xZvT8uUNZMylziLw6p34RRvwz28sCmZkC3j+MAmH1cY=;
 b=o78Oaj4YUahXBVxnsHQ527M6mdo+EsfpMM94PDOCQki6eNOQWZ2qXnvYg3wbJdqEdF
 wZb7ygiih4673ValaNauwtX60GAiZUQXhOfqVlVKzF1bjp2amtY6L7j5ljFfjaezlBy3
 KiZy16e5zSv4t+gbX+KiYtuvTju7z+f4zXHmapGbbP9jQCSmsev5vT/zKke02mzUTOiC
 PXebKJDvWrHZkfzNQL7ZOuMfLxX9EpjM93onoZbuaz5218/63ZSEWp0RI8DmsphhGtb4
 s/J49SrJOhWowq9g7HVHcInAVLcK/qAjHZXMPwPAEveq1hcNEUZIGO6MYH/PtGvQ2tyT
 aX0Q==
X-Gm-Message-State: ANhLgQ06mglfHvYtgx1B3fqHVWzdK6/fCg4tMMYVBtUV9gUX0hlB/rYo
 M2eb7gPDyhrgjGxssDEhdgpkUjJKZ7lnpoZu/gjbBs2z9gI3mwSQTvWyuukpnY2agZJxVaBpZnm
 4wffUDxD0G6dcDAWpMf2/e+mLH4mSPdrvv4xHr1NSq/FEMITp
X-Received: by 2002:ab0:670c:: with SMTP id q12mr1616902uam.120.1583501255078; 
 Fri, 06 Mar 2020 05:27:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs3w+81WB1bvMo8BztGMuU9IcVTk151PZqqCudO7ulAafDNjlarUkHe2rMqIlh0Gj+5/qQrJuBZzgYPMfP0mvE=
X-Received: by 2002:ab0:670c:: with SMTP id q12mr1616893uam.120.1583501254865; 
 Fri, 06 Mar 2020 05:27:34 -0800 (PST)
MIME-Version: 1.0
References: <CAATJJ0L+jdk3ggWx61=AGoTd-FZ64tJ1tzPK8Frgg9Ez+dv6XQ@mail.gmail.com>
 <20200304093946.18682-1-christian.ehrhardt@canonical.com>
 <20200306105426.GH1335569@stefanha-x1.localdomain>
In-Reply-To: <20200306105426.GH1335569@stefanha-x1.localdomain>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 6 Mar 2020 14:27:09 +0100
Message-ID: <CAATJJ0+XYK5My==A0o+o9BhRDuN9H3=GQX89kMB1VbfNM4QFOw@mail.gmail.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000cc51e505a02f9d31"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cc51e505a02f9d31
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 6, 2020 at 11:54 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Mar 04, 2020 at 10:39:46AM +0100, Christian Ehrhardt wrote:
>
> Please start a new email thread.  Patches sent as replies to existing
> email threads are easily missed by humans and tooling also doesn't
> recognize them.
>

Sure, thanks Stefan for the hint about how that will be processed/looked at
by maintainers and reviewers.

-- 
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--000000000000cc51e505a02f9d31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 6, 2020 at 11:54 AM Stefa=
n Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On W=
ed, Mar 04, 2020 at 10:39:46AM +0100, Christian Ehrhardt wrote:<br>
<br>
Please start a new email thread.=C2=A0 Patches sent as replies to existing<=
br>
email threads are easily missed by humans and tooling also doesn&#39;t<br>
recognize them.<br>
</blockquote></div><div><br></div><div>Sure, thanks Stefan for the hint abo=
ut how that will be processed/looked at by maintainers and reviewers.</div>=
<div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Christian =
Ehrhardt<br>Staff Engineer, Ubuntu Server<br>Canonical Ltd</div></div>

--000000000000cc51e505a02f9d31--

