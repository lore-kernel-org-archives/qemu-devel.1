Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E65CC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF3F206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="IapsD0gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF3F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYFm-00040e-C6
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jVYFE-0003ZR-1H
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:22:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:34299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jVYFC-000457-BB
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=1OSsI/S5Z0Bd9kcM7tLl4HLQAftxPPOps+hzLT6ZmnQ=; b=IapsD0gEqPshc/tvl8CPHH1ZiF
 mapSMBjbIXsdxMmoDKtD3+OEreT52HYyVzQ8wRblX2vKuB/YL+ZvFU89hmblJ3Fj4Xi3HmEAt8S6f
 tNO4Qo+O8E22s1o7Tyo8W+pDYFMGh31ZLXVSkfeDDD2nWQzdRnyqybTjvIN1iA/58oGr/8TGEIpl6
 fnjfNTAlj2C9MnhhNzR/zH6YsI87iikL/9ZMe3qveoY0GY9GqwAeqEwGoxkLua3OJ5XdxkmLSyxVy
 3J5lCfTefsF/sHZ9FRsUyiAxLdb7kwUpwBy0C4g/hm0hQnKy8HHMKMMl2984D/nFniLaCutj3PtuG
 o8X3W9pWyrA/RDL2r0o29uIBGeWR5ycJX9v6miqTKlWeDMAi81B6nChM0RFyUA7f1TqjyqkYe9lYh
 2ePq1CIn/k3iFq3iS88MjD8H3NzFystAXckEbOaxm+rNBdhgrlR7vQfQKZEJAn3rD8vGTjPWGMb5m
 5MBODiIQOAjVSzHVBwEQ56u1REmetNTaW3xE9Ko+qmHHpUFJeDfJYmkFPKCSL1F4XH5+fswKHvBDM
 /1cmcP7Wa+oojiGLPteUg79FCTrNJ24fj0YitwpgbS/86b4En0qY+bNR4ccrvc+phDEv5lma+bGDK
 WpHtMx5kKNNTUZlVP/lt77uH+/0WoeSI3jGFZNvkw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 3/5] 9pfs: add new function v9fs_co_readdir_many()
Date: Mon, 04 May 2020 12:08:07 +0200
Message-ID: <8025053.zxIBI3vFlk@silver>
In-Reply-To: <20200504111834.117c98d9@bahia.lan>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <5819799.mbObChnQ2B@silver> <20200504111834.117c98d9@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:22:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 4. Mai 2020 11:18:34 CEST Greg Kurz wrote:
> > > > > > +        memcpy(e->dent, dent, sizeof(struct dirent));
> > > > > > +
> > > > > > +        /* perform a full stat() for directory entry if requested
> > > > > > by
> > > > > > caller */ +        if (dostat) {
> > > > > > +            err = s->ops->name_to_path(
> > > > > > +                &s->ctx, &fidp->path, dent->d_name, &path
> > > > > > +            );
> > > > > > +            if (err < 0) {
> > > > > > 
> > > > > >                  err = -errno;
> > > > > > 
> > > > > > -            } else {
> > > > > > -                *dent = entry;
> > > > > > -                err = 0;
> > > > > > +                break;
> > > > > 
> > > > > ... but we're erroring out there and it seems that we're leaking
> > > > > all the entries that have been allocated so far.
> > > > 
> > > > No, they are not leaking actually.
> > > > 
> > > > You are right that they are not deallocated in do_readdir_many(), but
> > > > that's intentional: in the new implementation of v9fs_do_readdir() you
> > > > see that v9fs_free_dirents(entries) is *always* called at the very end
> > > > of
> > > > the function, no matter if success or any error. That's one of the
> > > > measures to simplify overall code as much as possible.
> > > 
> > > Hmm... I still don't quite like the idea of having an erroring function
> > > asking for extra cleanup. I suggest you come up with an idem-potent
> > > version
> > > of v9fs_free_dirents(), move it to codir.c (I also prefer locality of
> > > calls
> > > to g_malloc and g_free in the same unit), make it extern and call it
> > > both on the error path of v9fs_co_readdir_many() and in
> > > v9fs_do_readdir().
> > 
> > I understand your position of course, but I still won't find that to be a
> > good move.
> > 
> > My veto here has a reason: your requested change would prevent an
> > application that I had in mind for future purpose actually: Allowing
> > "greedy" fetching
> Are you telling that this series has some kind of hidden agenda related to
> a possible future change ?!?

readdir_many() is written intended as general purpose directory retrieval 
function, that is for other purposes in future in mind, yes.

What I don't do is adding code which is not explicitly needed right now of 
course. That would not make sense and would make code unnecessarily bloated 
and of course too complicated (e.g. readdir_many() is currently simply 
directly calling v9fs_readdir_response_size() to decide whether to terminate 
the loop instead of taking some complicated general-purpose loop end 
"predicate" structure or callback as function argument).

But when it comes to the structure of the code that I have to add NOW, then I 
indeed take potential future changes into account, yes! And this applies 
specifically to the two changes you requested here inside readdir_many(). 
Because I already know, I would need to revert those 2 changes that you 
requested later on. And I don't see any issue whatsover retaining the current 
version concerning those 2.

Best regards,
Christian Schoenebeck



