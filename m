Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F79C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D061B206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7hSEvMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D061B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuew-00086l-So
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIuO2-0002r2-Hm
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:55:46 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:36110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIuNy-0008OI-Uj
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:55:46 -0400
Received: by mail-lj1-x22d.google.com with SMTP id r24so2124527ljm.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=QbxLOORekCrvx4ikhYGgSXES7hdsdpUTxWTOpXnLCVw=;
 b=K7hSEvMt9S2NeE+NnFxGU0lj1WTlDU65wT8bWUTY08wZoVZD5I2OBZiJ45H50aSn0s
 FxgBvJOqY5ZB/bT25q4yZngWSsftcgeX2M4Mno8+h0Fo0BRL+c6Xi+ThS/r3Lndw09mF
 PAuek4Zu84aDccz569h69J8rzvm8jsDJzgIXiYd5mW23cLKhRN6JRcVOEMqnpS5PMd6p
 DKXcam9LKlhAVyU4OQr8b7ZLL7DMR9bd9Gb1mE5v4ErsIWdQ41dT1R8JfIDHW8ui2TfG
 uGaqkdjbIYlPwVKb7JqOJb5wvq9zCHqrEPjO0WfjEKyM9ZChE9h8g1zKzJT0cDqguf4R
 7T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=QbxLOORekCrvx4ikhYGgSXES7hdsdpUTxWTOpXnLCVw=;
 b=onqbS5Ghrb4wAiafnA1HHoMXzXQ3EXe7qMCZwXUt9Gj9xX5P+ERnh7PZ9A8QdZwzKo
 HqNo2DIHIGweQrChoto7R5dL9tFpOU5Sb+Vp0Q33p8789YPFeXGlE2xPYk5uN9la0txw
 rDbDpbOKgeojC6PuNoxOSGHiZWBxLw8swneXye4XHLpb4Z6JlmqYZj74piiZ7AOj3Dhj
 02SQhd0rel5vS5e6U0Ikrjg07hEJSEehEZGpJkzEcALQO/884jc3NfjfEh1FCR1hVtNI
 xRjQ2tgOwlBe6+S93XdT8mIoi2J8fNbxBSIaZSY0Mxh2jYziz4psMFJ1VvpdMPwwNpYx
 ZsOA==
X-Gm-Message-State: AOAM530m7WpHw77FOjKjuKHFzW4wPXhhhZJw/rO6ckrWeZAkjv3VrcJX
 SYjWs7cfdZ2GbVsRCHMlN8VzZTzuARns61P/4KQ=
X-Google-Smtp-Source: ABdhPJz7MJKlgq2K2US0+e7RlwViCU7jumxCpoKpYSJU9DiOpUXGKRFOIyPT5A+9VQhlSmbI6it8VseHAWWdm0PHnSc=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr10976362ljj.368.1600350940521; 
 Thu, 17 Sep 2020 06:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <22951108-74c2-a98b-9316-b17c4d8188e0@redhat.com>
 <f90ee77c-11f8-e025-8f4f-38e78e0fe618@redhat.com>
 <20200917093442.GB1568038@redhat.com>
