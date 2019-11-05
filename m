Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E43C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFCC21929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npr455PA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFCC21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5Hq-0008FE-GG
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS5H8-0007qH-KQ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS5H6-0008C4-TM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:18:02 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:35032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iS5H2-0008Ao-5g
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:17:58 -0500
Received: by mail-qt1-x841.google.com with SMTP id r22so20976512qtt.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oVvaUBMNbfF6xWhnEINfzjbG8TEY+ltUPzTgzGdlXNo=;
 b=Npr455PAsCOft4IKxZxhy87XiYQyLumyyGFLirF1g7LFZUZFnuOuvFjKiazTooYdIa
 OUN2HEbU0Q1FkOpv/BD6Gv62OxDbWiatfj4XPE2I6oMzeIiQ+V32d/FFBh31SV3lqaIv
 4dU+4Hk6q5z/zCxWlkuFD35rdyg6CsqqM2xSI8HMyDzP6mNUtyGndX53mfniANW/CNdv
 4ZLg05rTEWODN/Iu18EsxlOi2iK6zDGCDX3SCgaY7+WR6TS+U4EKI2LbzonDAoOi27Lj
 GtcfRcxfDfitf/KwCl7UpcvRAEZ/QdXUTd39hGHP7QjUs2O6IFl07Zxb0Q1sUPGKbz/L
 cD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oVvaUBMNbfF6xWhnEINfzjbG8TEY+ltUPzTgzGdlXNo=;
 b=F4S76n8HyQV+vFLqbkCfWRW8Q+zxGGy8nzV4fXEBpK+EVLITuNGW9q5ZDwzbGRnmw2
 Qu/Tt5KwCO2hhSPihYrq2Fh3kdVpG3mIhm7jpzYbwxU76G6NJYvFhJfSeqJ+lLL3ZJz5
 KVgWyEfOP6567dZQIsXqTP3mp3+6dPd31U3tzLC916J0/oZA7kRksgK+ExvEDE0enKvP
 h/Zu0UwvUq/aLeP5qgcovtHUO/+v6PCMT55OVUvJjXWofUkEuyngudflKWDjIaRZbkKK
 yQlB0Obn1qNwXaArttN49qw24yZmTs0+daAdV8QI9ouOX3Hdl4+EdZLaEZ9Gef+ICXr4
 g54A==
X-Gm-Message-State: APjAAAVei0daunFvA3eWfU9LZrBeXK0vvwsOoei3FxxQWFJD1GVOgP0U
 zALphi80HbV+QAEcMqvsaO3KIJ8Uq76/qJj54kU=
X-Google-Smtp-Source: APXvYqzlseP/jo4zFvfpQInSqz+FWgjeQ3RNVjKJzTAa/AjLOOxuz3pUfkTpp0O/VtXZYCEp9GK3g3CHhwcO1IvkeVs=
X-Received: by 2002:aed:3ae8:: with SMTP id o95mr19575400qte.277.1572985073549; 
 Tue, 05 Nov 2019 12:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20191031105904.12194-1-jsnow@redhat.com>
 <CAFEAcA964ibGcb02kTC_bTcX5xLu5r-=NJMz5Kykct0t7CVwnw@mail.gmail.com>
 <13430122-c3b2-b68e-8cc8-59e2cb864add@redhat.com>
In-Reply-To: <13430122-c3b2-b68e-8cc8-59e2cb864add@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 Nov 2019 21:17:42 +0100
Message-ID: <CAJSP0QVmL_JTZOo=opN6Z6kgpwJaY780YocSteC1z48kpCac5Q@mail.gmail.com>
Subject: Re: git-publish, --pull-request and --signoff (was: Re: [PULL 0/9]
 Ide patches)
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 31, 2019 at 5:07 PM John Snow <jsnow@redhat.com> wrote:
> On 10/31/19 11:02 AM, Peter Maydell wrote:
> > On Thu, 31 Oct 2019 at 10:59, John Snow <jsnow@redhat.com> wrote:
> >>
> >> The following changes since commit 68d8ef4ec540682c3538d4963e836e43a211dd17:
> >>
> >>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-plugins-281019-4' into staging (2019-10-30 14:10:32 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
> >>
> >> for you to fetch changes up to c35564caf20e8d3431786dddf0fa513daa7d7f3c:
> >>
> >>   hd-geo-test: Add tests for lchs override (2019-10-31 06:11:34 -0400)
> >>
> >> ----------------------------------------------------------------
> >> Pull request
> >>
> >
> > Hi -- this passed the merge tests but it looks like you forgot
> > to add your signed-off by line as the submaintainer to Sam's
> > patches. Could you fix that up and resend, please?
> >
> > thanks
> > -- PMM
> >
>
> I bit myself twice with this now: adding --signoff to a pull request
> signs the messages that get sent to list, but not the ones that get staged.
>
> Could always be a bug in my local copy, but I'm documenting it on the
> list, in case I don't get time to look at this in the next 24h.

Do you mean Signed-off-by is only added to emails that are sent and
not to the actual commits in your repo?

This is how git-format-patch(1) --signoff works.  git-publish does not
modify local commits either.

Some people would probably be surprised if git-publish modified their
commit history.

I'm not sure what the best solution here is, aside from introducing a
separate signoff option called --apply-signoff or similar so there is
no confusion.

Stefan

