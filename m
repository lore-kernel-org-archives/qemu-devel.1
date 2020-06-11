Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9508DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E90B206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1mqLbA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E90B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNYS-0004n0-E8
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jjNT9-0007eC-Vm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:42:12 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736]:40605)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jjNT7-0006Gs-Hv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:42:11 -0400
Received: by mail-qk1-x736.google.com with SMTP id c185so5556225qke.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cJHbUePUtX0gR4rRzB4TOAY6qOeaSy9xql/JyZDP9PQ=;
 b=E1mqLbA2BuHJQdAgiCYgTrWEE/F5W77YWYwuNyEEc5oK50u5uxepi7q3vTlP1C2+Ku
 llMdYz0jFUZEINp3uMdJEOo4ODLm/h7YUotrKBhzorlW+Ue817Ou90+aCa/XhQ5TB9te
 7X1pKlKu3n7UgPGh6u6rmY3lxCTYUdY8+Gt3pyLD1wwFRUJhuGG/qnHeko6n7YCKM6vE
 XdVGfWqCgZKWR2oufCMjOWpBOi5EjpEQLd0lYoJ+eRmfKLmi6f08psLwymipbm2M95T2
 ZXvy+5me4Y5NwQfxjzq91SaOw6B3Os99wCeHd1rGDINozXeAQLvT+NuM84qC94HTdKne
 +7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cJHbUePUtX0gR4rRzB4TOAY6qOeaSy9xql/JyZDP9PQ=;
 b=UEnhcLrCSpbuLgatJHD/Sy37635OxGBkE8oHqES7jP3Xml23s5qjPAVaxBi7RinSF0
 pjyNrqye9xO6NCNivv10F/690LJP/VewcLqwrJqz9X4w0b3cA58OPbk+/TOEpdLh0YdV
 aUpkw3b/wO0EJIqdavkvMQjrCSQ/irQqCI4GYrurknc5LlYgkZWvAespWsiiLLL/ivax
 33gz0TSJSfs/PQ2a/cNfropbQm8naMNDQn1Z7Fvf+yNFEhIkUqhurOyXY7lK7bVXCyv8
 w7XAgrVb2vpekfLu10Wh56OM6+h71efAnjcMJvJ8ramiZvEJ+BGTHhYUdVpmZKYQnpVj
 kkDg==
X-Gm-Message-State: AOAM531mzqru4D4q+oME7iUsup4bvI++Pezlcz5l7NG6NAJxhScDSlUE
 haw772Uxmb6tddmLEZOuRr7lJAmz9VnXBe7FFAhqNw==
X-Google-Smtp-Source: ABdhPJyBUC6VsPERSvKcMYZaydfB0AvS4bQ12Y90Shi3mN7bzWs1NZCwKuyet9T5/zx1z7gWB11lXt/0IVpFM2lxf0M=
X-Received: by 2002:a37:b501:: with SMTP id e1mr8261653qkf.269.1591882921558; 
 Thu, 11 Jun 2020 06:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
 <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
 <20200610140620.GE6947@linux.fritz.box>
 <CAFr6bU=aD=AXnoR-qSdQtQC690FYFqFsDRHHGxdUDkTh2ho1cA@mail.gmail.com>
 <20200610163122.GF6947@linux.fritz.box>
In-Reply-To: <20200610163122.GF6947@linux.fritz.box>
From: Sam Eiderman <sameid@google.com>
Date: Thu, 11 Jun 2020 16:41:50 +0300
Message-ID: <CAFr6bUnNF=Ria7owVKgZbmATJi3jy04RaiOPKjrbYQi5qNoZnA@mail.gmail.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
To: Kevin Wolf <kwolf@redhat.com>
Cc: David Edmondson <dme@dme.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, eblake@redhat.com,
 Max Reitz <mreitz@redhat.com>, Tony Zhang <tzz@google.com>
