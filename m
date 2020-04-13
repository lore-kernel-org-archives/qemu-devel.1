Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B01C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 12:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A5020692
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 12:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2P1UOWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A5020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNyOv-0000b4-ML
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 08:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jNyOH-0008PJ-Dv
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jNyOF-0001eX-1e
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:40:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jNyOE-0001dq-Qc
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586781638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWAUxoc6iBpGeLuCgFc6dp4XPtdd6dAGm+khFsvTeyk=;
 b=P2P1UOWfEhhNoslgET5uYspgWhjJYocwpX2FYbajrVf8OP0li+fdD6CHuR8fKaXd5AIDrR
 36/m9ddLAGs497GgBtjkmWzlboopelUMaU3QXOpIF5FIgBl4Adpzlxw1lHBrSQiEMsJcZX
 QSan+BKJ+0JeMcgsAT5EJiSrQhIznkk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-nzQepeUGMUCcJLJf2fAPZQ-1; Mon, 13 Apr 2020 08:40:33 -0400
X-MC-Unique: nzQepeUGMUCcJLJf2fAPZQ-1
Received: by mail-ed1-f71.google.com with SMTP id eb6so8935554edb.12
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 05:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eEaMiW1waXKRvjOue1Sr5/onkauuUebE/R8v/tVK1PE=;
 b=bgP1Bpgj9H7CGQDp8g46sA8TdfQz0qD4aFKMX1OdbTTixq3lR4i6bKg5+ItqQFmyzd
 ONKx6oVccSdDwd03WcMp3Uk3myhEztnPbrXnrLu4dW3WwsQOkN/RMfpN8Pf987ygUMBC
 6+S9o4bzJBZbAV3aussmoBBW3IC3HWDbEwEG4euA1lQFctLqyNX72pQEmd7amzYDGM7P
 2qxK2E+5jx4mpYB9qX+4Ohnxc140+apgEH5l/LrnIchr6bLyDFrwMRwZGj+n3RRXnepW
 4gOclOClt4x6f+aOb81nHbkBTPVqsbn4HSM4OYC/paCOl+6qMum0yWU94hU9jpw7cug0
 Zeng==
X-Gm-Message-State: AGi0PuYWmL62UfBkgmaDeUWJ/BcxL+Yg1sOuatDfTEbDP6IUp6JOBPl/
 9CPNASbDrDg8Vxjoy3QNYerx/L0Ge3csI+czig1fJzswC/uhEV3W9ZtgUSguHgL+QB7CPpRViEE
 f/GqQsxSu17Du59lpO/Ge7HRt4qHJn6w=
X-Received: by 2002:aa7:ce86:: with SMTP id y6mr10919edv.161.1586781632206;
 Mon, 13 Apr 2020 05:40:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypIwMV25PajHzZspqGH98XRxqHFDjYSzC7tPgIX8dNbywmm1m08fTzA14YlGSLbeSnzi4PI1UNwF2RY9z/TSykk=
X-Received: by 2002:aa7:ce86:: with SMTP id y6mr10903edv.161.1586781631931;
 Mon, 13 Apr 2020 05:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <CAFEAcA_PJPm+CciSEhXt+JMV+P55EqHYd4S8ehBC6HYqzJ_ZBQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_PJPm+CciSEhXt+JMV+P55EqHYd4S8ehBC6HYqzJ_ZBQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2020 14:40:19 +0200
Message-ID: <CABgObfZbY_SBUM=vTR31bokkJ9s9nmQVs18X7xt0PTvZrSTkWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Automation of Coverity Scan uploads (via Docker)
To: Peter Maydell <peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000082043305a32b6329"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000082043305a32b6329
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, go ahead. I would like to add a docker-coverity Makefile target but I
can do that later.

