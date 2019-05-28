Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4967CC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FFB20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boZxlBat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FFB20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41969 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hViEJ-0005bY-Fd
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:57:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hViCW-0004Vx-9w
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hViCV-0005Ho-Fx
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:56:00 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:37288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hViCV-0005HK-Bn
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:55:59 -0400
Received: by mail-yb1-xb44.google.com with SMTP id l66so4061754ybf.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 12:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=yrqKPors1uhW/6HWX5S1WZiByGeNkXhp/tOefsty0uI=;
	b=boZxlBatYYiFC47eNGz1y4wXPzETiN14gkkQrh/aGvzkjaJ+2bCxBGL80pGe8QaC7x
	YLuxOOleY5f+bFKgeQMgTkaj+J8W3Y1jv3Ujib/+zo12xeFwd7DTI1I7d5ySA7Bhquk9
	2SZIrTNkszqNpbvePSDQPMajQbu/V70FBXYpsrgeEvnCbk6H78uAzofdllPSRt1aDec5
	cdZR4WtJRLM/fJdSEfcismSUz+ecR3OBNPrH/1/guxO+TsMFHiwy3hk4Sr3NezAmD03c
	UZ6P1SnwOYhniLbqNHnkcBHXbEi+UwKuDKnv4QOe6peXaCtD35uD48KK9qX4XnMRk88Z
	q9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=yrqKPors1uhW/6HWX5S1WZiByGeNkXhp/tOefsty0uI=;
	b=Hyr1j+LUwHRVBxHH9ZRfRY1ovephmBpIOdBIhZ1VYTdlMMFJC8Q8Lzr3szK0/SOKL+
	nox+iTCVeznwglTQtg3/a9T7SV1Pe5vCp60Wma8OnmxOE2mGAel1M0NbgfC8DAGyVgi7
	FjtuFVMl65PTqUA4//QEb9gbiLdLYEhGBmYsJ+cl2Eph+6x2emdVPrrOe9vC5S+4loYP
	ffNDiPhKBqBSGGnzOmnBCFecW87u8ufOFBX7NzhxW3GukutlEPaZ2yhccVepPCdxaRdf
	7eoe93tfHWHuytR8Q4sUYRZynV0REGEzVdv45RdiN5sg4StFPCBTY3D6XAJRCrNUr3of
	JBGA==
X-Gm-Message-State: APjAAAXUmokp7IcOVXSCbN7ZFvRdLGlePjAuSyuZ4Imr+rsmzT/K64z9
	MOk72vD6Ug8dL+xDZ9xNTRPWVqM+8KFjbwuihXI=
X-Google-Smtp-Source: APXvYqxax+LE0X28NxcW2Y5hh2AxKEcwppeK6jdtz2BakQVt2X5kp1LLGcdPYdfoQ+AXos3Iia+WUEVRKeUjhhTJoFo=
X-Received: by 2002:a25:c404:: with SMTP id u4mr59113059ybf.119.1559073358227; 
	Tue, 28 May 2019 12:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
In-Reply-To: <87lfyqla7r.fsf@dusky.pond.sub.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 28 May 2019 12:55:45 -0700
Message-ID: <CAMo8BfKKGgLnw5DxXs=1Mh3EyenyzJxait4Ds9F7d3Y7843QnA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel <qemu-devel@nongnu.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 11:12 AM Markus Armbruster <armbru@redhat.com> wrote:
> target/xtensa/helper.h
Intentional.

> target/xtensa/overlay_tool.h
Unintentional.

> target/xtensa/xtensa-isa.h
It's a one-liner that includes another header.

-- 
Thanks.
-- Max

