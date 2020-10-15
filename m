Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F3AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D191218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R899ssy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D191218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT8Uv-0007Qt-84
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kT8Sf-0006QB-My
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kT8Sa-0000oD-Kt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602788321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfU/8C9vAd/KHw91dMadCgq1VTR4BjdaUwQ5WsuStxE=;
 b=R899ssy8cfI27quDVRgkGSCIi58nBbwBd/Q/5MV8nrRhu+hz/v9gDxzmnsZ68TsIGmKpqz
 uF7dU0U+caOnOMGgLF87cqB1WbeJKuXLiHI5wKeTPx1Qq1u/bXO2yOHgpYn+H4llUrhwyh
 RVIi0Nitosc+I0ZiN5OfKamsxosQKPc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-QmR8InsROIOcAjcLal9IjQ-1; Thu, 15 Oct 2020 14:58:39 -0400
X-MC-Unique: QmR8InsROIOcAjcLal9IjQ-1
Received: by mail-il1-f199.google.com with SMTP id z8so2885494ilh.13
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 11:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XfU/8C9vAd/KHw91dMadCgq1VTR4BjdaUwQ5WsuStxE=;
 b=Wl1tBJjvpR0IUuqgNGYFLtOUjyPI0rlGn4/ErLTMlFH36c8d62q4iTQEc5WyLe6wBR
 WPenA/Z1rGai0e1oHB1P/jlgbiCJ+3KnRengA/zLmgaIyRuAoWvS9q6lWenThW6eluP4
 0wgUdjIzOSVXLU5NGnWndz1EIDHpKZCrZovu2BKE/YtRYn5gKt+ejAaK/1o98yoABD5l
 WwS4KIRC/tb9NbRxo6rHWjJ2+TW4qnzlAn/a29rPG0C0m1IymVCwK/XBQd65ayFM0cTe
 vIno1nUsGlF2Wm/91PXZJqUl//l8nmYl1nggZ+G3e8WkgW/pAOeBg7CTSrIN0tLSKi2u
 +8/Q==
X-Gm-Message-State: AOAM5330EUHDCO69Or7vaEhhrnO/HO/6/87KfJDWKH5PkVq4CjIotTCA
 HTq+cYpNFax6RHgkyd2FRf1Mr6BnFRneFXZYp2LCqr6t1Gl0+IXM4iWQdqkQofBdxn7126eEOxe
 0zjev0EEYp7IFAVk=
X-Received: by 2002:a05:6638:102c:: with SMTP id
 n12mr4572115jan.87.1602788318688; 
 Thu, 15 Oct 2020 11:58:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6GqOP2pdmWIs51coD5LLPGTlZfqBr3MJ6P577qtpMlu0wlJ/+G1GeCSE6+lhY9Sg9jgxCbw==
X-Received: by 2002:a05:6638:102c:: with SMTP id
 n12mr4572103jan.87.1602788318425; 
 Thu, 15 Oct 2020 11:58:38 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id z9sm3051674iln.87.2020.10.15.11.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 11:58:37 -0700 (PDT)
Date: Thu, 15 Oct 2020 14:58:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 00/10] migration queue
Message-ID: <20201015185835.GC133059@xz-x1>
References: <20201008191046.272549-1-dgilbert@redhat.com>
 <CAFEAcA-U2BjAne57Zn7c4_J97NAZSYzzy6r59iVeGmtgfD3APg@mail.gmail.com>
 <20201014200138.GB133059@xz-x1>
 <821ef4ae-1e66-02b9-d9ae-567005aa7c2f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <821ef4ae-1e66-02b9-d9ae-567005aa7c2f@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, zhengchuan@huawei.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 11:13:44AM +0200, Thomas Huth wrote:
> On 14/10/2020 22.01, Peter Xu wrote:
> > On Sun, Oct 11, 2020 at 07:29:25PM +0100, Peter Maydell wrote:
> >>> Migration:
> >>>   Dirtyrate measurement API cleanup
> >>>   Postcopy recovery fixes
> >>>
> >>> Virtiofsd:
> >>>   Missing qemu_init_exec_dir call
> >>>   Support for setting the group on socket creation
> >>>   Stop a gcc warning
> >>>   Avoid tempdir in sandboxing
> >>
> >> This seems to hang in 'make check' trying to run
> >> tests/qtest/migration-test on s390x and ppc, ie
> >> the big-endian hosts.
> > 
> > Hi, Peter,
> > 
> > Do you know what's the page size on both platforms?
> 
> s390x uses 4k page size by default. Only huge-pages are different.

Hmm... Then I can't explain.  Maybe there're two bugs, or maybe there's
something I've overlooked.

> 
> > I'm also trying to find a s390x host to give it a shot.  However I decided to
> > also ask this loud so it might be even faster.
> 
> Easiest way to test on s390x is likely to use Travis. If you have already an
> github or gitlab account, you can simply clone the qemu repository there and
> add Travis (from the Marketplace in Github, not sure how it exactly works
> with Gitlab) to your cloned repo. If you then push commits to a branch,
> Travis should trigger automatically, including runs on s390x, see e.g.:
> 
>  https://travis-ci.com/github/huth/qemu/jobs/399317194

Finally I setup the CI this time and that's quite handy.  I should probably do
this even earlier, thanks Thomas!

Anyway, I'll see whether my fix will pass travis (still running), and see
whether I should repost again.

-- 
Peter Xu


