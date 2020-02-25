Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD511C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CDE20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FboQrRap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CDE20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6gXm-0007kG-Mq
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 15:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6gWt-0007Cn-BW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6gWq-0008R4-U8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:10:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6gWq-0008NX-JQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582661403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+sf8ZRXYL7ixA6w9mKIBZou0y4rvjL7wIFJAF22AxsI=;
 b=FboQrRap1VzkoVks5hSnBWweGT+A3J4d+vAhVybVBnpgPDX4X8X2j1Ppb8ajZW8zxhbJLW
 h86BQwTiutgltv1KmyX4UnGx68+oISkQmJ0H8LZCqBgs704vTHPt+GJFaw/aEHHTrwAa1G
 iLZMKIXaBC7zt1yKFpy9LsypQlVXgFc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-w5omJ4-GPCOqaJtVbwiR7w-1; Tue, 25 Feb 2020 15:10:00 -0500
X-MC-Unique: w5omJ4-GPCOqaJtVbwiR7w-1
Received: by mail-ed1-f69.google.com with SMTP id l4so326307edn.20
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 12:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6R4T3A3mwFEFCOdcQL5zhJd9fxQ/wXz8yASzD0Ueq5Q=;
 b=VqGgZS+MhZ31ZOWvcd3kq4iPik1l+oDZyWIMALmkN5aTNT6WQ8nxYdTEiqJ7H/0CLm
 Kw+RmU+rzMMzhrZ8XoKZxyHMBZOOn1Fs8cwf9sMGOSQgc67D30KK1pLixi/2dQPdTu7X
 4uw90UEaMuNWa24A/ovIDVOGJ91mkTUKUDDN7PkFLZlYld1VwP5ERGBIDxm55QAc1gYB
 pJPjGGvWjm7Aa1nazpCs1t2C5eiR5RsWzIgttqXBJpICLa0KuwHjFWkcHBeDBuj9gN/W
 yQqti+qWxZfkmEQe5Q4ndS7WCnfmMfZqHmQA5A5dzk4p9oygIlvKQUuwvlXSrwW0RZQG
 eG2Q==
X-Gm-Message-State: APjAAAWg/+UrONDXcpeVI7IlNV31LOxR0x5Mud+rnPfLl5pxLsevdwAr
 E4bREYWgMGvZN9VJh6JFxXYsOFk1DxJm3Epp5+0ArRClX8AMIQI2v5hsMkXr50g3mXOBl2akwQ9
 aXNXGPhy5us/pXceAio6sGBmr0Ym09Y0=
X-Received: by 2002:aa7:ca10:: with SMTP id y16mr667726eds.217.1582661399695; 
 Tue, 25 Feb 2020 12:09:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTO1wPKsmmrxVR+ZoIpabDwBdgty+0G9lYR0UkwKon7UtdRXhIH+AFlf4Gn7QEzbkXK3isRiTZAgICu5TIqzo=
X-Received: by 2002:aa7:ca10:: with SMTP id y16mr667710eds.217.1582661399392; 
 Tue, 25 Feb 2020 12:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
 <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
 <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
 <9f64719b-184c-cd61-1260-f13428ea7369@redhat.com>
 <CAFEAcA9F6jQ7bAp3DuJ+hA48iwi-NtviBxJKQxF-PUD41FyDzg@mail.gmail.com>
 <CABgObfaFyGE7sFsQ62hoLBJLo+DpO8ftznahUM1EHCzPcOEKuw@mail.gmail.com>
 <CAFEAcA-nzSwxHqhuL+=ByM3uYCngiY4z0NJkMdPdTTyvh35M7g@mail.gmail.com>
In-Reply-To: <CAFEAcA-nzSwxHqhuL+=ByM3uYCngiY4z0NJkMdPdTTyvh35M7g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Feb 2020 21:09:46 +0100
Message-ID: <CABgObfY0QY0g42QGB6K_PzKUX8OPhiSe-KXwU+rB9ksK3FzPog@mail.gmail.com>
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Peter Maydell <peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000082ceec059f6c128f"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000082ceec059f6c128f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 25 feb 2020, 20:50 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Tue, 25 Feb 2020 at 19:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
> I feel like we're working a bit at cross purposes here so maybe
> we'd benefit from just nailing down who's going to do what and
> in which order?
>

I am not going to do much more than what I posted today, basically only the
automated conversion.

>
> My current thought on ordering is something like:
>  * commit this
>  * commit Kashyap's series
>  * commit (an adjusted version of) your split-out-the-texi series
>  * (automated) conversion of more texi -- all in one series I guess ?
>  * ???
>  * profit
>
> but I'm not very strongly attached to that.
>

The main issue with this series and Kashyap's is that if we don't manage to
get everything done in 5.0 we have a mutilated qemu-doc. Then either we
keep it mutilated or we scramble to undo the work. So I would agree to
commit the series in this order, but without the removal of the .texi files=
.

> Perhaps we could have the files in both .texi and (automatically
> > converted) .rst versions at the same time in the tree for a short
> > period. If that's okay for you, I can post tomorrow a series to do that=
.
>
> My instinct is to say that that's a bit dangerous as it means
> we might end up with changes to the "wrong" version of the
> two files. Would it let us do the conversion faster or
> more conveniently ?
>

It would be a kind of "insurance" against being late, basically. Doc
changes are rare enough that we could manage it, I think (and as long as
code review catches changes to only one version of the docs, no bitrot is
possible since we would build both).

Paolo


> thanks
> -- PMM
>
>

--00000000000082ceec059f6c128f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 25 feb 2020, 20:50 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Tue, 25 Feb 2020 at 19:10, P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>I feel like we&#39;=
re working a bit at cross purposes here so maybe<br>
we&#39;d benefit from just nailing down who&#39;s going to do what and<br>
in which order?<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">I am not going to do much more than what I posted today, bas=
ically only the automated conversion.</div><div dir=3D"auto"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
My current thought on ordering is something like:<br>
=C2=A0* commit this<br>
=C2=A0* commit Kashyap&#39;s series<br>
=C2=A0* commit (an adjusted version of) your split-out-the-texi series<br>
=C2=A0* (automated) conversion of more texi -- all in one series I guess ?<=
br>
=C2=A0* ???<br>
=C2=A0* profit<br>
<br>
but I&#39;m not very strongly attached to that.<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">The main issue with this ser=
ies and Kashyap&#39;s is that if we don&#39;t manage to get everything done=
 in 5.0 we have a mutilated qemu-doc. Then either we keep it mutilated or w=
e scramble to undo the work. So I would agree to commit the series in this =
order, but without the removal of the .texi files.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">&gt; Perhaps we could have the files in both .texi and (automatic=
ally<br>
&gt; converted) .rst versions at the same time in the tree for a short<br>
&gt; period. If that&#39;s okay for you, I can post tomorrow a series to do=
 that.<br>
<br>
My instinct is to say that that&#39;s a bit dangerous as it means<br>
we might end up with changes to the &quot;wrong&quot; version of the<br>
two files. Would it let us do the conversion faster or<br>
more conveniently ?<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">It would be a kind of &quot;insurance&quot; against bein=
g late, basically. Doc changes are rare enough that we could manage it, I t=
hink (and as long as code review catches changes to only one version of the=
 docs, no bitrot is possible since we would build both).</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--00000000000082ceec059f6c128f--


