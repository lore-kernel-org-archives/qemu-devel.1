Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB7C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 04:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C0020719
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 04:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgaReU0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C0020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCxb3-0006bJ-Aw
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 00:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kCxaX-0006BI-Eo
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 00:08:05 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:41371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kCxaV-0002IY-TV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 00:08:05 -0400
Received: by mail-pg1-x52f.google.com with SMTP id w186so1946154pgb.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 21:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=/IZfGdAHaY74I0GweMtYCs3e/Trpf3wot/3qi/A0klc=;
 b=pgaReU0t1TQS+eHVdYlFeLkRwXj5Dk9GobvPyKtO1g+20cBGU/6hxV7s+9+lyRF3L9
 7TRoFapFsgi+3R8g2Uv1kH6zV0qMxiZDYYtuUgBR1pJ4LyKGNiWYYkyULj04tR2KK/NN
 3OUc5jLJ0/escGmqMBgiNvFEZNAGb4udWzAktMTg88E6wYgI2fg3fWEiczRRbMXbqYnX
 gTuJTktwf8zchPnQIMvHUnOPvLZHymzLZ+MfpCvOHy4raKlrvd/qjx4Zb0ruTJaGYWSZ
 wyDilJ6f6ZRxCb3/1A11UJ7cLAIh+e6LVru3TSfjP2V7m/f2iITM3ALANcQ3xCrAGkUr
 0qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=/IZfGdAHaY74I0GweMtYCs3e/Trpf3wot/3qi/A0klc=;
 b=VlmPXuYL3vwB/2n+1BLdRBJUwsKLml3DUG8F6inmgmh6qjQJ/JDIhcxi6nRt4Vx8MC
 S/x6DEMTJCMLRV87q+Ylx+dxviN2+1EfO50jqYv8yclcfNB+9aa70TTSPJKKN9OVkf8m
 ypJrydFXG7kgb/pxkVKNeBU/QBmvAsHDqbaZu/hVsNIZGwyORqrwk22JjvYYdo6QllQ9
 Bm+xtJQ9MeZDV8VkFIl+ja8X5v5Zg6hdmxDmQhZV0Z0JyS0ZQl7h9Mrgyeb3KheDhAR7
 NJFqRqcRSmyyMJa7xz7MewQSUyfj+kCjiLRmOewYrb7mvev/tVC1R7alvl0RI991uv41
 2/Ig==
X-Gm-Message-State: AOAM533uP1A1XGuGiAkdHL3XwGQS0cCjuhqGGdXMyMBbvHGqAUhrc5Jy
 uTW0zN2A60PEYDumAaZpxzpZ4JOSoYDcdbwj6u4ql6jgE1c=
X-Google-Smtp-Source: ABdhPJwEi5HeZWjObEGAo/P0b1FNFpFonj/gGyFV7EbLUj6WhUG3yLWKRL0h+iyIfC9RVDpI/zvxkAJDTbDgOWCAL6M=
X-Received: by 2002:a63:757:: with SMTP id 84mr3822742pgh.377.1598933281241;
 Mon, 31 Aug 2020 21:08:01 -0700 (PDT)
MIME-Version: 1.0
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Mon, 31 Aug 2020 21:07:50 -0700
Message-ID: <CA+Ai=tA_u+BCC0Etgu421240mdmGZBPccSRmLc9hcMpyi_0BSg@mail.gmail.com>
Subject: Contributing to x86 device emulationi
To: QEMU Developers <qemu-devel@nongnu.org>, mst@redhat.com,
 marcel.apfelbaum@gmail.com, 
 pbonzini@redhat.com, ehabkost@redhat.com, mtosatti@redhat.com
Content-Type: multipart/alternative; boundary="0000000000003f7f3b05ae38aac6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003f7f3b05ae38aac6
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I am a software engineer working as an SDE in the industry and I have been
wanting to contribute to QEMU. I mailed earlier introducing myself to the
mailing list and I was told to talk to specific people who work with the
subsystem I want to contribute to.

I am interested in contributing to the following areas of QEMU: KVM, x86
device emulation and storage optimization. I was hoping that I could get
some pointers on areas where I could contribute to. I am a bit lost since
QEMU is a vast project and I don't really know whether any
specific features are being worked on. If I had a goal in mind, that would
make it much easier to navigate the codebase as well.

My skillset is as follows: 3 years of work experience in Java and Python,
experience in designing and developing backend systems, APIs, deployments
and productionizing Machine Learning algorithms. I have knowledge of C/C++
as well, but I am a bit rusty there.

My questions that I hope to get answers to are these:

   1. Is there any specific area within x86 emulation, storage optimzation
   or KVM that I could contribute to? I am willing to work on chunks of
   projects too, if there are any that are ongoing.
   2. What background knowledge do I need for contribution? I have a good
   understanding of how the linux kernel works. I also have a decent
   familiarity with x86 architecture.


Thank you for reading this far and I look forward to hearing back from you.

Thanks,
Rohit.

--0000000000003f7f3b05ae38aac6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello everyone,<div><br></div><div>I am a software enginee=
r working as an SDE in the industry and I have been wanting to contribute t=
o QEMU. I mailed earlier introducing myself to the mailing list and I was t=
old to talk to specific people who work with the subsystem I want to contri=
bute to.</div><div><br></div><div>I am interested in contributing to the fo=
llowing areas of QEMU: KVM, x86 device emulation and storage optimization. =
I was hoping that I could get some pointers on areas where I could contribu=
te to. I am a bit lost since QEMU is a vast project and I don&#39;t really =
know whether any specific=C2=A0features are being worked on. If I had a goa=
l in mind, that would make it much easier to navigate the codebase as well.=
</div><div><br></div><div>My skillset is as follows: 3 years of work experi=
ence in Java and Python, experience in designing and developing backend sys=
tems, APIs, deployments and productionizing Machine Learning algorithms. I =
have knowledge of C/C++ as well, but I am a bit rusty there.</div><div><br>=
</div><div>My questions that I hope to get answers to are these:</div><div>=
<ol><li>Is there any specific area within x86 emulation, storage optimzatio=
n or KVM that I could contribute to? I am willing to work on chunks of proj=
ects too, if there are any that are ongoing.</li><li>What background knowle=
dge do I need for contribution? I have a good understanding of how the linu=
x kernel works. I also have a decent familiarity with x86 architecture.</li=
></ol><div><br></div></div><div>Thank you for reading this far and I look f=
orward to hearing back from you.</div><div><br></div><div>Thanks,</div><div=
>Rohit.</div></div>

--0000000000003f7f3b05ae38aac6--