In-Reply-To: <20200917093442.GB1568038@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 17 Sep 2020 21:55:30 +0800
Message-ID: <CAE2XoE8KLoNmEL19KveohbSxLZgPMbNXdY6nfN_xUG5AQ2pAQQ@mail.gmail.com>
Subject: Re: Use patchew to push successfully applied series to GitLab
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000536af905af82bdca"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: patchew-devel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000536af905af82bdca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 5:36 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:
>
> On Thu, Sep 17, 2020 at 10:53:14AM +0200, Paolo Bonzini wrote:
> > On 17/09/20 10:16, Philippe Mathieu-Daud=C3=A9 wrote:
> > > patchew is currently pushing successfully applied series
> > > (using the cover Message-ID as tag) to GitHub.
> > > This is very handy (no need to apply patches manually):
> > > https://github.com/patchew-project/qemu/tags
> > >
> > > Can we push the same that to an equivalent GitLab account?
> > > We could then have a script replying to the series if the
> > > series fails CI. Doing so would save reviewer/tester time
> > > (I'd rather have a series not failing on our CI tests before
> > > starting to review/test it).
> >
> > Yes, we could.  Indeed we could also look at the pipeline result instea=
d
> > of needing Patchew's custom testers (using a webhook).  It would be a
> > bit on the heavy side for GitLab's resources; while right now they're
> > still providing unlimited CI time, in principle the "gold" tier provide=
s
> > "only" 833 hours and a full CI run takes more or less 1.
>
> Yep, this is a limitation of the patchew model where we have a central
> service testing each contributors patches, instead of having the CI jobs
> running in context of a user's fork and thus havin the CI usage cost
> ammoritized across all user's accounts.
>
> In a merge request workflow, this pretty much "just works" because the
> CI jobs alwas run in the user's fork before the merge request is opened,
> or when force-pushed.
>
> Assuming we're not adopting a merge request workflow in the near term,
> I wonder if we could do something clever to improve our mailing list
> workflow CI to get jobs running mostly in user's forks.
>
> A large number of contributors use "git-publish" to send patches. That
> is already capable of optionally pushing to a public git server for
> pull requests.
>
> What if we used git-publish to always push to gitlab when submitting
> patches, and have it include the gitlab ref in the cover letter.
>
> That would trigger CI jobs in the user's fork, and patchew would not
> have to run anything itself. It would merely monitor the user's fork
> and report back to the list if the job failed. Patchew would ony then
> have to run stuff in its own shared fork if the user didn't include
> a gitlab ref in their cover letter.  At least this works for x86
> Linux stuff. Doesn't work for any scenario needing custom runners.
>
> Still if our regular contributors went this way, the shared fork
> could have much lower build job load than we see today.
>
> > So it would work great but we would have to set up our own runners,
> > and/or have a cheaper pipeline for this gating CI.  Is that possible to
> > configure in Gitlab?
>
> The ideal situation is that we have one set of defined jobs that are
> used universally by the person merging to git master, by patchew, by
> any contributors before posting.
>
> In terms of traditional build jobs, we have a huge number defined in
> GitLab CI but it is only a partially overlapping set vs patchew,
> principally because the GitLab jobs are x86 only. For the non-x86 stuff
we would have to define
> jobs that target custom runners and then have custom runners registered
> against Patchew's account. If quota becomes a problem, we'd nede x86
custom
> runners too.
>
> The other useful part of patchew is the "checkpatch.pl" validation.
> We should really create a job in GitLab CI that covers this, as it
> is something that's useful for developers to get right before posting.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
https://www.instagram.com/dberrange :|
>
>
I agreed all, from these days experience on contributing to qemu, you
suggestion improve most aspect
I feel not good.

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000536af905af82bdca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Sep 17, 2020 at 5:36 PM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On Thu, Sep 17, 2020 at 10:53:14AM +0200, Paolo B=
onzini wrote:<br>&gt; &gt; On 17/09/20 10:16, Philippe Mathieu-Daud=C3=A9 w=
rote:<br>&gt; &gt; &gt; patchew is currently pushing successfully applied s=
eries<br>&gt; &gt; &gt; (using the cover Message-ID as tag) to GitHub.<br>&=
gt; &gt; &gt; This is very handy (no need to apply patches manually):<br>&g=
t; &gt; &gt; <a href=3D"https://github.com/patchew-project/qemu/tags">https=
://github.com/patchew-project/qemu/tags</a><br>&gt; &gt; &gt;<br>&gt; &gt; =
&gt; Can we push the same that to an equivalent GitLab account?<br>&gt; &gt=
; &gt; We could then have a script replying to the series if the<br>&gt; &g=
t; &gt; series fails CI. Doing so would save reviewer/tester time<br>&gt; &=
gt; &gt; (I&#39;d rather have a series not failing on our CI tests before<b=
r>&gt; &gt; &gt; starting to review/test it).<br>&gt; &gt;<br>&gt; &gt; Yes=
, we could.=C2=A0 Indeed we could also look at the pipeline result instead<=
br>&gt; &gt; of needing Patchew&#39;s custom testers (using a webhook).=C2=
=A0 It would be a<br>&gt; &gt; bit on the heavy side for GitLab&#39;s resou=
rces; while right now they&#39;re<br>&gt; &gt; still providing unlimited CI=
 time, in principle the &quot;gold&quot; tier provides<br>&gt; &gt; &quot;o=
