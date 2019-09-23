Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B20C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED0D20882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="RuklwlFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED0D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCMW5-0005iR-ML
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iCMVM-0005GK-Cj
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iCMVL-0006dY-04
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:27:44 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:58263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iCMVK-0006d4-OL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=iQsqsYll1i55WbC/AM87Id5KKbN0YRMriTpo9uxAwrY=; b=RuklwlFs0iv88y5AohT4HIztmL
 swbIazUoHoyKLp2qXL2P/4Zu2/qqn9hkekEaiYLA1zmnkLixNwqyRsBN6AN0N6T69GgJs25a8UlJM
 4cOos0aWquusGqAt2JpSwBv2B35lGxHpw28Ar1OM6db3ufNHMSvWxTmaPgARMmhI50TObSUu0JEpC
 udvT4Sm+nBeAXExqZaJMesqwML6eUI3+/215sFnw1EcnKiTW4hWu1JP+Xh7GdMg/Mkyg2YitBlRmo
 irbmnxUJ3FME62akr+12iVWG2Df21CRrb16svWiCafyK8hGZcboPX2cmpR8YGpwKDTPiXCrQcSK17
 +pBxJinBAqCuB7zCV7SkHdiVJ4SUlZd7HfBEgkG6Ek9FKVF7EbjJwGgKKbD153QQ3m7vNpV9omrot
 ZbTBO8jCJj4h6BeMyo7Li98/WvbdW9HcrVniIplbnHL0DgvRGeNNxLTadse5fakvJBp5c15xvPMbz
 VYKx9aL8H6OgjxQvo/C2UTNijgTcTe/0pSU1A8xz1N2LvUlAnwv1LID8lqfMSu1EOceJCb7EpKDii
 KEHUNhpmrd9sTSkBXuEr2TkwO7dNW4fqY3es1QXasxy4/w04zkCm+lqBjL8seiXYtl4HkDxtYcMsz
 69sp7ZMKmqqGkJFPu/7CdBsKZ/ojvpF8P4QNNjJgU=;
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
Date: Mon, 23 Sep 2019 13:27:37 +0200
Message-ID: <5814161.pL1kAXq1mB@silver>
In-Reply-To: <20190905145931.3748d5f2@bahia.lan>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <1897173.eDCz7oYxVq@silver> <20190905145931.3748d5f2@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
Cc: berrange@redhat.com, stefanha@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 dgilbert@redhat.com, antonios.motakis@huawei.com, Ian Kelling <iank@fsf.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Christian Schoenebeck <qemu_oss@crudebyte.com>
From: Christian Schoenebeck via <qemu-devel@nongnu.org>

On Donnerstag, 5. September 2019 14:59:31 CEST Greg Kurz wrote:
> On Thu, 05 Sep 2019 14:25:13 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Mittwoch, 4. September 2019 15:02:30 CEST Christian Schoenebeck wrote:
> > > > > Well, mailman is handling this correctly. It replaces the "From:"
> > > > > field
> > > > > with a placeholder and instead adds my actual email address as
> > > > > "Reply-To:" field. That's the common way to handle this on mailing
> > > > > lists,
> > > > > as also mentioned here:
> > > > > https://en.wikipedia.org/wiki/DMARC#From:_rewriting
> > > > > 
> > > > > So IMO patchew should automatically use the value of "Reply-To:" in
> > > > > that
> > > > > case as author of patches instead.
> > > > > 
> > > > > Reducing security cannot be the solution.
> > > > 
> > > > No, there's no need to reduce security.  Just change your local git
> > > > configuration to produce a 'From:' line in the commit body..
> > > 
> > > Got it. :)
> > > 
> > > > >> How are you sending patches ? With git send-email ? If so, maybe
> > > > >> you
> > > > >> can
> > > > >> pass something like --from='"Christian Schoenebeck"
> > > > >> <qemu_oss@crudebyte.com>'. Since this is a different string, git
> > > > >> will
> > > > >> assume you're sending someone else's patch : it will automatically
> > > > >> add
> > > > >> an
> > > > >> extra From: made out of the commit Author as recorded in the git
> > > > >> tree.
> > > > 
> > > > I think it is probably as simple as a 'git config' command to tell git
> > > > to always put a 'From:' in the body of self-authored patches when
> > > > using
> > > > git format-patch; however, as I don't suffer from munged emails, I
> > > > haven't actually tested what that setting would be.
> > 
> > Well, I tried that Eric. The expected solution would be enabling this git
> > setting:
> > 
> > git config [--global] format.from true
> > https://git-scm.com/docs/git-config#Documentation/git-config.txt-formatfro
> > m
> > 
> > But as you can already read from the manual, the overall behaviour of git
> > regarding a separate "From:" line in the email body was intended solely
> > for
> > the use case sender != author. So in practice (at least in my git version)
> > git always makes a raw string comparison between sender (name and email)
> > string and author string and only adds the separate From: line to the
> > body if they differ.
> > 
> > Hence also "git format-patch --from=" only works here if you use a
> > different author string (name and email) there, otherwise on a perfect
> > string match it is simply ignored and you end up with only one "From:" in
> > the email header.
> > 
> > So eventually I added one extra character in my name for now and removed
> > it
> > manually in the dumped emails subsequently (see today's
> > "[PATCH v7 0/3] 9p: Fix file ID collisions").
> 
> Hence my proposal in some other mail to pass a different string to
> git send-email, but I guess this also works for git format-patch.
> 
> eg, adding double quotes around your "firstname name"
> 
>  --from='"Christian Schoenebeck" <qemu_oss@crudebyte.com>'

Yeah, I will use that for now, since it just works^TM (I tested it).

Because for some reason my emails are still mangled on this list. Probably I 
still have to drop more header fields from dkim's "h=..." setting. We'll see.




