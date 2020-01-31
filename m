Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E6C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33193206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnFWcE9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33193206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUjl-0001SM-Cf
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixUj2-0000eB-TP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixUj1-0003U3-AJ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:44:40 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixUj1-0003RV-3r
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:44:39 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so6254575otd.9
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 03:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AZDYNDSbSEPlDO5GL/RS+Paol6CiMRQi6AXB3v402Lk=;
 b=hnFWcE9aOVEPSt5J6yaewPu7Hfwv2ncyyO9jMFlK2k0v1O5ROqyiKJ5AE1znjXkL+/
 boJRxvwMrvgSOmswnPFADlVusGsXGJuaA3DBxOTeuj2n/uyyW05vrZ2x01kZbNskqp7C
 ttbq3oKBXpyzTOQW33fKPlF8GLRL0+1TiQM6ykp68uTQMIFfi4KBzF5DczpuR5eLIGNJ
 xQFr4gm5BGnqdvu4kfdabErSCccsePqmj0EnqYl3sDd0e65rox53XyBfuwDOTYQ2plYD
 xBArO3AIx6rHAUMaxSyPySwKsd/eckFlHza+0Q3AqvIGntI5xxq8uKqX+rKmFhjbMbug
 f2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AZDYNDSbSEPlDO5GL/RS+Paol6CiMRQi6AXB3v402Lk=;
 b=QgamiEZQFSpmX+fNBaXxctckEEuW/1gR5kgKGYpq4xeZk8EdAL5MajiuEu/2N5MK4U
 GlnqEPsV3a9eHjbi3QU0uvf8wDgsb76ZkfA8JWOqLIbBZtgS9YuGfzRyEpp58pvST28y
 fflDtkbeUqlJBZj4uXZuac6x08OglbgCIQSdwgJJIWgAnxvl+0GpCxmyN7H+fu+AK3Rf
 Ixx8Nn1ksKWaK8pxg5egGC2UU5h8iHYhKRLvNljNHKsEQYn8KaGt9RSHulGSXrSO8OY/
 QIKLfJTc33cTaSLC2HvX7xRqRTBCkcahHRk0Tjl5ujTW2xVoOHWpwzLjBFzJJEZKjpZb
 P6MQ==
X-Gm-Message-State: APjAAAW8WYy54yNQ26lERT4/leYr7t0JKG4DNeW8zPLT4tOlL1U0XYEp
 +QmReF+aMHT8ujWwcF12iVO8qgdsCQbKextuAEJWkC6QxO8=
X-Google-Smtp-Source: APXvYqzMnU8MAY8Qdai2I3Wy5ckKIHFpZZ8X5qRLha/RMsd8QyHqNxoRZnZcFeaA6w0hy9lrMdAJj7UMMOMKbgUgGnY=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr7256026otd.91.1580471077954; 
 Fri, 31 Jan 2020 03:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20200124162606.8787-1-peter.maydell@linaro.org>
