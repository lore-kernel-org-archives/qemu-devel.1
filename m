Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB0AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D92206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D92206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCXuw-0001pW-TW
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jCXuB-0000ub-6J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jCXu8-0006Ys-DN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:10:21 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:9243 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jCXu6-0006I1-Va
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:10:19 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 21D187412
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:10:10 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BBF95A04F
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:10:09 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60C525A045
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:10:09 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:10:09 +0100 (CET)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com
 [209.85.166.177]) by smtp2 (Postfix) with ESMTPSA id 28BE07412
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:10:09 +0100 (CET)
Received: by mail-il1-f177.google.com with SMTP id d14so6718776ilq.10
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 17:10:08 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0MxJATzrAQzTBDcufiTh1K98rhb5d5axPHGXaijMS82XnP5OFC
 mP48SaF4DMJWA8GRNeGpGE+9JR6Mhf+/McRugA==
X-Google-Smtp-Source: ADFU+vvL3Ftx/Z/KNCqKfe0I3Rq9r7t6cRu0MamP5frAc7Gvuo4Ve5RXMfj9Fyg24yFkoxE8+d8+xUpstPgQmwH1JjY=
X-Received: by 2002:a05:6e02:86:: with SMTP id
 l6mr10938187ilm.22.1584058207596; 
 Thu, 12 Mar 2020 17:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200309191200.GA60@669c1c222ef4>
 <20200309192021.GD65@669c1c222ef4>
 <0d0b5735-85f0-0325-abb9-c90e4bdfc5cd@vivier.eu>
In-Reply-To: <0d0b5735-85f0-0325-abb9-c90e4bdfc5cd@vivier.eu>
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Fri, 13 Mar 2020 01:09:57 +0100
X-Gmail-Original-Message-ID: <CAGZZdDFER9Eu0O29bKcWUx4pSLE8gRaLByY0ASRTPQ3Whe1Lrw@mail.gmail.com>
Message-ID: <CAGZZdDFER9Eu0O29bKcWUx4pSLE8gRaLByY0ASRTPQ3Whe1Lrw@mail.gmail.com>
Subject: Re: [PATCH v10 04/10] qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and
 QEMU_PERSISTENT
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000c47a4005a0b14af3"
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Fri, 13 Mar 2020 01:10:09 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25288.001
X-TM-AS-Result: No--1.409-7.0-31-10
X-imss-scan-details: No--1.409-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25288.001
X-TMASE-Result: 10--1.409400-10.000000
X-TMASE-MatchedRID: DWyTxeVhwmOgBUTSh64wSUKGB4JJ2ELXgOjda/oQg4pNEfIB/J0c/ou3
 renu5Y0wxesJnMEzEallElo+yZC/3G/pirVPFAXUvHKClHGjjr2lhc243Qzx9Wjliw+xvItdFOO
 aygn1UTF1G0Py49F+F3CVOA5OEjiE0O4K4UYObiqnuuCqTEeAVAeCHewokHM/pyURDSVseYvEOb
 3Mgo89SC+we2BWmKLJm8pq/P5qixv8IGiYQaseULzgL/eLACDEAWQaZTMSP840fNYH/7Sdcqud2
 22l+s63m7kHB2bm1Nqv+BkntKx69E5diCa8ldUhJDuWzfvz/McGAD6h6FZmEdjPKewyT8Tfo8WM
 kQWv6iXoC+VlRHhOyDzv8EzJ2ohvKsmEtKMlFWagbQVmZlKXfD6BJD4r15TRvl/7TaEFZrPHB8n
 gAB/2PEjJLPe+r0+Y5iOW83GB3CpT0JhSyL/bVNgvXRlgpLvMvvna3aLRup85/5hpP58bIR0OJq
 eI0to/o3CZ5PX7Lr1uGPNHJ5mNfcb8fthkdPb8M9UwWEBAXjgXMxM9iwxfu0qn/09w3T0kU+1Yw
 Km80Y1WXGvUUmKP2w==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Fri, 13 Mar 2020 01:10:10 +0100 (CET)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
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
Reply-To: unai.martinezcorral@ehu.eus
Cc: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c47a4005a0b14af3
Content-Type: text/plain; charset="UTF-8"

2020/03/10 9:20, Laurent Vivier:

> If variable are set to 'yes', how do you force the value to no with the
> command line?
>

I believe you cannot. Do you mean the explanation should be reworded? Or
that the feature should be implemented?


> Please, refresh my memory, why do we need these variables?
> Do you have an use case?
>

See
https://patchew.org/QEMU/20190306031221.GA53@03612eec87fc/20190306044620.GC75@03612eec87fc/
I copy the relevant explanation below:

The main use case is to provide defaults when this script is included
> in a docker container. There are three actors involved:
>
> - Developers of QEMU providing some defaults in the script.
> - Developer of a docker image including the script from upstream but
> changing some defaults by setting envvars inside the container.
> - User of the container that might want to override the settings
> either by setting the envvars or through the command line.
>
> If the entrypoint to the docker image is any script that executes
> qemu-binfmt-conf.sh at some point, the user cannot provide options
> through the command line. Envvars allow to do so, without requiring
> the user to customize the docker image.

--000000000000c47a4005a0b14af3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">2020/03/10 9:20, Laurent Vivier:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
If variable are set to &#39;yes&#39;, how do you force the value to no with=
 the<br>
command line?<br></blockquote><div><br></div><div>I believe you cannot. Do =
you mean the explanation should be reworded? Or that the feature should be =
implemented? <br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">

Please, refresh my memory, why do we need these variables?<br>
Do you have an use case?<br></blockquote><div><br></div><div>See <a href=3D=
"https://patchew.org/QEMU/20190306031221.GA53@03612eec87fc/20190306044620.G=
C75@03612eec87fc/">https://patchew.org/QEMU/20190306031221.GA53@03612eec87f=
c/20190306044620.GC75@03612eec87fc/</a> I copy the relevant explanation bel=
ow:<br><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The main use c=
ase is to provide defaults when this script is included<br>in a docker cont=
ainer. There are three actors involved:<br><br>- Developers of QEMU providi=
ng some defaults in the script.<br>- Developer of a docker image including =
the script from upstream but<br>changing some defaults by setting envvars i=
nside the container.<br>- User of the container that might want to override=
 the settings<br>either by setting the envvars or through the command line.=
<br><br>If the entrypoint to the docker image is any script that executes<b=
r>qemu-binfmt-conf.sh at some point, the user cannot provide options<br>thr=
ough the command line. Envvars allow to do so, without requiring<br>the use=
r to customize the docker image.</blockquote></div><br></div></div>

--000000000000c47a4005a0b14af3--


