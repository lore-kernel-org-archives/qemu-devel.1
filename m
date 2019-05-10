Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40070C04AB2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B0921479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B0921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41647 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3qX-0007Oe-9H
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:37:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP3pX-0006zQ-M0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP3pW-0004q7-I5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:36:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hP3pW-0004pt-Cf
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:36:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8920530842A9;
	Fri, 10 May 2019 11:36:45 +0000 (UTC)
Received: from redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EA6D646C8;
	Fri, 10 May 2019 11:36:43 +0000 (UTC)
Date: Fri, 10 May 2019 12:36:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190510113640.GI7671@redhat.com>
References: <20190510102637.10209-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190510102637.10209-1-lvivier@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 10 May 2019 11:36:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] rng-builtin: add an RNG backend that
 uses qemu_guest_getrandom()
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 12:26:37PM +0200, Laurent Vivier wrote:
> Add a new RNG backend using QEMU builtin getrandom function.
>=20
> It can be created and used with something like:
>=20
>     ... -object rng-builtin,id=3Drng0 -device virtio-rng,rng=3Drng0 ...
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>=20
> Notes:
>     This patch applies on top of
>     "[PATCH v5 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"
>     Based-on: 20190510012458.22706-1-richard.henderson@linaro.org
>    =20
>     v2: Update qemu-options.hx
>         describe the new backend and specify virtio-rng uses the
>         rng-random by default (do we want to change this?)

Yeah, I think we could change the default backend, as it won't affect
migration in any way

>=20
>  backends/Makefile.objs |  2 +-
>  backends/rng-builtin.c | 56 ++++++++++++++++++++++++++++++++++++++++++
>  qemu-options.hx        | 10 +++++++-
>  3 files changed, 66 insertions(+), 2 deletions(-)
>  create mode 100644 backends/rng-builtin.c

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

