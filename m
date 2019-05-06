Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB06C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 07:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBBD2087F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 07:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh92Yt00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBBD2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51918 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNYM2-00053z-O1
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 03:48:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hNYL1-0004gB-BL
	for qemu-devel@nongnu.org; Mon, 06 May 2019 03:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hNYKz-0006Pg-Ij
	for qemu-devel@nongnu.org; Mon, 06 May 2019 03:47:03 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hNYKz-0006PF-CF
	for qemu-devel@nongnu.org; Mon, 06 May 2019 03:47:01 -0400
Received: by mail-ot1-x341.google.com with SMTP id b1so10650940otp.5
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=KPilyAyZ+1ASPfwxRJhKFIQCDY5DmnG4Y164m/v26gk=;
	b=Lh92Yt00+i7b5/cKCfOd0DwKMKuzShNDfrrDrEt4C86P97PdORRYM0H9Izat/p/lCq
	MGia8KXjlc5pIaOUuJ8tEmEmP42Sp9SrKZD28FtVTSfr3ZUvNXeoRBzHgA7FzEAxMLl4
	AvxvEBrkwv/vwTfFBE2X47t7l4N/XMyCzQsh8KdkWM6goWdKoEGsKNDsAkhsGoOOYb+x
	7ydZhVdoUduQiy1Jt7i9Vug/PpDgnROum0/dtxmJu4eIGd2fPvNdmgvzXVsgvWsMgPR4
	x1pVf4q9DnQAggC6QQl66KkHn8p2P45MAHqTdTlcf0DcGGCOCnuOOoL1bIbR8BBLNmfA
	bRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=KPilyAyZ+1ASPfwxRJhKFIQCDY5DmnG4Y164m/v26gk=;
	b=kNRPT6b+Sv2IwYH1eOzSoZz7YqPYtwpIFZhvbzQvY0AoTDa21Mi3j6ws1XqjPP3RU2
	mOP5zHorR1vv5SQzvPrX4bb65yJhgsDcLWjBqjyrXkVrXEW+zXa8SaYrxwhZHCAnqawp
	aERApFEUmR+wzLe353oFT3IZRyx3TVJEbbytJudy1Z4K59n6y7DJCa6ZdpYhAasMfU6s
	hegw57871NZ8a1YAmMyoblNl5JqMvJDgeJGCAdAxJRVx0GhkACnGpTh1tDxcXkkwZuop
	tNRgEHZeyL5lL41DxdhluHAD2uqemaHpla1bSY4g0JrMxZ+Rq1Cnmy0z4ZCFQcr/1d3/
	vgtQ==
X-Gm-Message-State: APjAAAV4WNVJJdD9NHnlugyNp1UVUXxsmRXV73M2LXsE4a6gMos+PZbd
	ZPKo7bAu7aMMdMllfALdosYTeKnnAgXNm0YBIqU=
X-Google-Smtp-Source: APXvYqzTFgAE47WDiNHM6liePkgLJTMv8atfdxMffUPpbF6wv0RKgagbY/KdV5Wqxb/OkIS0Y/1w4gs3QMGDWHHp9Uk=
X-Received: by 2002:a9d:604c:: with SMTP id v12mr12995237otj.304.1557128819865;
	Mon, 06 May 2019 00:46:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP;
	Mon, 6 May 2019 00:46:59 -0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP;
	Mon, 6 May 2019 00:46:59 -0700 (PDT)
In-Reply-To: <CAFEAcA9BCXuOxaFaHvT0bDnb+7e_vYuhxspjokRp19G+SUf+MA@mail.gmail.com>
References: <CAFEAcA9BCXuOxaFaHvT0bDnb+7e_vYuhxspjokRp19G+SUf+MA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 6 May 2019 09:46:59 +0200
Message-ID: <CAL1e-=hYzmo3gFpFH6SzeMVy4aEPnRyLBKwwqTOOXFRk0K66hg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Spreading the load on QEMU pullreq handling and
 release work
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Apr 30, 2019 7:38 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> For most releases in the past five years, I've been handling the
> work of applying pull requests, tagging release candidates, and
> so on. (For one or two releases somebody else has done this when
> I've been off on holiday.) This takes up a fair chunk of my time
> during the actual "release" phase of a cycle, and it also
> represents a "bus factor" issue for the project if I'm the only
> person doing this. I'd like to try to spread this work out a bit
> between more people.
>
> Specifically, where I'd like to get to is that we have a rota of
> three people doing this, which at our "three releases a year"
> pace means any one person only has to handle one release cycle
> a year.
>
> Part of this move is going to require moving away from some of the
> ad-hoc scripting and testing that I currently do on a selection of
> personal and work machines and instead using machines that can be
> used by other project members.  (One recent suggestion is that
> perhaps the gitlab CI might be a useful place to start, since it
> allows us to provide custom build workers rather than only doing
> x86 host testing.)
>
> For the moment I'd like to ask for in-principle volunteers
> to be on the release-handling rota.
>
> The work involves:
>  * the mechanical process of actually processing pullreq
>    emails and applying them
>  * letting people know about failures, which can mean some
>    investigation of exactly why something has failed to
>    distinguish problems with the pull from preexisting
>    intermittent failures from infrastructure issues
>  * more careful by-hand scrutiny of pull requests from
>    submaintainers who haven't done it before or who don't make
>    pull requests often (checking for missing signoffs, weirdly
>    malformed pull requests, patches that shouldn't be in the
>    pull, etc)
>  * maintenance of what I guess will need to be a shared
>    project GPG keyring to add submaintainer keys (there's
>    a judgement call required for whether a new key is
>    sufficiently trusted, working with the submaintainer to
>    ask them to try to get more signatures if possible, etc)
>  * curating the "Planning" wiki page where we record things
>    not yet fixed in the current release, including chasing
>    people for fixes for RC bugs, asking around if anything
>    ought to go in, tracking potential RC issues that crop up
>    on the mailing list, etc
>  * making sure we correctly raise the "is this important
>    enough to go in" bar for pull requests during the release
>    candidate phase by scrutinizing pull requests and if
>    necessary pushing back on submaintainers
>  * likely some other things I have forgotten
>
> Since there is a definite human judgement required here, this
> isn't going to be a fully automatable process[*], and it would
> be best done by people who've got a reasonably long history of
> working with the project (both from a trust perspective and
> because they have the experience to make the judgement calls
> required).
>
> [*] It could quite possibly be automated a bit more than I
> currently do it, though. I'm also open to the idea that maybe we
> should do less gatekeeping at the apply-pull stage and instead
> delegate to submaintainers to make the right judgements, though
> in my experience there is usually at least one pullreq
> submitted late in the rc process which has stuff in it that
> should not go in at that point...
>
> NB: at the moment there is a split in handling of release
> candidates and the release, where I do the tagging of an rc in
> git, and Michael Roth then rolls tarballs and makes
> announcements of the rc or final release. Michael -- is that
> work something you'd like to spread around between more people
> or are you happy to continue to do it all?
>
> So, any volunteers (from anybody, not just people on the cc list) ?
>

I think I could successfully undertake majority of the tasks you mentioned
(l am not certain on build tests only, since I most probably don=CB=8At hav=
e the
test equipment that is versatile enough and I am not sure how Github CI
works).

In any case, I admire your handling this heavy burden so far, and wish we
continue making QEMU better every year.

Sincerely,
Aleksandar

> thanks
> -- PMM
>
