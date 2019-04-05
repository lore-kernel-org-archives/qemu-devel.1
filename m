Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EFBC282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 20:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E126F2146F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 20:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e62E2X4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E126F2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46595 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCVbO-0006OM-Tq
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 16:38:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hCVaB-0005bN-2j
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hCVa4-0008Qt-0h
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:36:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>)
	id 1hCVa2-0008Ef-A6; Fri, 05 Apr 2019 16:36:55 -0400
Received: by mail-oi1-x242.google.com with SMTP id a6so5963215oie.5;
	Fri, 05 Apr 2019 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
	:cc:references:message-id:user-agent:subject:date;
	bh=PdOjsXFT2Y6C0eEcpP8n5BQLDDgaY+5Qbs1GnN/K9n4=;
	b=e62E2X4KmXfFdimfg5twCWmjqkBw5KzmwMnAE3PkW2lpTGEHxUqI4D3pHXq+SPXMro
	iyXlTVIon/EobhLBk7Jby+2nVVqxvDIhqXL9jgqtp/OnFSdsCZLVC0WulzEi/6uArz72
	0W2W67vlizUMlJZSptBxzaLkv3n4oPr8udjAIgQwBM/8G/zpdrhBFkvAfFBd9C2SDvMm
	z55fr2nkytJGu4cRiafx05wAQf2r6/yPZlreR4t+YoPiXr0aezTywNnS1oGPAdo34u/t
	2atH4lMfEOLLjPPCUhGCVlisH+8X6hn+kFcFBEuLWvtpJZ0NVuml810ndmwLp2gfM/wO
	nWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
	:from:in-reply-to:cc:references:message-id:user-agent:subject:date;
	bh=PdOjsXFT2Y6C0eEcpP8n5BQLDDgaY+5Qbs1GnN/K9n4=;
	b=hWiK5W7m0LRw83m7zy+DJuzcGIBhfzlXKEel9WY5D8IHarAJ6t8ix1cgs8reRTLBQ/
	DEqN7IS0KQEb98BDxSHMuXEkQ57ASuZWEOU+F3OCuMq3PS0cgUsPr/q9oOuCYpO1XOOx
	elmFR5crLBHRoIsDuh/+Xq5CCLQAkl4fTSqHHpQClMa8iOafouXHwIGrXWik8wB1rcJH
	FVd7gMpSzlKy1m9m6X1eO/+ruJ4yQnP2tcbY0ohYi783bpXUuqe4mtJmPf57/H4O4wRI
	jOWPiOxgM6XThazxIU1WQaqE2lcsJepD/WLy+13dUAKLRQQJtH56Io8cLpt2AEOATHx4
	vGkA==
X-Gm-Message-State: APjAAAW1TMwN6veS7DJp3mqDv8k2q6reC3QoSnvB0eWGiihIyjZXdHl1
	3jKHKd7ShXpEq2bFyVZf9Z0=
X-Google-Smtp-Source: APXvYqxTU+ZyAJSTnDl7rf48YOmkk/kSbTj8gEX2qKf0i8KGudev/a8/Lz71shrmhIUzHmIn0Te39g==
X-Received: by 2002:aca:db83:: with SMTP id s125mr7906530oig.61.1554496142070; 
	Fri, 05 Apr 2019 13:29:02 -0700 (PDT)
Received: from localhost (cpe-173-174-75-230.austin.res.rr.com.
	[173.174.75.230]) by smtp.gmail.com with ESMTPSA id
	x202sm9152114oix.54.2019.04.05.13.29.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 13:29:01 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <ce68c2dc-857a-aff0-0fb7-a8e48e921c54@redhat.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
	<ce68c2dc-857a-aff0-0fb7-a8e48e921c54@redhat.com>
Message-ID: <155449613359.3739.8673708328232350625@sif>
User-Agent: alot/0.7
Date: Fri, 05 Apr 2019 15:28:53 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 00/97] Patch Round-up for stable 3.0.1,
 freeze on 2019-04-08
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
Cc: Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Michael Tokarev <mjt@tls.msk.ru>, Peter Lieven <pl@kamp.de>,
	qemu-stable@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405202853.jvV4RtxpG-67zfJW2Gv1IpZCT7uwjc_CsWSdS-kdA6g@z>

Quoting Philippe Mathieu-Daud=C3=A9 (2019-04-04 17:31:31)
> On 4/1/19 10:58 PM, Michael Roth wrote:
> > Hi everyone,                                                           =
                                   =

> > =

> > The following new patches are queued for QEMU stable v3.0.1:
> > =

> >   https://github.com/mdroth/qemu/commits/stable-3.0-staging
> > =

> > The release is planned for 2019-04-11:
> > =

> >   https://wiki.qemu.org/Planning/3.0
...
> =

> I'm not sure about 4c257911dcc7c4189768e9651755c849ce9db4e8
> "i386: remove the 'INTEL_PT' CPUID bit from named CPU models"

AFAICT this was only enabled by default via Icelake-*, Cascadelake-Server
models, which are only in 3.1+. I have it queued for 3.1.1 though.

> =

> What about 334c43e2c342e878311c66b4e62343f0a7c2c6be?
> "qemu-img: fix error reporting for -object"

Looks like this fixes a regression introduced in 3.1 with 7e1e0c11, I'll
make sure to queue it for 3.1.1 though.

> =

> Also ade0075523478fa015afd5c6f6cc70681687818d:
> "contrib/rdmacm-mux: Fix out-of-bounds risk"

Fixes regression introduced in 4.0 with a5d2f6f8773

> =

> And 3fd2092fd11b9e4220a08eca0663cc59178a6c3f:
> "hw/usb: fix mistaken de-initialization of CCID state"


Fixes regression introduced in 4.0 with 7dea29e4

> =

> Eventually:
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00843.html
> "megasas: fix mapped frame size"

Hopefully it makes it in by rc3 next week, otherwise we'd need to delay
3.0.1 to pick it up. Will keep it eye on it.

Thanks for the suggestions!

> =

> Regards,
> =

> Phil.
>=20

