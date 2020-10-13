Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,PLING_QUERY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46E9C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF46B20E65
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxWu1uo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF46B20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSD9a-0007EZ-0g
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSD8v-0006oK-77
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:46:37 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135]:40322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSD8t-0001y6-LS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:46:36 -0400
Received: by mail-lf1-x135.google.com with SMTP id a9so20751803lfc.7
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 22:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LNEUXpS8N0KH/JdbduSvZxs9jDcwwGBJIJ6K7iSuBN8=;
 b=SxWu1uo/+GACcMZnKaLVZg0uDlNg80M8Bee4oLpjJtbiJzuXmpqlx8g+1SqAB/M4LR
 pL3iUpsdNY98/Xxn13Qr7Dl4oi0A/3p3LDw3MRs4iUDCEmztdP7WmSpqxN9yX5VelSm4
 tit7lgKLWKCFsfXtPz6qc9NnfF1Sl+WcGR7KQ2I8xGp937eCF+XzuBVfKx+lJ9zBGYwr
 sQOiiHlDtLn7CXbEftcQ/8A7gBJOC5sJ3yACwM+BJ32ucGPIrLCgCJdVjW36K0xCJPlj
 9gAt0b/cgbwdPkSw/QuGdgncBibFoVAtEoI+HLo0XDrhxHCL9hRQxRllc4eq6IDX8Yjl
 j+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LNEUXpS8N0KH/JdbduSvZxs9jDcwwGBJIJ6K7iSuBN8=;
 b=POBFghh5J/RqAb/9ukZffbo6/BPSVxnATlJ0BG2MN4Fn3cH+D4p4aIlW6Kg4/gcNe7
 EIm8tzIFQR2EQrOV00qoxk/YAaoTosQJk8Xudt1PDLRTyz3tk+3eWmD0HrtqRbUDn88d
 xMy4jl7G29VaMXEMN6NDfmurbK9v/eYEurToVToor1/dYDTtOxYSYB+PlQiCc9mqGjIc
 WFV2qVshouzwi58eByHvhbOIWPKfisVWjk/jLQkfat1gDbOMyu5qtmnAbkXhynaxj4y4
 KI1JM4Sgv+Jq2TioAI9Cl5n/ff4FxD/y1+02EUOjiewvV0bMUKVjIy4UwRY6saECH4bR
 Z6SQ==
X-Gm-Message-State: AOAM531063lQFiTpmA+Gq37pzrMi4TKTKdSbx8E1PVIsJy5nA7FmpnqR
 eMBih9sNRXgMC2Uf0InZLxY8yPB/rDLAxQVVBZI=
X-Google-Smtp-Source: ABdhPJxwM5nJX6kyxU50rOQTjgBYavOyJr1SEug0ooYlBiLOXt/qh6akVbf4EmatmjsL5M3XoaemFpCo9LP2kz/ybIs=
X-Received: by 2002:a19:4bd4:: with SMTP id y203mr3585959lfa.539.1602567993345; 
 Mon, 12 Oct 2020 22:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
 <20201013045245.GA11344@linux.intel.com>
 <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
In-Reply-To: <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
From: harry harry <hiharryharryharry@gmail.com>
Date: Tue, 13 Oct 2020 01:46:16 -0400
Message-ID: <CA+-xGqMMa-DB1SND5MRugusDafjNA9CVw-=OBK7q=CK1impmTQ@mail.gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
To: Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: multipart/alternative; boundary="000000000000f8cba105b186efbe"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=hiharryharryharry@gmail.com; helo=mail-lf1-x135.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000f8cba105b186efbe
Content-Type: text/plain; charset="UTF-8"

BTW, I assume the software logic for KVM to find the HPA with a given HVA
(as you said like below) should be the same as the hardware logic in MMU
to translate ``GPA -> [extended/nested page tables] -> HPA''.  If this is
true, I cannot understand how KVM can find a correct HPA with an HVA (e.g.,
array[0]'s HVA is not 0x0000000000000081 in the last email) that is
different from its corresponding GPA.

GPA -> [memslots] -> HVA -> [host page tables] -> HPA

--000000000000f8cba105b186efbe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">BTW, I assume the software logic for KVM =
to find the HPA with a given HVA (as you said like below) should be the sam=
e as the hardware logic in MMU to=C2=A0translate ``GPA -&gt; [extended/nest=
ed page tables] -&gt; HPA&#39;&#39;.=C2=A0

If this is true, I cannot understand how KVM can=C2=A0find a correct HPA wi=
th an HVA (e.g., array[0]&#39;s HVA is not 0x0000000000000081 in the last e=
mail) that is different from its corresponding GPA.

</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">GPA -&gt; [memslots] -&gt=
; HVA -&gt; [host page tables] -&gt; HPA<br></div><div dir=3D"ltr"><br></di=
v><div dir=3D"ltr"><br></div><div></div><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div>

--000000000000f8cba105b186efbe--

