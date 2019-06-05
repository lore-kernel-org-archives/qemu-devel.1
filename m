Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4CC28D18
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5FC2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFaGiDsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5FC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50137 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYdBm-0008Qy-RG
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:11:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hYctn-00029i-TC
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hYctm-0002nH-CB
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:52:43 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hYctm-0000Re-1F
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:52:42 -0400
Received: by mail-lf1-x144.google.com with SMTP id r15so20121583lfm.11
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1Hz16CjSVKI9mJnkn1KnvjIQu9ifaRY9cU/IZVUlwNU=;
	b=DFaGiDsJPCZHPSW5WRa15aA6TkjjxYnuUYh+ZaAanOY/RGmUCtRzHoTvwpi8Tpi7ok
	csv1RIHnED1e9RQ6rx3PQN3s8b+9JAf8Tp8Br+VpACsH1gkg+JaWLH3GJt+BBqxs02bu
	ZNHwii7Rt7SABHnyl7duVdww/8FlIMvAvJZxNOA6szqzTlOHLnfr4m4/FqkEsUjWHnI6
	6kybgCbfHs8r8v96/Rfl0i6NKfbtihguG1sG0e+Mz5oF9jv2QLbpgxTtFnKAM3+PMuxR
	IlXJWmlqaX/sQ2R7K7UOHziyl1K5X8NNMzFCfkGDj2dDT4kjGWnRfJaEcP8KAylNVYSb
	SxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1Hz16CjSVKI9mJnkn1KnvjIQu9ifaRY9cU/IZVUlwNU=;
	b=XDEH34wU96FFdDJ5FZCkb/HKxo9gFyIszjJa7clQRK5f3bKnJrso+gax7VuuIjbUKq
	3ZfYFHr3MABqa9im1L9HvG2nJZJUVMgxeP+THqlv/Lu5d3r0dwDs9x4o6R4gUmNElNyZ
	GrJPwcHwOdp8uksvMPmoNGECUkIQI0KW4I1XFtj2+1A1w6ejHBd+Tn+nGE9jx1CfPY1U
	oOdIRKree2QnAbTliKscrWlKsDlOOvxgqx/Pz1U/MQ1irdf+B+1huO2XxpALheaE8gGY
	pJJZnq/J4ml/194KhegcZpJElknRiugU/d9gRrBSbe8ea7hNfDtJQWd0tKOn6QPYTIBx
	UlsA==
X-Gm-Message-State: APjAAAV/Z+0ikISA/f8aOPUJU78KPFApDrjqxoUDCk56vWJXvEUdwzLZ
	v9vtl9xikJU5FMPOao5iPgi4tJcs/SPrPdehWPk=
X-Google-Smtp-Source: APXvYqynYKhryBu6X7B1rsR4QbD0PBAMuj5DyvqhC/LfRcieddq+/mKdvDk62gtyNMH3tpoM0bmlMMrMwddfRzUiGFs=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr19769994lfu.141.1559767938080; 
	Wed, 05 Jun 2019 13:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
In-Reply-To: <87lfyqla7r.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2019 13:49:44 -0700
Message-ID: <CAKmqyKMWRS0Duz2DFw0nwtBPSdj04AMWod-c4sXu_Jc-N3+4Qg@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 11:13 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> We have a bunch of headers without multiple inclusion guards.  Some are
> clearly intentional, some look accidental.  Too many for me to find out
> by examining each of them, so I'm asking their maintainers.
>
> Why do I ask?  I'd like to mark the intentional ones and fix the
> accidental ones, so they don't flunk "make check-headers" from "[RFC v4
> 0/7] Baby steps towards saner headers" just because they lack multiple
> inclusion guards.
>

Sorry for the delay I have been on holidays. I think the ARM ones have
all been covered by Peter, here is some info on the RISC-V includes.

....

> linux-user/riscv/sockbits.h
> linux-user/riscv/syscall_nr.h
> linux-user/riscv/target_syscall.h
> linux-user/riscv/termbits.h

I'm not sure here, it looks like all targets have the same guards, so
just follow what the others do here.

....

> target/riscv/cpu_bits.h
> target/riscv/cpu_user.h

These should have guards

> target/riscv/helper.h

Intentional

> target/riscv/instmap.h

I think this should have a guard.

Alistair

