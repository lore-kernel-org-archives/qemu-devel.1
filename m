Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B812C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3E921A49
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3E921A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5rOc-0003yx-O9
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 09:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i5rMX-0002P7-Qz
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i5rMW-0001MW-8z
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:59:45 -0400
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:40703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i5rMV-0001Lf-QI
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:59:44 -0400
Received: from player697.ha.ovh.net (unknown [10.108.35.232])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 827E01DF7C6
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 14:59:41 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id CBB399802E54;
 Thu,  5 Sep 2019 12:59:33 +0000 (UTC)
Date: Thu, 5 Sep 2019 14:59:31 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190905145931.3748d5f2@bahia.lan>
In-Reply-To: <1897173.eDCz7oYxVq@silver>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com>
 <4642438.ai5u8AxThJ@silver> <1897173.eDCz7oYxVq@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 485544334990547264
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejjedghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.42.204
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
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
Cc: berrange@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, antonios.motakis@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 05 Sep 2019 14:25:13 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 4. September 2019 15:02:30 CEST Christian Schoenebeck wrote:
> > > > Well, mailman is handling this correctly. It replaces the "From:" field
> > > > with a placeholder and instead adds my actual email address as
> > > > "Reply-To:" field. That's the common way to handle this on mailing
> > > > lists,
> > > > as also mentioned here:
> > > > https://en.wikipedia.org/wiki/DMARC#From:_rewriting
> > > > 
> > > > So IMO patchew should automatically use the value of "Reply-To:" in that
> > > > case as author of patches instead.
> > > > 
> > > > Reducing security cannot be the solution.
> > > 
> > > No, there's no need to reduce security.  Just change your local git
> > > configuration to produce a 'From:' line in the commit body..
> > 
> > Got it. :)
> > 
> > > >> How are you sending patches ? With git send-email ? If so, maybe you
> > > >> can
> > > >> pass something like --from='"Christian Schoenebeck"
> > > >> <qemu_oss@crudebyte.com>'. Since this is a different string, git will
> > > >> assume you're sending someone else's patch : it will automatically add
> > > >> an
> > > >> extra From: made out of the commit Author as recorded in the git tree.
> > > 
> > > I think it is probably as simple as a 'git config' command to tell git
> > > to always put a 'From:' in the body of self-authored patches when using
> > > git format-patch; however, as I don't suffer from munged emails, I
> > > haven't actually tested what that setting would be.
> 
> Well, I tried that Eric. The expected solution would be enabling this git 
> setting:
> 
> git config [--global] format.from true
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-formatfrom
> 
> But as you can already read from the manual, the overall behaviour of git 
> regarding a separate "From:" line in the email body was intended solely for 
> the use case sender != author. So in practice (at least in my git version) git 
> always makes a raw string comparison between sender (name and email) string 
> and author string and only adds the separate From: line to the body if they 
> differ.
> 
> Hence also "git format-patch --from=" only works here if you use a different 
> author string (name and email) there, otherwise on a perfect string match it 
> is simply ignored and you end up with only one "From:" in the email header.
> 
> So eventually I added one extra character in my name for now and removed it 
> manually in the dumped emails subsequently (see today's
> "[PATCH v7 0/3] 9p: Fix file ID collisions").
> 

Hence my proposal in some other mail to pass a different string to
git send-email, but I guess this also works for git format-patch.

eg, adding double quotes around your "firstname name"

 --from='"Christian Schoenebeck" <qemu_oss@crudebyte.com>'

> Besides that direct string comparison restriction; git also seems to have a 
> bug here. Because even if you have sender != author, then git falsely uses 
> author as sender of the cover letter, whereas the emails of the individual 
> patches are encoded correctly.
> 
> Best regards,
> Christian Schoenebeck
> 
> 


