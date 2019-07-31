Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C51BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B4E206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B4E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspKf-0004OZ-Nn
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33390)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hspJm-0003T6-PK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hspJl-0000Xd-H4
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:11:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hspJl-0000XM-Bw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:11:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACF2D30C1354;
 Wed, 31 Jul 2019 14:11:00 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C03455D6A7;
 Wed, 31 Jul 2019 14:10:59 +0000 (UTC)
Date: Wed, 31 Jul 2019 15:10:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190731141055.GI12463@redhat.com>
References: <20190725084341.8287-1-berrange@redhat.com>
 <87a7cui9le.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7cui9le.fsf@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 31 Jul 2019 14:11:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/3] require newer glib2 to enable
 autofree'ing of stack variables exiting scope
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 03:04:29PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > Both GCC and CLang support a C extension attribute((cleanup)) which
> > allows you to define a function that is invoked when a stack variable
> > exits scope. This typically used to free the memory allocated to it,
> > though you're not restricted to this. For example it could be used to
> > unlock a mutex.
> <snip>
> >
> >     GOOD:
> >         g_autofree char *wibble =3D g_strdup("wibble")
> > 	...
> > 	return g_steal_pointer(wibble);
> >
> >     g_steal_pointer is an inline function which simply copies
> >     the pointer to a new variable, and sets the original variable
> >     to NULL, thus avoiding cleanup.
>=20
> Surely this is a particular use case where you wouldn't use g_autofree
> to declare the variable as you intending to return it to the outer scop=
e?

I think it depends on the situation. Obviously real code will have
something in the "..." part I snipped.

You have 20 code paths that can result in returning with an error, where
you want to have all variables freed, and only 1 code path for success
Then it makes sense to use g_autofree + g_steal_pointer to eliminate
many goto jumps.

If you have only 1 error path and 1 success path, then a traditional
g_free() call is may well be sufficient.

IOW, as with many coding "rules", there's scope to use personal
judgement as to when it is right to ignore it vs folow it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

