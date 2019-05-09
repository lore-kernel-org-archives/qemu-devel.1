Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4B4C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D941216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D941216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOi4W-0002LR-R1
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 08:22:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOi3J-0001hh-Br
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOi3I-0007AS-4G
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:21:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hOi3H-00079Q-V4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:21:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE0FD3001C60;
	Thu,  9 May 2019 12:21:30 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 497751001E67;
	Thu,  9 May 2019 12:21:23 +0000 (UTC)
Date: Thu, 9 May 2019 13:21:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190509122120.GO31299@redhat.com>
References: <20190509121820.16294-1-stefanha@redhat.com>
	<20190509121820.16294-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509121820.16294-3-stefanha@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 09 May 2019 12:21:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs: add Security chapter to the
 documentation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 01:18:20PM +0100, Stefan Hajnoczi wrote:
> This new chapter in the QEMU documentation covers the security
> requirements that QEMU is designed to meet and principles for securely
> deploying QEMU.
>=20
> It is just a starting point that can be extended in the future with mor=
e
> information.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  Makefile           |   2 +-
>  docs/security.texi | 131 +++++++++++++++++++++++++++++++++++++++++++++
>  qemu-doc.texi      |   3 ++
>  3 files changed, 135 insertions(+), 1 deletion(-)
>  create mode 100644 docs/security.texi

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

