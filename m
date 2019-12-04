Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43130C2BC73
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1244F2081B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUQVOwdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1244F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWI4-0006of-8g
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <catherine.hecx@gmail.com>) id 1icWFu-0004xu-Ov
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <catherine.hecx@gmail.com>) id 1icWFt-0007yc-II
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:07:54 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
 id 1icWFt-0007yJ-DB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:07:53 -0500
Received: by mail-oi1-x242.google.com with SMTP id l136so7167921oig.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9ctF7i3YtaWmAPKJFqGq+fBuSBQxGx/l8PItlK/C7Eo=;
 b=hUQVOwdmFC9xwg7/Ve37lsNCG6PtBBrZi+lRiu9Ki5QARiteTFoWW4qiYJj3C/70nY
 7TitbHQQkRxiZEUS3klsV40tLT8rkp774g0yCbVmbjWk0C5MEqy5hWeF4tQB+N+ab5w1
 /dqTGur7jQvVV9j3MkOWRcJZh/GgmK20d68ERS0gQlNIkF0sEnjotboBeZlq2iqOkvA9
 sj/F4KNkS1fnDpD8iiFSgSEOvFcqGt/fgZyY2TEOQ4P+UxsjTmumMvIWl1AR7d2QSz8S
 HmVWoo6adrh5PEa4d1qv89bSsT/mwQNemlymhPkeeFvSP8MvFEshri0Uo1qYmfqISexr
 s+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9ctF7i3YtaWmAPKJFqGq+fBuSBQxGx/l8PItlK/C7Eo=;
 b=EY8/LtxT7e7i8+lOOZyy7/RFgxQN6K69k8F78QDkwlpvVVLX4YaHy6ypZ/kq6D7Bj8
 xNKjh1qkA8TZclmiajO/GGICF07ynCG1Ae+f8fomh3JeCNs4pKy9QBQ1vcbJmij7ABZQ
 o4VNir4N7E36/Im44c2rwT3Yn88dgrZES15rRKLmjz0N6k+Qf+Ol1+99gCDO0yE5FvyH
 TBjoZwHpkH/zO9qzVoqX0qfnw+A3GtPFlAcyjlshIna3Oi/tzO+F57z7fOxpZhayoaUA
 Dq9goQB6FsC3HHLM7fU99y6oO8eulxmE3krFMd8uQI/tAEN66wNTc/oB5cYvT2tIh7rD
 o4gA==
X-Gm-Message-State: APjAAAVGZgN5l+KvTwDR9/Hke1qxHPdQku+TVO0w1AVI1SaChTXh3iso
 GbL1UliDbrsDIexmDjCPVad2ZpFojpKZPkLNp5w=
X-Google-Smtp-Source: APXvYqwlVzccHWoUnndVXD/fSaLr9oIIxWv9l1YrNMvD8H8Rb/h63ukjjNcKXQuVAxyXR9S/QoCJIOIusbFgT7Fb3/o=
X-Received: by 2002:aca:4712:: with SMTP id u18mr609507oia.93.1575472072501;
 Wed, 04 Dec 2019 07:07:52 -0800 (PST)
MIME-Version: 1.0
References: <1575449430-23366-1-git-send-email-catherine.hecx@gmail.com>
 <2ac1a83c-6958-1b49-295f-92149749fa7c@redhat.com>
 <CAEn6zmFex9WJ9jr5-0br7YzQZ=jA5bQn314OM+U=Q6ZGPiCRAg@mail.gmail.com>
 <714a0a86-4301-e756-654f-7765d4eb73db@redhat.com>
In-Reply-To: <714a0a86-4301-e756-654f-7765d4eb73db@redhat.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Wed, 4 Dec 2019 23:07:39 +0800
Message-ID: <CAEn6zmHnTLZxa6Qv=8oDUPYpRD=rvGxJOLjd8Qb15k9-3U+CKw@mail.gmail.com>
Subject: Re: [PATCH] target/i386: relax assert when old host kernels don't
 include msrs
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo


On Wed, 4 Dec 2019 at 21:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/12/19 14:33, Catherine Ho wrote:
> > Hi Paolo
> > [sorry to resend it, seems to reply it incorrectly]
> >
> > On Wed, 4 Dec 2019 at 19:23, Paolo Bonzini <pbonzini@redhat.com
> > <mailto:pbonzini@redhat.com>> wrote:
> >
> >     On 04/12/19 09:50, Catherine Ho wrote:
> >     > Commit 20a78b02d315 ("target/i386: add VMX features") unconditionally
> >     > add vmx msr entry although older host kernels don't include them.
> >     >
> >     > But old host kernel + newest qemu will cause a qemu crash as follows:
> >     > qemu-system-x86_64: error: failed to set MSR 0x480 to 0x0
> >     > target/i386/kvm.c:2932: kvm_put_msrs: Assertion `ret ==
> >     > cpu->kvm_msr_buf->nmsrs' failed.
> >     >
> >     > This fixes it by relaxing the condition.
> >
> >     This is intentional.  The VMX MSR entries should not have been added.
> >     What combination of host kernel/QEMU are you using, and what QEMU
> >     command line?
> >
> >
> > Host kernel: 4.15.0 (ubuntu 18.04)
> > Qemu: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs-dev
> > cmdline: qemu-system-x86_64 -M pc -cpu host --enable-kvm -smp 8 \
> >                   -m 4G,maxmem=4G
> >
> > But before 20a78b02d315, the older kernel + latest qemu can boot guest
> > successfully.
>
> Ok, so the problem is that some MSR didn't exist in that version.  Which
I thought in my platform, the only MSR didn't exist is MSR_IA32_VMX_BASIC
(0x480). If I remove this kvm_msr_entry_add(), everything is ok, the guest can
be boot up successfully.

> one it is?  Can you make it conditional, similar to MSR_IA32_VMX_VMFUNC?
Ok, I will. Thanks for the suggestion

Best regards
Catherine

