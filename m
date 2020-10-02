Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADCEC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0263620758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHY2hmlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0263620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPuA-0007co-VN
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOPtV-00079G-FG
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOPtT-0001Pn-RF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601663699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbR0cLP0fWCfNzoo8dftakLEHXm35YEgJ90iQ4KqFNQ=;
 b=dHY2hmlrtW54i4f8DzFU6Nqy8yPNoRDR/B7plX1yAQxOf1VaJlCdSs7s/KwKBnhG6h9zcB
 8o6OzUWBoWp9CA8xPktrSPuFa2kHOdF2Fxw6EDA+XcErumbOlomodOtP/WzQlTcGf5mSD5
 nmWhX7FSYS2zoI5EhYN4xiDdvkhH0EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-pE6ZdfcwPCKhucbKprL7hw-1; Fri, 02 Oct 2020 14:34:57 -0400
X-MC-Unique: pE6ZdfcwPCKhucbKprL7hw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A44A1019634;
 Fri,  2 Oct 2020 18:34:56 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C9DF75120;
 Fri,  2 Oct 2020 18:34:55 +0000 (UTC)
Date: Fri, 2 Oct 2020 14:34:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/8] docs: tweak kernel-doc for QEMU coding standards
Message-ID: <20201002183455.GF7303@habkost.net>
References: <20191129140217.17797-1-pbonzini@redhat.com>
 <20191129140217.17797-3-pbonzini@redhat.com>
 <CAFEAcA-svKVfBGRfwX6d5woqOW0z--rV3-gC9Qi9NqypYfZ=hw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-svKVfBGRfwX6d5woqOW0z--rV3-gC9Qi9NqypYfZ=hw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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

On Mon, Dec 02, 2019 at 06:01:16PM +0000, Peter Maydell wrote:
> On Fri, 29 Nov 2019 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Surprisingly, QEMU does have a pretty consistent doc comment style and
> > it is not very different from the Linux kernel's.  Of the documentation
> > "sigils", only "#" separates the QEMU doc comment style from Linux's,
> > and it has 200+ instances vs. 6 for the kernel's '&struct foo' (all in
> > accel/tcg/translate-all.c), so it's clear that the two standards are
> > different in this respect.  In addition, our structs are typedefed and
> > recognized by CamelCase names.
> >
> > Adjust kernel-doc's parser for these two aspects of the QEMU coding
> > standards.  The patch has been valid, with hardly any change, for over
> > two years, so it should not be an issue to keep kernel-doc in sync with
> > the Linux copy.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[...]
> > @@ -1906,7 +1914,9 @@ sub process_name($$) {
> >             ++$warnings;
> >         }
> >
> > -       if ($identifier =~ m/^struct\b/) {
> > +       if ($identifier =~ m/^[A-Z]/) {
> > +           $decl_type = 'type name';
> > +       } elsif ($identifier =~ m/^struct\b/) {
> >             $decl_type = 'struct';
> >         } elsif ($identifier =~ m/^union\b/) {
> >             $decl_type = 'union';
> 
> The match for 'type name' is pretty wide but I guess
> we can find out through experience if we need to narrow it.

This change seems to make it impossible to document any macros
with uppercase names.

(for example, most of the macros in object.h are not included in
the generated docs)

What exactly is the purpose of the hunk above?

-- 
Eduardo


