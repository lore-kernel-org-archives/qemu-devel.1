Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D735CC2D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A761F20772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="zryV+PLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A761F20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJD5a-0007yr-PJ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ilg@livius.net>) id 1jJD4J-00076Y-8N
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ilg@livius.net>) id 1jJD4A-0000jV-Br
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:20:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ilg@livius.net>) id 1jJD49-0000g7-BU
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:20:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id j19so1733340wmi.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=0DlHeLuEnRavkorEiD4EUkZMTVIflXOgnQ3kXkSM9UQ=;
 b=zryV+PLhfEzpb9xQYnQN6ojG0sDqkNTBnqGGa6lC4ai1gWJ/+Q5me9ae2etvdUupLD
 JuJO+/BZANTtPZ5y/wKROaqI5QVf0Jq1orQM3GXyRd41fzyRuckKEULqLJrxs5inABLO
 ss51JrNAizGcQIwI5ESKEjQR1EOkOjepuxvaZjEZDYEYFv3EClmkw/SusWTgP+fbxjA9
 JNnHRWRj7w7esC+CBv41yetW8QMYkVju0E6gghxvWXbvdWcjxXlFgFTtxIzbKZOIw++w
 R6Ou6Vlo/JCkmrIoFePcKGHVDXu/cORomktdwkFYrdtCFXO2c0zp3N+bJLEPT2xXy/t6
 8vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=0DlHeLuEnRavkorEiD4EUkZMTVIflXOgnQ3kXkSM9UQ=;
 b=rh62/bC1+Et/KK4nPl0PT76jsLZxKnD9i6H1Rxjw2p1qPbD8Q2WJcfo5mzhp5Slid2
 WrTbX/BSF3yGBMcXBr/Y5pNhsH0M+OaJsUvGDw0yWUX5aQQlR7MjMc7waxzLIt4eajCf
 EH2Tq0svPZI/1o7FewrIQ7NYaOFxOi24pw0fQtjcCaFAiZCMXVRvmNdP7N4rAlSI9m+A
 j1kAW6jpTpMdlNfN69ms9u8iWdb8kj1jmQEI2qxWvSNaKEdMHnxfJHlK+Pm6UH4wYDjt
 NY7+MAoFVClDOCJdTFND6GSqQubBnVGJBOIrIgC82rNoKjKEEgGuD+dl8epCGaqva+VW
 njfA==
X-Gm-Message-State: ANhLgQ2yEABTH5sDPDQ3DFr4q8hun++/zDJto9pGZHSu3L7gWewTw3lV
 10GM1Z7e2aRpsV6MqTgvTf+hkQ==
X-Google-Smtp-Source: ADFU+vuUUwfDchGMhdmCcj2quWx38tFUjqjL9wVoqiox86g/cyrW83FFaKSTGXk6UNAaCf6zaZ4bUw==
X-Received: by 2002:a05:600c:d4:: with SMTP id
 u20mr2577708wmm.83.1585646411800; 
 Tue, 31 Mar 2020 02:20:11 -0700 (PDT)
Received: from wks.local (5-12-53-142.residential.rdsnet.ro. [5.12.53.142])
 by smtp.gmail.com with ESMTPSA id x18sm19686929wrr.2.2020.03.31.02.20.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 02:20:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: deprecation of in-tree builds
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
Date: Tue, 31 Mar 2020 12:20:08 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D490715-F32F-4A34-A31F-5709B28FB6CA@livius.net>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 31 Mar 2020, at 10:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 30/03/20 16:37, Kevin Wolf wrote:
>> If manually dealing with separate build directories is inconvenient
>> today,

It may be for some, but it isn't for all, perhaps we should not =
generalise and get the wrong conclusions.

In the xPack Build Box (a set of Docker images) that I use for the =
binary xPack builds, I probably have some tens of libraries and tools, =
and most of them use separate build folders, no problem with this.

With these docker images I build, on the same 64-bit linux machine, =
multi-platform QEMU binaries (and other complicated things like =
toolchains), and for them I use separate build folders for each target =
platform (win32, win64, linux32, linux64) and a common source folder.

>> it will still be inconvenient with Meson, so this would mean
>> introducing the automatic directly creation together with the other
>> changes to enable Meson. Which is fine by me, as long as it is really
>> done when the external directory becomes mandatory, so that people =
won't
>> have to switch back and forth between directories.
>=20
> Serious question: why is automatic directly creation more convenient =
for
> developers?

For my use case it isn't, automatic creation will break my folder =
structure and I'll not be able to use the common source folder and =
multiple target build folders structure that I use now.

>  Even if "./configure" generates a "build" directory for
> you, you would still have to invoke the QEMU binary as
> "build/x86_64-softmmu/qemu-system-x86_64".  That is less convenient =
than
> doing "mkdir build" in the first place.

I agree, if 'build' can be anywhere, not necessarily inside the source =
tree.

I just tested, and meson creates the build folder where it is instructed =
to, it can be inside or outside the source folder, so I think that the =
QEMU build procedure should preserve his freedom, and not enforced the =
use of a specific folder, otherwise performing multi-platform builds =
will be more complicated than necessary.


Regards,

Liviu




