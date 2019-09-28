Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217FFC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 13:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41CA20815
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 13:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Kxw1YOCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41CA20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iECzg-0000kb-N2
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 09:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iECjU-0003mh-LT
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 09:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iECjS-0004Lk-UD
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 09:25:56 -0400
Received: from mout.web.de ([212.227.17.12]:37109)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iECjS-0004LF-Kp
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 09:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569677121;
 bh=JE0xCarsPskqsFMIZOt4fGVBf+d2YKIloQ/zL0UM7L4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Kxw1YOCwldhsjW7Y69/IwWiQNcidlV1o1SZS1IpfGXvvPFY6h67gS0sQ7DZTwlyfm
 eF6wCpOLquVBILSn8wonC7UhCaJuSpGm2IWfbT0TFumAzIg5CFBsB8fO9fim2Pnwh+
 ZsFB6gBKoBjz2R4IBVR/6nKv6juLRYkPnwH1BS7A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.13]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuuFh-1i5ESe1P29-0101az; Sat, 28
 Sep 2019 15:25:21 +0200
Date: Sat, 28 Sep 2019 12:44:38 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v5 3/4] net/filter.c: Add Options to insert filters
 anywhere in the filter list
Message-ID: <20190928124438.260668cf@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D780627E646@shsmsx102.ccr.corp.intel.com>
References: <cover.1568574478.git.lukasstraub2@web.de>
 <b4241e918682c83163857da3aaab5c14ec1c81f8.1568574478.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D780627E646@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1LFCUokJ9tmSntsYReejjff7sJiAhtHx9L1O6BjavtarOOIAGLQ
 /cT8g/xgq3RiEGI9SmcR36Zep/u18fiQqCldyY1LHClML28y9XQY+xhUfUp2UM1nuhuUN+H
 rM3MkH0kERffgXAE3DbJRZAyfjzPyV0CtnDzdKj2dwugjlclx/OVaOhMXmILEXfvx+W67xY
 XduPPxqU3Hctk0bvZfehQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MbJSgz41GCc=:UDsgcF7XM+hC2VJFNyrF0u
 sewhf0lA26pBG4TI6mfIOK9pCnxgbaKdYWLPaGdZzV1HHXN5mn7X+zehYGkZ2P8o4X3hd0cqB
 htcHeaZgddaoDotndsocOlKuJAi/tkqbSWLSJCSgsohtJ84kHOz6/vwwuvrusQHtu4U40F2/k
 UhnQRxPaTJA6DwqGhTV7GTMTDF0c5qKdWQpaXFQGO0zjihzGFP1V7eRYQfund/cARCvVB4Hup
 uhV4sb7C/OY7VV4seuNqBgtiObAr+UYS1B02J7ZvS8f1U+NZ0xO0aVo8KEpMzuFIXFsIhP9vy
 5uAQGTca1qXH5ZQypG4cG0ZZwJpUYed/KuYQGTVtzbfWmBqBJ++oZ502QWj6DEEHvwcovaUmP
 PILv421HOoyYz2XkylJksvhWF63q81bSscZIOSnneuJmGFCdkC9ucC65fAW0WbHLbDXV5DJkL
 741WtG1XRoy4htK/xjaCOuFiQI6A54oijilbaYzVR9cvqeZf8jDV5KNRF6aVuvbCEsoo0C9yo
 K+MrOldKMn4HknUQwb/tN4kXMUpC3qk4BwvduTD5KHSEXplza5Qh9wkOvEgDeZFcwKKm0Lles
 mltqL2I6JUcYbFA1r/FucipqKET3rHHyzQjxstk1c4HFCm7gZ2T1Gg8qMSu/XUD2FiVx7v9qf
 5lzYdNcPeHDHPjU0RdFG0VSnVAXZld08r1jK5XUom+tXtSYui1zu5BH8cQp9prp8njwB1Mgfd
 U/ZNshUcZ6LB++4u8oVpydNVNZIKcin9XL4MDgHixSPLSzk3xU8MoPSDAGXRU3OuJSnj9ARMB
 h/YFCiM/dupjNaApBsq56s4R2HleLeI2/eoVt+XVh/HggkfO40Pf0moh24baC4qlQMgbfAYqG
 TZvL+7dLcSJ6dXLEBtO4WVrhlXANrQWE6aOGpLGN3Aa8Uo0QoJiWiHwtpFOAYijzlXvCCsRWY
 97fWk3oCds6XUfBZsLPsI+0FtSnlUzO2+RidTtNf1gqLAdUHthmz6bN9nksK/WK+Lxr02zNN9
 XoPBPmHPLH1SmQIvcJaQolBAe0I/LsZQqM5mkdwe54qczuOrOZGyY4pUAaT/fidfrgKVgQi42
 Alvxchr4Wisg9MuxDQnVHsdg0sRPIKmHAKMDMH3FPIOV37o5sOvxpjX1A8lVyGO2TBrXN23Yr
 ND1LF7f4KV7uwizXOHXp3RPOGRXZIvi7ekWr+I3l+TmENTUyvsDG+IJlBuD+BuldvUNBVPvY5
 tSTtMq0j9uAe+DOfrHlnXxTAiMvmCny+FRGFal4V+bw+A6jU8i26dyCro11Y=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.12
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 17:02:58 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:
> > diff --git a/qemu-options.hx b/qemu-options.hx index
> > 08749a3391..23fa5a344e 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4368,7 +4368,7 @@ applications, they can do this through this
> > parameter. Its format is  a gnutls priority string as described at
> > @url{https://gnutls.org/manual/html_node/Priority-Strings.html}.
> >
> > -@item -object filter-
> > buffer,id=3D@var{id},netdev=3D@var{netdevid},interval=3D@var{t}[,queue=
=3D@var{
> > all|rx|tx}][,status=3D@var{on|off}]
> > +@item -object
> > +filter-buffer,id=3D@var{id},netdev=3D@var{netdevid},interval=3D@var{t=
}[,queue
> > +=3D@var{all|rx|tx}][,status=3D@var{on|off}][,position=3D@var{head|tai=
l|id=3D<id
> > +>}][,insert=3D@var{behind|before}]
> >
> >  Interval @var{t} can't be 0, this filter batches the packet delivery:=
 all  packets
> > arriving in a given interval on netdev @var{netdevid} are delayed @@ -
> > 4387,11 +4387,11 @@ queue @var{all|rx|tx} is an option that can be app=
lied
> > to any netfilter.
> >  @option{tx}: the filter is attached to the transmit queue of the netd=
ev,
> >               where it will receive packets sent by the netdev.
> >
> > -@item -object filter-
> > mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=3D@var{chardevid},=
queue
> > =3D@var{all|rx|tx}[,vnet_hdr_support]
> > +@item -object
> > +filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=3D@var{cha=
rdevid},
> > +queue=3D@var{all|rx|tx}[,vnet_hdr_support][,position=3D@var{head|tail=
|id=3D<
> > i
> > +d>}][,insert=3D@var{behind|before}]
> >
> >  filter-mirror on netdev @var{netdevid},mirror net packet to
> > chardev@var{chardevid}, if it has the vnet_hdr_support flag, filter-mi=
rror will
> > mirror packet with vnet_hdr_len.
> >
>
> Please add description for the newly added parameter in each filter.
> After that:
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
>
> Thanks
> Zhang Chen

Hi,
I will add a single description like its currently done with the "queue" o=
ption, noting that
it applies to any netfilter. Is that Ok?

Regards,
Lukas Straub

>
> > -@item -object filter-
> > redirector,id=3D@var{id},netdev=3D@var{netdevid},indev=3D@var{chardevi=
d},out
> > dev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support]
> > +@item -object
> > +filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},indev=3D@var{=
chardevi
> > +d},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support=
][,p
> > os
> > +ition=3D@var{head|tail|id=3D<id>}][,insert=3D@var{behind|before}]
> >
> >  filter-redirector on netdev @var{netdevid},redirect filter's net pack=
et to
> > chardev  @var{chardevid},and redirect indev's packet to filter.if it h=
as the
> > vnet_hdr_support flag, @@ -4400,7 +4400,7 @@ Create a filter-redirecto=
r
> > we need to differ outdev id from indev id, id can not  be the same. we=
 can
