Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDDAC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F87206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F87206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHmDi-0006QZ-UK
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lwhsu.freebsd@gmail.com>) id 1iHmB9-0005Gz-3Q
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lwhsu.freebsd@gmail.com>) id 1iHmB7-000376-Ud
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:53:15 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1iHmB7-00036U-Qx; Tue, 08 Oct 2019 05:53:13 -0400
Received: by mail-yb1-f195.google.com with SMTP id z125so5696991ybc.4;
 Tue, 08 Oct 2019 02:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oKZ5G8k2+4BXF3YFRN0/YHPCbKR/VVCOJqKEeY/vIYw=;
 b=OelywSjUC8GdnzjtgZq2d2n5VTYmnKbgRqR8WMqDDeOxZO+OZTN7/NNjlrKemYG2fI
 vdBuDR2UM7g9NDCBDp7rwz5qgQ9U04K9ZclTrYSDKTiiVOBmsp4fvHAvL79ZDLf3OfDo
 x7YNEJm/Sfhd3Dzi+vPgff0c3s/MKgaPq+tnIBIdKGTme4cZxG/cdJfcWPHNYPkzfWHY
 BF/DHKHkdJQ/uftRGLUZynw9YxkxTSLXd1/m10qJef5taSpBX+6t+f8j2xM8MaFUspiz
 gsZFQesSWmmn2TXYk1/gKXwTJ9yAT0rEjyVS0snadhGeM8A2W7MffMi2S7+TIkqJZeAQ
 ygww==
X-Gm-Message-State: APjAAAUTwuufubdafISXe6mUsfqv8L248BYxw7nMREripCS/Hy1yGehB
 l6wfqfJXaffMb90Lcs9UWITEKVXHwtv8SF1MI5o=
X-Google-Smtp-Source: APXvYqxhkGcCc79iww0xpcFlUgfDGE6d7fLlHjcWr8GQpg1Vr3o5jwh0TCiWhpMzMpEdcMxXRmLUHN3eAo6LGfZZCEc=
X-Received: by 2002:a25:3604:: with SMTP id d4mr13205240yba.127.1570528392671; 
 Tue, 08 Oct 2019 02:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191008084931.12753-1-thuth@redhat.com>
 <CAGxU2F61+TjSy_GJ_2673--VLstVyJjNoqqPdZw+ej22xbzk=Q@mail.gmail.com>
In-Reply-To: <CAGxU2F61+TjSy_GJ_2673--VLstVyJjNoqqPdZw+ej22xbzk=Q@mail.gmail.com>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Tue, 8 Oct 2019 17:52:59 +0800
Message-ID: <CAKBkRUwiNV7qUhcDYak9s65bbb5PzzZWp3x6-pKCn5H0cJFrFg@mail.gmail.com>
Subject: Re: [PATCH] Test netmap on FreeBSD
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.195
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
Cc: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Vincenzo Maffione <vmaffione@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 5:49 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Thomas,
>
> On Tue, Oct 8, 2019 at 10:49 AM Thomas Huth <thuth@redhat.com> wrote:
> >
> > FreeBSD offers a package for "netmap", thus let's install it in our
> > FreeBSD tests to get some compile test coverage for net/netmap.c, too.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  .cirrus.yml      | 2 +-
> >  tests/vm/freebsd | 3 +++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/.cirrus.yml b/.cirrus.yml
> > index 8326a3a4b1..44fea2c29e 100644
> > --- a/.cirrus.yml
> > +++ b/.cirrus.yml
> > @@ -8,7 +8,7 @@ freebsd_12_task:
> >      memory: 8G
> >    install_script: pkg install -y
> >      bash bison curl cyrus-sasl git glib gmake gnutls gsed
> > -    nettle perl5 pixman pkgconf png usbredir
> > +    netmap nettle perl5 pixman pkgconf png usbredir
>
> >    script:
> >      - mkdir build
> >      - cd build
> > diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> > index 2a19461a90..45821702bd 100755
> > --- a/tests/vm/freebsd
> > +++ b/tests/vm/freebsd
> > @@ -54,6 +54,9 @@ class FreeBSDVM(basevm.BaseVM):
> >          # libs: opengl
> >          "libepoxy",
> >          "mesa-libs",
> > +
> > +        # libs: network
> > +        "netmap",
>
> IIRC netmap is shipped with the FreeBSD kernel, so we shouldn't need to
> install it.
>
> I tried to understand what is the 'netmap' pkg and I found the following
> in my FreeBSD 12 VM:
>
>     # pkg search netmap
>     netmap-0.1.3_1         Make a graphical representation of the surrounding network
>
> I don't think we are installing the right 'netmap' (I know, it is a bit
> confusing :) )
>
> I'll tried "make vm-build-freebsd" without this patch and I noticed
> "netmap support    yes" in the configure output. So I think we're
> already compiling the netmap backend in the 'vm-buil-freebsd' target and
> maybe also in cirrus.
>
> Maybe Ed and Li-Wen can confirm (or not).

Yes netmap(4) is a built-in and default feature on FreeBSD. netmap
package from ports is not related to it.

BTW, I haven't tried qemu's netmap feature on FreeBSD.  Is there
anything we can test this more?

Best,
Li-Wen