nly&quot; 833 hours and a full CI run takes more or less 1.<br>&gt;<br>&gt;=
 Yep, this is a limitation of the patchew model where we have a central<br>=
&gt; service testing each contributors patches, instead of having the CI jo=
bs<br>&gt; running in context of a user&#39;s fork and thus havin the CI us=
age cost<br>&gt; ammoritized across all user&#39;s accounts.<br>&gt;<br>&gt=
; In a merge request workflow, this pretty much &quot;just works&quot; beca=
use the<br>&gt; CI jobs alwas run in the user&#39;s fork before the merge r=
equest is opened,<br>&gt; or when force-pushed.<br>&gt;<br>&gt; Assuming we=
&#39;re not adopting a merge request workflow in the near term,<br>&gt; I w=
onder if we could do something clever to improve our mailing list<br>&gt; w=
orkflow CI to get jobs running mostly in user&#39;s forks.<br>&gt;<br>&gt; =
A large number of contributors use &quot;git-publish&quot; to send patches.=
 That<br>&gt; is already capable of optionally pushing to a public git serv=
er for<br>&gt; pull requests.<br>&gt;<br>&gt; What if we used git-publish t=
o always push to gitlab when submitting<br>&gt; patches, and have it includ=
e the gitlab ref in the cover letter.<br>&gt;<br>&gt; That would trigger CI=
 jobs in the user&#39;s fork, and patchew would not<br>&gt; have to run any=
thing itself. It would merely monitor the user&#39;s fork<br>&gt; and repor=
t back to the list if the job failed. Patchew would ony then<br>&gt; have t=
o run stuff in its own shared fork if the user didn&#39;t include<br>&gt; a=
 gitlab ref in their cover letter.=C2=A0 At least this works for x86<br>&gt=
; Linux stuff. Doesn&#39;t work for any scenario needing custom runners.<br=
>&gt;<br>&gt; Still if our regular contributors went this way, the shared f=
ork<br>&gt; could have much lower build job load than we see today.<br>&gt;=
<br>&gt; &gt; So it would work great but we would have to set up our own ru=
nners,<br>&gt; &gt; and/or have a cheaper pipeline for this gating CI.=C2=
=A0 Is that possible to<br>&gt; &gt; configure in Gitlab?<br>&gt;<br>&gt; T=
he ideal situation is that we have one set of defined jobs that are<br>&gt;=
 used universally by the person merging to git master, by patchew, by<br>&g=
t; any contributors before posting.<br>&gt;<br>&gt; In terms of traditional=
 build jobs, we have a huge number defined in<br>&gt; GitLab CI but it is o=
nly a partially overlapping set vs patchew,<br>&gt; principally because the=
 GitLab jobs are x86 only. For the non-x86 stuff we would have to define<br=
>&gt; jobs that target custom runners and then have custom runners register=
ed<br>&gt; against Patchew&#39;s account. If quota becomes a problem, we&#3=
9;d nede x86 custom<br>&gt; runners too.<br>&gt;<br>&gt; The other useful p=
art of patchew is the &quot;<a href=3D"http://checkpatch.pl">checkpatch.pl<=
/a>&quot; validation.<br>&gt; We should really create a job in GitLab CI th=
at covers this, as it<br>&gt; is something that&#39;s useful for developers=
 to get right before posting.<br>&gt;<br>&gt; Regards,<br>&gt; Daniel<br>&g=
t; --<br>&gt; |: <a href=3D"https://berrange.com">https://berrange.com</a> =
=C2=A0 =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<a href=3D"https://www.flickr.com/phot=
os/dberrange">https://www.flickr.com/photos/dberrange</a> :|<br>&gt; |: <a =
href=3D"https://libvirt.org">https://libvirt.org</a> =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 -o- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://fsto=
p138.berrange.com">https://fstop138.berrange.com</a> :|<br>&gt; |: <a href=
=3D"https://entangle-photo.org">https://entangle-photo.org</a> =C2=A0 =C2=
=A0-o- =C2=A0 =C2=A0<a href=3D"https://www.instagram.com/dberrange">https:/=
/www.instagram.com/dberrange</a> :|<br>&gt;<br>&gt;<br>I agreed all, from t=
hese days experience on contributing to qemu, you suggestion improve most a=
spect<div>I feel not good.<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000536af905af82bdca--

