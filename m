Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F02C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F95206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeFnmIXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F95206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cnE-0002Z1-Vn
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1j6cm5-00010N-5W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1j6cm4-0008BW-7J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:09:33 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b]:35447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>)
 id 1j6cm2-00088e-4g; Tue, 25 Feb 2020 11:09:30 -0500
Received: by mail-il1-x12b.google.com with SMTP id g12so11265158ild.2;
 Tue, 25 Feb 2020 08:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=bBxq4NlVT2GPfEQHH0hn7IMMrqDvaebxrDPcHRUCmVQ=;
 b=PeFnmIXiaQXXC1hZoM2/FOQBtn4LarKDEsvjyiZrpzK8iw4E2UVlU4HH6GpvmSJ0y7
 QJn1ZR4PP1964p1H5cLyiT0sKiJNQzovc3IPNX8n5g5gEAQN50Sp9zfCmJhIFMvtagof
 dTtLM0YWVOjwcEiqJzXm+hYalT96GGAe9+EF5qKCKZl+iguohVhoKoAcIoQ08OQkEMxA
 ALEa/qUjspBz+wPiwYccxf1fDZ+xoNAhzOwMH4wQw3bhA58gt14q6Yij9EybV4l2j/4J
 C1kQywJDY+v3PgdSk8tdMIuLKv2ei3cbYw5GgUfa6qNnzg0zifB/9r/myR49kD5J54xQ
 gKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=bBxq4NlVT2GPfEQHH0hn7IMMrqDvaebxrDPcHRUCmVQ=;
 b=gl9iyJhtFyzkXDfCGtFGGcvQv/D/KqbZtUOZQceOZTVg8XCur8w1F8+VzEI4vpobRp
 ef/9fRteN2VMp7sfEJW6e5uUNjaS4hG/xc8Mdxw/9B1djDtti8aWqGvYfQc1Xy8NB8D0
 cGuxL8MddoFXa4sJUemTHJsH+lfCJV/RJoYVFn3Wnn5+bVPQcM948gBSaGsYnQhvDhQm
 oZJxe868/MSB14S/b2nD6a6gKlEVDK9VL2xOzv2OtxI1jajw2G8pg2lD9LJTv2jmw2Ud
 +Ccqj1lDkcxwVcBg8yO8G3Ls/rrMXDSqdnQz8kUG81DOP79zrHnkeuYS1lLt1JB/Y66q
 Vebg==
X-Gm-Message-State: APjAAAXcW+1n2Njp/BY0i72y6/r72Lx7Xg5uuLrL6h1qv8KvbLPwKVd4
 +7+jPSvOpGtJ2VXIQSG24w4d6UjScaexcctfvDk=
X-Google-Smtp-Source: APXvYqzihMF67D637iOTQRASMq8d5Y/DQGqcGg8S2RvIEt9WmGR4Nnm1bzUynkgr5HxgldJSaZFAARvggtgly0kO3Zo=
X-Received: by 2002:a92:b749:: with SMTP id c9mr67810506ilm.143.1582646968592; 
 Tue, 25 Feb 2020 08:09:28 -0800 (PST)
MIME-Version: 1.0
From: Wayne Li <waynli329@gmail.com>
Date: Tue, 25 Feb 2020 10:09:17 -0600
Message-ID: <CAM2K0nreUP-zW2pJaH7tWSHHQn7WWeUDoeH_HM99wysgOHANXw@mail.gmail.com>
Subject: Problem with virtual to physical memory translation when KVM is
 enabled.
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12b
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
Cc: qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear KVM list members,

We developed a virtual machine using the QEMU code.  This virtual
machine emulates a certain custom-made computer that runs on a certain
military platform.  All I can tell you about this virtual machine is
that it emulates a computer that has an e5500 processor.  Currently I
am running this virtual machine on a T4240-RDB which has a PowerPC
e6500 processor.

Anyway, right now I=E2=80=99m trying to get this virtual machine working wi=
th
KVM enabled.  But the problem I=E2=80=99m having is the VM doesn=E2=80=99t =
do anything
after the KVM_RUN ioctl call is made (NIP doesn=E2=80=99t progress and no
registers change).  What seems to be the problem is the VM doesn=E2=80=99t =
run
the instruction that=E2=80=99s supposed to be retrieved from the virtual
address 0xFFFF_FFFC.   When KVM isn=E2=80=99t enabled and the VM is running
using TCG (tiny code generator), a branch instruction to 0xFFFF_F700
is retrieved from the virtual address 0xFFFF_FFFC and the VM kicks off
running from there.

So what could be causing this problem?  I=E2=80=99m guessing it has somethi=
ng
to do with the translation lookaside buffers (TLBs)?  But the
translation between virtual and physical memory clearly works when KVM
isn=E2=80=99t enabled.  So what could cause this to stop working when KVM i=
s
enabled?  Or maybe I=E2=80=99m not understanding something right and missin=
g
what the problem actually is?  Let me know your thoughts.

-Thanks, Wayne Li

