Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB6C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB92C2075B
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB92C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUvfu-0000WE-Lu
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 12:07:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1hUvf2-0000Bh-Gs
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1hUvf0-0000Yn-Ir
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:06:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>)
	id 1hUvez-0000WZ-FP; Sun, 26 May 2019 12:06:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so14468666wrv.2;
	Sun, 26 May 2019 09:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=s+HOWzVFr+YI1vj7VTZk1D1a+uKRsGbT224LaJuZNaM=;
	b=S/cxG77Cj1duiNYzY4QwoOKz2W+FRFgdimzKI4Kqz6qC3YNqnIQ9Eq9fIO3C7veT7K
	UfLIQK1XM5XDd9JUigvD849Akh41H/WW4q2exDCGXNjEVB1oS6nICg8NgqbuXszz+lSZ
	CAZiEpWzLkOmgt1RysTa0L7GdVIM98dtAE33NNYVjU2ZbgczgqHJAkANGchIeDUUWYYV
	8EHrKvMH0736hLLniQkM7VrZFZ5pS/b2NtsAm1x8mJynL+O+G4dQXJ+ppZtxbWBW11GA
	zy1RV5+bipMLHQMy+p9P1a6u/OJlz4lt3uTVsd3RUHYS5+k0A5aC5bwFIN2RieMlTcMR
	X2Cg==
X-Gm-Message-State: APjAAAWbbWoKp9LSpnhbj7o9bksAoer4VCPnK+srTwSm0J5n0CSqto/O
	B16Xy/+mHTTMe7O0GMeRZK0=
X-Google-Smtp-Source: APXvYqxO3x+ygRgd53DluD91rr6L5j87U63t2Meq8EthyuODjrhddkk49bhn9PwEkjYHpa7NP1sQwQ==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr1954848wrn.244.1558886765827; 
	Sun, 26 May 2019 09:06:05 -0700 (PDT)
Received: from thl530.multi.box (pD9E8362E.dip0.t-ipconnect.de.
	[217.232.54.46]) by smtp.gmail.com with ESMTPSA id
	m10sm11816176wmf.40.2019.05.26.09.06.03
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 26 May 2019 09:06:04 -0700 (PDT)
Date: Sun, 26 May 2019 18:05:44 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190526180544.1426817a@thl530.multi.box>
In-Reply-To: <20190525225013.13916-2-laurent@vivier.eu>
References: <20190525225013.13916-1-laurent@vivier.eu>
	<20190525225013.13916-2-laurent@vivier.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v7 01/10] escc: introduce a selector for
 the register bit
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau
	<marcandre.lureau@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Sun, 26 May 2019 00:50:04 +0200
schrieb Laurent Vivier <laurent@vivier.eu>:

> On Sparc and PowerMac, the bit 0 of the address
> selects the register type (control or data) and
> bit 1 selects the channel (B or A).
>=20
> On m68k Macintosh, the bit 0 selects the channel and
> bit 1 the register type.
>=20
> This patch introduces a new parameter (bit_swap) to
> the device interface to indicate bits usage must
> be swapped between registers and channels.
>=20
> For the moment all the machines use the bit 0,
> but this change will be needed to emulate Quadra 800.
>=20
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  hw/char/escc.c         | 30 ++++++++++++++++++++++++------
>  include/hw/char/escc.h |  1 +
>  2 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