Content-Type: multipart/alternative; boundary="00000000000010a79405a7cf2007"
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=sameid@google.com; helo=mail-qk1-x736.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000010a79405a7cf2007
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 10, 2020 at 7:31 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 10.06.2020 um 17:26 hat Sam Eiderman geschrieben:
> > Thanks for the clarification Kevin,
> >
> > Well first I want to discuss unallocated blocks.
> > From my understanding operating systems do not rely on disks to be
> > zero initialized, on the contrary, physical disks usually contain
> > garbage.
> > So an unallocated block should never be treated as zero by any real
> > world application.
>
> I think this is a dangerous assumption to make. The guest did have
> access to these unallocated blocks before, and they read as zero, so not
> writing these to the conversion target does change the virtual disk.
> Whether or not this is a harmless change for the guest depends on the
> software running in the VM.
>

I see your point


>
> > Now assuming that I only care about the allocated content of the
> > disks, I would like to save io/time zeroing out unallocated blocks.
> >
> > A real world example would be flushing a 500GB vmdk on a real SSD
> > disk, if the vmdk contained only 2GB of data, no point in writing
> > 498GB of zeroes to that SSD - reducing its lifespan for nothing.
>
> Don't pretty much all SSDs support efficient zeroing/hole punching these
> days so that the blocks would actually be deallocated on the disk level?
>
> > Now from what I understand --target-is-zero will give me this behavior
> > even though that I really use it as a "--skip-prezeroing-target"
> > (sorry for the bad name)
> > (This is only true if later *allocated zeroes* are indeed copied
> correctly)
>
> As you noticed later, it doesn't.
>
> The behaviour you want is more like -B, except that you don't have a
> backing file. If you also pass -n, the actual filename you pass isn't
> even used, so I guess '-B "" -n' should do the trick?
>
> Kevin
>
>

--00000000000010a79405a7cf2007
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 10, 2020 at 7:31 PM Kevin=
 Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 10.06.2020=
 um 17:26 hat Sam Eiderman geschrieben:<br>
&gt; Thanks for the clarification Kevin,<br>
&gt; <br>
&gt; Well first I want to discuss unallocated blocks.<br>
&gt; From my understanding operating systems do not rely on disks to be<br>
&gt; zero initialized, on the contrary, physical disks usually contain<br>
&gt; garbage.<br>
&gt; So an unallocated block should never be treated as zero by any real<br=
>
&gt; world application.<br>
<br>
I think this is a dangerous assumption to make. The guest did have<br>
access to these unallocated blocks before, and they read as zero, so not<br=
>
writing these to the conversion target does change the virtual disk.<br>
Whether or not this is a harmless change for the guest depends on the<br>
software running in the VM.<br></blockquote><div><br></div><div>I see your =
point</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; Now assuming that I only care about the allocated content of the<br>
&gt; disks, I would like to save io/time zeroing out unallocated blocks.<br=
>
&gt; <br>
&gt; A real world example would be flushing a 500GB vmdk on a real SSD<br>
&gt; disk, if the vmdk contained only 2GB of data, no point in writing<br>
&gt; 498GB of zeroes to that SSD - reducing its lifespan for nothing.<br>
<br>
Don&#39;t pretty much all SSDs support efficient zeroing/hole punching thes=
e<br>
days so that the blocks would actually be deallocated on the disk level?<br=
>
<br>
&gt; Now from what I understand --target-is-zero will give me this behavior=
<br>
&gt; even though that I really use it as a &quot;--skip-prezeroing-target&q=
uot;<br>
&gt; (sorry for the bad name)<br>
&gt; (This is only true if later *allocated zeroes* are indeed copied corre=
ctly)<br>
<br>
As you noticed later, it doesn&#39;t.<br>
<br>
The behaviour you want is more like -B, except that you don&#39;t have a<br=
>
backing file. If you also pass -n, the actual filename you pass isn&#39;t<b=
r>
even used, so I guess &#39;-B &quot;&quot; -n&#39; should do the trick?<br>
<br>
Kevin<br>
<br>
</blockquote></div></div>

--00000000000010a79405a7cf2007--