In-Reply-To: <20200124162606.8787-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 11:44:27 +0000
Message-ID: <CAFEAcA9wHqKhpiCXG1AokYDJ0DHbzG0Qg6WogY1bqDdgt5iRag@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] qemu-img, qemu-trace-stap, virtfs-proxy-helper:
 convert to rST
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I know it's only a week, but could I ping for review on this?
(statements of the form "I do want to review but need more
time" also welcome.) Given the potential for conflicts with
other changes that touch the docs, plus that there's other
patchsets which depend on this one, it would be nice to put
it into the tree sooner rather than later.

Still in need of review: patches 1 (makefile magic),
5 (the qemu-img conversion itself), 7 (qemu-trace-stap).

thanks
-- PMM

On Fri, 24 Jan 2020 at 16:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset converts the following documentation to rST format:
>  * qemu-img
>  * qemu-trace-stap
>  * virtfs-proxy-helper
>
> (That means everything in step 3 in the plan:
> https://wiki.qemu.org/Features/Documentation#3:_Convert_things_which_are_mostly_standalone_manpages
> will be done except for qemu-cpu-models.texi. That
> should be a straightforward conversion but I haven't
> touched it yet because I know there's an on-list patch
> that updates the texi and wanted to avoid a conflict.)
>
> The patchset includes a new Sphinx extension which handles parsing
> the .hx files which provide documentation fragments for the qemu-img
> manual.
>
> Changes from v1 to v2:
>  * rebased on master, since the qemu-nbd conversion has now
>    gone in
>  * the patches at the end to convert qemu-trace-stap and
>    virtfs-proxy-helper are new
>  * new patch at the start of the series which fixes a
>    bug in our makefiles where we could try to invoke
>    Sphinx twice in parallel on the same doctree (which
>    causes it to crash, as well as being unnecessary work)
>  * fixed the import line for ExtensionError, so this
>    should now work with Sphinx 1.8
>
> I've assigned manpages to interop/ or system/ according
> to the structure set out in the wiki page above. We should
> have a discussion about whether some of these should go
> in a new tools/ manual or not (I'll start a separate
> thread for that), but it's easy enough to move them
> later if we need to.
>
> The general approach follows the outline in the email I
> sent the other day:
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg03786.html
>
> The new Sphinx extension implements the hxtool-doc::
> directive, which indicates where the assembled rST
> document fragments should be inserted into the manual.
> qemu-img-cmds.hx doesn't use the DEFHEADING or ARCHHEADING
> directives, but the extension implements them (tested
> with some local modifications to the .hx file to check
> that they do the right thing).
>
> As noted in the commit message for the qemu-img.texi conversion,
> I have not attempted to tackle any of the muddle in the
> current documentation structure or the repetition between
> the manual document, the fragments in the .hx file and
> the C code; this is a "simplest thing that works"
> like-for-like conversion.
>
> Another deliberate omission is that I have not attempted
> to get links between our various Sphinx manuals (system,
> interop, etc) working yet, as this is not totally trivial
> and the odd minor missed hyperlink doesn't seem to me
> to be a deal-breaker.
>
> Sorry about the size of the main 'convert qemu-img'
> patch, but it's unavoidable when converting a big
> document between formats.
>
> thanks
> -- PMM
>
> Peter Maydell (8):
>   Makefile: Ensure we don't run Sphinx in parallel for manpages
>   hxtool: Support SRST/ERST directives
>   docs/sphinx: Add new hxtool Sphinx extension
>   qemu-img-cmds.hx: Add rST documentation fragments
>   qemu-img: Convert invocation documentation to rST
>   qemu-img-cmds.hx: Remove texinfo document fragments
>   scripts/qemu-trace-stap: Convert documentation to rST
>   virtfs-proxy-helper: Convert documentation to rST
>
>  Makefile                             |  46 +-
>  MAINTAINERS                          |   3 +
>  docs/conf.py                         |   3 +-
>  docs/interop/conf.py                 |   9 +-
>  docs/interop/index.rst               |   3 +
>  docs/interop/qemu-img.rst            | 822 +++++++++++++++++++++++++++
>  docs/interop/qemu-trace-stap.rst     | 124 ++++
>  docs/interop/virtfs-proxy-helper.rst |  72 +++
>  docs/sphinx/hxtool.py                | 210 +++++++
>  fsdev/virtfs-proxy-helper.texi       |  63 --
>  qemu-doc.texi                        |  10 +-
>  qemu-img-cmds.hx                     |  99 ++--
>  qemu-img.texi                        | 795 --------------------------
>  rules.mak                            |  36 ++
>  scripts/hxtool                       |  33 +-
>  scripts/qemu-trace-stap.texi         | 140 -----
>  16 files changed, 1383 insertions(+), 1085 deletions(-)
>  create mode 100644 docs/interop/qemu-img.rst
>  create mode 100644 docs/interop/qemu-trace-stap.rst
>  create mode 100644 docs/interop/virtfs-proxy-helper.rst
>  create mode 100644 docs/sphinx/hxtool.py
>  delete mode 100644 fsdev/virtfs-proxy-helper.texi
>  delete mode 100644 qemu-img.texi
>  delete mode 100644 scripts/qemu-trace-stap.texi
>
> --
> 2.20.1

