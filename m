Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F457C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4522082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4522082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHoW-0000yP-K9
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:56:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hRHmx-0008S9-6H
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hRHmv-0005UE-T9
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hRHmv-0005ST-Nk
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:55:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 179D3306641B;
	Thu, 16 May 2019 14:55:17 +0000 (UTC)
Received: from redhat.com (ovpn-112-59.ams2.redhat.com [10.36.112.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 175985D6A9;
	Thu, 16 May 2019 14:55:14 +0000 (UTC)
Date: Thu, 16 May 2019 15:55:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190516145511.GH22356@redhat.com>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
	<20190514191653.31488-2-richard.henderson@linaro.org>
	<20190515165328.GK4751@redhat.com>
	<1715ce98-7aef-9a2b-d74c-280796da456a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1715ce98-7aef-9a2b-d74c-280796da456a@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 16 May 2019 14:55:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 01/24] build: Link user-only with
 crypto-rng-obj-y
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

On Thu, May 16, 2019 at 07:48:30AM -0700, Richard Henderson wrote:
> On 5/15/19 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> > So I think we should just use $(crypto-obj-y) unconditionally in
> > the user emulators, and get rid of crypto-aes-obj-y too.
>=20
> That results in
>=20
>   LINK    arm-linux-user/qemu-arm
> ../crypto/tlssession.o: In function `qcrypto_tls_session_check_certific=
ate':
> /home/rth/qemu/qemu/crypto/tlssession.c:356: undefined reference to
> `qauthz_is_allowed_by_id'
> collect2: error: ld returned 1 exit status
>=20
> which means all of the authz objects need to come in as well.
> I suppose they're not big, but still...
>=20
> I'm leaning toward reviving crypto-user-obj-y, with just the
> crypto random and aes objects in.
>=20
> Thoughts?

Coincidentally I think I need to split the $authz-obj-y variable into
two parts

 authz-obj-y containing only base.o
 authz-obj-impl-y containing everything else

Most things will thus be satisfied by just $authz-obj-y. Only the
system emulators and qemu-nbd then need to have authz-obj-impl-y

This will avoid qemu-img, qemu-io, and other tools and linux-user
from having to link to the pam library.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

