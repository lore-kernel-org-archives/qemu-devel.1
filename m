Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF6FC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787DE2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvyjKla+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787DE2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVqsY-0001IW-Iv
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 02:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVqrJ-0008W6-3Z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 02:47:29 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:40601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVqrG-000438-Vw
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 02:47:28 -0400
Received: by mail-ot1-x32d.google.com with SMTP id f97so434668otb.7
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 23:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RJHimsB3H9L1q4FwPKpUkz6EyWjhz6WFtpaIt+tm72A=;
 b=MvyjKla+TQfgttaKgwm6XW//o2vUOTOGQ/yN2YC72kT/wdw5jwOh7tpR+OIha37nsj
 1p+//a64HHQHDkhNkwPRXyuewjqs30FcwuXQYjOHbMzQ9nl+jvOd8Sp9xkhRljCQ9Dy+
 30/AfR01fG0coaj9LkvjrDepZ66s/NaKxujRexYPOo4pFhB8dABVcCHfQhBQZwjC8t1K
 xaFhOgJxx4BeRhOPHjuilV+6Q5J1nJPLLITaMJQNY6Z6SjDV9oePClElQidvW4CvjNiB
 gkxOVXUZmGcKl5Lf07/saMa3t6kmCb0+B8WKMUEmVjc6BQGDndRNvF3MLyExxMovZb7t
 X51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RJHimsB3H9L1q4FwPKpUkz6EyWjhz6WFtpaIt+tm72A=;
 b=Qioja5EPgmGEkTHPJoUgm4RxnCF7N9zpsPUF+eQI8tbpZ9yQQT0XIZOr0Ax3mVuKC+
 t/jD/OxR3RKR3v985vofBaQuzug/6fKAhC1QhXlHjLYASrUEXWP0FC1tgjjqHgjViL4w
 A3E+Oth3SC7/pf/RHZyd/44D+jKAVEL+2eZ0DSIwxk+RpG7pe6f4o9vcH4iqB8TmZVm1
 shKQ1zpP5iD4vr+soyvq59siaDJCBuy4YnVUPCBvDVQ7sEcJ0/lp/SNmzNNfXE+HGoRm
 c7r+i+ePMmJxm1ly/Po2yXAXBJLa9Vt3LMS2QPrNF6K1AMzv1XH5bAKAmgpuMM2TguYX
 7RUg==
X-Gm-Message-State: AOAM5313wYg+pHiwZVEvxQfJSxoRWolLY3PL6kZ6h/f3J67ZLdMBOaG5
 TPBpvhEpa7JAUE7mn6vzDkVHn1YKjsFEdgeq2CI=
X-Google-Smtp-Source: ABdhPJyJ9vHD3JvVrMOVADviEuYC7rjK9/2o3ASCwmeubxMQJ3Ez2UQKK4kClXz7RZXoyUye6iL83yUVFa5sn/yRRks=
X-Received: by 2002:a9d:2c4:: with SMTP id 62mr601188otl.102.1603435645696;
 Thu, 22 Oct 2020 23:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <20201023144901.5bd908a1@yekko.fritz.box>
In-Reply-To: <20201023144901.5bd908a1@yekko.fritz.box>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 23 Oct 2020 09:47:14 +0300
Message-ID: <CAC_L=vUh8LU5c8c00OhnbEiW7EzZFWKU61vOdub7c11wDMXeRg@mail.gmail.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
To: David Gibson <dgibson@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000014ff5105b250f4ad"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-ot1-x32d.google.com
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000014ff5105b250f4ad
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Fri, Oct 23, 2020 at 6:49 AM David Gibson <dgibson@redhat.com> wrote:

> On Thu, 22 Oct 2020 11:01:04 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Thu, Oct 22, 2020 at 05:50:51PM +0300, Marcel Apfelbaum wrote:
> >  [...]
> >
> > Right. After detecting just failing unconditionally it a bit too
> > simplistic IMHO.
>
> There's also another factor here, which I thought I'd mentioned
> already, but looks like I didn't: I think we're still missing some
> details in what's going on.
>
> The premise for this patch is that plugging while the indicator is in
> transition state is allowed to fail in any way on the guest side.  I
> don't think that's a reasonable interpretation, because it's unworkable
> for physical hotplug.  If the indicator starts blinking while you're in
> the middle of shoving a card in, you'd be in trouble.
>
> So, what I'm assuming here is that while "don't plug while blinking" is
> the instruction for the operator to obey as best they can, on the guest
> side the rule has to be "start blinking, wait a while and by the time
> you leave blinking state again, you can be confident any plugs or
> unplugs have completed".  Obviously still racy in the strict computer
> science sense, but about the best you can do with slow humans in the
> mix.
>
> So, qemu should of course endeavour to follow that rule as though it
> was a human operator on a physical machine and not plug when the
> indicator is blinking.  *But* the qemu plug will in practice be fast
> enough that if we're hitting real problems here, it suggests the guest
> is still doing something wrong.
>

I personally think there is a little bit of over-engineering here.
Let's start with the spec:

    Power Indicator Blinking
    A blinking Power Indicator indicates that the slot is powering up or
powering down and that
    insertion or removal of the adapter is not permitted.

What exactly is an interpretation here?
As you stated, the races are theoretical, the whole point of the indicator
is to let the operator know he can't plug the device just yet.

