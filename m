Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE37CC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8378B21537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8378B21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hklUs-0001G0-Rk
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 04:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59611)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1hklTA-0000Ju-Of
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1hklT3-0007s8-BI
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:27:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hklT2-0007bN-CA
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:27:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so19093304oth.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 01:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bMzUduVpP5qjHbpPTjte1O9TxF81ynAEZbzsOtiZHYY=;
 b=QfYU8SCxhEqFqjukCRcLo2KluL1TqfUhgOqXqIg4sOiGwKrewwimI6aN0WFFLWTuUm
 PPgjj7Z7HOaxwf6Ai6yF7fxVtwKOLgQu5GC9mI6P5mIT0L9NircF5NKdp2fcSDykO3y9
 xoOoF8aie5TlZrNQ00EVbPe9ahHFiyIHBR5WKIIkDpaJbM1NgM/xCwQr1SJ1DTpFWwiM
 aTvqRFXxTYLZfPCL+Q69z6SW4OFRgtn/a4hcYPn1MoH3wijQzKac5eSG1dPQYyBvJWka
 Ay62/z+EzOuCw1dx9NWFJNrPaFz5LdRvbkaU7p29kBQjnHoeGIBXZsm1PpQ0OdJkN0k0
 uw7w==
X-Gm-Message-State: APjAAAUI4bpCMrp3ITiJiMwxVQ344v0wMFj557HsXy1BzLOQX6vymTj8
 1eZ6+fAfTQDFhw2AV2FCjodzW0UyeddZEZINaL4Z0g==
X-Google-Smtp-Source: APXvYqyX+WvST/tcbwAmb9G5xZvfVNlbCp7b6FJ8i++zydv9exdR0NqrqysEgYJIctXG6A0U0h1oEEQGNZRZcU6qgPk=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr17192474otq.38.1562660809714; 
 Tue, 09 Jul 2019 01:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708160442.GL3082@redhat.com>
In-Reply-To: <20190708160442.GL3082@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 9 Jul 2019 12:26:38 +0400
Message-ID: <CAMxuvaxih_D9HLRnRxhNweux3LsOsxCxzYn6VY748sJx0w8KSQ@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [PATCH 0/3] Add dbus-vmstate
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Jul 8, 2019 at 8:04 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> > The D-Bus protocol can be made to work peer-to-peer, but the most
> > common and practical way is through a bus daemon. This also has the
> > advantage of increased debuggability (you can eavesdrop on the bus and
> > introspect it).
>
> The downside of using the bus daemon is that we have to spawn a new
> instance of dbus-daemon for every QEMU VM that's running on the host,
> which is yet more memory overhead for each VM & another process to
> manage, and yet another thing to go wrong.

dbus-daemon (or dbus-broker) has been optimized to fit on many devices
and use cases, it doesn't take much memory (3mb for my session dbus
right now).

More processes to manage is inevitable. In a near future, we may have
5-10 processes running around qemu. I think dbus-daemon will be one of
the easiest to deal with. (as can be seen in the dbus-vmstate test, it
is very simple to start a private dbus-daemon)

>
> QEMU already has a direct UNIX socket connection to the helper
> processes in question. I'd much rather we just had another direct
> UNIX socket  connection to that helper, using D-Bus peer-to-peer.
> The benefit of debugging doesn't feel compelling enough to justify
> running an extra daemon for each VM.

I wouldn't minor the need for easier debugging. Debugging multiple
processes talking to each other is really hard. Having a bus is
awesome (if not required) in this case.

There are other advantages of using a bus, those come to my mind:

- less connections (bus topology)
- configuring/enforcing policies & limits
- on-demand service activation & discoverability

I also think D-Bus is the IPC of choice for multi-process. It's easier
to use than many other IPC due to the various tools and language
bindings available. Having a common bus is a good incentive to use a
common IPC, instead of a dozen of half-baked protocols.

Nevertheless, I also think we could use D-Bus in peer-to-peer mode,
and I did some investigation. The slirp-helper supports it. We could
teach dbus-vmstate to eastablish peer-to-peer connections. Instead of
receiving a bus address and list of Ids, it could have a list of dbus
peer socket path. Both approaches are not incompatible, but I think
the bus benefits outweigh the downside of running an extra process.

