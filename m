Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD53CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5123920878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQaesPSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5123920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSR53-0007RF-Rk
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSR2N-0003cV-L7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:36:47 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134]:41055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSR2L-00013M-Gj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:36:47 -0400
Received: by mail-lf1-x134.google.com with SMTP id d24so1190320lfa.8
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NQjQ2k5Saht+0v/Nw1gJ06v1KosSim39Rrh/K70mE9E=;
 b=jQaesPSFTPRhdaJ/IqEXZZ70+scGkNb1HDPfK0KW1sqhP4cGHHqrqbj3R4XFat/hI6
 kNzBtGPjo6gxc1fjnQPZzYfA351zCCY7KaRTj5adeqKSIUy55WSUP+UCmmBGd3DnVuTu
 hPBFcJENBJ6F49GIFfi8K8XoSuq0AptuOLd2jROZc9v9vK4o/ETSzfbBEWqQz237jgpk
 pA5GJyuGgTJaVa8EfxDL3DW91H+9zpBHVIFimRxOufQQu4ehrba7mwhg89+F42mUL2E6
 SBmQLmz6PmQTa8LeUIMG5GalZy1R93WKzOHMUNFJHD1FnvYbIa3Yomn9KqLZAKE/nAKt
 mfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NQjQ2k5Saht+0v/Nw1gJ06v1KosSim39Rrh/K70mE9E=;
 b=uSUC7n3jZpQ8hzSRlPa12xJsQvkKvnMHXW/Eytd8NOHvCY+SXs3WTX3LyGhoupcAXO
 FXgNzYntF2guIaJw3mqT/kv39WEPJwJx4V9WpFvDjfFh1oasdH+oZpz/2zRUxc1F9/+K
 9ttK8VsBY+/ONv0CyQSWw0L9IuoORkpOJEJmmwXIV2vifaYrVuNVguj0+tjPw1FYAtNj
 als0HOMu4FsbrK2SQODZj5B04u0fFvF9mKIZORoTSVz19twM0uBpPjM2aWyjVfFhIYrX
 KgktavkD98Zek/AMoUFlrlRDZDM1wcgOdgqOETLQsZ84xfJdsYbft2Z1pvcauPGwYCxt
 OG6Q==
X-Gm-Message-State: AOAM533IRYq4l+COsV9HL2/p32ih6rfVeZFpeGj33d0ShrrIUDyTYB4i
 ubuUXJnJd2vg1cdbKuOK2vwynL/b8LTinraCkKE=
X-Google-Smtp-Source: ABdhPJyc4gYiGMgm7ccRbPjdTl523pIjBDmx0/crijD7nRyGalWIpfyK/BHYXHE1SSV/b2RI2rJ28LKu9QHjo9pCIdc=
X-Received: by 2002:a19:8256:: with SMTP id e83mr332082lfd.530.1602621403376; 
 Tue, 13 Oct 2020 13:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
 <20201013045245.GA11344@linux.intel.com>
 <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
 <CA+-xGqMMa-DB1SND5MRugusDafjNA9CVw-=OBK7q=CK1impmTQ@mail.gmail.com>
 <a163c2d8-d8a1-dc03-6230-a2e104e3b039@redhat.com>
In-Reply-To: <a163c2d8-d8a1-dc03-6230-a2e104e3b039@redhat.com>
From: harry harry <hiharryharryharry@gmail.com>
Date: Tue, 13 Oct 2020 16:36:25 -0400
Message-ID: <CA+-xGqOMKRh+_5vYXeLOiGnTMw4L_gUccqdQ+HGSOzuTosp6tw@mail.gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
To: Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=hiharryharryharry@gmail.com; helo=mail-lf1-x134.google.com
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
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo and Sean,

Thanks much for your prompt replies and clear explanations.

On Tue, Oct 13, 2020 at 2:43 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> No, the logic to find the HPA with a given HVA is the same as the
> hardware logic to translate HVA -> HPA.  That is it uses the host
> "regular" page tables, not the nested page tables.
>
> In order to translate GPA to HPA, instead, KVM does not use the nested
> page tables.

I am curious why KVM does not directly use GPAs as HVAs and leverage
nested page tables to translate HVAs (i.e., GPAs) to HPAs? Is that
because 1) the hardware logic of ``GPA -> [extended/nested page
tables] -> HPA[*]'' is different[**] from the hardware logic of ``HVA
-> [host regular page tables] -> HPA''; 2) if 1) is true, it is
natural to reuse Linux's original functionality to translate HVAs to
HPAs through regular page tables.

[*]: Here, the translation means the last step for MMU to translate a
GVA's corresponding GPA to an HPA through the extended/nested page
tables.
[**]: To my knowledge, the hardware logic of ``GPA -> [extended/nested
page tables] -> HPA'' seems to be the same as the hardware logic of
``HVA -> [host regular page tables] -> HPA''. I appreciate it if you
could point out the differences I ignored. Thanks!

Best,
Harry