> > just use indev or outdev, but at least one of indev or outdev  need to=
 be
> > specified.
> >
> > -@item -object filter-
> > rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=3D@var{all|rx|tx}=
,[vnet_
> > hdr_support]
> > +@item -object
> > +filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=3D@var{al=
l|rx|tx}
> > +,[vnet_hdr_support][,position=3D@var{head|tail|id=3D<id>}][,insert=3D=
@var{beh
> > +ind|before}]
> >
> >  Filter-rewriter is a part of COLO project.It will rewrite tcp packet =
to
> > secondary from primary to keep secondary tcp connection,and rewrite @@=
 -
> > 4413,7 +4413,7 @@ colo secondary:
> >  -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dre=
d1
> >  -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall
> >
> > -@item -object filter-
> > dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{filename}][,maxlen=
=3D@var{
> > len}]
> > +@item -object
> > +filter-
> > dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{filename}][,maxlen=
=3D
> > +@var{len}][,position=3D@var{head|tail|id=3D<id>}][,insert=3D@var{behi=
nd|befor
> > +e}]
> >
> >  Dump the network traffic on netdev @var{dev} to the file specified by
> > @var{filename}. At most @var{len} bytes (64k by default) per packet ar=
e
> > stored.
> > --
> > 2.20.1
>


