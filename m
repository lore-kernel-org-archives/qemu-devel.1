Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C9CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BC720882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="av/rAq3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BC720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYXh-0003y6-Lq
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMYWb-00036p-VR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMYWa-000767-C1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:19:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMYWa-00075M-8O
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571667546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5nMpbBIffQ/iD0SBQwlgw0kmEnA+C+KMLdxfTAHeH4=;
 b=av/rAq3YEpSjIuZyL0IZLfTnprgrfBoHcJgVhLFszE/9wdVGeTUolfs3as4pREJYf4ovLs
 bUdXvfaRbeGhr7wwbwnO6LlISOUQySLgaOuBe+5LKSOOw2Xpg9zjse4PA0hkrse3E9929+
 bJDD0PRkVZitZd/YoN5NClg5YBC/2ns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-h8DNFhvKNi6IJNpmx13Zeg-1; Mon, 21 Oct 2019 10:19:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE7347B;
 Mon, 21 Oct 2019 14:19:04 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2936E60A9F;
 Mon, 21 Oct 2019 14:18:52 +0000 (UTC)
Date: Mon, 21 Oct 2019 16:18:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v4 0/11] add failover feature for assigned network devices
Message-ID: <20191021161850.78413ad7.cohuck@redhat.com>
In-Reply-To: <20191018202040.30349-1-jfreimann@redhat.com>
References: <20191018202040.30349-1-jfreimann@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: h8DNFhvKNi6IJNpmx13Zeg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 22:20:29 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> This is implementing the host side of the net_failover concept
> (https://www.kernel.org/doc/html/latest/networking/net_failover.html)

(...)

> Jens Freimann (10):
>   qdev/qbus: add hidden device support
>   pci: mark devices partially unplugged
>   pci: mark device having guest unplug request pending
>   qapi: add unplug primary event
>   qapi: add failover negotiated event
>   migration: allow unplug during migration for failover devices
>   migration: add new migration state wait-unplug
>   libqos: tolerate wait-unplug migration state
>   net/virtio: add failover support
>   vfio: unplug failover primary device before migration

I have looked over the patches I have not commented on directly as
well, and they look sane to me (i.e. I didn't spot any obvious
problems). Feel free to add my ack if you like.