I understand it would be more user friendly if the QEMU would wait
internally for the
blinking to end, but the whole point of the indicator is to let the
operator (human or machine)
know they can't plug the device at a specific time.
Should QEMU take the responsibility of the operator? Is it even correct?

Even if we would want such a feature, how is it related to this patch?
The patch simply refuses to start a hotplug operation when it knows it will
not succeed.

Another way that would make sense to me would be  is a new QEMU interface
other than
"add_device", let's say "adding_device_allowed", that would return true if
the hotplug is allowed
at this point of time. (I am aware of the theoretical races)

The above will at least mimic the mechanics of the pyhs world.  The
operator looks at the indicator,
the management software checks if adding the device is allowed.
Since it is a corner case I would prefer the device_add to fail rather than
introducing a new interface,
but that's just me.

Thanks,
Marcel


> --
> David Gibson <dgibson@redhat.com>
> Principal Software Engineer, Virtualization, Red Hat
>

--00000000000014ff5105b250f4ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi David,</div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 6:49 AM =
David Gibson &lt;<a href=3D"mailto:dgibson@redhat.com">dgibson@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Thu, 22 Oct 2020 11:01:04 -0400<br>
&quot;Michael S. Tsirkin&quot; &lt;<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
<br>
&gt; On Thu, Oct 22, 2020 at 05:50:51PM +0300, Marcel Apfelbaum wrote:<br>
&gt;=C2=A0 [...]=C2=A0 <br>
&gt; <br>
&gt; Right. After detecting just failing unconditionally it a bit too<br>
&gt; simplistic IMHO.<br>
<br>
There&#39;s also another factor here, which I thought I&#39;d mentioned<br>
already, but looks like I didn&#39;t: I think we&#39;re still missing some<=
br>
details in what&#39;s going on.<br>
<br>
The premise for this patch is that plugging while the indicator is in<br>
transition state is allowed to fail in any way on the guest side.=C2=A0 I<b=
r>
don&#39;t think that&#39;s a reasonable interpretation, because it&#39;s un=
workable<br>
for physical hotplug.=C2=A0 If the indicator starts blinking while you&#39;=
re in<br>
the middle of shoving a card in, you&#39;d be in trouble.<br>
<br>
So, what I&#39;m assuming here is that while &quot;don&#39;t plug while bli=
nking&quot; is<br>
the instruction for the operator to obey as best they can, on the guest<br>
side the rule has to be &quot;start blinking, wait a while and by the time<=
br>
you leave blinking state again, you can be confident any plugs or<br>
unplugs have completed&quot;.=C2=A0 Obviously still racy in the strict comp=
uter<br>
science sense, but about the best you can do with slow humans in the<br>
mix.<br>
<br>
So, qemu should of course endeavour to follow that rule as though it<br>
was a human operator on a physical machine and not plug when the<br>
indicator is blinking.=C2=A0 *But* the qemu plug will in practice be fast<b=
r>
enough that if we&#39;re hitting real problems here, it suggests the guest<=
br>
is still doing something wrong.<br></blockquote><div><br></div><div>I perso=
nally think there is a little bit of over-engineering=C2=A0here.</div><div>=
Let&#39;s start with the spec:</div><div><br></div><div>=C2=A0 =C2=A0 Power=
 Indicator Blinking<br>=C2=A0 =C2=A0 A blinking Power Indicator indicates t=
hat the slot is powering up or powering down and that<br>=C2=A0 =C2=A0 inse=
rtion or removal of the adapter is not permitted.</div><div><br>What exactl=
y is an interpretation here?</div><div>As you stated, the races are theoret=
ical, the whole point of the indicator</div><div>is to let the operator kno=
w he can&#39;t plug the device just yet.</div><div><br></div><div>I underst=
and it would be more user friendly if the QEMU would wait internally for th=
e</div><div>blinking to end, but the whole point of the indicator is to let=
 the operator=C2=A0(human or machine)</div><div>know they can&#39;t plug th=
e device at a specific time.</div><div>Should QEMU take the responsibility=
=C2=A0of the operator? Is it even correct?<br></div><div><br></div><div>Eve=
n if we would want such a feature, how is it related to this patch?</div><d=
iv>The patch simply refuses to start a hotplug operation when it knows it w=
ill not succeed.=C2=A0</div><div>=C2=A0<br></div><div>Another way that woul=
d make sense to me would be=C2=A0 is a new QEMU interface other than</div><=
div>&quot;add_device&quot;, let&#39;s say &quot;adding_device_allowed&quot;=
, that would return true if the hotplug is allowed</div><div>at this point =
of time. (I am aware of the theoretical races)=C2=A0</div><div><br></div><d=
iv>The above will at least mimic the mechanics of the pyhs=C2=A0world.=C2=
=A0 The operator looks at the indicator,</div><div>the management software =
checks if adding the device is allowed.</div><div>Since it is a corner case=
 I would prefer the device_add to fail rather than introducing a new interf=
ace,</div><div>but that&#39;s just me.</div><div><br></div><div>Thanks,</di=
v><div>Marcel</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
-- <br>
David Gibson &lt;<a href=3D"mailto:dgibson@redhat.com" target=3D"_blank">dg=
ibson@redhat.com</a>&gt;<br>
Principal Software Engineer, Virtualization, Red Hat<br>
</blockquote></div></div>

--00000000000014ff5105b250f4ad--

