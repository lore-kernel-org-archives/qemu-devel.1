Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B891C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 05:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8FF2087D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 05:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4SvkjVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8FF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRTvC-0005sq-KX
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 01:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kRTt4-0004ch-HN
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 01:27:14 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:44590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kRTt2-0008RE-Ok
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 01:27:14 -0400
Received: by mail-lf1-x141.google.com with SMTP id b1so11578230lfp.11
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 22:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=BXr6Qv9c19rLUAFC72iyMLSJkX8fR5TDPxOXRWfLo6E=;
 b=Q4SvkjVK4tQ4PInpkVuq++Gnpxwlgej6KTKzWEOs2Q/Bz2/HkypNARzSev4FwnVP91
 qlacBzHNmZpE6lnK34B4kESW5Bgo8Qh5lffptegokv0EIW3Mytcv2gkDS5JgA55zJ3ah
 CuY1x9F7KHQcvizo1n3VOBiK3yYITNXCbramrDdyaZO0nEp6rlanFgvlYNiUPFwr2lp6
 HDZWfqhe40I70EnKYievR5V8FQnpT6llQUZ9IHGPUJ99Mh52qhnCdLTelS7aKy2pqbdu
 vG+p5l4TAerErm39K8iivmD2yikm6/2Ud7ynZCt3rDmBllNwDQKGKD1FuiEKwXK07S5q
 EtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=BXr6Qv9c19rLUAFC72iyMLSJkX8fR5TDPxOXRWfLo6E=;
 b=ZGF+I8VaxAfzqEnBeIWIi+9zZ3qBNqwnSF5rIVA0iokUoyj6zz5whfgQzXx720INie
 zdu5OUBIDtgiUFAP/70EBqnW79OY8uanTiWoOM5aJe8OFzWL116m0Nr84V0GDGwVPmtV
 p7gfVcc/VLXJLJJpvrjhfWmHjuJie6+8HPlMHVK9ZypEPJvr1jsUgnc7lEX3ahyYJ4bu
 9zm30jP2x9TqYkJGTC7o8PFIj0ekjZoEaxqlANxWH4QPH2+POdMV/iTvvB4sCK7VvJPF
 Eh0ui4gtdRKEuvi4/NQGYpJfKpO48emLUawGzAqoaqEAtPqpMS5aWFmzqn2LvE5M/M1L
 Xu/g==
X-Gm-Message-State: AOAM5303asdyh8erdncEG5VlQGOvGabllC+fbHnjUsI14ZX0IgvPFL7c
 S99nn/C6KUZRC8vcqP9XGQEXUSg7sRPEQ92+9M1Ywqy/oSg=
X-Google-Smtp-Source: ABdhPJzcHgxI7SrbYA/0tXX/VBuvfcmF+piFzByAl92owvJcz6dDGixtHU8yfidTlw/Ft4RpewrEk3c/Ds5Ci2HeVeY=
X-Received: by 2002:ac2:554c:: with SMTP id l12mr775302lfk.35.1602394029527;
 Sat, 10 Oct 2020 22:27:09 -0700 (PDT)
MIME-Version: 1.0
From: harry harry <hiharryharryharry@gmail.com>
Date: Sun, 11 Oct 2020 01:26:55 -0400
Message-ID: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
Subject: Why guest physical addresses are not the same as the corresponding
 host virtual addresses in QEMU/KVM? Thanks!
To: qemu-devel@nongnu.org, mathieu.tarral@protonmail.com, stefanha@redhat.com, 
 libvir-list@redhat.com, kvm@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=hiharryharryharry@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi QEMU/KVM developers,

I am sorry if my email disturbs you. I did an experiment and found the
guest physical addresses (GPAs) are not the same as the corresponding
host virtual addresses (HVAs). I am curious about why; I think they
should be the same. I am very appreciated if you can give some
comments and suggestions about 1) why GPAs and HVAs are not the same
in the following experiment; 2) are there any better experiments to
look into the reasons? Any other comments/suggestions are also very
welcome. Thanks!

The experiment is like this: in a single vCPU VM, I ran a program
allocating and referencing lots of pages (e.g., 100*1024) and didn't
let the program terminate. Then, I checked the program's guest virtual
addresses (GVAs) and GPAs through parsing its pagemap and maps files
located at /proc/pid/pagemap and /proc/pid/maps, respectively. At
last, in the host OS, I checked the vCPU's pagemap and maps files to
find the program's HVAs and host physical addresses (HPAs); I actually
checked the new allocated physical pages in the host OS after the
program was executed in the guest OS.

With the above experiment, I found GPAs of the program are different
from its corresponding HVAs. BTW, Intel EPT and other related Intel
virtualization techniques were enabled.

Thanks,
Harry

