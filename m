Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CCEC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263EC2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPGbkiZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263EC2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMuQ-0006ev-Ew
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iwMtk-0005qo-Nd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iwMtj-0000Vz-Fd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:11:04 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iwMtj-0000Tt-8P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:11:03 -0500
Received: by mail-oi1-x243.google.com with SMTP id l9so9624268oii.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 01:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jBQ+9/7DvEcrRuOZK4t9PNx3l4hqXPfp+YoNldH1yLM=;
 b=FPGbkiZC220whO1f9y6+SIw+KTGaNKZyn7VWP2vYF4Pf44OCNleWFSBAl5rRL4qXU9
 Jz0OBtp/quvszYIf2AVPgiqyHhfDyCZuPy6B/h2PA51iKfGc4mhM3TCTeDDdLgcann+B
 ThEVcAnSUx7APvDNsXRAvH07W38suTbl7jS7WxZ56VM78rTZURhhmn3uIxX0cZXubtEH
 sl6csmnX9t6b1Q1MP5RoNhD+SzMKf93DlEbY5K/RWZQdjoXppwxDMFGaSM4VuQcVIv3/
 +Yvt27jAYvTDBGY/yZPs6Uh/SWd5Ry8OI3JOTVVGlUBKFToVTGTvl+1nAi7+80KE+TZ+
 HLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jBQ+9/7DvEcrRuOZK4t9PNx3l4hqXPfp+YoNldH1yLM=;
 b=Ri5jVtAxMTI627LJnH1rTG46F0izIc4qEYsoLOcPunKP0odk4iQ7umkspIKb+WYT6o
 WyPemw4fMHcJ3rKZhMP/n7ZHCnh6W6cfZoU7jzpCBG+xmVumFUkJuubfMvigj37/3DaH
 D4ibymlI6fYP7JYgfwxv/m3UYTtcnvqgIArs2DeI+ngrakpy/SfXS5GKydXAu83v5i9n
 qgQe3wUMkZeSYo4jN93i0ugHnYJ3uMnSyDFZepgv+MDpv5o+Zkl2Zv32Hcdd4I6aqf6L
 5O844cgdqHaI7jACo66kFJmved2ffX+zdDMxgDpCPWx5T9ONJSsOeVGhFwOJ+4Jy3xN+
 z+Jw==
X-Gm-Message-State: APjAAAUQL+Wi+hQdmexNooucSMt/A1LiktzFHX/JApB57Q3DYoeS283E
 xizp5DEiSupL14QKLmVIH+DHGxrgOXVqjKHH77yTOzzN1HY=
X-Google-Smtp-Source: APXvYqwC18mGIyTPBU8BJuZnVroKjjINuan5vcDCjbu45sBAGCNFSOY2dARp+rzBfJKiCUUI+83WJUnW75UmLiFsiVc=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2191298oif.163.1580202662099; 
 Tue, 28 Jan 2020 01:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
 <20200124103458.1525982-3-david.edmondson@oracle.com>
 <8412b6bf-3819-9042-4ade-d42f36fd3a97@redhat.com>
 <cunr1zk9gio.fsf@gag-halfrunt.hh.sledj.net>
In-Reply-To: <cunr1zk9gio.fsf@gag-halfrunt.hh.sledj.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2020 09:10:51 +0000
Message-ID: <CAFEAcA9F5zMjujDwtct5sDFXx+hCObFzyBxpM6JkK1JzuRvRsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc: Use @code rather than @var for options
To: David Edmondson <dme@dme.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 at 07:39, David Edmondson <dme@dme.org> wrote:
>
> Eric Blake <eblake@redhat.com> writes:
>
> > On 1/24/20 4:34 AM, David Edmondson wrote:
> >> Texinfo defines @var for metasyntactic variables and such terms are
> >> shown in upper-case or italics in the output of makeinfo. When
> >> considering an option to a command, such as "-n", upper-casing is
> >> undesirable as it may confuse the reader or be in conflict with the
> >> equivalent upper-case option.
> >>
> >> Replace the use of @var for options with @code to avoid this.
> >>
> >> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> >> ---
> >>   qemu-img.texi | 16 ++++++++--------
> >>   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > Is this patch still needed given Peter's recent push to move to rST
> > documentation?
>
> No, it would be obviated by those changes.

Yeah; in particular the rST formatting corrects this minor
inconsistency. (I noticed it because my emacs find-and-replace
operations which turn @var{foo} into *FOO* were incorrectly
turning the @var{-s} into *-S*, which they wouldn't have done
if it were @code{-s}...)

thanks
-- PMM

