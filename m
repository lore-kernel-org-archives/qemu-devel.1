Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E71BC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46887206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzuMPSeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46887206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkbd-0006i8-DD
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTkWP-0007Xw-Mp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTkWP-0001dK-3F
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:04:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTkWO-0001ZS-JU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158295;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kEdDZCE5W4RBJoVhlV+T141TNUFbAtbpjRtzu9HYug=;
 b=NzuMPSeCo1nzI2sPyjKMDxNDn5K4irxmFQhISnp4/944SgLW6YTj8/zOeZakxqrT5f6UHs
 i7o7RT4A+ZDeBrYwT862Ep7nd0J2Rw1G0AJ7H/B1ga3jP09MVVnZ3PmYj4E1Ktu9a6QL50
 4rZunN4k0NYrvrVftV34LPEDF57fNoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-00TpTLR8MveCbZkrHOSXwQ-1; Wed, 29 Apr 2020 07:04:48 -0400
X-MC-Unique: 00TpTLR8MveCbZkrHOSXwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 673BE100944F
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:04:40 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 448875D781;
 Wed, 29 Apr 2020 11:04:35 +0000 (UTC)
Date: Wed, 29 Apr 2020 12:04:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 00/12] audio: deprecate -soundhw
Message-ID: <20200429110431.GE1495129@redhat.com>
References: <20200429110214.29037-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200429110214.29037-1-kraxel@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 01:02:02PM +0200, Gerd Hoffmann wrote:
>  include/hw/audio/soundhw.h |  2 ++
>  hw/audio/ac97.c            |  9 ++-------
>  hw/audio/adlib.c           |  8 +-------
>  hw/audio/cs4231a.c         |  8 +-------
>  hw/audio/es1370.c          |  9 ++-------
>  hw/audio/gus.c             |  8 +-------
>  hw/audio/intel-hda.c       |  3 +++
>  hw/audio/pcspk.c           | 27 ++++++++++++++++++++++++---
>  hw/audio/sb16.c            |  9 ++-------
>  hw/audio/soundhw.c         | 24 +++++++++++++++++++++++-
>  qdev-monitor.c             |  2 ++
>  stubs/isa-bus.c            |  7 +++++++
>  stubs/pci-bus.c            |  7 +++++++
>  stubs/Makefile.objs        |  2 ++

There should also be an addition to docs/system/deprecated.rst to point
users to the suggested replacement syntax.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


