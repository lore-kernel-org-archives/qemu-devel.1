Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12DCC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D81C2171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D81C2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEubE-0007ly-9J
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:44:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEuaV-0007Qu-Or
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEuaU-0000yB-E9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:43:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEuaU-0000xT-42
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:43:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C55C93002E1F;
	Fri, 12 Apr 2019 11:43:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC2AA619BA;
	Fri, 12 Apr 2019 11:43:10 +0000 (UTC)
Date: Fri, 12 Apr 2019 12:43:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20190412114307.GK25308@redhat.com>
References: <20190412113730.28828-1-otubo@redhat.com>
	<20190412113730.28828-2-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190412113730.28828-2-otubo@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 12 Apr 2019 11:43:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 1/1] configure: Relax check for libseccomp
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
Cc: peter.maydell@linaro.org, deller@gmx.de, philmd@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412114307.AvjCQY7xI_1AyMBTp09xPBZJIdcljN4I6G4RRsQzwqg@z>

On Fri, Apr 12, 2019 at 01:37:30PM +0200, Eduardo Otubo wrote:
> From: Helge Deller <deller@gmx.de>
>=20
> All major distributions do support libseccomp version >=3D 2.3.0, so th=
ere
> is no need to special-case on various architectures any longer.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Eduardo Otubo <otubo@redhat.com>

When sending pull requests the subsystem maintainer *must*
add their Signed-off-by as this is what has legal meaning
with respect to the developer certificate of origin.

Acked-by is something that is used to give a different
subsystem maintainer permission to merge a patch that
would normally be your responsibility.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

