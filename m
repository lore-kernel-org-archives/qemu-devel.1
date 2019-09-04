Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184D1C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97FF22CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="cb5TFzoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97FF22CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VDW-0002tI-LK
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i5Uvl-0002wx-6y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i5Uvi-0000l8-K9
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:02:36 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:57297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1i5Uvi-0000ji-2R
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zMsqznVlY7oTgNONFBZhZJ8J7V5CuSYQ397rZhTg6lw=; b=cb5TFzoMHiJKZ6gh6Q91VXTUEM
 Nh7DhN2Wh4QTiqf6MI6S4UdLtKASpnrIRI1LN6oj8PVKW6QCwldEEan7lIexSQbBNDFQ1lEcNgagD
 EDWhJVQjcpKFc2qVySH3/yuwwfDKwOP0tUigW5b4I3xIIfr6tLUPFyfZImoNTiLhpMajZOu/1dYDq
 TKVGAyfZsVv364FYT2QCQLQ/Pn0VKZrO05q/X/SX8rFcj3Nz9oqvVbC5o/CnxJ+LkojL4wgP3S/pD
 y7t2aBW0MK8ktmKocAWAAXE3nlTrlQ7TYdHU7X9yKIt1QEaoI4cWZvkzv4PPSW4/u3K6pN2HcOw8R
 CW1QWeFQxy9nGlG4P4tjLXiTztfba4YcI0E5d+tcnRwpDG//QyqQrDgTTxehOMW5Z7DExyP0WIyO+
 l2+xL8hQ6dkghb9NXBhDtFtfbfiZj1/B6WAIbZPZ/Ybu3bWEW2/NNac9wo5QIQll6QsEUOZniIXT/
 uO1JoPg/C87r7tq/PWoaASRlM+Lc+GZLAisiaDMtmfWg/5/rZmoHfi6Pa8qpscS+dV9nfPMIwjGTd
 vHhsJpQzd7HaU3aotyudToyS+RYQ0JZDB01Vvmm8VFHhqBDO7JiTnYSDzRztjUR+BrRphvYQEJKPH
 dLWOLvpXTAP7zKp5sPyypX+m8mjb5ygPrUajhbcxo=;
To: qemu-devel@nongnu.org
Date: Wed, 04 Sep 2019 15:02:30 +0200
Message-ID: <4642438.ai5u8AxThJ@silver>
In-Reply-To: <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <2734436.Mu773bgsdE@silver> <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 5.189.157.229
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: berrange@redhat.com, stefanha@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 dgilbert@redhat.com, antonios.motakis@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 3. September 2019 21:38:15 CEST Eric Blake wrote:
> On 9/2/19 5:29 PM, Christian Schoenebeck via Qemu-devel wrote:
> >>>>> === OUTPUT BEGIN ===
> >>>>> 1/4 Checking commit bb69de63f788 (9p: Treat multiple devices on one
> >>>>> export
> >>>>> as an error) ERROR: Author email address is mangled by the mailing
> >>>>> list
> >>>>> #2:
> >>>>> Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> >>>> 
> >>>> This is problematic since it ends up in the Author: field in git.
> >>>> Please
> >>>> find a way to fix that.
> >>> 
> >>> Like in which way do you imagine that? And where is the actual practical
> >>> problem? I mean every patch still has my signed-off-by tag with the
> >>> correct
> >>> email address ending up in git history.
> >> 
> >> Yes, this only breaks Author: if the patch is applied from the list.
> 
> Except that many maintainers DO apply mail from the list (thanks to 'git
> am').  Fixing patchew to unmunge things is an appealing idea, but would
> not fix the problem for maintainers not cloning from patchew, so even if
> patchew avoids the problem locally, it should still continue to warn
> about the problem.
> 
> >>> The cause for this issue is that the domain is configured to require
> >>> DKIM
> >>> signatures for all outgoing emails. That's why mailman replaces my
> >>> address
> >>> by "Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>"
> >>> placeholder since it could not provide a valid signature.
> 
> And when you know that mailman is going to munge your address, the fix
> is to configure git to output 'From: correct name <correct@example.com>'
> as the first line of the BODY of the message, since 'git am' favors the
> unmunged From: from the body over the munged From: from the headers.

Ah I see, I will try that with the next 9p patch set round (probably 
tomorrow). Thanks for the hint!

I actually had a quick glimpse on the patchew sources yesterday to see if 
there was some undocumented alternative header like "X-git-author:" or 
something like that, but could not find one.

> > Well, mailman is handling this correctly. It replaces the "From:" field
> > with a placeholder and instead adds my actual email address as
> > "Reply-To:" field. That's the common way to handle this on mailing lists,
> > as also mentioned here:
> > https://en.wikipedia.org/wiki/DMARC#From:_rewriting
> > 
> > So IMO patchew should automatically use the value of "Reply-To:" in that
> > case as author of patches instead.
> > 
> > Reducing security cannot be the solution.
> 
> No, there's no need to reduce security.  Just change your local git
> configuration to produce a 'From:' line in the commit body..

Got it. :)

> >> How are you sending patches ? With git send-email ? If so, maybe you can
> >> pass something like --from='"Christian Schoenebeck"
> >> <qemu_oss@crudebyte.com>'. Since this is a different string, git will
> >> assume you're sending someone else's patch : it will automatically add an
> >> extra From: made out of the commit Author as recorded in the git tree.
> 
> I think it is probably as simple as a 'git config' command to tell git
> to always put a 'From:' in the body of self-authored patches when using
> git format-patch; however, as I don't suffer from munged emails, I
> haven't actually tested what that setting would be.
> 
> > I use "git format-patch ..." to dump the invidiual emails as raw email
> > sources and then I'll send those raw emails from the command line. So I
> > have even more control of what is exactly sent out and could of course
> > also add custom email header fields if required, if that would solve the
> > situation somehow, i.e. manually as first test and later in automated
> > way. That's not the issue here.
> Working around the problem does not require munging email headers, but
> adding a line to the email body.




