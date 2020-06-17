Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E4CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DF0207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxlDHK0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DF0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTHU-0007zY-Ir
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jlTGo-0007Mt-BZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:18:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jlTGm-00033M-GN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592381883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Px744DndY9wwKp/ozOVoIy+mjVVo2Z5y/J7LxdWbTkI=;
 b=RxlDHK0nPaWpyxE6ROLhuWGlM/1+3T3xSCjXF4//Ku856d260SRLWzB27WJNowDV/8oGbq
 L4KM8u+S/Z+YbewVWLfS3+gHuy/NklOGMDAXSciToPHGV15cQcpcmY0vaPArIj225wV0Ju
 5qqOfz6oWgIMv+NC0WcZUVWCUF21Gbc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-En8Rya06MvS1FI7NaGGLeQ-1; Wed, 17 Jun 2020 04:18:00 -0400
X-MC-Unique: En8Rya06MvS1FI7NaGGLeQ-1
Received: by mail-wr1-f71.google.com with SMTP id n6so659979wrv.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 01:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=bpmCr662YF4Ib7TmzcOLdv1o2cu8DQmvdyKM2I2becA=;
 b=nfae8MObC8DxPLsYpJuTbdtIzPDypqcMuGnWGjG5uEsTSEVrhNpZiHsap4M/6RmcGs
 SQxUVLhT8aKZzH9H6IFaWcvn/DExOm5zUdHj0jATKs+SejjD5/ldGa2kzI3nT4sjOgvv
 yQyoxvCwK9+Zu7P3nQd2qkucVzGdIEC+ELtGvr4rt9uv9YLLKKxP7jcOsvAhWexmI7kD
 vDKGee++1bG0G0fThrXYymA0sUF2OezqxMEcchudAVYJnR2wPwox0qBWAT4vtaaSGIyC
 dLcRzlHdd/YT1/k2hjyaN9Cx7YLfOgIOxj+c+Ebxiv+MzzoKlyLET23hqnnLyzzXIXRa
 KU4w==
X-Gm-Message-State: AOAM5334/tfaHptRwI81/fOjph872Cw6mXIdT9qqvnSaBhMTjNIqXPXV
 zuW3krqJhZ874vz7btThprDvGqXAqHzvDf3rDUYelj/4GiehP3qd6Y65hWHGw41xkwbTHdV/2Af
 OewKRYcvQnKVDrtc=
X-Received: by 2002:a7b:c090:: with SMTP id r16mr7670201wmh.105.1592381878856; 
 Wed, 17 Jun 2020 01:17:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrlr0uY0igqpA4U2ShpkqjaM8QGKEhXdFUQi0UqB3BE5I/rcFNJOPfOAhKdnTSKG/AHakk1A==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr7670176wmh.105.1592381878566; 
 Wed, 17 Jun 2020 01:17:58 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:466:71c0:703f:24ee:3c57:e184?
 ([2a01:e0a:466:71c0:703f:24ee:3c57:e184])
 by smtp.gmail.com with ESMTPSA id v7sm5815129wrp.45.2020.06.17.01.17.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jun 2020 01:17:58 -0700 (PDT)
From: Christophe de Dinechin <cdupontd@redhat.com>
Message-Id: <56BCFEC0-DEEF-46A9-9BC4-8A75ABD158CF@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
Date: Wed, 17 Jun 2020 10:17:55 +0200
In-Reply-To: <20200616171021.GV2366737@habkost.net>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm> <20200616171021.GV2366737@habkost.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_12CD78C0-16CE-40CF-8F46-CE5829A775C8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cdupontd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pedro.principeza@canonical.com, dann.frazier@canonical.com,
 "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 christian.ehrhardt@canonical.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, lersek@redhat.com, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Apple-Mail=_12CD78C0-16CE-40CF-8F46-CE5829A775C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> Le 16 Jun 2020 =C3=A0 19:10, Eduardo Habkost <ehabkost@redhat.com> a =C3=
