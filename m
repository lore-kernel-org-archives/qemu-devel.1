Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F12DC04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 03:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48061205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 03:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHJbQYE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48061205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRT9H-0007Xt-Fo
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 23:03:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tedheadster@gmail.com>) id 1hRT7a-0006X8-5T
	for qemu-devel@nongnu.org; Thu, 16 May 2019 23:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tedheadster@gmail.com>) id 1hRT7Z-0005DF-6R
	for qemu-devel@nongnu.org; Thu, 16 May 2019 23:01:22 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:37489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tedheadster@gmail.com>)
	id 1hRT7Z-0005CV-2B
	for qemu-devel@nongnu.org; Thu, 16 May 2019 23:01:21 -0400
Received: by mail-ua1-x942.google.com with SMTP id t18so2137217uar.4
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 20:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:reply-to:from:date:message-id
	:subject:to:cc;
	bh=9X8bxWq/cG0PF8Tpyb1g7+w8YmRdoeicTJFGCB7LWD8=;
	b=JHJbQYE9YS9jH6FhTypgneUEShNzLP5UiPaDbMOkF0egCvLFdzmbxhqmJNkHpco8rQ
	dxHggGVmfhlExHmUqy2nAxi+r8WQZKZ7oRAjpq01T1h+9fXwCnR3dGXVnXgI54e//O1v
	1NNyTGlQFkNZbr9oTun3kyZmy1JotZPKafqNCWlB0gQPBIy4uruxiN0ueSGWdhlyIy7Z
	PR7Y0a9pTATreLbogP+IMRbdSHgkKDT+8h4+xDJSMSIBgaxeuh3JopG2a32JmuwuTVF+
	jHKYg8OPVqakOFohs3x/6RVsJlWWStKBk6YTsR4dMVg4cOwNaNyFAKqCP5CKRBaqA//e
	nsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
	:from:date:message-id:subject:to:cc;
	bh=9X8bxWq/cG0PF8Tpyb1g7+w8YmRdoeicTJFGCB7LWD8=;
	b=GT7rAPrjdYE8MYENYG72vTjzohyx/snlLIadVYWJttKYxeZi3QgXTLPT0/m3BCLwZW
	lPT98URQgwEzx1hCIuR7Kmtj4ffR8ylwqbbpJ4md3a70fI+oBeQVxJvMJiCTim8x17Ks
	vnWLP6RDjoevJnzbtEmhjljAFADcp8knsJNnAj621VpLqJv/q3hIfGnhd97c7aE55RQ2
	wYDaXcojblCcXPVMo8TCUa6ckXTeYcCWcUkAlSNRJwRW2puIsb/jW+Ng1NrC31t9jTKG
	Ok87cPMcxrArfkaImoPM7IlQjQIlTnnLAi0VHAi4DyYTA8JVB70JL1AYN5y0aVmaQKh6
	gkAQ==
X-Gm-Message-State: APjAAAWFRp6xLjlKNHJTfNFCY0VevJXaF7114QAacuiilf1uOyOHMSid
	ua8ugp8jyJzQZ+1hUwoBc5KsK99zjXcbOQpnKw==
X-Google-Smtp-Source: APXvYqyNwDXngjFf2fyrrk71zh+epo15y8s1qE/yDpQLBYjZOa/e/2G9mPTwFZBSpbob5SdgyfzaXF57sjv/faBqkOc=
X-Received: by 2002:ab0:6051:: with SMTP id o17mr25265875ual.34.1558062080168; 
	Thu, 16 May 2019 20:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_bf=0=tyCumcNpVLtneio+vbd4JuFMmtWqSwXWFC-7PMg@mail.gmail.com>
	<6da0c28c-ef4f-8199-1cee-bf1f08387ff1@redhat.com>
	<ea9cf5ec-f259-9a23-eae1-1b2250c367b0@redhat.com>
	<CAP8WD_ZUVZJKk-tEfG8+yd6t_U9+A3a4s5_ohjU5KLP0tY5YwQ@mail.gmail.com>
	<a471eb8d-0cc0-0205-c51d-ce3a75b6d799@redhat.com>
In-Reply-To: <a471eb8d-0cc0-0205-c51d-ce3a75b6d799@redhat.com>
From: tedheadster <tedheadster@gmail.com>
Date: Thu, 16 May 2019 23:01:09 -0400
Message-ID: <CAP8WD_ZOzxdJ70cEeqJLha8+2ueYXKf8fjODnjqAeOnk8mJ+dg@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::942
Subject: Re: [Qemu-devel] Pentium Pro Feature Bugs
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
Reply-To: whiteheadm@acm.org
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Matthew Whitehead <whiteheadm@acm.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 10:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 17/05/19 02:30, tedheadster wrote:
> > Paolo,
> >   I am running the kvm32 machine and I see a problem. Here is the
> > output of /proc/cpuinfo :
> >
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
> > cmov constant_tsc
> >
> > I see something rather important missing: cpuid.
> >
> > A lot of stuff breaks without cpuid, and I am fairly sure that qemu is
> > supposed to 'hard code' in support for it. It is present with both my
> > i486 and i586 virtual machines.
> >
> > - Matthew
> >
>
> That's weird... The cpuid flag does not come from QEMU, it is a "soft"
> flag determined by trying to toggle EFLAGS.ID and EFLAGS.ID behaves the
> same for all CPU models.  What else do you see in /proc/cpuinfo?
>
> Paolo

Here is all of /proc/cpuinfo

processor       : 7
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      : Common 32-bit KVM processor
stepping        : 1
microcode       : 0x1
cpu MHz         : 2394.405
cache size      : 16384 KB
physical id     : 7
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 7
initial apicid  : 7
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
        stant_tsc        : fpu vme de pse tsc msr pae mce cx8 apic
mtrr pge mca cmov cons
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips        : 4789.21
clflush size    : 32
cache_alignment : 32
address sizes   : 32 bits physical, 0 bits virtual
power management:

