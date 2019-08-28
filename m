Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99B6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF29222CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF29222CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zla-0001DT-QW
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 11:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i2zkQ-0000Kn-OP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i2zkP-00081y-0h
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:20:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i2zkO-00080z-RR
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:20:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 233E418B3D87;
 Wed, 28 Aug 2019 15:20:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 689C560C5D;
 Wed, 28 Aug 2019 15:20:30 +0000 (UTC)
Date: Wed, 28 Aug 2019 16:20:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190828152028.GM2991@redhat.com>
References: <20190823163931.7442-1-berrange@redhat.com>
 <20190823163931.7442-4-berrange@redhat.com>
 <878srd5nlz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878srd5nlz.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 28 Aug 2019 15:20:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] docs: document use of automatic
 cleanup functions in glib
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

On Wed, Aug 28, 2019 at 04:14:00PM +0100, Alex Benn=C3=A9e wrote:
> > +The cleanup functions are not restricted to simply free'ing memory. =
The
> > +GMutexLocker class is a variant of GMutex that has automatic locking=
 and
> > +unlocking at start and end of the enclosing scope
> > +
> > +In the following example, the `lock` in `MyObj` will be held for the
> > +precise duration of the `somefunc` function
> > +
> > +    typedef struct {
> > +        GMutex lock;
> > +    } MyObj;
> > +
> > +    char *somefunc(MyObj *obj) {
> > +        g_autofree GMutexLocker *locker =3D g_mutex_locker_new(&obj-=
>lock)
> > +        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
> > +        g_autoptr (GList) bar =3D .....
> > +
> > +        if (eek) {
> > +           return NULL;
> > +        }
> > +
> > +        return g_steal_pointer(&foo);
> > +    }
>=20
> I would personally prefer we get some RFC patches for auto-unlocking un=
der our
> belt before we codify it's usage in our developer docs. Locking is a
> fickle beast at the best of times and I'd like to see where it benefits
> us before there is a rush to covert to the new style.
>=20
> For one thing the only uses I see of g_mutex_lock is in our tests, the
> main code base uses qemu_mutex_lock. How would we go about registering
> the clean-up functions for those in the code base?

Ideally we could just relpace qemu_mutex with g_mutex, but if that's
not possible we would have to create a clone of GMutexLocker as
QemuMutexLocker doing exactly the same thing. It is a shame to reinvent
the wheel with our threading code though.

/me tries to remember what it was that we can do with QEMU's threads
that we can't do with GLib's threads.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

