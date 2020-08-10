Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D70C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 20:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C46720838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 20:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HO/nBzb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C46720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5E3p-000739-Sy
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 16:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5E3I-0006dV-KM
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 16:05:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5E3F-0006iJ-S8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 16:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597089944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f2XPrKWekrRmhcKrn7UvXyOC3kez8TDycq6auOS7DOM=;
 b=HO/nBzb7s7+VTB7RxmQdtuhkWX0XpE9ob3xBKYAYnrz3eeMu9sC7Gpf1EimXxrGsmHTg2e
 FFDfVapkRrevGs0v358zX3MqCWBuP5PDNYuoWRhdd7+V1NCMneKAUVNDr4fKzzktgllFo/
 Vty0ljXp27DofbNowDQKV/a2oHHFpi4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-5O9qJHw9M1y7gFyVGZDdng-1; Mon, 10 Aug 2020 16:05:40 -0400
X-MC-Unique: 5O9qJHw9M1y7gFyVGZDdng-1
Received: by mail-ej1-f69.google.com with SMTP id lg2so4223907ejb.23
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 13:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f2XPrKWekrRmhcKrn7UvXyOC3kez8TDycq6auOS7DOM=;
 b=C1+HZc4EgBmOAH6WBl/fdm6rB+n1AJzA7p5GUfxAWSemY5Kp6UtBurmX6CbpqGxlNO
 I6TVZ3JeJBbC9x6iwcGvw3o/0j8Rsj1m8zOTD3KzQRLzwJewKY/Nan0rW4ZUGv6vgu7G
 Cv5OVxJP+gjzzoLATMmy0JLMEJVVgcTPAXaV4/YxIeLocGrK8339cmgHzl+XsVyBO0Ao
 Ir6zOUfozQr/SEYUTF3a6THe0KKup80plbJ92YxYiQRTU+3A0q6oQLnI3S9y6YRNpUco
 qkiw6ttZRQQvaJZSAIf/QbDoAHrS71VAYO5VVLg8JZ4eqFMQs/Ai0u9+yQpKv0TaE/oC
 GMWw==
X-Gm-Message-State: AOAM5335oQBnCI+QhcS4DD1XTSXvI3lWdGHTOZYxPjYxsSd+OyjmYwpX
 LQjRdrs3obn+iVztLXwzBlAq+k/i93gGnJ3XFsJhjgEA5PJyz6u80MDRJwP/g1Xw1bEtz9Yxj3I
 26tJWvzOtGYV52PWjvC6jmE2FHF5Am1k=
X-Received: by 2002:a05:6402:206d:: with SMTP id
 bd13mr23024036edb.57.1597089938885; 
 Mon, 10 Aug 2020 13:05:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVU7S3L6yR/1cecBxE3Y+sBpYqBt0TfPeBEWUP8dDa8U4MzLOcUyYknZrl//x0UUocVHqbcznjWMw9jgaFFMY=
X-Received: by 2002:a05:6402:206d:: with SMTP id
 bd13mr23024009edb.57.1597089938576; 
 Mon, 10 Aug 2020 13:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-136-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8J3-Sb4r4CqmLE=cmZHL311_B4EZD7L5+N-OhHD+X9jg@mail.gmail.com>
 <0c4c75a6-0165-6549-6d3d-24c3f3f7d180@redhat.com>
 <CAFEAcA8o6PvVMhxS5VPmqMiXEjCdFf194-LAOqrMm4VhaOAV6w@mail.gmail.com>
 <85e3b495-9855-dc16-986a-1042de99237c@redhat.com>
 <CAFEAcA8Azxzyjwg8YG2ALmEkXGrm0csFYPzJRdzYMkdHag+01w@mail.gmail.com>
 <0e1a3132-2426-b553-c4c7-747c339f2eaa@redhat.com>
 <CAFEAcA_NtuHYa203faCU+0Sk9K_UFxFt_pqLB+0pX3Zd4k3KWw@mail.gmail.com>
In-Reply-To: <CAFEAcA_NtuHYa203faCU+0Sk9K_UFxFt_pqLB+0pX3Zd4k3KWw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Aug 2020 22:05:26 +0200
Message-ID: <CABgObfYCCKbWZ-o7Xq4bYCMptm=omTR-HX5saiaC=Wv1Tua_KQ@mail.gmail.com>
Subject: Re: [PATCH 135/147] meson: sphinx-build
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000076abe405ac8b7a9c"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000076abe405ac8b7a9c
Content-Type: text/plain; charset="UTF-8"

Il lun 10 ago 2020, 21:57 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> > Since it's all handled internally by sphinx, I think you only need to
> > add the man pages to the dictionary, and get rid of the corresponding
> > Texinfo outputs in qapi/meson.build and qga/meson.build?
>
> The patchset has a fair amount of change to the makefiles:
>  Makefile                                   |  86 +---
>  rules.mak                                  |  14 +-
>
>
> > In other words, it should be just this:
>
> ...so if it's that simple that would be nice.
>

Hopefully. Of course you would also have to delete the Texinfo rules in
meson.build but that's certainly more self explanatory then the qapi-gen.py
bit.

Paolo


> -- PMM
>
>

--00000000000076abe405ac8b7a9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Il lun 10 ago 2020, 21:57 Peter Maydell &lt;<a href=3D"mailto:=
peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scritto:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">&gt; Since it&#39;s all handled interna=
lly by sphinx, I think you only need to<br>
&gt; add the man pages to the dictionary, and get rid of the corresponding<=
br>
&gt; Texinfo outputs in qapi/meson.build and qga/meson.build?<br>
<br>
The patchset has a fair amount of change to the makefiles:<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8=
6 +---<br>
=C2=A0rules.mak=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-<b=
r>
<br>
<br>
&gt; In other words, it should be just this:<br>
<br>
...so if it&#39;s that simple that would be nice.<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Hopefully. Of course you w=
ould also have to delete the Texinfo rules in meson.build but that&#39;s ce=
rtainly more self explanatory then the qapi-gen.py bit.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--00000000000076abe405ac8b7a9c--


