Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E996C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BF321479
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BF321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOvg-0004p6-Iv
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:57:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hTOux-0004UP-PH
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hTOuw-0008AY-Kh
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:56:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hTOuw-00089k-Eb
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:56:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DD4FC05D3F4;
	Wed, 22 May 2019 10:56:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.248])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 90831544ED;
	Wed, 22 May 2019 10:56:16 +0000 (UTC)
Date: Wed, 22 May 2019 11:56:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190522105614.GD32359@redhat.com>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
	<20190517023924.1686-3-richard.henderson@linaro.org>
	<20190521150402.GQ25835@redhat.com>
	<a928e588-63dc-ed4c-fcdc-9001941559fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a928e588-63dc-ed4c-fcdc-9001941559fd@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 22 May 2019 10:56:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 02/25] build: Link user-only with crypto
 random number objects
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 22, 2019 at 06:52:45AM -0400, Richard Henderson wrote:
> On 5/21/19 11:04 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, May 16, 2019 at 07:39:01PM -0700, Richard Henderson wrote:
> >> For user-only, we require only the random number bits of the
> >> crypto subsystem.  Rename crypto-aes-obj-y to crypto-user-obj-y,
> >> and add the random number objects, plus init.o to handle any
> >> extra stuff the crypto library requires.
> >=20
> > If you pull in my authz patch first:
> >=20
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04863.html
> >=20
> > then we can just kill crypto-aes-obj-y entirely, and make
> > linux-user reference crypto-obj-y as normal. My patch avoids
> > pulling in PAM, and your previous patch takes care of the
> > static linking problem.
>=20
> You would think so, wouldn't you.  And yet, not.
>=20
>   CC      authz/base.o
> /home/rth/qemu/qemu/authz/base.c:23:10: fatal error: trace.h: No such f=
ile or
> directory
>  #include "trace.h"
>           ^~~~~~~~~
> compilation terminated.
>=20
> We're missing some dependency somewhere, and I have no idea what's miss=
ing.
>=20
> This for
>=20
> ../qemu/configure --static --disable-system --disable-tools
>=20
> I have a working configuration here in v8.  Can we please leave the bik=
eshed
> unpainted for the moment and you can adjust the makefiles as you see fi=
t afterward?

Yep, ok. I'll be away on holiday for a while so don't have time to look
into it now. So lets get this merged as is & I'll investigate further
when I come back.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

