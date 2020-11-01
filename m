Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 08:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935C52084C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 08:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYP0IWQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935C52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZ8iZ-0007gF-GU
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 03:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZ8hh-0007EO-UQ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 03:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZ8he-00047M-15
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 03:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604219223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/WUruQliqyOc4k+HPFnKp2cbo8DwvekRC+ZDNYfNCTg=;
 b=SYP0IWQHsWX3l5VwfJJ9czXEewZEdNsPywAg9IoCN5C//x8RyNGH+16AGTkbA3O6v/kkvj
 27IoRoBUN61bhRzRuXfn/OuLIAF+S0+1yfHL+vRqeELlPcy6V56HnIhcvorD9uth8w79+w
 vvzpfYvgcVt10eSrwP9PiKqn8GrJh5U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-9ml9FBgzPPKq0A5YvY_nXg-1; Sun, 01 Nov 2020 03:26:59 -0500
X-MC-Unique: 9ml9FBgzPPKq0A5YvY_nXg-1
Received: by mail-pj1-f72.google.com with SMTP id r1so1863074pjp.5
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 01:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/WUruQliqyOc4k+HPFnKp2cbo8DwvekRC+ZDNYfNCTg=;
 b=jjAcmhHehMJdbf9FaUycFM6m4DGtFWNvx7H/ixwNkx+AfhJd8WqUI3RYWKNbB+YnTh
 MXIFxVRd76v+UoUHb17Q03cdV56KP5pXSoRe7Qmd/xxGcsz60XAMNSYX1smOeFsQQg9A
 uLHEgLC6ZzFZhVx+p0lNwUe539SrN46j1hIdL9djwConLGrDfk8JUIXvg+/mrZtNe9fl
 s0lurCz2yc9Ki6t9vAWHR+YXdpKESgdyB4GOsGzTAzMMRtLYbX+IC4eSOLx3AoU/WMlH
 l745FWO8oiAix+3iNsc/kYoPuMuxHvZsshCzErZWYJicqnttfoSmS4ga/47ndZYjVCR3
 Cs6A==
X-Gm-Message-State: AOAM531EJNl9u2AoNIjh2yyPVNXwiK3KVjQd7mBSp68+1TDyUVKVGGRd
 T8pIC/TKukYKmLzY/X1nOHvLQpEHmiZYwJzBooUeXXBSjimOswJn2D6GeEdG7IgLNGBLW/Flril
 gc9EEd7oXKLTbcNqY+/c+/M8BiKtCVR4=
X-Received: by 2002:a17:90b:608:: with SMTP id
 gb8mr11773061pjb.6.1604219218046; 
 Sun, 01 Nov 2020 01:26:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0Al/8p3s8md2jGUyZsdsHsE3Xb4aE8SF+yuwkmwWSsPAENxTY8YRkIg0Ax9AUEUdQV4LpJMYpPRTn8G/LsD0=
X-Received: by 2002:a17:90b:608:: with SMTP id
 gb8mr11773019pjb.6.1604219217734; 
 Sun, 01 Nov 2020 01:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
 <20201029083130.0617a28f@w520.home>
 <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
 <20201031174726-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201031174726-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 1 Nov 2020 09:26:45 +0100
Message-ID: <CABgObfYGQ-a1rAkniq5qhrOtx=Ufdto=nLysW0_CFUQhcrZr3Q@mail.gmail.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000009d8a2905b3076428"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 03:27:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Yan Vugenfirer <yan@daynix.com>,
 Jag Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009d8a2905b3076428
Content-Type: text/plain; charset="UTF-8"

Il sab 31 ott 2020, 22:49 Michael S. Tsirkin <mst@redhat.com> ha scritto:

> > > I still don't get why it must be opaque.
> >
> > If the device state format needs to be in the VMM then each device
> > needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc).
>
> And QEMU cares why exactly?
>

QEMU cares for another reason. It is more code to review, and it's worth
spending the time to reviewing it only if we can do a decent job at
reviewing it.

There are several cases in which drivers migrate non-architectural,
implementation-dependent state. There are some examples in nested
virtualization (the deadline of the VMX preemption timer) or device
emulation (the RTC has quite a few example also of how those changed
through the years). We probably don't have anyway the knowledge of the
innards of the drivers to do a decent job at reviewing patches that affect
those.

> Let's invert the question: why does the VMM need to understand the
> > device state of a _passthrough_ device?
>
> To support cross version migration and compatibility checks.
>

That doesn't have to be in the VMM. We should give guidance but that can be
in terms of documentation. Also, in QEMU we chose the path of dropping
sections on the source when migrating to older versions, but that can also
be considered a deficiency of vmstate---a self-synchronizing format
(Anthony many years ago wanted to use X509 as the migration format) would
be much better. And for some specific device types we could define standard
formats, just like PCI has standard classes.

Paolo

>
This problem is harder than it appears, I don't think vendors
> will do a good job of it without any guidance and standards.
>
> --
> MST
>
>

--0000000000009d8a2905b3076428
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 31 ott 2020, 22:49 Michael S. Tsirkin &lt;<a hr=
ef=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; ha scritto:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">&gt; &gt; I still don&#39;t get why it must be=
 opaque.<br>
&gt; <br>
&gt; If the device state format needs to be in the VMM then each device<br>
&gt; needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc).<b=
r>
<br>
And QEMU cares why exactly?<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">QEMU cares for another reason. It is more code t=
o review, and it&#39;s worth spending the time to reviewing it only if we c=
an do a decent job at reviewing it.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">There are several cases in which drivers migrate non-architectu=
ral, implementation-dependent state. There are some examples in nested virt=
ualization (the deadline of the VMX preemption timer) or device emulation (=
the RTC has quite a few example also of how those changed through the years=
). We<span style=3D"font-family:sans-serif">=C2=A0probably don&#39;t have a=
nyway the knowledge of the innards of the drivers to do a decent job at rev=
iewing patches that affect those.</span></div><div dir=3D"auto"><span style=
=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">&gt; Let&#39;s invert the q=
uestion: why does the VMM need to understand the<br>
&gt; device state of a _passthrough_ device?<br>
<br>
To support cross version migration and compatibility checks.<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That doesn&#39;=
t have to be in the VMM. We should give guidance but that can be in terms o=
f documentation. Also, in QEMU we chose the path of dropping sections on th=
e source when migrating to older versions, but that can also be considered =
a deficiency of vmstate---a self-synchronizing format (Anthony many years a=
go wanted to use X509 as the migration format) would be much better. And fo=
r some specific device types we could define standard formats, just like PC=
I has standard classes.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Paolo</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
This problem is harder than it appears, I don&#39;t think vendors<br>
will do a good job of it without any guidance and standards.<br>
<br>
-- <br>
MST<br>
<br>
</blockquote></div></div></div>

--0000000000009d8a2905b3076428--


