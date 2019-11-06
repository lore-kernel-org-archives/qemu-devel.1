Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120EC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 06:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147B920869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 06:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajKNFfEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147B920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSEdU-0001Xg-Bj
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 01:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSEca-00017b-BQ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 01:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSEcY-00034Y-W1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 01:16:48 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:44895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSEcY-00034E-QD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 01:16:46 -0500
Received: by mail-qk1-x741.google.com with SMTP id m16so23271871qki.11
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 22:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TWLS9QqGfpl3c5rW/Hx6GXvJAp4VGa8gFX1x84hvU7M=;
 b=ajKNFfEp+qEysJahjJCSaRG7IAAvO4iMqfOxeCU+eqluwVdZtGcz1JnUNsGYSNexYv
 SZ99Q1Tpk2Err/h6PSjPBUuGb6A5QCHM4Gzvk9cx765DPa0scSK79R7RCFN1tZO1sDLM
 XLNh4I02Rr2dEX7bX/Skpq+q6pH2lUmVOxrBuRGyoZQTQqBXp83hyAeCAtFuP98AFdzK
 Yxd2PzGW91iQQ7qyTkZBVbByuss/aOVpl7K5hnA8MJPgoH/fqwXGQ30yQH1M0MGJ69hu
 Aycq7x/n3/wX/6k6MOwi+RxwVOes9+vKhnCmk/1FnIgQ8NIWuYmdn7XfJwScU+9GFA1K
 UAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TWLS9QqGfpl3c5rW/Hx6GXvJAp4VGa8gFX1x84hvU7M=;
 b=ML8ELim5kt5YGOZYjzllJrrHYFFMHoWOhVGl2iE7gwnYhvu2ulEEja0LSLvQBgIl+e
 sWYoj6vUOYchyjUFq+1BLdZyUc2csT4rht1SoLkc0hvigyqrofg2yrgviMKT3u/tCmu5
 6kJbPw1YoKRJdIWNXReicQh2hGtmYA0Mk/gk7fF6pIzlOgnOWB06RSRgCc5eBN/1p6/Y
 tieA1sK22+1DxeHyeHaAsPVUinbjWkkDJyLxWF5wQTOtiZY/45Ph/NSncjZqGNWuprmx
 SykU6geG+iJGgxCXIDqYVWx03V/CUqawo1SI/CjiRLE6l9+Dvsuh0Rm/IVTMwVrVBSPc
 e2jA==
X-Gm-Message-State: APjAAAWpFJSREgqqP7Oln3R9xBJufhmEpxauiVqP8RZ5AWk69yGaglhe
 n/qqvmi7+T/4rX9VErpogA6g0DZKuBiooPuiNaI=
X-Google-Smtp-Source: APXvYqyWVVR/RKtibqRVYIE2uoDpvIveuVBSnOT3o6ZZNn81rjRMr+pNIMH2AYTp7Yrdh1VwKcCLL++e4KucbAjsUho=
X-Received: by 2002:a05:620a:3dd:: with SMTP id
 r29mr679781qkm.370.1573021004390; 
 Tue, 05 Nov 2019 22:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20191031105904.12194-1-jsnow@redhat.com>
 <CAFEAcA964ibGcb02kTC_bTcX5xLu5r-=NJMz5Kykct0t7CVwnw@mail.gmail.com>
 <13430122-c3b2-b68e-8cc8-59e2cb864add@redhat.com>
 <CAJSP0QVmL_JTZOo=opN6Z6kgpwJaY780YocSteC1z48kpCac5Q@mail.gmail.com>
 <20191105202242.GI3812@habkost.net>
In-Reply-To: <20191105202242.GI3812@habkost.net>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Nov 2019 07:16:32 +0100
Message-ID: <CAJSP0QUkvjh9iehUDbYCCgOrAU212=yEO1+y_1FYK4LNSsR2+w@mail.gmail.com>
Subject: Re: git-publish, --pull-request and --signoff (was: Re: [PULL 0/9]
 Ide patches)
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 5, 2019 at 9:22 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Nov 05, 2019 at 09:17:42PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Oct 31, 2019 at 5:07 PM John Snow <jsnow@redhat.com> wrote:
> > > On 10/31/19 11:02 AM, Peter Maydell wrote:
> > > > On Thu, 31 Oct 2019 at 10:59, John Snow <jsnow@redhat.com> wrote:
> > > >>
> > > >> The following changes since commit 68d8ef4ec540682c3538d4963e836e43a211dd17:
> > > >>
> > > >>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-plugins-281019-4' into staging (2019-10-30 14:10:32 +0000)
> > > >>
> > > >> are available in the Git repository at:
> > > >>
> > > >>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
> > > >>
> > > >> for you to fetch changes up to c35564caf20e8d3431786dddf0fa513daa7d7f3c:
> > > >>
> > > >>   hd-geo-test: Add tests for lchs override (2019-10-31 06:11:34 -0400)
> > > >>
> > > >> ----------------------------------------------------------------
> > > >> Pull request
> > > >>
> > > >
> > > > Hi -- this passed the merge tests but it looks like you forgot
> > > > to add your signed-off by line as the submaintainer to Sam's
> > > > patches. Could you fix that up and resend, please?
> > > >
> > > > thanks
> > > > -- PMM
> > > >
> > >
> > > I bit myself twice with this now: adding --signoff to a pull request
> > > signs the messages that get sent to list, but not the ones that get staged.
> > >
> > > Could always be a bug in my local copy, but I'm documenting it on the
> > > list, in case I don't get time to look at this in the next 24h.
> >
> > Do you mean Signed-off-by is only added to emails that are sent and
> > not to the actual commits in your repo?
> >
> > This is how git-format-patch(1) --signoff works.  git-publish does not
> > modify local commits either.
> >
> > Some people would probably be surprised if git-publish modified their
> > commit history.
> >
> > I'm not sure what the best solution here is, aside from introducing a
> > separate signoff option called --apply-signoff or similar so there is
> > no confusion.
>
> I would make git-publish error out if --signoff and
> --pull-request are used simultaneously.  I can't think of a
> justification for having the email contents not match the git tag
> contents in a pull request.

Sounds good!

Stefan