=A9crit :
>=20
> On Tue, Jun 16, 2020 at 05:57:46PM +0100, Dr. David Alan Gilbert wrote:
>> * Gerd Hoffmann (kraxel@redhat.com) wrote:
>>>  Hi,
>>>=20
>>>> (a) We could rely in the guest physbits to calculate the PCI64 apertur=
e.
>>>=20
>>> I'd love to do that.  Move the 64-bit I/O window as high as possible an=
d
>>> use -- say -- 25% of the physical address space for it.
>>>=20
>>> Problem is we can't.
>>>=20
>>>> failure. Also, if the users are not setting the physbits in the guest,
>>>> there must be a default (seems to be 40bit according to my experiments=
),
>>>> seems to be a good idea to rely on that.
>>>=20
>>> Yes, 40 is the default, and it is used *even if the host supports less
>>> than that*.  Typical values I've seen for intel hardware are 36 and 39.
>>> 39 is used even by recent hardware (not the xeons, but check out a
>>> laptop or a nuc).
>>>=20
>>>> If guest physbits is 40, why to have OVMF limiting it to 36, right?
>>>=20
>>> Things will explode in case OVMF uses more physbits than the host
>>> supports (host physbits limit applies to ept too).  In other words: OVM=
F
>>> can't trust the guest physbits, so it is conservative to be on the safe
>>> side.
>>>=20
>>> If we can somehow make a *trustable* physbits value available to the
>>> guest, then yes, we can go that route.  But the guest physbits we have
>>> today unfortunately don't cut it.
>>=20
>> In downstream RH qemu, we run with host-physbits as default; so it's rea=
sonably
>> trustworthy; of course that doesn't help you across a migration between
>> hosts with different sizes (e.g. an E5 Xeon to an E3).
>> Changing upstream to do the same would seem sensible to me, but it's not
>> a foolproof config.
>=20
> Yeah, to make it really trustworthy we would need to prevent
> migration to hosts with mismatching phys sizes.

Wouldn't it be sufficient to prevent guestphysbits > hostphysbits?

>  We would need to
> communicate that to the guest somehow (with new hypervisor CPUID
> flags, maybe).
>=20
> --=20
> Eduardo


--Apple-Mail=_12CD78C0-16CE-40CF-8F46-CE5829A775C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D""><br class=3D""><div><br cl=
ass=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">Le 16 Jun 202=
0 =C3=A0 19:10, Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" =
class=3D"">ehabkost@redhat.com</a>&gt; a =C3=A9crit :</div><br class=3D"App=
le-interchange-newline"><div class=3D""><span style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-va=
riant-caps: normal; font-weight: normal; letter-spacing: normal; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float:=
 none; display: inline !important;" class=3D"">On Tue, Jun 16, 2020 at 05:5=
7:46PM +0100, Dr. David Alan Gilbert wrote:</span><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none=
;" class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; fo=
nt-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; text-inde=
nt: 0px; text-transform: none; white-space: normal; widows: auto; word-spac=
ing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; t=
ext-decoration: none;" class=3D"">* Gerd Hoffmann (<a href=3D"mailto:kraxel=
@redhat.com" class=3D"">kraxel@redhat.com</a>) wrote:<br class=3D""><blockq=
uote type=3D"cite" class=3D"">&nbsp;Hi,<br class=3D""><br class=3D""><block=
quote type=3D"cite" class=3D"">(a) We could rely in the guest physbits to c=
alculate the PCI64 aperture.<br class=3D""></blockquote><br class=3D"">I'd =
love to do that. &nbsp;Move the 64-bit I/O window as high as possible and<b=
r class=3D"">use -- say -- 25% of the physical address space for it.<br cla=
ss=3D""><br class=3D"">Problem is we can't.<br class=3D""><br class=3D""><b=
lockquote type=3D"cite" class=3D"">failure. Also, if the users are not sett=
ing the physbits in the guest,<br class=3D"">there must be a default (seems=
 to be 40bit according to my experiments),<br class=3D"">seems to be a good=
 idea to rely on that.<br class=3D""></blockquote><br class=3D"">Yes, 40 is=
 the default, and it is used *even if the host supports less<br class=3D"">=
