Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552A6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D711020758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbZfmApc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D711020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOQ5b-0003Oh-VB
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOQ4O-0002WM-8p
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOQ4M-0002tg-FM
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601664373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wxv1f5bAZmH1CZsP11xbe3Qws/ihKLiV02+pmWsIfB4=;
 b=XbZfmApcRJc8d3L+q6rlgjNAK1KP0QY4Hd6tvllKdl5W7cz0cjeLlVcBp/G8Uo0HWR8UYW
 ZbRPPgsaV8OFAoNKOYk+nbDsPn7xAg8G1GUUG9R/zbEiQyM0hg1lMYA1MHHBCPljJd32zO
 VSn1bQwFm1oEY6rtgYLfBiUOdwLvSyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-qJaih-L5NAWTvxqWUYgGmg-1; Fri, 02 Oct 2020 14:46:10 -0400
X-MC-Unique: qJaih-L5NAWTvxqWUYgGmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C709F10BBECD;
 Fri,  2 Oct 2020 18:46:09 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F39F60BE2;
 Fri,  2 Oct 2020 18:46:09 +0000 (UTC)
Date: Fri, 2 Oct 2020 14:46:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/8] docs: tweak kernel-doc for QEMU coding standards
Message-ID: <20201002184608.GG7303@habkost.net>
References: <20191129140217.17797-1-pbonzini@redhat.com>
 <20191129140217.17797-3-pbonzini@redhat.com>
 <CAFEAcA-svKVfBGRfwX6d5woqOW0z--rV3-gC9Qi9NqypYfZ=hw@mail.gmail.com>
 <20201002183455.GF7303@habkost.net>
 <CAFEAcA_KXvADFm7uQX1a4peofK_On3DaFH2ZCUtWteaiABM-yA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_KXvADFm7uQX1a4peofK_On3DaFH2ZCUtWteaiABM-yA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 07:43:09PM +0100, Peter Maydell wrote:
> On Fri, 2 Oct 2020 at 19:35, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > On Mon, Dec 02, 2019 at 06:01:16PM +0000, Peter Maydell wrote:
> > > On Fri, 29 Nov 2019 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > >
> > > > Surprisingly, QEMU does have a pretty consistent doc comment style and
> > > > it is not very different from the Linux kernel's.  Of the documentation
> > > > "sigils", only "#" separates the QEMU doc comment style from Linux's,
> > > > and it has 200+ instances vs. 6 for the kernel's '&struct foo' (all in
> > > > accel/tcg/translate-all.c), so it's clear that the two standards are
> > > > different in this respect.  In addition, our structs are typedefed and
> > > > recognized by CamelCase names.
> > > >
> > > > Adjust kernel-doc's parser for these two aspects of the QEMU coding
> > > > standards.  The patch has been valid, with hardly any change, for over
> > > > two years, so it should not be an issue to keep kernel-doc in sync with
> > > > the Linux copy.
> > > >
> > > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > [...]
> > > > @@ -1906,7 +1914,9 @@ sub process_name($$) {
> > > >             ++$warnings;
> > > >         }
> > > >
> > > > -       if ($identifier =~ m/^struct\b/) {
> > > > +       if ($identifier =~ m/^[A-Z]/) {
> > > > +           $decl_type = 'type name';
> > > > +       } elsif ($identifier =~ m/^struct\b/) {
> > > >             $decl_type = 'struct';
> > > >         } elsif ($identifier =~ m/^union\b/) {
> > > >             $decl_type = 'union';
> > >
> > > The match for 'type name' is pretty wide but I guess
> > > we can find out through experience if we need to narrow it.
> >
> > This change seems to make it impossible to document any macros
> > with uppercase names.
> >
> > (for example, most of the macros in object.h are not included in
> > the generated docs)
> >
> > What exactly is the purpose of the hunk above?
> 
> It's so that QEMU's bare type names like MemoryRegionSection get
> recognized as being types. Kernel naming style always
> prefers to say "struct MemoryRegionSection" where we use the
> typedef and say "MemoryRegionSection", which is why the upstream
> kernel-doc doesn't care about this. IIRC, without it, doc comments
> which reference a type like '#TypeName' like:
> 
>      * @log_sync:
>      *
>      * Called by memory_region_snapshot_and_clear_dirty() and
>      * memory_global_dirty_log_sync(), before accessing QEMU's "official"
>      * copy of the dirty memory bitmap for a #MemoryRegionSection.
>      *
> 
> don't correctly render the typename into a link to the
> struct definition.

This is not the code that parses "#MemoryRegionSection", it is
the code that parses:

/**
 * MemoryRegionSection: describes a fragment of a #MemoryRegion
   ^^^^^^^ this line


-- 
Eduardo


