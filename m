Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD93AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00E620872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utQZ9ggK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00E620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCSh-0000np-P5
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSCQw-0000HE-7S
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:01:10 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130]:36891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSCQs-0003NU-Vr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:01:09 -0400
Received: by mail-lf1-x130.google.com with SMTP id j30so18288002lfp.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 22:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4tUFkCjr3BR4BPVQ1A2IdcD3uE18Oab1p6vpEeHtR3k=;
 b=utQZ9ggKNRuPFPYeI52bpvk5FdbHiRnsW8MS2LyeDtmrEm/j0NJXyNaB2fUO+fWTDw
 LLdOq08+UIOmXwW4v7znBzgkspAj4s4I2TLUivUwFuCN4nWLNZPd2mGpVm/SGDp3jU8P
 F5JtGISzUVW9I1VpZmsLyHZI7wLTFgZJtTR4cQglTyUKX0J7rRgjhyHpvmOMyOU6q9YQ
 fMAwT1jWheIHSy4x4XQYb6jgQU8bOu67ygtL2QgTRlkK42+7vosQCWisSd0n3B4ZYp68
 XnQSxHa/DNlulRyo5h8CRSqxSukzskMRoDlMr8mT097B97UblboAGbGYGWF10N+Z8RjG
 FEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4tUFkCjr3BR4BPVQ1A2IdcD3uE18Oab1p6vpEeHtR3k=;
 b=M00Ryj3xeTLYHs39nDLR8fuVu7XyDpmawsBWkit2q8oaso5zM8Qxthx2eR+/deB/WN
 s7PlaSg7mqRPFHmcXNZlalFUdQgFaVj9WEEH2n+0kn42an3vy+tZKtO1pxKTIRu5d7Bd
 B73XH+zGVylgdLLsC8ZTEzCdRpU15FvS6OA6ZlElYvZF1zCxAo0QA6yEDfBvSKuM8pAj
 +wmmeIDo446TKlThPOQvE6rxAlQpCEUUzcPRUih5SHREsDdVGJSH8+uCDVvf9LEvvfhy
 EVk1G2yx89KmFTuVb4qXeysNTBQKHlHZvNKV6Zx/M+IhPzzAwtBXENOtLycuUE2DmgOQ
 7W0Q==
X-Gm-Message-State: AOAM5329+W2vT7EAG5L2vFocMSzQHJkZUekNCVR+Y9s6AWWFWCIFrJMa
 q1CxTFY8YYeBWZLjWpoD0cJ03HQWW3KqeT/c8Hk=
X-Google-Smtp-Source: ABdhPJxsDMs5v4qG7zLIU+Y8ZxU1bF2RlHuTOOp2qn/CEuXbMiL0Hy6LhJcVYbty1SbXw0do35Th4Nf/WfvQlDX0j00=
X-Received: by 2002:a19:8256:: with SMTP id e83mr8521474lfd.530.1602565264506; 
 Mon, 12 Oct 2020 22:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
In-Reply-To: <20201012165428.GD26135@linux.intel.com>
From: harry harry <hiharryharryharry@gmail.com>
Date: Tue, 13 Oct 2020 01:00:47 -0400
Message-ID: <CA+-xGqNd37hyhAbkWxcze3YoVxY3a=_79b+ecF9+ZFCpbqcnnA@mail.gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
To: Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=hiharryharryharry@gmail.com; helo=mail-lf1-x130.google.com
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

BTW, I still have one more question as follows. Thanks!

On Mon, Oct 12, 2020 at 12:54 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> No, the guest physical address spaces is not intrinsically tied to the host
> virtual address spaces.  The fact that GPAs and HVAs are related in KVM is a
> property KVM's architecture.  EPT/NPT has absolutely nothing to do with HVAs.
>
> As Maxim pointed out, KVM links a guest's physical address space, i.e. GPAs, to
> the host's virtual address space, i.e. HVAs, via memslots.  For all intents and
> purposes, this is an extra layer of address translation that is purely software
> defined.  The memslots allow KVM to retrieve the HPA for a given GPA when
> servicing a shadow page fault (a.k.a. EPT violation).
>
> When EPT is enabled, a shadow page fault due to an unmapped GPA will look like:
>
>  GVA -> [guest page tables] -> GPA -> EPT Violation VM-Exit
>
> The above walk of the guest page tables is done in hardware.  KVM then does the
> following walks in software to retrieve the desired HPA:
>
>  GPA -> [memslots] -> HVA -> [host page tables] -> HPA
>
> KVM then takes the resulting HPA and shoves it into KVM's shadow page tables,
> or when TDP is enabled, the EPT/NPT page tables.  When the guest is run with
> TDP enabled, GVA->HPA translations look like the following, with all walks done
> in hardware.
>
>  GVA -> [guest page tables] -> GPA -> [extended/nested page tables] -> HPA

If I understand correctly, the hardware logic of MMU to walk ``GPA ->
[extended/nested page tables] -> HPA''[1] should be the same as ``HVA
-> [host page tables] -> HPA"[2]. If not true, how does KVM find the
correct HPAs when there are EPT violations?

[1] Please note that this hardware walk is the last step, which only
translates the guest physical address to the host physical address
through the four-level nested page table.
[2] Please note that this hardware walk assumes translating the HVA to
the HPA without virtualization involvement.

Thanks,
Harry

