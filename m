Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873C7C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E7620784
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTz6uC7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E7620784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6pc-0004TY-As
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU6oj-0003ja-7G
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU6oh-0000NE-GL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:53:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jU6og-0000N3-V4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588243997;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THeTvcGuRN4Bun5fx0MTyGccwi9yZTG1GFIwZi6erl8=;
 b=HTz6uC7fIjgHjknn0Lvxb0P7+V6ML4biv2YnEm+pppDOQGFUNi014/Ej0qaNqnQ/eRZqkH
 vnQJmKmDudaytFNjyKRvYWnEsXRmagA0CQjuqh9jQEhlZBaMjm1d79I8IxXGA6/UVMYjpr
 TPsaUFWQlhfDqf4sRsbuQZ9D/MnhQMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-pwm47HcpPv-LAeZvyY34Pw-1; Thu, 30 Apr 2020 06:53:15 -0400
X-MC-Unique: pwm47HcpPv-LAeZvyY34Pw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E58A18FF663;
 Thu, 30 Apr 2020 10:53:14 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87A931001920;
 Thu, 30 Apr 2020 10:53:06 +0000 (UTC)
Date: Thu, 30 Apr 2020 11:53:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Configuring onboard devices (was: Failing property setters +
 hardwired devices + -global = a bad day)
Message-ID: <20200430105303.GK2084570@redhat.com>
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com>
 <87k11xh2kq.fsf@dusky.pond.sub.org>
 <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
 <87tv11e1en.fsf_-_@dusky.pond.sub.org>
 <20200430103437.GI2084570@redhat.com>
 <CAFEAcA_1BB6qCpP+yAOKBeryxCZk5aC-YAw+KbGLFm2zCVL2oQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_1BB6qCpP+yAOKBeryxCZk5aC-YAw+KbGLFm2zCVL2oQ@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 11:45:40AM +0100, Peter Maydell wrote:
> On Thu, 30 Apr 2020 at 11:34, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> > We "merely" need a new query language targetted to QEMU's qtree
> > structure, which we can expose in the CLI that gives unique access
> > to every possible property.
>=20
> Past resistance to this has been grounded in not wanting to
> expose the exact arrangement of the qtree as a user-facing
> thing that needs to be maintained for back-compat reasons.

I could be missing a key difference, but I thought we already exposed
the qtree in QMP  via qom-list, qom-get, qom-set ?  Libvirt uses
these commands for reading various properties.  I guess 'qom-set' is
really defining the kind of query string language I was illustrating
already. So mapping qom-set to the CLI as-is would not be worse than
what we already support in QMP

> Eg in your example the i440fx-pcihost sits directly on the
> 'system bus', but this is an odd artefact of the old qbus/qdev
> system and doesn't really reflect the way the system is built
> up in terms of QOM components; we might one day want to
> restructure things there, which would AIUI break a
> command line like

> > To uniquely identify this we can have a string:
> >
> >  /dev[1]/bus[pci/0]/dev[id=3Dballoon0]/bus[virtio-bus]/dev[0]/deflate-o=
n-oom=3Dtrue

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