than that*. &nbsp;Typical values I've seen for intel hardware are 36 and 39=
.<br class=3D"">39 is used even by recent hardware (not the xeons, but chec=
k out a<br class=3D"">laptop or a nuc).<br class=3D""><br class=3D""><block=
quote type=3D"cite" class=3D"">If guest physbits is 40, why to have OVMF li=
miting it to 36, right?<br class=3D""></blockquote><br class=3D"">Things wi=
ll explode in case OVMF uses more physbits than the host<br class=3D"">supp=
orts (host physbits limit applies to ept too). &nbsp;In other words: OVMF<b=
r class=3D"">can't trust the guest physbits, so it is conservative to be on=
 the safe<br class=3D"">side.<br class=3D""><br class=3D"">If we can someho=
w make a *trustable* physbits value available to the<br class=3D"">guest, t=
hen yes, we can go that route. &nbsp;But the guest physbits we have<br clas=
s=3D"">today unfortunately don't cut it.<br class=3D""></blockquote><br cla=
ss=3D"">In downstream RH qemu, we run with host-physbits as default; so it'=
s reasonably<br class=3D"">trustworthy; of course that doesn't help you acr=
oss a migration between<br class=3D"">hosts with different sizes (e.g. an E=
5 Xeon to an E3).<br class=3D"">Changing upstream to do the same would seem=
 sensible to me, but it's not<br class=3D"">a foolproof config.<br class=3D=
""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvet=
ica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-w=
eight: normal; letter-spacing: normal; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text=
-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret=
-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: nor=
mal; text-align: start; text-indent: 0px; text-transform: none; white-space=
: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoratio=
n: none; float: none; display: inline !important;" class=3D"">Yeah, to make=
 it really trustworthy we would need to prevent</span><br style=3D"caret-co=
lor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: He=
lvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: normal; letter-spacing: normal; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; text-decoration: none; float: none; display: inline=
 !important;" class=3D"">migration to hosts with mismatching phys sizes.</s=
pan></div></blockquote><div><br class=3D""></div><div>Wouldn't it be suffic=
ient to prevent guestphysbits &gt; hostphysbits?</div><br class=3D""><block=
quote type=3D"cite" class=3D""><div class=3D""><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;=
 float: none; display: inline !important;" class=3D""> &nbsp;We would need =
to</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fo=
nt-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal;=
 font-variant-caps: normal; font-weight: normal; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none=
; float: none; display: inline !important;" class=3D"">communicate that to =
the guest somehow (with new hypervisor CPUID</span><br style=3D"caret-color=
: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal=
; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; t=
ext-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: non=
e;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helve=
tica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-=
weight: normal; letter-spacing: normal; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none; float: none; display: inline !i=
mportant;" class=3D"">flags, maybe).</span><br style=3D"caret-color: rgb(0,=
 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-v=
ariant-caps: normal; font-weight: normal; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" clas=
s=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font=
-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: no=
rmal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tra=
nsform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: r=
gb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; f=
ont-variant-caps: normal; font-weight: normal; letter-spacing: normal; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; =
float: none; display: inline !important;" class=3D"">--<span class=3D"Apple=
-converted-space">&nbsp;</span></span><br style=3D"caret-color: rgb(0, 0, 0=
); font-family: Helvetica; font-size: 18px; font-style: normal; font-varian=
t-caps: normal; font-weight: normal; letter-spacing: normal; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; word-spac=
ing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"=
"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-si=
ze: 18px; font-style: normal; font-variant-caps: normal; font-weight: norma=
l; letter-spacing: normal; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-widt=
h: 0px; text-decoration: none; float: none; display: inline !important;" cl=
ass=3D"">Eduardo</span></div></blockquote></div><br class=3D""></body></htm=
l>
--Apple-Mail=_12CD78C0-16CE-40CF-8F46-CE5829A775C8--


