Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C713AC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E59A208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myNZoxb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E59A208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3FX3-0006S6-Qg
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 04:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i3FWB-0005xG-Ip
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i3FWA-0007eL-Cg
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:10:55 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i3FWA-0007dk-5B; Thu, 29 Aug 2019 04:10:54 -0400
Received: by mail-ot1-x341.google.com with SMTP id w4so2516873ote.11;
 Thu, 29 Aug 2019 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=BLaHWFDPqOT/lxkliz8Tx8aiymVIsu9+Gxxg8ItiMF0=;
 b=myNZoxb9IlRVynLJPBy+MbfH7NVFZPXXJUdk75apDRrrzxBR/Zzoa2uJosNME1MqnJ
 fc2wDeCweMU+HKnhpaDNQZUaCP2YmYUvZJLnARxnEwZ+p6Q/r4IihKcKjmZzfOFWYcdH
 8z9QdWtBXUQTzUoSyOw2xmUMxIOH6hzk0jpzzkRcu8GvTK+GRtcCTr4PAvboeCUxjmeM
 RXoxb17Xktwxf72ES1vYQkhw5ddltYxtwasZxD0UW4+EKzB4dRthFHXWr+ceCE67t1ve
 Br5dbMELOcoVyHQMoRLm5ieR1/zvXd8MLbvS/c30pzgeBbAUhdFIE5qjPYk4DAiQDEMr
 jZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=BLaHWFDPqOT/lxkliz8Tx8aiymVIsu9+Gxxg8ItiMF0=;
 b=T9YaRxWCZ50jLUp2Hjp6MRittRpy4eIWv2Y0i5f7cxhuaClPUAg25FLsUkTyJwf6+Z
 WJNu7loO+RTZnxyZR2VvxrI7xH+ED3wi2SCkhZSs+Qam9+9QE1ExWOnfo58Y0QdL2hPK
 TJXcNPXjg/5EiGSr4/4WP+wL9iUKnCfceuSR4Wp3T+gigS21NEnd3NpLgkRjCGeUr0pN
 VGFFESdcybY/ia9booYZMTgwzSHoBi9xsNKqAhI6YA7cM5jp3E9XDA8eMIKgslE6hTn1
 YjhC24o9uPjuB3m6ElP0oWfI7RL1t5HIq/F9+PB8R7BR4+ZHPJprimjqMOBKi0ArR8uO
 MtPg==
X-Gm-Message-State: APjAAAVS8yFskD4QRS1kiaDIlOeT2aXjpufFHNIBzsFxs9t16k/urxvu
 BrTdlwWQv50DyD0+0F1aeXzEV7N3auGlTHv0DmY=
X-Google-Smtp-Source: APXvYqweMiR5PbLGxojBieM+OzRZeb9P5lMRfXGwZok18VUXxh5Mxxil4NjeB9PsrYMDTOXIZV/oN/QMfiHguaukKHQ=
X-Received: by 2002:a05:6830:1d75:: with SMTP id
 l21mr6279422oti.121.1567066252735; 
 Thu, 29 Aug 2019 01:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 29 Aug 2019 01:10:52
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 29 Aug 2019 01:10:52
 -0700 (PDT)
In-Reply-To: <20190826075112.25637-6-david@redhat.com>
References: <20190826075112.25637-1-david@redhat.com>
 <20190826075112.25637-6-david@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 29 Aug 2019 10:10:52 +0200
Message-ID: <CAL1e-=jGsf=a9YBS=rCjJvNNEtMyBgyYc-dsPDsiFCqj+bV6hg@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 5/7] mips/tcg: Call probe_write() for
 CONFIG_USER_ONLY as well
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.08.2019. 09.52, "David Hildenbrand" <david@redhat.com> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Let's call it also for CONFIG_USER_ONLY. While at it, add a FIXME and get
> rid of one local variable.
>
> MIPS code probably needs a bigger refactoring in regards of
> ensure_writable_pages(), similar to s390x, so for example, watchpoints
> can be handled reliably later. The actually accessed addresses should
> be probed only, not full pages.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  target/mips/op_helper.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 34bcc8d884..08d9a4f9f1 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -4537,16 +4537,14 @@ static inline void
ensure_writable_pages(CPUMIPSState *env,
>                                           int mmu_idx,
>                                           uintptr_t retaddr)
>  {
> -#if !defined(CONFIG_USER_ONLY)
> -    target_ulong page_addr;
> +    /* FIXME: Probe the actual accesses (pass and use a size) */
>      if (unlikely(MSA_PAGESPAN(addr))) {
>          /* first page */
>          probe_write(env, addr, 0, mmu_idx, retaddr);
>          /* second page */
> -        page_addr =3D (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> -        probe_write(env, page_addr, 0, mmu_idx, retaddr);
> +        addr =3D (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> +        probe_write(env, addr, 0, mmu_idx, retaddr);
>      }
> -#endif
>  }
>
>  void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
> --
> 2.21.0
>
>
