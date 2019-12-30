Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DB7C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 15:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA87D20718
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 15:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7SrG0GZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA87D20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilxIb-0007qn-3b
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 10:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1ilxHr-0007As-Dm
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 10:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1ilxHp-0005jc-0N
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 10:48:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ilxHo-0005jD-TY
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 10:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577720932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eie/6KGuYr/9B08JptfZ0j1vbtpHyZvG/k91jGibVJI=;
 b=U7SrG0GZRALE9LI+quLHuM/1NPTegvkCuBNBq9M/1U1tpTo038WDe+8J7amnudxQ9E+M8k
 ApJ72Ab05Wkc5dsb54wUxQYqS9q49t8c3H+H3AUBLv+9qvYT1UTrXFZBJpXOwafUs0YR28
 /IoibORBlHh8JZrwX3MmeUcamhv1fw4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-CMj512INNXK9EYtxMNAFtw-1; Mon, 30 Dec 2019 10:48:50 -0500
Received: by mail-wr1-f69.google.com with SMTP id z10so13646689wrt.21
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 07:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eie/6KGuYr/9B08JptfZ0j1vbtpHyZvG/k91jGibVJI=;
 b=l5oJjc3EaWIKDCSFKZkRaH2xtbtzMWsGM8aEcB4X5zP0maHk+x3eMPNh/k9XN8/bmq
 1uMZ3fwcjYHRG4GJKRgji0Xr6TTGEffnqWaMjipOWD21DbtSkKd+AO/McMs5pzwAFlW6
 1Iw/Q7cBG2y/9c3ZXVMlhcy2ff0HSuvtNSV8aNqE50dXYe1Lz6Mp2Z3P8R/9usykoO68
 v2lLIyC3bHHypYF4tglA4k2faX7uq2o+S89ZKTrLyP7oIuJLVHDDgM/u1KsHJi5xtS3h
 5OfMAWmcR4Cltz2daJyp7xoBF7Hy3iaCQqdfXy+q0I1MR2gqae+m0eu+aWSYsEXcZP6Z
 Q3QA==
X-Gm-Message-State: APjAAAV5Y5htSXf3MQ70JY2DbTD6JuI9MoJO/FbsmitogtFYEOPTGrqb
 H4udsnFmoLkxkjwWS3Wz5rrO/xbeGVNuI3KHhyYYlYF1tjG51uQzjFuc0waQMMiG4OB/XTKIqvU
 xPv2sQboXmo5s6327xclKsORB4zmwW6k=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr65711257wro.195.1577720929472; 
 Mon, 30 Dec 2019 07:48:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3CnY+as7x2kI0Y6CBZEeBLW/sV1Fr9aas6dYnp/Xbl2nb3n59pazc3GXJTotgX7e+xWtVEzEAKTxk0ILTwPE=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr65711205wro.195.1577720929179; 
 Mon, 30 Dec 2019 07:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20191230090900.446-1-philmd@redhat.com>
 <20191230090900.446-2-philmd@redhat.com>
 <273bf2e5-1223-3d01-f930-394195c037e4@weilnetz.de>
 <64c2434d-3b2b-1a3e-5358-e4b5acfbe8e8@redhat.com>
 <CABgObfYahQbbteCAsMfKAYjPLDUpGJExO9mWyRw15mm=VWHsbQ@mail.gmail.com>
 <cd2746d2-8f88-2012-def9-dfce47d8e764@redhat.com>
In-Reply-To: <cd2746d2-8f88-2012-def9-dfce47d8e764@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 30 Dec 2019 16:48:38 +0100
Message-ID: <CAP+75-WjOfJeFooQnrhC8y73dCWrfJbHhtYUG3LzZRxpbhTwCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tcg: Search includes from the project root source
 directory
To: Paolo Bonzini <pbonzini@redhat.com>
X-MC-Unique: CMj512INNXK9EYtxMNAFtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 30, 2019 at 3:02 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 12/30/19 11:33 AM, Paolo Bonzini wrote:
> > Il lun 30 dic 2019, 09:59 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m
> > <mailto:philmd@redhat.com>> ha scritto:
> >
> >      > I'd prefer not changing those files.
> >
> >     OK, I'll wait to see what Richard/Markus prefer.
> >
> >
> > I think it's best if you keep the include directives as-is for files
> > only needed from tcg/, and move the other headers (those that are neede=
d
> > from other directories only) to include/tcg.

Assuming we don't want to add include/tcg/ in the path search list, we
still need to update the tcg/*.c include directives to use "tcg/":

tcg/tcg-op-gvec.c:21:10: fatal error: tcg.h: No such file or directory
   21 | #include "tcg.h"
      |          ^~~~~~~
compilation terminated.
make[1]: *** [rules.mak:69: tcg/tcg-op-gvec.o] Error 1
make[1]: *** Waiting for unfinished jobs....
  CC      mips64el-softmmu/accel/tcg/translate-all.o
tcg/optimize.c:27:10: fatal error: tcg-op.h: No such file or directory
   27 | #include "tcg-op.h"
      |          ^~~~~~~~~~
compilation terminated.
make[1]: *** [rules.mak:69: tcg/optimize.o] Error 1
tcg/tcg-op-vec.c:22:10: fatal error: tcg.h: No such file or directory
   22 | #include "tcg.h"
      |          ^~~~~~~
compilation terminated.
make[1]: *** [rules.mak:69: tcg/tcg-op-vec.o] Error 1
tcg/tcg-common.c:35:10: fatal error: tcg-opc.h: No such file or directory
   35 | #include "tcg-opc.h"
      |          ^~~~~~~~~~~
compilation terminated.
make[1]: *** [rules.mak:69: tcg/tcg-common.o] Error 1
tcg/tcg-op.c:28:10: fatal error: tcg.h: No such file or directory
   28 | #include "tcg.h"
      |          ^~~~~~~
compilation terminated.
make[1]: *** [rules.mak:69: tcg/tcg-op.o] Error 1
tcg/tcg.c:51:10: fatal error: tcg-op.h: No such file or directory
   51 | #include "tcg-op.h"
      |          ^~~~~~~~~~
compilation terminated.

> I thought moving headers to include/tcg would diverge too much from
> libtcg, but this project already did it, so why not:
> https://github.com/S2E/libtcg/tree/master/include/tcg


