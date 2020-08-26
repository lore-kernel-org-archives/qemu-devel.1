Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3E42078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4tdloXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3E42078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxCR-0005Yg-G6
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAx9e-000348-Lo
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:16:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60650
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAx9c-0004Sb-OH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598454959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wM38FLfnx0POA2G2D6IfJNi2kCkdlQ6TNYDsvVRTw6w=;
 b=Q4tdloXEV8R0QP2z+21ov/skRRVifxuFRPfraP3aG4eAKqCtjaGGG1SWoD2o5unkNfRIXU
 kNaLs9ecsiOlaoG8ewPuHjkVHRywCE6n1rq/1ljJUA6NIFBraBVeppo43Z0f7ywpQguxvN
 MGfNw04oetDPMzBqhJRuNdTgDbf1MbU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-mvoZQduKOAySp7oza8Ikog-1; Wed, 26 Aug 2020 11:15:56 -0400
X-MC-Unique: mvoZQduKOAySp7oza8Ikog-1
Received: by mail-ed1-f70.google.com with SMTP id dj21so810788edb.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wM38FLfnx0POA2G2D6IfJNi2kCkdlQ6TNYDsvVRTw6w=;
 b=UliASEHTVuzJEOy2U+yd+i6G8FcY2/1scCiEMoYo5W+C5d/Q8zYFAScwD1WdWWWPTp
 s1c86V+hm6o2cSVaGYJWzH+wbvX2KcEX4a/Qn3W4jUX+wQkuJkWBX0ByLNiRxK83iK+/
 Kq5wYrZEu/cYleESsWXauLQ6vB76n+PN3a1doXXxwJdOc2HCQDfMatQh68YKjHHsr7dy
 uBKh1Umv5r6CmAweONuqGJUZWKUWFKugqOHtusDU5qoSCqjixprY7cutd0cekKCHokkN
 petSDOFxdzyV1O8mblFx0McRl/qJGH4cd//52fjLNe2+iiiq7M4TP15q1H2w5y/VIoR2
 WZaQ==
X-Gm-Message-State: AOAM530NU3QktmMLw7H8ZWD8r1wwfoaD7hWzgPin32nRQUf2VXelneK2
 RqW5F0fJLhxwTjrV3LlmRFGyTog7JoYgcgTMCsz8aZOBbMl9ltsvl1EqtLtURvTKlIgUJKJ/iGp
 Os0mN3Le/SVTwq/XdZIF0vqfj8rZqy/I=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr6960367ejb.121.1598454953975; 
 Wed, 26 Aug 2020 08:15:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1IlET/TfutOj5NMxbb7e3rDwNvRMhPytsmYbuGUp6GBoLMq6H7lk6JDYqhU86WSToPPHtXhDtZdFJIOnOdVA=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr6960347ejb.121.1598454953783; 
 Wed, 26 Aug 2020 08:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200823225804.umk5gh6knptqo5mw@mozz.bu.edu>
 <CABgObfZtGY-TuTLXNJNU9m_yQLfE6AM-+MdfqaaRjfMcWC8+Og@mail.gmail.com>
 <20200826135513.ay5ga3xi2ilcagqf@mozz.bu.edu>
In-Reply-To: <20200826135513.ay5ga3xi2ilcagqf@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 17:15:42 +0200
Message-ID: <CABgObfbxqPH1p-0ZD2wZWiKP0GjOjV6s+umgmOMKjm2ic7R=zg@mail.gmail.com>
Subject: Re: [Fwd] Issue 25164 in oss-fuzz: qemu: Fuzzing build failure
To: Alexander Bulekov <alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 3:56 PM Alexander Bulekov <alxndr@bu.edu> wrote:
>
> On 200825 0958, Paolo Bonzini wrote:
> > Il lun 24 ago 2020, 00:58 Alexander Bulekov <alxndr@bu.edu> ha scritto:
> >
> > > Hi Paolo,
> > > Our oss-fuzz builds started failing, after the meson merge. I think I
> > > tracked down the issues:
> > > 1.) Looking at the build-log here:
> > >
> > > https://oss-fuzz-build-logs.storage.googleapis.com/log-d43d402c-1ce5-4422-b3db-ccbf83a862a0.txt
> > > The error happens at link-time. Re-running the build with V=1:
> > > "/usr/bin/ld" ...
> > > --whole-archive /usr/local/lib/clang/12.0.0/.../libclang_rt.asan-x86_64.a \
> > > --start-group ..... -T /src/qemu/tests/qtest/fuzz/fork_fuzz.ld  \
> > > -wrap qtest_inb -wrap qtest_inw ..... --end-group .....
> > >
> >
> > I think you can put everything into a response for and include it with
> > @fuzz.cmd in the command line.
>
> I don't think I understand. Should I provide the entire linker command,
> by email?

You can create a file fuzz.cmd.in containing

-Wl,-T,@FUZZING_LINKER_SCRIPT@
-Wl,-wrap,qtest_inb
-Wl,-wrap,qtest_inw

etc.

Create a fuzz.cmd that includes the correct path to fuzz.ld in the
source tree (using configure_file) and pass this file to the linker
using @tests/libqtest/fuzz/fuzz.cmd in link_args (and also
link_depends). See libblock and block for an example.

Paolo

Paolo


