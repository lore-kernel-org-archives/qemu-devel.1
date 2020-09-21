Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AF0C35257
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6612120757
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnsCe5nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6612120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRVG-0002tM-Jg
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKRPM-0004yO-VS
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKRPI-0004rj-GB
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600716199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+j9L0ZAZL/NaLzyPDCq7BvPcV/MfX97JZt8foMxzSO8=;
 b=hnsCe5nnf8REAfNN/ZvmlvxKaweTGtp+kyb/59Z7r5yomSkTpdSZS1Q2pbM7Fo63iefXh7
 LW86CF5HNTUrDgD8GOgjqQ2dTr2SDglTIEqjZsX31UmYtuMkxCsU7YFJ02GlHRFKNBRiOI
 PIbaDFy3070UVaUw45n8XZv+Ef5gzHc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-yEeUOguBP82D4SVKiL1cYg-1; Mon, 21 Sep 2020 15:23:17 -0400
X-MC-Unique: yEeUOguBP82D4SVKiL1cYg-1
Received: by mail-ej1-f72.google.com with SMTP id rs9so5236660ejb.17
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 12:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+j9L0ZAZL/NaLzyPDCq7BvPcV/MfX97JZt8foMxzSO8=;
 b=KDu265T8sZ28O3V99kJDds2ntNigX3lMfgJzR7pnoWWnWxgvpurh+fEouZREdRSNjJ
 svY+sz0LD/BVgSZPjeTUidvjiDRI/6EGmnTZI9AXfqIqxqMX3mFF3+lxq4qwHqa/7RDY
 VCaGu9FqVfnGGmkJ7kaVyhzFSk14w4TlEjOBFMADu5Gwzfqnxq6SDR6gj/FL0a3iY4wp
 IJr7ObqQcMT1H+beClJMgq0vhURvyrMSPor5bocQ5Zkb/3rs+RzHvkyqlNOvsYiMvalu
 9p+PnMnV0TnV5itiWF2UxjUHPKdEV4NZ/KNWWVUSa4LHcWkXEORzNdsGC4cAf4HJRRjL
 ea4A==
X-Gm-Message-State: AOAM532BgjbyXL7yJYKu3AKTu6L9n7vsOi9ac4xd1kghvgXci35FsjNU
 8lznX8Oy49XWj0+pjo7VRVAl+xQZQopxbDS4mao+5x9PFuaLSPfH8nJaiX54m1YuVwiwLwGqw0u
 FNaqc7NyHp+Eu37NOrf/aR2HXXLJfG6E=
X-Received: by 2002:a17:906:cc98:: with SMTP id
 oq24mr1050667ejb.106.1600716195763; 
 Mon, 21 Sep 2020 12:23:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMV88ugGhH42NoEo5rJyCKvVO4ujljGsniFEETRaOm+qvTXhwoQWBdAsnipRQONqaeLX/8c+sKNZuVM+CyYds=
X-Received: by 2002:a17:906:cc98:: with SMTP id
 oq24mr1050653ejb.106.1600716195524; 
 Mon, 21 Sep 2020 12:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200918174117.180057-1-f4bug@amsat.org>
 <20200918174117.180057-4-f4bug@amsat.org>
 <874knra5fk.fsf@dusky.pond.sub.org>
 <6384105c-65ca-60f8-4fa0-afd2e46b144a@redhat.com>
 <87pn6f48xx.fsf@dusky.pond.sub.org> <20200921122400.GI3221@work-vm>
 <e88a8f34-ec08-f6b1-05b6-d91c447ee1ed@redhat.com>
 <87363byxp0.fsf@dusky.pond.sub.org>
In-Reply-To: <87363byxp0.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Sep 2020 21:23:03 +0200
Message-ID: <CABgObfbVsN-eh0eb3QUuk1qQ2mU92y80EjP-PVi-oV=mz0UAnw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] hw/sd/sdcard: Do not use legal address '0' for
 INVALID_ADDRESS
