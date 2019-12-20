Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C26C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8052C24679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBtjhJnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8052C24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiKvu-0004In-MR
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iiKur-0002Vn-D8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iiKuq-0006q5-1o
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:14:13 -0500
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35]:33689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iiKup-0006pd-R8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:14:11 -0500
Received: by mail-qv1-xf35.google.com with SMTP id z3so3824227qvn.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 08:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=dga8GK0tNNZduQ6hsHWxJpGLWJSmov5vi9EQuoBaS0k=;
 b=iBtjhJnB+PbPbwOE/EsfWgWV9mJKpZRUMCQghmTcA8eTxTsj9SzTrhRM/CFykKzSzY
 g+EOjivvQGK6hQDYD7U5F15RITD1Qq0wZm07LeWMr8x3PXSi5I9PIps+ixKq+RcBRcHO
 b0ISlp6t9QlG3Cjj0bkOQYhteUXdrGhD0nxYRtwq5KIwak06BQyxpkU3CdWrIjQqU5tq
 SLCz8axjIm4K2yOV3n5A4SXTJ19gGwedb7VNoePYchCcRfe9nLVH2uHFQMAktYXTA7Hl
 q0ULhgagXwIVBYZSJZyXSvW1FAh35DV+hFvEOdlCUocUNRlttil/rjJ9/jJArHrXTdRH
 /M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=dga8GK0tNNZduQ6hsHWxJpGLWJSmov5vi9EQuoBaS0k=;
 b=rPlx/DBs6MvYq2ZxAUgUBGKWwhMBPgZMMFmWXIk5jTykjIQ1sqPpLs/YfgDuPZvgc7
 HpYvZEGY0dDEATm6/bHsqu9zUfTVsJMQUz3UtR4tSR4S3HtCjZ2Ziyghqc7xqPtw4p3A
 S9Np/M7yIsSpG/z5mWsg3Mu28k6r1Q/63lqYVm2LefnEK8FHX6y57cv1cPezC388OvV5
 aOInKsXIfXuiM9gpFzVhbrauVe7cqvLbXBzSflis39eUeZxPRfRwWKiuhdw5WL3Z3cZl
 C/ItxDLCMx40qYFlTm16MM5Bod05St15tCh1R25aZPaIr9cqFQG1f5vbhbqt1VGUfdt8
 0FQA==
X-Gm-Message-State: APjAAAU1GykvGF2xr0hXjSElqZ2b2XwmgzXK+ZFfyaHtgaZ7WCBZPIt3
 IgrV60TxqOqKx5UNhZaaqbqN1yz69xJCvQYfJuUlzK9fbUI=
X-Google-Smtp-Source: APXvYqzI8gK19wLXL8E8e7WhaLOgFw1DHHWnTDwi/Ej+ck+rusiBIUYSEdPlnbWwL4wMxYwsSPF66GFNxlYlT2tRyUg=
X-Received: by 2002:a05:6214:982:: with SMTP id
 dt2mr12597377qvb.174.1576858450796; 
 Fri, 20 Dec 2019 08:14:10 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 20 Dec 2019 16:13:59 +0000
Message-ID: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
Subject: Making QEMU easier for management tools and applications
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f35
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
QEMU presents a command-line interface and QMP monitor for
applications to interact with.  Applications actually need API
bindings in their programming language.  Bindings avoid reimplementing
code to spawn a QEMU process and interact with QMP.  QEMU is kind of
lazy and de facto relies on libvirt for API bindings.

Is it time for better QEMU APIs?

1. We have qapi-schema.json.  Let's render to HTML and publish
versioned documentation online.

2. scripts/qmp/ contains command-line tools for QMP communication.
They could use some polish and then be shipped.

3. python/qemu/ contains Python modules for managing a QEMU process
and QMP communication.  This should be packaged in distros and
available on PyPI.

4. Go and Rust bindings would also be useful.  There is
https://github.com/intel/govmm but I think it makes sense to keep it
in qemu.git and provide an interface similar to our Python modules.

5. A jailer is needed to isolate the QEMU process and vhost-user
device backends using seccomp, Linux namespaces, and maybe
SELinux/AppArmor.  We used to be able to rely on libvirt for QEMU
security, but it's becoming a common task for any device backend and
IMO should be its own launcher tool.

6. A configuration file format is sorely needed so that guest
configuration can be persisted and easily launched.  Today you have to
create a shell script that executes a QEMU command-line, but this is
suboptimal because sharing executable scripts is dangerous from a
security perspective and is hard to parse or modify programmatically.

In many of these areas we already have a partial solution.  It just
needs more work.  I think it would be worth the effort and the mental
shift to really providing APIs that are easy to use by applications.

What do you think?

Have I missed things that are needed?

Have I included things that are unnecessary?

Stefan

