Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB2C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5019221556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drHCmRTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5019221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGhn-000540-7Y
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1kaGbd-00005e-Al
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:05:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1kaGbb-0007Mb-EY
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604487930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0j216KX2d+fBUVjhfXxyP8fMfgnefI70Gvr45Qdo2Ao=;
 b=drHCmRTM2Tdbrr1iqmhcmTrK+aN4dGr4IuB5grFek8NFUeZg8/T1JjPN4/c0DIr98g6tCM
 KaJPoyPwTtkhMM4qZTZnSJGDiU71wiBWOj2YHoxowIdb2PFlFvg1WMBN9HrsBMxLt61bhd
 OibZZmg8oNpD6iEto9Oc9W2r/lFZ7oo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-tae0kDAJMVG-hsI7QBkKKQ-1; Wed, 04 Nov 2020 06:05:26 -0500
X-MC-Unique: tae0kDAJMVG-hsI7QBkKKQ-1
Received: by mail-wm1-f69.google.com with SMTP id t21so507522wmt.8
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=WRdqu6s286mRbd/74N0o4Sd4xNQt/nzJ9T5ydhYRBpY=;
 b=R3RB79H27a+U7hPDMPj/pTpFvOF0r2E6mfRj8wqGtaoCT876lMkhXAOeRzA+sk+zas
 bEaQh4sRr7yBfyaklS9wwVibscfezv9I2LF7r5vf5oM8FA9TNgg6S0KV/dHIGlSPn0op
 rqvPrBW/Wv4Z+THfHv9qhL1fvh7HTKIvwAG7lm2YjWzPHMki8hdvEXKAi/oak3u8QY6r
 iw3imo3Jj9X/sUt6F/NO/SJh7K+X4HLouFOmuEu8qOHK5W0BOaGlAjb4Zrf5PVb1sGeI
 SwbXx4WmdLe8NMsudG6of+J07ITajgBV/r1/19je6cKH3wmU6Zf0IugmHhnB8RcMu3t5
 f4jg==
X-Gm-Message-State: AOAM532AYCC5GxViBXNBdb97Y8OU5/6HeWWLg9QKcUprfY5KyvxO924R
 H432nnrjyFwR6FUkHQC5dK80WclV7z/sfrEJ1SXmrTUIbQYJnRPlOGitdBHUNBryrU6+zcGFnrq
 k2YDbTj8Xl32QN2I=
X-Received: by 2002:a5d:69d1:: with SMTP id s17mr31787537wrw.77.1604487924746; 
 Wed, 04 Nov 2020 03:05:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPXJfJv9YnHKeGxzwvoxpTy5Rlhm1ymbPULz8u4n8ULFQUDEiP7sA3QCu1FxQ5488XqxgaPg==
X-Received: by 2002:a5d:69d1:: with SMTP id s17mr31787496wrw.77.1604487924459; 
 Wed, 04 Nov 2020 03:05:24 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:8ce9:a0d5:3af2:7f0f?
 ([2a01:e0a:466:71c0:8ce9:a0d5:3af2:7f0f])
 by smtp.gmail.com with ESMTPSA id t11sm1722910wmf.35.2020.11.04.03.05.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Nov 2020 03:05:23 -0800 (PST)
From: Christophe de Dinechin <cdupontd@redhat.com>
Message-Id: <1254BB01-E5A3-468D-A423-838EC0DCE302@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: VFIO Migration
Date: Wed, 4 Nov 2020 12:05:21 +0100
In-Reply-To: <20201103184951.GM3566@work-vm>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103121709.GD3566@work-vm>
 <20201103152752.GC253848@stefanha-x1.localdomain>
 <20201103184951.GM3566@work-vm>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cdupontd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_5A40B49A-8545-4E0E-8734-461136A82EBD"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cdupontd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 BALATON Zoltan via <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Apple-Mail=_5A40B49A-8545-4E0E-8734-461136A82EBD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 3 Nov 2020, at 19:49, Dr. David Alan Gilbert <dgilbert@redhat.com> wro=
