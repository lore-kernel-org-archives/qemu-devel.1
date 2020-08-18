Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C89C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF1C206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLLKIIZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF1C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7xZR-0006Ow-Ec
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 05:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k7xYv-0005tS-2m
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k7xYt-00079Q-DL
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597741542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeIRskZNBfBNEpwIboKAblWDbUp2nzPbUmApME6QZPk=;
 b=RLLKIIZ9WfTJwMPP0rqnCf6oKAl6DNQCA1zQAqzCHXUoiHeyOILR86QAMc0uykwt43W12a
 3lxZ+tbfF/X6qB5BqQzzt+uefxbKWGGtDbkUWPBTwqCmoVgSKojHLdD74uhWmrkaYpSRzH
 23BNjlJJ6JxirR93ngnRkgDnqXMxlko=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-lD_lNkRnNKy196X4TR4euQ-1; Tue, 18 Aug 2020 05:05:40 -0400
X-MC-Unique: lD_lNkRnNKy196X4TR4euQ-1
Received: by mail-ot1-f69.google.com with SMTP id g3so8955370otq.7
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 02:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WeIRskZNBfBNEpwIboKAblWDbUp2nzPbUmApME6QZPk=;
 b=uXJVp+OqU4rL9r10c+CvCPpEtu4BLcJVWsP1zgE+qYMTcRdu7ZYgWEecUYqeGRwtpB
 vywsMYSVhibs/OjdIr/s4M/LSeMC95lLOpUEKuz1jUpihJvBYt8jRu1Uqc8s99wikHY7
 LB5RSaOgesH8wRP9RWl5qkBjb3qkLTWPqn1VC9A75AORy5WaIa0mwvx977HoXXwUIdMD
 30ZLVJh9RCNK4Y+/mPYZQ0EXOjgDVvg4Tr3jlSSI1b2s7TTAfkvV6a4zeMsKeKNp5IB8
 AmD66CQ/XAWC3mwXXs3cc52woTOlTBIX1gok57IvaemkJw0Xfe+nzWrlDs4X+owOQh8p
 M+nQ==
X-Gm-Message-State: AOAM533avUXvl8Ko9LG8POeV+m9K7v2FP9XoKLv3rVy4T6E8BRRKgRmL
 qgJJj7ZR7nhbU5j59U9JrXjHYv1tYJSnTp7QO7Yc+pnPG5XRSKypQHOEevqoV6cqYkYIxokp0LS
 ST7eykoq0ZgR4AJ6JOSC0GW2bJFYURu8=
X-Received: by 2002:a4a:4f16:: with SMTP id c22mr14185655oob.33.1597741539297; 
 Tue, 18 Aug 2020 02:05:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhH1ZsFkLRDqBzTcAGSqYsVioR/aFv34pfdBLYUcO7eaK3LCMJIBNwZWX5GI9oh7TIgXu39OfIXPZyGKowQOc=
X-Received: by 2002:a4a:4f16:: with SMTP id c22mr14185643oob.33.1597741539048; 
 Tue, 18 Aug 2020 02:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-7-kwolf@redhat.com>
 <CAMRbyyu8=uFJkqCuC5BBamzHOwfXaw-rWVa+KT4gQc3bE=WKfQ@mail.gmail.com>
 <20200818084712.GB6865@linux.fritz.box>
In-Reply-To: <20200818084712.GB6865@linux.fritz.box>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 18 Aug 2020 12:05:22 +0300
Message-ID: <CAMRbyyuJ9OK_cSp9OrXoOxLoaDSgyMvRLh8ObT80NSbq484Dng@mail.gmail.com>
Subject: Re: [RFC PATCH 06/22] qemu-nbd: Use raw block driver for --offset
To: Kevin Wolf <kwolf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e0d7cf05ad2330b9"
Received-SPF: none client-ip=63.128.21.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e0d7cf05ad2330b9
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 18, 2020 at 11:47 AM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 17.08.2020 um 19:19 hat Nir Soffer geschrieben:
> > On Thu, Aug 13, 2020 at 7:36 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > > Instead of implementing qemu-nbd --offset in the NBD code, just put a
> > > raw block node with the requested offset on top of the user image and
> > > rely on that doing the job.
> > >
> > > This does not only simplify the nbd_export_new() interface and bring it
> > > closer to the set of options that the nbd-server-add QMP command
> offers,
> > > but in fact it also eliminates a potential source for bugs in the NBD
> > > code which previously had to add the offset manually in all relevant
> > > places.
> > >
> >
> > Just to make sure I understand this correctly -
> >
> > qemu-nbd can work with:
> >
> >     $ qemu-nbd 'json:{"driver": "file", "filename": "test.raw"}'
> >
> > And:
> >
> >     $ qemu-nbd 'json:{"driver": "raw", "file": {"driver": "file",
> > "filename": "test.raw"}}'
> >
> > I assumed that we always create the raw node?
>
> No, the first form creates only the 'file' node without a 'raw' node on
> top. For all practical matters, this should be the same in qemu-img or
> qemu-nbd. For actually running VMs, omitting the 'raw' node where it's
> not needed can improve performance a little.
>