To: Markus Armbruster <armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000388c9605afd7c856"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Kevin O'Connor <kevin@koconnor.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000388c9605afd7c856
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think we can just bite the bullet and bump the version number. Just like
not all boards are created equal in terms of migration compatibility,
neither are all devices.

Unfortunately pflash is among those that need some care, but we have much
more leeway with sdhci-pci.

Paolo

Il lun 21 set 2020, 17:08 Markus Armbruster <armbru@redhat.com> ha scritto:

> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > On 9/21/20 2:24 PM, Dr. David Alan Gilbert wrote:
> >> * Markus Armbruster (armbru@redhat.com) wrote:
> >>> Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com> writes:
> >>>
> >>>> +Paolo & Kevin.
> >>>>
> >>>> On 9/21/20 10:40 AM, Markus Armbruster wrote:
> >>>>> Philippe Mathieu-Daud=C3=83=C2=A9 <f4bug@amsat.org> writes:
> >>>>>
> >>>>>> As it is legal to WRITE/ERASE the address/block 0,
> >>>>>> change the value of this definition to an illegal
> >>>>>> address: UINT32_MAX.
> >>>>>>
> >>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <f4bug@amsat.org>
> >>>>>> ---
> >>>>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>>>>> Cc: Markus Armbruster <armbru@redhat.com>
> >>>>>>
> >>>>>> Same problem I had with the pflash device last year...
> >>>>>> This break migration :(
> >>>>>> What is the best way to do this?
> >>>>>
> >>>>> Remind me: did we solve the problem with pflash, and if yes, how?
> >>>>
> >>>> No we can't. The best I could do is add a comment and as this
> >>>> is not fixable. See commit aba53a12bd5: ("hw/block/pflash_cfi01:
> >>>> Document use of non-CFI compliant command '0x00'").
> >>>>
> >>>> I now consider the device in maintenance-only
> >>>> mode and won't add any new features.
> >>>>
> >>>> I started working on a new implementation, hoping it can be a
> >>>> drop in replacement. Laszlo still has hope that QEMU pflash
> >>>> device will support sector locking so firmware developers could
> >>>> test upgrading fw in VMs.
> >>>>
> >>>> Back to the SDcard, it might be less critical, so a migration
> >>>> breaking change might be acceptable. I'm only aware of Paolo
> >>>> and Kevin using this device for testing. Not sure of its
> >>>> importance in production.
> >>>
> >>> Neither am I.
> >>>
> >>> Which machine types include this device by default?
> >>
> >> To me it looks like it's some of the ARM boards.
> >
> > My worry is TYPE_PCI_SDHCI ("sdhci-pci"):
> >
> >     k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
> >     k->device_id =3D PCI_DEVICE_ID_REDHAT_SDHCI;
> >     k->class_id =3D PCI_CLASS_SYSTEM_SDHCI;
> >
> > config SDHCI_PCI
> >     bool
> >     default y if PCI_DEVICES
>
> Ah, now I remember.  Not the first time I wished it wouldn't exist...
>
> >>> How can a non-default device be added, and to which machine types?
> >>>
> >>> I gather the fix changes device state incompatibly.  Always, or only =
in
> >>> certain states?
>
> I think we need to answer this question.
>
> >>>                  I'm asking because if device state remains compatibl=
e
> >>> most of the time, we might be able use subsection trickery to keep
> >>> migration working most of the time.  Has been done before, I think.
>
>

--000000000000388c9605afd7c856
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I think we can just bite the bullet and bump the version =
number. Just like not all boards are created equal in terms of migration co=
mpatibility, neither are all devices.<div dir=3D"auto"><br></div><div dir=
=3D"auto">Unfortunately pflash is among those that need some care, but we h=
ave much more leeway with sdhci-pci.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">Il lun 21 set 2020, 17:08 Markus Armbruster &lt;<a =
href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com" target=3D"_blank" rel=3D"noreferrer">philmd@=
redhat.com</a>&gt; writes:<br>
<br>
&gt; On 9/21/20 2:24 PM, Dr. David Alan Gilbert wrote:<br>
&gt;&gt; * Markus Armbruster (<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>) wrote:<br>
&gt;&gt;&gt; Philippe Mathieu-Daud=C3=83=C2=A9 &lt;<a href=3D"mailto:philmd=
@redhat.com" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;=
 writes:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +Paolo &amp; Kevin.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 9/21/20 10:40 AM, Markus Armbruster wrote:<br>
&gt;&gt;&gt;&gt;&gt; Philippe Mathieu-Daud=C3=83=C2=A9 &lt;<a href=3D"mailt=
o:f4bug@amsat.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.org</a>=
&gt; writes:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; As it is legal to WRITE/ERASE the address/block 0,=
<br>
&gt;&gt;&gt;&gt;&gt;&gt; change the value of this definition to an illegal<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; address: UINT32_MAX.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 &=
lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank" rel=3D"noreferrer">=
f4bug@amsat.org</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Dr. David Alan Gilbert &lt;<a href=3D"mailto:d=
gilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">dgilbert@redhat.co=
m</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Markus Armbruster &lt;<a href=3D"mailto:armbru=
@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Same problem I had with the pflash device last yea=
r...<br>
&gt;&gt;&gt;&gt;&gt;&gt; This break migration :(<br>
&gt;&gt;&gt;&gt;&gt;&gt; What is the best way to do this?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Remind me: did we solve the problem with pflash, and i=
f yes, how?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; No we can&#39;t. The best I could do is add a comment and =
as this<br>
&gt;&gt;&gt;&gt; is not fixable. See commit aba53a12bd5: (&quot;hw/block/pf=
lash_cfi01:<br>
&gt;&gt;&gt;&gt; Document use of non-CFI compliant command &#39;0x00&#39;&q=
uot;).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I now consider the device in maintenance-only<br>
&gt;&gt;&gt;&gt; mode and won&#39;t add any new features.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I started working on a new implementation, hoping it can b=
e a<br>
&gt;&gt;&gt;&gt; drop in replacement. Laszlo still has hope that QEMU pflas=
h<br>
&gt;&gt;&gt;&gt; device will support sector locking so firmware developers =
could<br>
&gt;&gt;&gt;&gt; test upgrading fw in VMs.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Back to the SDcard, it might be less critical, so a migrat=
ion<br>
&gt;&gt;&gt;&gt; breaking change might be acceptable. I&#39;m only aware of=
 Paolo<br>
&gt;&gt;&gt;&gt; and Kevin using this device for testing. Not sure of its<b=
r>
&gt;&gt;&gt;&gt; importance in production.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Neither am I.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Which machine types include this device by default?<br>
&gt;&gt; <br>
&gt;&gt; To me it looks like it&#39;s some of the ARM boards.<br>
&gt;<br>
&gt; My worry is TYPE_PCI_SDHCI (&quot;sdhci-pci&quot;):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0k-&gt;vendor_id =3D PCI_VENDOR_ID_REDHAT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0k-&gt;device_id =3D PCI_DEVICE_ID_REDHAT_SDHCI;<br>
&gt;=C2=A0 =C2=A0 =C2=A0k-&gt;class_id =3D PCI_CLASS_SYSTEM_SDHCI;<br>
&gt;<br>
&gt; config SDHCI_PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0default y if PCI_DEVICES<br>
<br>
Ah, now I remember.=C2=A0 Not the first time I wished it wouldn&#39;t exist=
...<br>
<br>
&gt;&gt;&gt; How can a non-default device be added, and to which machine ty=
pes?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I gather the fix changes device state incompatibly.=C2=A0 Alwa=
ys, or only in<br>
&gt;&gt;&gt; certain states?<br>
<br>
I think we need to answer this question.<br>
<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
I&#39;m asking because if device state remains compatible<br>
&gt;&gt;&gt; most of the time, we might be able use subsection trickery to =
keep<br>
&gt;&gt;&gt; migration working most of the time.=C2=A0 Has been done before=
, I think.<br>
<br>
</blockquote></div>

--000000000000388c9605afd7c856--


