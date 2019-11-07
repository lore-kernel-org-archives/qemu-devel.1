Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB657C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752452085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxsYAwsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752452085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSf90-0006LR-I1
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 05:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iSf7K-0005bD-7o
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iSf7I-00047a-GY
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:34:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31502
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iSf7I-00043j-Cg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573122855;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJnX6daviaLSWKOQAWeTsdo/NmIC1/8gt5xIkGpYGZU=;
 b=RxsYAwsEabW9edCTwZ52GvDRLdWzjW2pZfnEPLnO8PJ2MvVjdZGD4iSX/KRQAu2qyRsUTl
 5lwl6RbKDF+6cDWWWI+lc7xYCo4eBGm52ysj7goik1XOL8ks+WB50ILv3NsYw6dO+PvcOW
 bMvzaJpkyTKjwxqqMnji/2rVcf9iILA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-VG8srFWMOoa0IzWrLdDrEw-1; Thu, 07 Nov 2019 05:34:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5F41800C61;
 Thu,  7 Nov 2019 10:34:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E02D5D6D8;
 Thu,  7 Nov 2019 10:33:59 +0000 (UTC)
Date: Thu, 7 Nov 2019 10:33:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 00/18] Add qemu-storage-daemon
Message-ID: <20191107103357.GB120292@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: VG8srFWMOoa0IzWrLdDrEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 03:01:46PM +0200, Kevin Wolf wrote:
> This series adds a new tool 'qemu-storage-daemon', which can be used to
> export and perform operations on block devices. There is some overlap
> between qemu-img/qemu-nbd and the new qemu-storage-daemon, but there are
> a few important differences:
>=20
> * The qemu-storage-daemon has QMP support. The command set is obviously
>   restricted compared to the system emulator because there is no guest,
>   but all of the block operations are present.
>=20
>   This means that it can access advanced options or operations that the
>   qemu-img command line doesn't expose. For example, blockdev-create is
>   a lot more powerful than 'qemu-img create', and qemu-storage-daemon
>   allows to execute it without starting a guest.
>=20
>   Compared to qemu-nbd it means that, for example, block jobs can now be
>   executed on the server side, and backing chains shared by multiple VMs
>   can be modified this way.
>=20
> * The existing tools all have a separately invented one-off syntax for
>   the job at hand, which usually comes with restrictions compared to the
>   system emulator. qemu-storage-daemon shares the same syntax with the
>   system emulator for most options and prefers QAPI based interfaces
>   where possible (such as --blockdev), so it should be easy to make use
>   of in libvirt.
>=20
> * While this series implements only NBD exports, the storage daemon is
>   intended to serve multiple protocols and its syntax reflects this. In
>   the past, we had proposals to add new one-off tools for exporting over
>   new protocols like FUSE or TCMU.
>=20
>   With a generic storage daemon, additional export methods have a home
>   without adding a new tool for each of them.
>=20
> I'm posting this as an RFC mainly for two reasons:
>=20
> 1. The monitor integration, which could be argued to be a little hackish
>    (some generated QAPI source files are built from a separate QAPI
>    schema, but the per-module ones are taken from the system emulator)
>    and Markus will want to have a closer look there. But from the IRC
>    discussions we had, we seem to agree on the general approach here.
>=20
> 2. I'm not completely sure if the command line syntax is the final
>    version that we want to support long-term. Many options directly use
>    QAPI visitors (--blockdev, --export, --nbd-server) and should be
>    fine. However, others use QemuOpts (--chardev, --monitor, --object).
>=20
>    This is the same as in the system emulator, so we wouldn't be adding
>    a new problem, but as there was talk about QAPIfying the command
>    line, and I wouldn't want later syntax changes or adding lots of
>    compatibility code to a new tool, I thought we should probably
>    discuss whether QAPIfying from the start would be an option.

I think that following what the QEMU emulators currently do for
CLI args should be an explicit anti-goal, because we know that it is
a long standing source of pain.  Fixing it in the emulator binaries
is hard due to backward compatibility, but for this new binary we
have a clean slate.

This feels like a good opportunity to implement & demonstrate what
we think QEMU configuration ought to look like. Work done for this
in the qemu-storage-daemon may well help us understand how we'll
be able to move the QEMU emulators into a new scheme later.

My personal wish would be to have no use of QemuOpts at all.

Use GOptionContext *only* for parsing command line arguments
related to execution of the daemon - ie things like --help,
--version, --daemon, --pid-file.

The use a "--config /path/to/json/file" arg to point to the config
file for everything else using QAPI schema to describe it fully.

When loading the config file, things should be created in order
in which they are specified. ie don't try and group things,
otherwise we end up back with the horrific hacks for objects
where some are created early & some late.



For an ambitious stretch goal, I think we should seriously consider
whether our use of chardevs is appropriate in all cases that exist,
and whether we can avoid the trap of over-using chardev in the new
storage daemon since it is a clean slate in terms of user facing
CLI config.

chardevs are designed for & reasonably well suited to attaching to
devices like serial ports, parallel ports, etc. You have a 1:1
remote:local peer relationship. The transport is a dumb byte
stream, nothing special needed on top & the user can cope with
any type of chardev.

Many cases where we've used chardevs as a backend in QEMU are a
poor fit. We just used chardevs as an "easy" way to configure a
UNIX or TCP socket from the CLI, and don't care about, nor work
with, any othuer chardev backends. As a result of this misuse
we've had to put in an increasing number of hacks in the chardev
code to deal with fact that callers want to know about  & use
socket semantics. eg FD passing, the chardev reconnection polling
code.

The monitor is a prime example of a bad fit - it would be better
suited by simply referencing a SocketAddress QAPI type, instead
of having the chardev indirection. It would then directly use
the QIOChannelSocket APIs and avoid the inconvenient chardev
abstractions which are a source of complexity & instability for
no net gain.  vhostuser is another prime example, responsible
for much of the complexity & bugs recently added to chardevs
to expose socket semantics


This is a long winded way of saying that we should consider what
syntax we expose for the monitor socket configuration with the
new daemon. Even if the internal code still uses a chardev for
the forseeable future, we have the option to hide this from the
user facing configuration. Let the user specify a SocketAddress,
which we use to secretly instantiate a chardev. Eventually we can
convert the monitor code to stop using a chardev internally too,
with a suitable deprecation period for main QEMU binarijes.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


