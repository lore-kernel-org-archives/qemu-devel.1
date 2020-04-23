Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F09BC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E352D2087E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN1Qf+/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E352D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcak-0003e7-36
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRcZZ-000394-6B
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRcZW-00083c-Di
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:11:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRcZV-0007vi-Ti
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587651080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/JwLv7qTwZXb7WOzHZf4Qay65ANMY13MybZa5aupOw=;
 b=RN1Qf+/ct+X2poB/T9dTsEuPv1lHFk6j2zdvYgQNvIQ1ByFy+co68QAChlnkfIgqdRTpJi
 qwib1h6jjnJJasoTBEowLIu8d0rqNs8dETmEVx+8pvNdJaMOrJRLoEl9AlVuxj91YgC184
 8bKAm0Qjp7FUkc3X5eZGH47nh2xFF2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-fOBYjE2fM1ey-LYIUmAmXg-1; Thu, 23 Apr 2020 10:11:17 -0400
X-MC-Unique: fOBYjE2fM1ey-LYIUmAmXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46B13A0BDA;
 Thu, 23 Apr 2020 14:11:16 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07B6726324;
 Thu, 23 Apr 2020 14:11:14 +0000 (UTC)
Date: Thu, 23 Apr 2020 15:11:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dan Christian <dchristian@cardinalpeak.com>
Subject: Re: Need BT support in qemu for Zephyr
Message-ID: <20200423141112.GE1077680@redhat.com>
References: <CADxL6wUGWZO0U=G7UTAebG57m6tG58hoMf_-TCC+0qReUB0G6w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADxL6wUGWZO0U=G7UTAebG57m6tG58hoMf_-TCC+0qReUB0G6w@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 07:33:37AM -0600, Dan Christian wrote:
> There was a note about BT support being deprecated.
>=20
> Having it makes developing/testing Zephyr
> <https://github.com/zephyrproject-rtos/zephyr> bluetooth vastly easier.
>=20
> I hope it will be retained.

Unfortunately it has already been deleted and so will be gone in the 5.0
release of QEMU for certain. In theory it could be brought back to life
in future releases, but it would require someone to step forward as an
active maintainer and fix the problems it had.

The big driving reason for deleting it was that it appeared to be largely
broken / crashing as explained in the commit removing it:

commit 1d4ffe8dc77cbc9aafe8bcf514ca0e43f85aaae3
Author: Thomas Huth <thuth@redhat.com>
Date:   Wed Nov 20 10:10:13 2019 +0100

    Remove the core bluetooth code
   =20
    It's been deprecated since QEMU v3.1. We've explicitly asked in the
    deprecation message that people should speak up on qemu-devel in case
    they are still actively using the bluetooth part of QEMU, but nobody
    ever replied that they are really still using it.
   =20
    I've tried it on my own to use this bluetooth subsystem for one of my
    guests, but I was also not able to get it running anymore: When I was
    trying to pass-through a real bluetooth device, either the guest did
    not see the device at all, or the guest crashed.
   =20
    Even worse for the emulated device: When running
   =20
     qemu-system-x86_64 -bt device:keyboard
   =20
    QEMU crashes once you hit a key.
   =20
    So it seems like the bluetooth stack is not only neglected, it is
    completely bitrotten, as far as I can tell. The only attention that
    this code got during the past years were some CVEs that have been
    spotted there. So this code is a burden for the developers, without
    any real benefit anymore. Time to remove it.
   =20
    Note: hw/bt/Kconfig only gets cleared but not removed here yet.
    Otherwise there is a problem with the *-softmmu/config-devices.mak.d
    dependency files - they still contain a reference to this file which
    gets evaluated first on some build hosts, before the file gets
    properly recreated. To avoid breaking these builders, we still need
    the file around for some time. It will get removed in a couple of
    weeks instead.
   =20
    Message-Id: <20191120091014.16883-4-thuth@redhat.com>
    Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
    Acked-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Thomas Huth <thuth@redhat.com>


Can you give more details about what specific QEMU configuration you are
using with Bluetooth - eg what QEMU command line args are you passing
and how functional was the result? Also what QEMU versions have you
succesfully used BT with ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


