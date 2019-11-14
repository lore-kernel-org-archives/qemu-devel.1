Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F1C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817CD206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tzf2jT9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817CD206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCdp-0004rt-K8
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iVCcY-0004Fu-QF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iVCcX-0006BB-MU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:45:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27937
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iVCcX-00069q-IJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573728300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Nt+L7AyynlHy9T0nz927XxE9rIrPjXOPM2Z4p6H8Ts=;
 b=Tzf2jT9jgOk19uY+bNZPSwCnxUAt/y86o8A337DoL/95irDcEjOuy+KiToRDjpUe6qBkma
 e+G0ufWIdugMs1Do4eqNwl8R9O9UFmHRbL9jRgNw4W2o6kvLW+EYRmj/c4snYTXMHxxxgb
 KzZ7disWeIp7DzNGCzXDCMHNCrVufK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-DuUh-PPMPimbBNl6Kza8UA-1; Thu, 14 Nov 2019 05:44:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BA70107ACE6;
 Thu, 14 Nov 2019 10:44:57 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-103.ams2.redhat.com [10.36.117.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82ADF5F762;
 Thu, 14 Nov 2019 10:44:55 +0000 (UTC)
Date: Thu, 14 Nov 2019 11:44:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC PATCH 00/18] Add qemu-storage-daemon
Message-ID: <20191114104454.GA5735@linux.fritz.box>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <45be7a0c-f6ae-5d18-7297-697311046fbd@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <45be7a0c-f6ae-5d18-7297-697311046fbd@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: DuUh-PPMPimbBNl6Kza8UA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: "mreitz@redhat.com" <mreitz@redhat.com>,
 "pkrempa@redhat.com" <pkrempa@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.10.2019 um 15:55 hat Vladimir Sementsov-Ogievskiy geschrieben:
> This reflects our idea of using qemu binary instead of qemu-img for doing
> block-layer operations offline.
>=20
> What is the practical difference between qemu-storage-daemon and starting
> qemu binary in stopped state?

If I'm doing things right, QEMU should be able to do the exact same
things as the storage daemon (and more). So functionality isn't what
makes the daemon desirable.

One point to consider is that the QEMU binary with a full system
emulator is (and has to be) relatively heavyweight compared to the
daemon.

I think libvirt once said they didn't want to use the qemu binary on the
grounds that it takes too long to start, though I'm not sure if that's
really an argument. I just did a quick test (qemu with -M none
-nodefaults -display none) and it's 30 vs. 60 ms on my laptop. I get the
same factor 2 for RSS.

More interesting is maybe the overhead in terms of binary size and
dependencies, especially if you need only either the storage daemon _or_
the QEMU binary (e.g. consider a case where the storage daemon runs in
one container and the VM in another).

Having two binaries allows to cut down the dependencies, and to some
extent also the binary size, for both binaries: The storage daemon
doesn't need anything related to system emulation, UI, network etc., and
in QEMU we can probably compile out most of the block layer then, which
gets rid of dependencies like libiscsi, librbd, libgfapi, etc.

As a bonus, this might even reduce the attack surface a little.

So yes, I agree that the storage daemon doesn't offer any functionality
that QEMU can't offer and we don't have a clear-cut requirement that
unambiguously calls for a separate storage daemon, but I still see some
advantage in having two separate binaries.

Another thing to mention is that on IRC, Stefan suggested the other day
to export block devices from the storage daemon not as vhost-user, but
using muser instead (i.e. providing a whole PCI device) and exporting
the existing virtio-blk-pci implementation. This would pull qdev and
device emulations into the storage daemon. I think that would be the
point where using the QEMU binary instead might make more sense (and
maybe compile it twice with different options if need be).

Kevin


