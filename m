Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03894C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C388D20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIm3xec5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C388D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixU5E-0002K5-V7
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ixU4I-0001NR-6u
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ixU4B-0007MB-Sb
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:02:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30154
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ixU4B-0007Ji-LN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580468544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QjAkTXGcLVzQBY6OKCUApzz9RUGB2gH8SAmyZWWRBcc=;
 b=MIm3xec5tPgp0XZoZdCPrpFuMqtpRuWOb2csaekioNOGBROnh/QYgGPyUjORkbkf4spwIO
 azyQ2A9AI1yBaVYiCgqhqX7SvGuF2zkQahvacAoW3Cx9kWOmuPXccs0ZcWuF9nrW0jY6cV
 GgQJFVHSiJz257l/BMA1EgAIxx+y930=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-dfRJgYxIPAqbelvdo82DmQ-1; Fri, 31 Jan 2020 06:02:20 -0500
Received: by mail-ed1-f70.google.com with SMTP id cy24so4559311edb.12
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 03:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=klW/MvX8BVQnddCl40OplT0FzWtxRJQ3oEnttdTfPsM=;
 b=Tqnr5BzaujETQo3lj9OmVp5KJ34ctfC4BNXoyK++qX7wfPyr2ROgZGX5nvjRbcwENG
 YveMgowoilnvICuq8ZMWGa+BTTZP/9nD3EOD5OJOV8R2Wqx0il5l9r2B5Lu5twUjqJcY
 vJo6I3p920XEE7ajLKhD4ft8/CNM09E0mr18F2zDQfZSBwgdqu58hfBK//hi9QAc5t+d
 kDfX/CWmKGgBIh5h2xCXt1UNXRSKpc8yuUZ6RurN0j5jyOeWFeM/5G7y+O4SRidJnn9R
 o24GLvv1tansUwGwbq/vIr99EkTG3QxwtX0unjIn5ZH8MPUFqCegAiXYRy2syj3TSiJD
 6aHA==
X-Gm-Message-State: APjAAAXPuLDaEVHG5T8SsB3ymMGLLnKEhuQ/sgqLP/1VfMX2qoiBitHx
 lw8uac6tMWJKpxS3gVxRMKooNfg57groeqHNVJLDEEZoZWCMVeH6z2O6AmYvwBQm+t3Afr9Vlus
 nEKXPLEq3gBFWDWbDWJjckjXxNPTpW9s=
X-Received: by 2002:a05:6402:36e:: with SMTP id
 s14mr8233412edw.379.1580468538847; 
 Fri, 31 Jan 2020 03:02:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGS3BpUPN4feZu2Qdmv9ZVwPr9LkWMkSk5gxTKu0FDPiwBihOB0mLJ0AitFfXYvi1pdReQtprXIQlNfZeYyHU=
X-Received: by 2002:a05:6402:36e:: with SMTP id
 s14mr8233375edw.379.1580468538545; 
 Fri, 31 Jan 2020 03:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org> <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
 <CAFEAcA-545QS9mnM6hwa6TxUpw_pDQ3Pa8tkf4qtzWS1Zi_fxQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-545QS9mnM6hwa6TxUpw_pDQ3Pa8tkf4qtzWS1Zi_fxQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 Jan 2020 12:02:05 +0100
Message-ID: <CABgObfaB=wHXyJbQR163bZdFHhWdCc4D8sWRHzte019_hSTuhA@mail.gmail.com>
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: dfRJgYxIPAqbelvdo82DmQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000d1c249059d6d812f"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d1c249059d6d812f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 31 gen 2020, 11:36 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Fri, 31 Jan 2020 at 06:11, Markus Armbruster <armbru@redhat.com> wrote=
:
> > Beware, personal opinion.
> >
> > When you put documentation next to the code it documents (which you
> > absolutely should, because it's your only realistic chance to keep the
> > two in sync), then extracting API comments is useful, because it
> > collects them in one place.
> >
> > It's of next to no use to me when the comments are all in the same plac=
e
> > already, namely the header.
>

The advantage of putting them in the header is that you have them all in
one place (inline functions and structs must be in the header). In practice
that balances for me the disadvantage of having some comments far from the
code they document, which increases the risk of bitrot especially for
comments such as "called with lock X held".

I definitely agree that the overview/introduction/conventions
> side of things is where we'd benefit most if somebody wanted
> to try to tackle that. We could roll
> https://wiki.qemu.org/Documentation/QOMConventions
> into that if we had a better place to put that info.
>

I am travelling this weekend so I might try to do some kind of thread
summary and brain dump in the wiki. I'll leave to Kashyap to do the rST
conversion and patch submission. ;-)

Paolo


> thanks
> -- PMM
>
>

--000000000000d1c249059d6d812f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 31 gen 2020, 11:36 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Fri, 31 Jan 2020 at 06:11, M=
arkus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank"=
 rel=3D"noreferrer">armbru@redhat.com</a>&gt; wrote:<br>
&gt; Beware, personal opinion.<br>
&gt;<br>
&gt; When you put documentation next to the code it documents (which you<br=
>
&gt; absolutely should, because it&#39;s your only realistic chance to keep=
 the<br>
&gt; two in sync), then extracting API comments is useful, because it<br>
&gt; collects them in one place.<br>
&gt;<br>
&gt; It&#39;s of next to no use to me when the comments are all in the same=
 place<br>
&gt; already, namely the header.<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">The advantage of putting them in the header=
 is that you have them all in one place (inline functions and structs must =
be in the header). In practice that balances for me the disadvantage of hav=
ing some comments far from the code they document, which increases the risk=
 of bitrot especially for comments such as &quot;called with lock X held&qu=
ot;.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">I definitely agree that the overview=
/introduction/conventions<br>
side of things is where we&#39;d benefit most if somebody wanted<br>
to try to tackle that. We could roll<br>
<a href=3D"https://wiki.qemu.org/Documentation/QOMConventions" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://wiki.qemu.org/Documentation/QOM=
Conventions</a><br>
into that if we had a better place to put that info.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">I am travelling this we=
ekend so I might try to do some kind of thread summary and brain dump in th=
e wiki. I&#39;ll leave to Kashyap to do the rST conversion and patch submis=
sion. ;-)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000d1c249059d6d812f--


