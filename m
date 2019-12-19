Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4A8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB74221D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlfuLowz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB74221D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihrAy-0000SV-SV
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 03:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihrAG-00084t-Lr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 03:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihrAF-0000wX-LZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 03:28:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihrAF-0000tn-G0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 03:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576744087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUf2Ztud9MHk2PyHoR6D+xqFnG87VGzCMIuuMok0O34=;
 b=QlfuLowzw1x+XS2B7KnjepputmlUZgFXMocnKWxC67IKZ+RRbzAVsEm9d7WdVuDQPJtUea
 75cKBxCUXuO4smqbCDak7Y+LWIwn7SLvEVRCbkBtcs8RCeGwPUQW/oPcRlnN92sCOkXoJP
 A8LCf9mWwMvLM5ZBQF2qzpgdrR2vELQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-ny8GbmKBMVaudMe7tUGnqw-1; Thu, 19 Dec 2019 03:28:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFAF210054E3;
 Thu, 19 Dec 2019 08:28:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F330C26E49;
 Thu, 19 Dec 2019 08:28:01 +0000 (UTC)
Date: Thu, 19 Dec 2019 09:28:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/4] qapi: Create module 'monitor'
Message-ID: <20191219082800.GB5230@linux.fritz.box>
References: <20191218161952.10202-1-kwolf@redhat.com>
 <20191218161952.10202-3-kwolf@redhat.com>
 <87eex1zbiq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87eex1zbiq.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ny8GbmKBMVaudMe7tUGnqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.12.2019 um 20:20 hat Markus Armbruster geschrieben:
> > diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> > index dd3f5e6f94..519b6f1a8e 100644
> > --- a/qapi/Makefile.objs
> > +++ b/qapi/Makefile.objs
> > @@ -6,8 +6,8 @@ util-obj-y +=3D qmp-event.o
> >  util-obj-y +=3D qapi-util.o
> > =20
> >  QAPI_COMMON_MODULES =3D audio authz block-core block char common crypt=
o
> > -QAPI_COMMON_MODULES +=3D dump error introspect job machine migration m=
isc net
> > -QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
> > +QAPI_COMMON_MODULES +=3D dump error introspect job machine migration m=
isc monitor
>=20
> Long line.

I went to fix this, but it's only 79 characters, so I think this is a
false alarm.

Kevin