Il lun 13 apr 2020, 14:13 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> What's your view on this series, Paolo? Personally I'd like
> to put it into master, because at least then we have something
> that we can do Coverity runs on, whereas AIUI at the moment
> we don't. But I'd rather not put it in after rc3, which is
> tomorrow...
>
> thanks
> -- PMM
>
> On Thu, 19 Mar 2020 at 19:33, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > v1 of this series was over a year ago:
> > https://patchew.org/QEMU/20181113184641.4492-1-peter.maydell@linaro.org=
/
> >
> > I dusted it off and fixed some stuff because Paolo reports that the
> > machine he was previously using for uploads can't run the Coverity
> > tools any more.
> >
> > The first four patches are fixes for problems that cause the Coverity
> > tool not to be able to scan everything.  The first one in particular
> > meant that every compilation unit failed, which would block uploads.
> > The other 3 would reduce the scan coverage but weren't fatal.  (The
> > only remaining warnings in the log are where Coverity complains about
> > asm intrinsics system headers.)
> >
> > With these scripts you can do an upload with
> > COVERITY_TOKEN=3Dnnnnnnnnn ./scripts/coverity-scan/run-coverity-scan
> --docker
> > (where nnnnnnnn is the project's secret token which admins can
> > get from the Coverity web UI).
> >
> > I did in fact do an upload to test it, so the currently visible
> > results on the website are the result of a scan on ce73691e258 plus
> > this series.
> >
> > The new upload has +112 defects, which is quite a lot, but I don't
> > think it's so many that it is "defects we rejected as false positives
> > coming back again"; my guess is a combination of the fixes in the
> > first 4 patches increasing coverage plus we haven't run a test in a
> > while plus maybe the script has some more config options enabled that
> > Paolo's box did not.  (In the web UI defects that were dismissed as
> > FPs seem still to be considered present-but-dismissed, so I think
> > that's OK.)
> >
> > Not much has changed since v1; I didn't get very much feedback
> > the first time around[*]. Docker still seems to do the "download
> > the Coverity tools" part more often than I expect. On the other
> > hand "actually automated with a script in the tree" beats "not
> > automated and currently broken" so maybe this patchset as it
> > stands is good enough, given that basically 1 or 2 people ever
> > will be running the script ?
> >
> > [*] Eric will note that yes, the script still uses set -e.
> >
> > (Like v1 this doesn't try to tie it into Travis, but we could
> > in theory do that some day, or have some other automated once
> > a week run of the script.)
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (6):
> >   osdep.h: Drop no-longer-needed Coverity workarounds
> >   thread.h: Fix Coverity version of qemu_cond_timedwait()
> >   thread.h: Remove trailing semicolons from Coverity qemu_mutex_lock()
> >     etc
> >   linux-user/flatload.c: Use "" for include of QEMU header target_flat.=
h
> >   scripts/run-coverity-scan: Script to run Coverity Scan build
> >   scripts/coverity-scan: Add Docker support
> >
> >  include/qemu/osdep.h                       |  14 -
> >  include/qemu/thread.h                      |  12 +-
> >  linux-user/flatload.c                      |   2 +-
> >  MAINTAINERS                                |   5 +
> >  scripts/coverity-scan/coverity-scan.docker | 131 +++++++
> >  scripts/coverity-scan/run-coverity-scan    | 401 +++++++++++++++++++++
> >  6 files changed, 544 insertions(+), 21 deletions(-)
> >  create mode 100644 scripts/coverity-scan/coverity-scan.docker
> >  create mode 100755 scripts/coverity-scan/run-coverity-scan
> >
> > --
> > 2.20.1
>
>

--00000000000082043305a32b6329
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, go ahead. I would like to add a docker-coverity Make=
file target but I can do that later.</div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">Il lun 13 apr 2020, 14:13 Peter Maydell=
 &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</=