We did not check if we have different performance with the extra raw node.
Since in our use case (copying images) small reads/writes are unlikely, I
don't
think it will make a difference.

What is true is that if you use a filename without specifying the driver
> (i.e.  you rely on format probing), you'll get a 'raw' node on top of
> the 'file' node.
>
> > oVirt always uses the second form to make it easier to support offset,
> > size, and backing.
> >
> https://github.com/oVirt/ovirt-imageio/blob/2021164d064227d7c5e03c8da087adc66e3a577e/daemon/ovirt_imageio/_internal/qemu_nbd.py#L104
> >
> > This also seems to be the way libvirt builds the nodes using -blockdev.
>
> libvirt actually has a BZ to avoid the 'raw' node for performance when
> it's not needed.
>
> > Do we have a way to visualize the internal node graph used by
> > qemu-nbd/qemu-img?
>
> No, but as long as you explicitly specify the driver, you get exactly
> what you specified.
>

So this is not really needed then.


> For exploring what happens, you can pass the same json: filename to QEMU
> (maybe with -hda) and then use the monitor to inspect the state.
>
> Kevin
>
>

--000000000000e0d7cf05ad2330b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Aug 18, 2020 at 11:47 AM Kevin Wo=
lf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wrote:<=
br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Am 17.08.2020 um 19:19 hat Nir Soffer geschrieben:<br>
&gt; On Thu, Aug 13, 2020 at 7:36 PM Kevin Wolf &lt;<a href=3D"mailto:kwolf=
@redhat.com" target=3D"_blank">kwolf@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Instead of implementing qemu-nbd --offset in the NBD code, just p=
ut a<br>
&gt; &gt; raw block node with the requested offset on top of the user image=
 and<br>
&gt; &gt; rely on that doing the job.<br>
&gt; &gt;<br>
&gt; &gt; This does not only simplify the nbd_export_new() interface and br=
ing it<br>
&gt; &gt; closer to the set of options that the nbd-server-add QMP command =
offers,<br>
&gt; &gt; but in fact it also eliminates a potential source for bugs in the=
 NBD<br>
&gt; &gt; code which previously had to add the offset manually in all relev=
ant<br>
&gt; &gt; places.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Just to make sure I understand this correctly -<br>
&gt; <br>
&gt; qemu-nbd can work with:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0$ qemu-nbd &#39;json:{&quot;driver&quot;: &quot;fil=
e&quot;, &quot;filename&quot;: &quot;test.raw&quot;}&#39;<br>
&gt; <br>
&gt; And:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0$ qemu-nbd &#39;json:{&quot;driver&quot;: &quot;raw=
&quot;, &quot;file&quot;: {&quot;driver&quot;: &quot;file&quot;,<br>
&gt; &quot;filename&quot;: &quot;test.raw&quot;}}&#39;<br>
&gt; <br>
&gt; I assumed that we always create the raw node?<br>
<br>
No, the first form creates only the &#39;file&#39; node without a &#39;raw&=
#39; node on<br>
top. For all practical matters, this should be the same in qemu-img or<br>
qemu-nbd. For actually running VMs, omitting the &#39;raw&#39; node where i=
t&#39;s<br>
not needed can improve performance a little.<br></blockquote><div>=C2=A0</d=
iv><div>We did not check if we have different performance with the extra ra=
w node.</div><div>Since in our use case (copying images) small reads/writes=
 are unlikely, I don&#39;t</div><div>think it will make a difference.</div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
What is true is that if you use a filename without specifying the driver<br=
>
(i.e.=C2=A0 you rely on format probing), you&#39;ll get a &#39;raw&#39; nod=
e on top of<br>
the &#39;file&#39; node.<br>
<br>
&gt; oVirt always uses the second form to make it easier to support offset,=
<br>
&gt; size, and backing.<br>
&gt; <a href=3D"https://github.com/oVirt/ovirt-imageio/blob/2021164d064227d=
7c5e03c8da087adc66e3a577e/daemon/ovirt_imageio/_internal/qemu_nbd.py#L104" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/oVirt/ovirt-imageio=
/blob/2021164d064227d7c5e03c8da087adc66e3a577e/daemon/ovirt_imageio/_intern=
al/qemu_nbd.py#L104</a><br>
&gt; <br>
&gt; This also seems to be the way libvirt builds the nodes using -blockdev=
.<br>
<br>
libvirt actually has a BZ to avoid the &#39;raw&#39; node for performance w=
hen<br>
it&#39;s not needed.<br>
<br>
&gt; Do we have a way to visualize the internal node graph used by<br>
&gt; qemu-nbd/qemu-img?<br>
<br>
No, but as long as you explicitly specify the driver, you get exactly<br>
what you specified.<br></blockquote><div><br></div><div>So this is not real=
ly needed then.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
For exploring what happens, you can pass the same json: filename to QEMU<br=
>
(maybe with -hda) and then use the monitor to inspect the state.<br>
<br>
Kevin<br>
<br>
</blockquote></div></div>

--000000000000e0d7cf05ad2330b9--


