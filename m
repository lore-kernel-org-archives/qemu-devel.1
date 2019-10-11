Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD20BC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9185D2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9185D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIt8Y-0001ry-Ed
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 07:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1iIt5H-0007IM-T3
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1iIt5F-0006Va-R6
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1iIt5E-0006SV-Vf
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:27:45 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3052C059B80
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 11:27:42 +0000 (UTC)
Received: by mail-ot1-f72.google.com with SMTP id i8so4624740otc.19
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 04:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i+pru+W/cL9NaXsEZaHTyJYge4kHKehavYL9OBP5BVA=;
 b=DEkimVJL4H8PhxgmvOm4zpXS335sdh9TEvLJwUKQw7dJksIQfrhvg/k87rAOYy4jjF
 yRCGH35ENjaCCqEZl1OYqMGnUwLqa4msAGoJkyccLdE5QZtMSJvVwz5RexfsuezUUry5
 FosDojt8leM11E5Hn6nePXGUpIvUo2RSCXqF3W6WuYpi9JZ18uw1h5Y5sPP50xlvoLwG
 D3vD9RWIYR9hN5v+KTD4UBsiDlPtP/GMWq8yC9gEnNuutt7iRFgOI7HqaS90XExLvQYq
 C8X+5CzHbmAd6+BKdjw5nhXPjqpMIoypy/rWMkLaY2s1bhCHXsi3/FzOjc8+3fpvOBfM
 R0Cg==
X-Gm-Message-State: APjAAAWylfoV6lUGKU/gIyi7ScVfYYnliShLYiESDJG0oCkEr8G/nFq/
 kEVrHEHn0hzurmVTTBnEb72YTgcS/VenKyax4Bm+RaJU3fa7LYBIhkcXu1jjeOlGf2op5RhxDAt
 Q/vj0XOezIraNKCpwR8jd19uc1hxB0Uw=
X-Received: by 2002:a9d:3675:: with SMTP id w108mr9413199otb.81.1570793262428; 
 Fri, 11 Oct 2019 04:27:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQHTZIBTgumgY8dP4Xk1kkQ7jfHWGFgVnTzXyEsIUjt4/Juz4yMgYh/VGf3x3tC+fcJEWd9sbdJo4bko2Y4wY=
X-Received: by 2002:a9d:3675:: with SMTP id w108mr9413178otb.81.1570793262147; 
 Fri, 11 Oct 2019 04:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191009194740.8079-1-crosa@redhat.com>
 <20191009194740.8079-2-crosa@redhat.com>
 <20191011093610.GD5158@localhost.localdomain>
In-Reply-To: <20191011093610.GD5158@localhost.localdomain>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 11 Oct 2019 14:27:25 +0300
Message-ID: <CAMRbyyu=NdwhKFwb=JzMyHfbnP4XzzpaHTCd7ucT7tLEk9HdFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] qemu-iotests: remove bash shebang from library
 files
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006809840594a0cedd"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-block <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006809840594a0cedd
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 11, 2019, 12:36 Kevin Wolf <kwolf@redhat.com> wrote:

> Am 09.10.2019 um 21:47 hat Cleber Rosa geschrieben:
> > Due to not being able to find a reason to have shebangs on files that
> > are not executable.
> >
> > While at it, add a mode hint to emacs, which would be clueless or
> > plain wrong about these containing shell code.
>
> vim still doesn't like the change.
>
> Of course, we could also add another line for vim and for every other
> editor in use, but actually, I think I'd prefer just dropping this
> patch. It even makes each file a few bytes larger instead of saving
> something. Shebang lines are a shorter and more portable format
> indicator than the alternatives.
>
> So I think in the end we have found a good reason to keep them. :-)
>

What about .sh suffix? Should be most portable way.

>

--0000000000006809840594a0cedd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Oct 11, 2019, 12:36 Kevin Wolf &lt;<a href=3D"=
mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Am 09.10.2019 um 21:47 hat Cleber Rosa geschrieben:<b=
r>
&gt; Due to not being able to find a reason to have shebangs on files that<=
br>
&gt; are not executable.<br>
&gt; <br>
&gt; While at it, add a mode hint to emacs, which would be clueless or<br>
&gt; plain wrong about these containing shell code.<br>
<br>
vim still doesn&#39;t like the change.<br>
<br>
Of course, we could also add another line for vim and for every other<br>
editor in use, but actually, I think I&#39;d prefer just dropping this<br>
patch. It even makes each file a few bytes larger instead of saving<br>
something. Shebang lines are a shorter and more portable format<br>
indicator than the alternatives.<br>
<br>
So I think in the end we have found a good reason to keep them. :-)<br></bl=
ockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">What abo=
ut .sh suffix? Should be most portable way.</div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div>=
</div>

--0000000000006809840594a0cedd--

