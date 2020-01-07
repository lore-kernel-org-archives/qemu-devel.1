Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F33C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4726207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGP/RMJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4726207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooqp-0000lT-3g
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ionO1-00075b-Pf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ionO0-0005Uc-0W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:51:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ionNX-0005IX-E0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578397829;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68EmF+9APYZn4U1yvfuNM8QsTUNGkUcZTwal+KPeF4o=;
 b=QGP/RMJGVSwCtU3Hw7QPrZT68lVY/hnSUj4OkyJE+vcpVsvCZa8S4D+bNe4jreglIoArbC
 9bsaqNzM19ouaOH0BMisISO1WotJYqWCBihZLyfqMYWIyQp+A/nn+2TNOqMBsn7kg2vrdK
 OtSbPEe7uL3WVxz2CpX/rmw+K6BxSxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-qJg7GpyTPJaCeaL6FbR7VA-1; Tue, 07 Jan 2020 06:50:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 786AF800D55
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:50:27 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E88E5C1B0;
 Tue,  7 Jan 2020 11:50:23 +0000 (UTC)
Date: Tue, 7 Jan 2020 11:50:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] trace: update qemu-trace-stap to Python 3
Message-ID: <20200107115020.GZ3368802@redhat.com>
References: <20200107112438.383958-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107112438.383958-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qJg7GpyTPJaCeaL6FbR7VA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 07, 2020 at 11:24:38AM +0000, Stefan Hajnoczi wrote:
> qemu-trace-stap does not support Python 3 yet:
>=20
>   $ scripts/qemu-trace-stap list path/to/qemu-system-x86_64
>   Traceback (most recent call last):
>     File "scripts/qemu-trace-stap", line 175, in <module>
>       main()
>     File "scripts/qemu-trace-stap", line 171, in main
>       args.func(args)
>     File "scripts/qemu-trace-stap", line 118, in cmd_list
>       print_probes(args.verbose, "*")
>     File "scripts/qemu-trace-stap", line 114, in print_probes
>       if line.startswith(prefix):
>   TypeError: startswith first arg must be bytes or a tuple of bytes, not =
str
>=20
> Now that QEMU requires Python 3.5 or later we can switch to pure Python
> 3.  Use Popen()'s universal_newlines=3DTrue argument to treat stdout as
> text instead of binary.
>=20
> Fixes: 62dd1048c0bd ("trace: add ability to do simple printf logging via =
systemtap")
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1787395
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/qemu-trace-stap | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


