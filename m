Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0BCC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485BD215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr8u4yyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485BD215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5GH-0002vw-BX
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 11:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ryanpboyce12@gmail.com>) id 1hb4Gr-0007rU-Qw
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ryanpboyce12@gmail.com>) id 1hb4Gq-0001Yu-FB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:30:37 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736]:42029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ryanpboyce12@gmail.com>)
 id 1hb4Gq-0001WO-9A
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:30:36 -0400
Received: by mail-qk1-x736.google.com with SMTP id b18so10353731qkc.9
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ImOfGg/A1brqrjpD2IyZgEanWzUHKgjeNrIiJg7JVi0=;
 b=Yr8u4yyBC0k7TJl1kLeR39AS6xKN7bmncTdq6ZSsx6GWai9MQGujd5DtVJWe9DCKaw
 UZQSES3MqsOoPloKR4HIqClF04srMYRKHzpjxIkMgmpoLJeHeucx+cFHlQeSOfB6jNTv
 pV6gBDi/sllYtYAUAVHi3JyDtMyRn4PjWGymtKnxYv5vTA5RJ2hj1ExOj50haXk1c6jq
 lFVqioryM8nFMMzfhDRF/llKEA1ffD9+qpKwPJrv1Fl7ED7gXUfBsRZY0aQHGbrKfbz9
 ROtXpKGfNsSwujnYKWoiQh/7QXj11PNniiRmHpjTUF4/UhS7QH+cDx39A0xeendwP0M3
 4CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ImOfGg/A1brqrjpD2IyZgEanWzUHKgjeNrIiJg7JVi0=;
 b=CwLXwVjD+/8K876GuUI2IIHaYFxqVdI/nggonMqNH7tngJcASVH/stWyR/kK6OfuJl
 DfSk8AfZ3ZqHAyPQHJNahbeUxj9F+A2c8WL/T7RpvTGcim87qM2Wv1AukkyI+T3ypFaa
 RFYeyJ2v2u52i8EH4p8KgrzxYyy1GPandD9cRSbw8lIf6fGtAjVfVtVTCWs2soVJxQ/u
 c0P4JkwKemNeK1OPW+zZMlu6wm8yP8A4p3h7eoPujiaYxxIFGGriBHozr6okYpTAm+bK
 aoUKGpWLrIi0V3WQoa7e2J0iI70XWwFw2fgGVEzx07SWopwQSgGyme/b7vG0sZywZh5R
 9YQA==
X-Gm-Message-State: APjAAAVZdOnSKALlmeYY1G6Ywag+e7knvaecYehP1eQviWSbV847wTrg
 zvqeFFjqh+8TwjyuXRMz58CjpOMt3PwVRzMgiSNQOKt4
X-Google-Smtp-Source: APXvYqwtFcJUM4cRWq9WLbWPvvZ7JR3yDIcMEbu7s/w3RbLCXEK7nsUzYuBEHI3LvdJTaItJHBwyvOCpUSATAPQhToY=
X-Received: by 2002:a05:620a:12db:: with SMTP id
 e27mr55237581qkl.352.1560349834828; 
 Wed, 12 Jun 2019 07:30:34 -0700 (PDT)
MIME-Version: 1.0
From: Ryan Boyce <ryanpboyce12@gmail.com>
Date: Wed, 12 Jun 2019 10:30:24 -0400
Message-ID: <CAOJt3afDmLtb1328ZWRvbO=SYgqtGZYX-aApTMoDPffiErygGg@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::736
X-Mailman-Approved-At: Wed, 12 Jun 2019 11:31:19 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] qemu processes
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

Hi Stefan,

I am a big fan of your blog! In relation to your blog post,
http://blog.vmsplice.net/2011/03/qemu-internals-big-picture-overview.html,
I have a question I am really hoping you can answer:

When I start a VM, I see that the qemu-kvm processes start and run as
"qemu-kvm..... -name "something1"...."
My issue, though, is I see multiple processes running as "qemu-kvm.....
-name "something1"...." and each of these processes has memory/cpu/disk
mapped to it.
Does qemu-kvm run VMs on a one-to-one VM-to-host process basis? Or does
each virtual cpu on the guest get its own process on the host?
For example, If I have a VM that has 4 virtual cpus, will I see 4 processes
(PIDs) on the host or should I see just see one for the VM itself.

Any help you can give would be GREATLY appreciated. Thank you!

Ryan
