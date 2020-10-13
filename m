Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83BEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 22:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15811218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 22:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbpELPlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15811218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSSzH-0002ZF-0r
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 18:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSSyH-00025t-Pt
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 18:40:41 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:37959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSSyG-0000zv-4a
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 18:40:41 -0400
Received: by mail-lj1-x235.google.com with SMTP id m20so1101970ljj.5
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C95JE+mHODDodnLkF36OpP56wFAkD0TkDH/Ba36Rdpo=;
 b=mbpELPlfanPl29T0k9DKIe6P+LRDcNhcTIBjOF6J45FU1I/v0Vu2zI7kZHCAZO/BDG
 3Iubz9p8HnQZx+b5ojmN763j1/9CTbWMYRej0aGcW2wBLQ9iu2zD/uf8TSOCS4IL+wgP
 fHHJ7mOlkaMn67Z8XB9KDzCHJ8UW5D45oEyPcEQx6g8Yb70LErQ8ZtA5NkkbUw7EOBbH
 8QRbRN98JrCBrAxdfPNO5WAow/G5jSps3aOhoLj1E2gsWSFXxEW3HdqZzYlryqdloExS
 XjwEg7JrdKNsHTN1S7mh2WaIuCBhJ+a6jHMgEbZ7ZCZs2r4BoJiETyk6oKoMGECwm3IE
 ctOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C95JE+mHODDodnLkF36OpP56wFAkD0TkDH/Ba36Rdpo=;
 b=FKYtKWQEqtt9XdUZih0OxR0ay1uRYUOasN7z4iQQZSUs9tXdkUy09P7lv53ExAs6RB
 FgRk1A04AO+mkPcIw00Ee6JH2UaDkOepxnH6WbjhGaVbBBESdzgoYHWQs4SrWXW3VGAb
 ftNXMamSFq6CzUAXG/oFERZ8EbPbnvo16GwLNTCZvaqMoYdTJMROVS0qKHdTcXQhdZ6a
 q6tMKzzwnt56y2bDcZegWQsXY53sB2URNvaxqqyuFSAldtpoor0GkeyzRJy2ha04osMU
 VDiEY9xcuSc8+UPhgyvzr3xfURwU1b7JNVox2N31z0RhltqfgNGyX0NXb7JvLOaEkH/3
 cTqQ==
X-Gm-Message-State: AOAM532/a1A4m7xbhXoBQJjxCNZuwvCWsqRlv/CwM/+KCdeDz0xeol/L
 kcALK7t8I543O8/oQTVyCL2ukSK6ZI1OlLov95Q=
X-Google-Smtp-Source: ABdhPJzpPWP5mrM5qGjhGlnmvUPWBacR1EMrK8VlvEEi2Vo7FK4UeC+GkOI7BgUWWEvCRzk3gr/ntKVwOYlvsoWgOZ4=
X-Received: by 2002:a2e:b006:: with SMTP id y6mr564022ljk.462.1602628837706;
 Tue, 13 Oct 2020 15:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
 <20201013045245.GA11344@linux.intel.com>
 <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
 <20201013070329.GC11344@linux.intel.com>
In-Reply-To: <20201013070329.GC11344@linux.intel.com>
From: harry harry <hiharryharryharry@gmail.com>
Date: Tue, 13 Oct 2020 18:40:19 -0400
Message-ID: <CA+-xGqO37RzQDg5dnE_3NWMp6+u2L02GQDqoSr3RdedoMBugrg@mail.gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
To: Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=hiharryharryharry@gmail.com; helo=mail-lj1-x235.google.com
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, mathieu.tarral@protonmail.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sean,

Thanks much for your detailed replies. It's clear to me why GPAs are
different from HVAs in QEM/KVM. Thanks! I appreciate it if you could
help with the following two more questions.

On Tue, Oct 13, 2020 at 3:03 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> This is where memslots come in.  Think of memslots as a one-level page tablea
> that translate GPAs to HVAs.  A memslot, set by userspace, tells KVM the
> corresponding HVA for a given GPA.
>
> Before the guest is running (assuming host userspace isn't broken), the
> userspace VMM will first allocate virtual memory (HVA) for all physical
> memory it wants to map into the guest (GPA).  It then tells KVM how to
> translate a given GPA to its HVA by creating a memslot.
>
> To avoid getting lost in a tangent about page offsets, let's assume array[0]'s
> GPA = 0xa000.  For KVM to create a GPA->HPA mapping for the guest, there _must_
> be a memslot that translates GPA 0xa000 to an HVA[*].  Let's say HVA = 0xb000.
>
> On an EPT violation, KVM does a memslot lookup to translate the GPA (0xa000) to
> its HVA (0xb000), and then walks the host page tables to translate the HVA into
> a HPA (let's say that ends up being 0xc000).  KVM then stuffs 0xc000 into the
> EPT tables, which yields:
>
>   GPA    -> HVA    (KVM memslots)
>   0xa000    0xb000
>
>   HVA    -> HPA    (host page tables)
>   0xb000    0xc000
>
>   GPA    -> HPA    (extended page tables)
>   0xa000    0xc000
>
> To keep the EPT tables synchronized with the host page tables, if HVA->HPA
> changes, e.g. HVA 0xb000 is remapped to HPA 0xd000, then KVM will get notified
> by the host kernel that the HVA has been unmapped and will find and unmap
> the corresponding GPA (again via memslots) to HPA translations.
>
> Ditto for the case where userspace moves a memslot, e.g. if HVA is changed
> to 0xe000, KVM will first unmap all old GPA->HPA translations so that accesses
> to GPA 0xa000 from the guest will take an EPT violation and see the new HVA
> (and presumably a new HPA).

Q1: Is there any file like ``/proc/pid/pagemap'' to record the
mappings between GPAs and HVAs in the host OS?

Q2: Seems that there might be extra overhead (e.g., synchronization
between EPT tables and host regular page tables; maintaining extra
regular page tables and data structures), which is caused by the extra
translation between GPAs to HVAs via memslots. Why doesn't KVM
directly use GPAs as HVAs and leverage extended/nested page tables to
translate HVAs (i.e., GPAs) to HPAs?

Thanks,
Harry