te:
>=20
> * Stefan Hajnoczi (stefanha@redhat.com <mailto:stefanha@redhat.com>) wrot=
e:
>> On Tue, Nov 03, 2020 at 12:17:09PM +0000, Dr. David Alan Gilbert wrote:
>>> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
>>>> Device Models
>>>> -------------
>>>> Devices have a *hardware interface* consisting of hardware registers,
>>>> interrupts, and so on.
>>>>=20
>>>> The hardware interface together with the device state representation i=
s called
>>>> a *device model*. Device models can be assigned URIs such as
>>>> https://qemu.org/devices/e1000e to uniquely identify them.
>>>=20
>>> I think this is a unique identifier, not actually a URI; the https://
>>> isn't needed since no one expects to ever connect to this.
>>=20
>> Yes, it could be any unique string. If the URI idea is not popular we
>> can use any similar scheme.
>=20
> I'm OK with it being a URI; just drop the https.

I completely agree. https gives the wrong idea about what this represents. =
Unless you give it https semantics, by requiring a doc or a schema or whate=
ver to be at the URL, but then you enter another universe of cans of worms.



--Apple-Mail=_5A40B49A-8545-4E0E-8734-461136A82EBD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode=
: space; line-break: after-white-space;" class=3D""><br class=3D""><div><br=
 class=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On 3 Nov 2=
020, at 19:49, Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat=
.com" class=3D"">dgilbert@redhat.com</a>&gt; wrote:</div><br class=3D"Apple=
-interchange-newline"><div class=3D""><span style=3D"caret-color: rgb(0, 0,=
 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-vari=
ant-caps: normal; font-weight: normal; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: n=
one; display: inline !important;" class=3D"">* Stefan Hajnoczi (</span><a h=
ref=3D"mailto:stefanha@redhat.com" style=3D"font-family: Helvetica; font-si=
ze: 18px; font-style: normal; font-variant-caps: normal; font-weight: norma=
l; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" class=
=3D"">stefanha@redhat.com</a><span style=3D"caret-color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps:=
 normal; font-weight: normal; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; disp=
lay: inline !important;" class=3D"">) wrote:</span><br style=3D"caret-color=
: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal=
; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; t=
ext-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: non=
e;" class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; f=
ont-size: 18px; font-style: normal; font-variant-caps: normal; font-weight:=
 normal; letter-spacing: normal; orphans: auto; text-align: start; text-ind=
ent: 0px; text-transform: none; white-space: normal; widows: auto; word-spa=
cing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">On Tue, Nov 03, 2020 at 12:17:09PM +0000=
, Dr. David Alan Gilbert wrote:<br class=3D""><blockquote type=3D"cite" cla=
ss=3D"">* Stefan Hajnoczi (<a href=3D"mailto:stefanha@redhat.com" class=3D"=
">stefanha@redhat.com</a>) wrote:<br class=3D""><blockquote type=3D"cite" c=
lass=3D"">Device Models<br class=3D"">-------------<br class=3D"">Devices h=
ave a *hardware interface* consisting of hardware registers,<br class=3D"">=
interrupts, and so on.<br class=3D""><br class=3D"">The hardware interface =
together with the device state representation is called<br class=3D"">a *de=
vice model*. Device models can be assigned URIs such as<br class=3D""><a hr=
ef=3D"https://qemu.org/devices/e1000e" class=3D"">https://qemu.org/devices/=
e1000e</a> to uniquely identify them.<br class=3D""></blockquote><br class=
=3D"">I think this is a unique identifier, not actually a URI; the https://=
<br class=3D"">isn't needed since no one expects to ever connect to this.<b=
r class=3D""></blockquote><br class=3D"">Yes, it could be any unique string=
. If the URI idea is not popular we<br class=3D"">can use any similar schem=
e.<br class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-=
family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px=
; font-style: normal; font-variant-caps: normal; font-weight: normal; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" class=3D""=
>I'm OK with it being a URI; just drop the https.</span><br style=3D"caret-=
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: n=
ormal; font-variant-caps: normal; font-weight: normal; letter-spacing: norm=
al; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D""></div></blockquote><div><br class=3D""></div><div>I com=
pletely agree. https gives the wrong idea about what this represents. Unles=
s you give it https semantics, by requiring a doc or a schema or whatever t=
o be at the URL, but then you enter another universe of cans of worms.</div=
><br class=3D""></div><br class=3D""></body></html>
--Apple-Mail=_5A40B49A-8545-4E0E-8734-461136A82EBD--


