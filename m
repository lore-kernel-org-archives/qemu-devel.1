Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9408AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE16207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvFsArbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE16207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTPo-00053D-GU
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iwTPD-0004aY-A7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iwTPB-0002rb-2I
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:07:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53628
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iwTPA-0002qO-VA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580227676;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qDOjiRntTdhpJe9GA4XUPJqNSDXuSMAta3dJbvrGac=;
 b=TvFsArbMwL7q9T3kEC0T8VOftsQlhoHZDG1zQtjQutXBrK/GOsQgNT13hbNEZqRSoHr0ia
 t3eTasAEnzosZ56gJTp0hsI9OG+T5AtE5lFppZ1qYpTrKYU7vxZbs0SCWHaRsy33priU0s
 Kvw+gioC3TUfvc92TOf7NO6aoeIYtRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-QjYfNpHXPaCCMLekcHuZKg-1; Tue, 28 Jan 2020 11:07:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF9B1DB64;
 Tue, 28 Jan 2020 16:07:51 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F01348887E;
 Tue, 28 Jan 2020 16:07:50 +0000 (UTC)
Date: Tue, 28 Jan 2020 16:07:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: python3 script header and rhel8
Message-ID: <20200128160747.GQ1446339@redhat.com>
References: <2cb797a9-25ec-8b36-2268-ec9638b14e1e@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <2cb797a9-25ec-8b36-2268-ec9638b14e1e@virtuozzo.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: QjYfNpHXPaCCMLekcHuZKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 03:44:04PM +0000, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Hmm Qemu dropped support for python2, and anyway python2 is not supported=
 now at all.
>=20
> Still, we have a lot of "#!/usr/bin/env python" headings in our scripts, =
which is
> unsupported by rhel8 by default. So, for example, because of such line in
> tests/qemu-iotests/nbd-fault-injector.py, iotest 277 fails.
>=20
> Of course, it's simple to set python in rhel8 to be python3... But should=
 we fix
> all the headings to be "#!/usr/bin/env python3"? Or what is the correct h=
eading
> for scripts in a new python3 world?

Using "#!/usr/bin/env python3" is probably our best choice, as it
makes it absolutely clear we're not happy with a python2 impl.

> # git grep -l '^#!/usr/bin/env python$'
> scripts/analyse-9p-simpletrace.py
> scripts/analyse-locks-simpletrace.py
> scripts/decodetree.py
> scripts/device-crash-test
> scripts/kvm/kvm_flightrecorder
> scripts/qapi-gen.py
> scripts/render_block_graph.py
> scripts/replay-dump.py
> scripts/simpletrace.py
> scripts/tracetool.py
> scripts/tracetool/__init__.py
> scripts/tracetool/backend/__init__.py
> scripts/tracetool/backend/dtrace.py
> scripts/tracetool/backend/ftrace.py
> scripts/tracetool/backend/log.py
> scripts/tracetool/backend/simple.py
> scripts/tracetool/backend/syslog.py
> scripts/tracetool/backend/ust.py
> scripts/tracetool/format/__init__.py
> scripts/tracetool/format/c.py
> scripts/tracetool/format/d.py
> scripts/tracetool/format/h.py
> scripts/tracetool/format/log_stap.py
> scripts/tracetool/format/simpletrace_stap.py
> scripts/tracetool/format/stap.py
> scripts/tracetool/format/tcg_h.py
> scripts/tracetool/format/tcg_helper_c.py
> scripts/tracetool/format/tcg_helper_h.py
> scripts/tracetool/format/tcg_helper_wrapper_h.py
> scripts/tracetool/format/ust_events_c.py
> scripts/tracetool/format/ust_events_h.py
> scripts/tracetool/transform.py
> scripts/tracetool/vcpu.py

IMHO the '#!/usr/bin/env' header should only be added to files
which are executable scripts - ie a main() method. IOW, it
ought to be removed from all these tracetool modules.

> tests/acceptance/virtio_seg_max_adjust.py
> tests/acceptance/x86_cpu_model_versions.py
> tests/docker/travis.py
> tests/qapi-schema/test-qapi.py
> tests/qemu-iotests/030
> tests/qemu-iotests/040
> tests/qemu-iotests/041
> tests/qemu-iotests/044
> tests/qemu-iotests/045
> tests/qemu-iotests/055
> tests/qemu-iotests/056
> tests/qemu-iotests/057
> tests/qemu-iotests/065
> tests/qemu-iotests/093
> tests/qemu-iotests/096
> tests/qemu-iotests/118
> tests/qemu-iotests/124
> tests/qemu-iotests/129
> tests/qemu-iotests/132
> tests/qemu-iotests/136
> tests/qemu-iotests/139
> tests/qemu-iotests/147
> tests/qemu-iotests/148
> tests/qemu-iotests/149
> tests/qemu-iotests/151
> tests/qemu-iotests/152
> tests/qemu-iotests/155
> tests/qemu-iotests/163
> tests/qemu-iotests/165
> tests/qemu-iotests/169
> tests/qemu-iotests/194
> tests/qemu-iotests/196
> tests/qemu-iotests/199
> tests/qemu-iotests/202
> tests/qemu-iotests/203
> tests/qemu-iotests/205
> tests/qemu-iotests/206
> tests/qemu-iotests/207
> tests/qemu-iotests/208
> tests/qemu-iotests/209
> tests/qemu-iotests/210
> tests/qemu-iotests/211
> tests/qemu-iotests/212
> tests/qemu-iotests/213
> tests/qemu-iotests/216
> tests/qemu-iotests/218
> tests/qemu-iotests/219
> tests/qemu-iotests/222
> tests/qemu-iotests/224
> tests/qemu-iotests/228
> tests/qemu-iotests/234
> tests/qemu-iotests/235
> tests/qemu-iotests/236
> tests/qemu-iotests/237
> tests/qemu-iotests/238
> tests/qemu-iotests/242
> tests/qemu-iotests/245
> tests/qemu-iotests/246
> tests/qemu-iotests/248
> tests/qemu-iotests/254
> tests/qemu-iotests/255
> tests/qemu-iotests/256
> tests/qemu-iotests/257
> tests/qemu-iotests/258
> tests/qemu-iotests/260
> tests/qemu-iotests/262
> tests/qemu-iotests/264
> tests/qemu-iotests/266
> tests/qemu-iotests/277
> tests/qemu-iotests/280
> tests/qemu-iotests/nbd-fault-injector.py
> tests/qemu-iotests/qcow2.py
> tests/qemu-iotests/qed.py
> tests/vm/basevm.py
> tests/vm/centos
> tests/vm/fedora
> tests/vm/freebsd
> tests/vm/netbsd
> tests/vm/openbsd
> tests/vm/ubuntu.i386

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