a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">What&#39;s your =
view on this series, Paolo? Personally I&#39;d like<br>
to put it into master, because at least then we have something<br>
that we can do Coverity runs on, whereas AIUI at the moment<br>
we don&#39;t. But I&#39;d rather not put it in after rc3, which is<br>
tomorrow...<br>
<br>
thanks<br>
-- PMM<br>
<br>
On Thu, 19 Mar 2020 at 19:33, Peter Maydell &lt;<a href=3D"mailto:peter.may=
dell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.=
org</a>&gt; wrote:<br>
&gt;<br>
&gt; v1 of this series was over a year ago:<br>
&gt; <a href=3D"https://patchew.org/QEMU/20181113184641.4492-1-peter.maydel=
l@linaro.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patc=
hew.org/QEMU/20181113184641.4492-1-peter.maydell@linaro.org/</a><br>
&gt;<br>
&gt; I dusted it off and fixed some stuff because Paolo reports that the<br=
>
&gt; machine he was previously using for uploads can&#39;t run the Coverity=
<br>
&gt; tools any more.<br>
&gt;<br>
&gt; The first four patches are fixes for problems that cause the Coverity<=
br>
&gt; tool not to be able to scan everything.=C2=A0 The first one in particu=
lar<br>
&gt; meant that every compilation unit failed, which would block uploads.<b=
r>
&gt; The other 3 would reduce the scan coverage but weren&#39;t fatal.=C2=
=A0 (The<br>
&gt; only remaining warnings in the log are where Coverity complains about<=
br>
&gt; asm intrinsics system headers.)<br>
&gt;<br>
&gt; With these scripts you can do an upload with<br>
&gt; COVERITY_TOKEN=3Dnnnnnnnnn ./scripts/coverity-scan/run-coverity-scan -=
-docker<br>
&gt; (where nnnnnnnn is the project&#39;s secret token which admins can<br>
&gt; get from the Coverity web UI).<br>
&gt;<br>
&gt; I did in fact do an upload to test it, so the currently visible<br>
&gt; results on the website are the result of a scan on ce73691e258 plus<br=
>
&gt; this series.<br>
&gt;<br>
&gt; The new upload has +112 defects, which is quite a lot, but I don&#39;t=
<br>
&gt; think it&#39;s so many that it is &quot;defects we rejected as false p=
ositives<br>
&gt; coming back again&quot;; my guess is a combination of the fixes in the=
<br>
&gt; first 4 patches increasing coverage plus we haven&#39;t run a test in =
a<br>
&gt; while plus maybe the script has some more config options enabled that<=
br>
&gt; Paolo&#39;s box did not.=C2=A0 (In the web UI defects that were dismis=
sed as<br>
&gt; FPs seem still to be considered present-but-dismissed, so I think<br>
&gt; that&#39;s OK.)<br>
&gt;<br>
&gt; Not much has changed since v1; I didn&#39;t get very much feedback<br>
&gt; the first time around[*]. Docker still seems to do the &quot;download<=
br>
&gt; the Coverity tools&quot; part more often than I expect. On the other<b=
r>
&gt; hand &quot;actually automated with a script in the tree&quot; beats &q=
uot;not<br>
&gt; automated and currently broken&quot; so maybe this patchset as it<br>
&gt; stands is good enough, given that basically 1 or 2 people ever<br>
&gt; will be running the script ?<br>
&gt;<br>
&gt; [*] Eric will note that yes, the script still uses set -e.<br>
&gt;<br>
&gt; (Like v1 this doesn&#39;t try to tie it into Travis, but we could<br>
&gt; in theory do that some day, or have some other automated once<br>
&gt; a week run of the script.)<br>
&gt;<br>
&gt; thanks<br>
&gt; -- PMM<br>
&gt;<br>
&gt; Peter Maydell (6):<br>
&gt;=C2=A0 =C2=A0osdep.h: Drop no-longer-needed Coverity workarounds<br>
&gt;=C2=A0 =C2=A0thread.h: Fix Coverity version of qemu_cond_timedwait()<br=
>
&gt;=C2=A0 =C2=A0thread.h: Remove trailing semicolons from Coverity qemu_mu=
tex_lock()<br>
&gt;=C2=A0 =C2=A0 =C2=A0etc<br>
&gt;=C2=A0 =C2=A0linux-user/flatload.c: Use &quot;&quot; for include of QEM=
U header target_flat.h<br>
&gt;=C2=A0 =C2=A0scripts/run-coverity-scan: Script to run Coverity Scan bui=
ld<br>
&gt;=C2=A0 =C2=A0scripts/coverity-scan: Add Docker support<br>
&gt;<br>
&gt;=C2=A0 include/qemu/osdep.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 -<br>
&gt;=C2=A0 include/qemu/thread.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +-<br>
&gt;=C2=A0 linux-user/flatload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05=
 +<br>
&gt;=C2=A0 scripts/coverity-scan/coverity-scan.docker | 131 +++++++<br>
&gt;=C2=A0 scripts/coverity-scan/run-coverity-scan=C2=A0 =C2=A0 | 401 +++++=
++++++++++++++++<br>
&gt;=C2=A0 6 files changed, 544 insertions(+), 21 deletions(-)<br>
&gt;=C2=A0 create mode 100644 scripts/coverity-scan/coverity-scan.docker<br=
>
&gt;=C2=A0 create mode 100755 scripts/coverity-scan/run-coverity-scan<br>
&gt;<br>
&gt; --<br>
&gt; 2.20.1<br>
<br>
</blockquote></div>

--00000000000082043305a32b6329--


