Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E692AC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B265820644
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbY8CDTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B265820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOIeV-0003PU-R6
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jOIdO-0002l8-3f
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jOIdN-0001Xu-0C
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:17:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40973
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jOIdM-0001Xi-SV
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586859456;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilAuUIurUe27QkRFDAsgKbvgeUBIEqT08fMy8ANTwKY=;
 b=LbY8CDTjllYCi54r+Is7DUZ5FZfnpIPWR0mXfclGMkJAiVTKz46HbtHiGIhJBvm3e2igqN
 0o1LhC45okKvHVyZj/Tul7jHx7wfHh4vaCMWxv7FGUXpeuI2HGMc6GnNRkQmrOJMKdjfVB
 Zrt3NzV+EDVLDvmVKia3MvmP5fKkEyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-YmrbOXIwPwaqLLEePEUNlg-1; Tue, 14 Apr 2020 06:17:34 -0400
X-MC-Unique: YmrbOXIwPwaqLLEePEUNlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92BC618C35A1;
 Tue, 14 Apr 2020 10:17:33 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FBC319C58;
 Tue, 14 Apr 2020 10:17:31 +0000 (UTC)
Date: Tue, 14 Apr 2020 11:17:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 11/11] .travis.yml: Build OSX 10.14 with Xcode 10.0
Message-ID: <20200414101729.GI1338838@redhat.com>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-12-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-12-alex.bennee@linaro.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 10:15:29PM +0100, Alex Benn=C3=A9e wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Travis recently made a change which generates various warnings
> such [*]:
>=20
>     CC      utils.o
>   In file included from cs.c:11:
>   In file included from /Library/Developer/CommandLineTools/SDKs/MacOSX10=
.14.sdk/usr/include/stdio.h:64:
>   /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_s=
tdio.h:93:16: warning: pointer is missing a nullability type specifier (_No=
nnull, _Nullable, or _Null_unspecified) [-Wnullability-completeness]
>           unsigned char   *_base;
>                           ^
>   /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_s=
tdio.h:93:16: note: insert '_Nullable' if the pointer may be null
>           unsigned char   *_base;
>                           ^
>                             _Nullable
>=20
> We only aim to support MacOS 10.14 and 10.15. 10.14 comes with
> Xcode 10.0. These warnings are not emitted with this Xcode version,
> so switch back to it.

It appears Travis have fixed the flaw in 10.3, as both QEMU and libvirt
are building correctly on 10.3 again. So I think you can drop this patch.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


