Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DC5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C992176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1PK7SC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C992176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaczV-0006hO-Bg
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iacl4-0005i0-NR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iacks-00060N-Oz
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:40:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37554
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iackr-0005nP-KN
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575020399;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEi63xphGA0hDHE99c1lbTzYSPufT+CNiHr6UJwxBtM=;
 b=Y1PK7SC5WtZJwldtd8x3bz8xKDRGP+HXfHmzDfmyzhTAlq/BD6aW7zQB6XG0lwuQMXAb0e
 mKADcOKi5puuYY8LIyJfTYCj3a9eBqbW+XR2O97JK69NBQamFqtyLk/QQdtec1cZ/Nvzz7
 Wt2Mnh5+tAb0bXtvQ/GymG94QIg/6BI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-Yrfb_ilDNeyUFGTe4a4Gtg-1; Fri, 29 Nov 2019 04:39:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 003D1107ACC4;
 Fri, 29 Nov 2019 09:39:55 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.ams2.redhat.com [10.36.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B09AF60BF1;
 Fri, 29 Nov 2019 09:39:44 +0000 (UTC)
Date: Fri, 29 Nov 2019 09:39:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129093941.GD2260471@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
 <20191129092713.GA2260471@redhat.com>
 <6b441014-1852-3257-2bc5-897cc51d08dc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6b441014-1852-3257-2bc5-897cc51d08dc@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Yrfb_ilDNeyUFGTe4a4Gtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 10:33:39AM +0100, Paolo Bonzini wrote:
> On 29/11/19 10:27, Daniel P. Berrang=C3=A9 wrote:
> >> Yes, with a fallback path currently using a temporary file under /tmp
> >> (we may want to use shm_open() instead, or a different location such
> >> as XDG_RUNTIME_DIR? - and use O_TMPFILE)
> > We can't assume either /tmp or XDG_RUNTIME_DIR is on tmpfs as that is n=
o
> > where near standard across all OS distros, and even if on tmpfs these
> > dirs can be size limited to a significant subset of available RAM. IOW
> > we can't safely use them unless explicitly told to.
>=20
> Agreed, mkstemp+shm_open seems better.  Perhaps this could be done in
> hostmem-memfd.c though, basically as a fallback option?  In principle
> one could even use getmntent to search for a hugetlbfs mount.

With mkstemp you still need to pick a location, and I don't think it
is clear there is a reliable choice that will always work.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


