Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A1CC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9722076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tg3axDH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9722076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHO4-0001vu-GW
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRHMv-000140-5V
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRHMs-0005Bi-QC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:32:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRHMp-000557-Am
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587569568;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gb6ErjXe6EyRPRXSqVLXphl/V47FFvgahYS8/TIO9ow=;
 b=Tg3axDH2PK5zGOry3Y0o/T6nHhAwOgFQiJdZOqRKdzli4ul76Y0EeUT0gAbxKdDlbhbFTr
 RZOvhqy8SJ7sHXFlfWrOMsk7pZp3PMh89CK+PMBw8DqdqQaVifzUcgWjCcdsa98rCdCoX1
 lwuxZ1j4GV9UoP/Cd2tRPB089VracRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-jwRcHLPoN1yFZFIMC6egzg-1; Wed, 22 Apr 2020 11:32:38 -0400
X-MC-Unique: jwRcHLPoN1yFZFIMC6egzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4AA080BE32;
 Wed, 22 Apr 2020 15:32:37 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84ED85C1D4;
 Wed, 22 Apr 2020 15:32:36 +0000 (UTC)
Date: Wed, 22 Apr 2020 16:32:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Subject: Re: [RFC PATCH v2 1/5] crypto/secret: rename to secret_interface.
Message-ID: <20200422153233.GE587120@redhat.com>
References: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 16, 2020 at 01:25:21AM +0300, Alexey Krasikov wrote:
> * Rename for future division into subclasses. Most part of the interface
>   will remain in basic common class.

You don't need to put bullet points in the commit message, just
have the text.

>=20
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>  crypto/{secret.c =3D> secret_interface.c}         | 0
>  include/crypto/{secret.h =3D> secret_interface.h} | 0
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  rename crypto/{secret.c =3D> secret_interface.c} (100%)
>  rename include/crypto/{secret.h =3D> secret_interface.h} (100%)

This breaks the build because Makefile.objs doesn't reference
the new filename, and likewise other files doing #include
don't work.

I don't think renaming actually makes sense in the first place,
because you then add the original files back again in a later
patch.

You need to just have a patch which introduces secret_interface.{ch}
without killing the original secret.{c,h} entirely.  The key point is
that QEMU must successfully compile on each individual patch in the
series, otherwise it breaks "git bisect" usage.

Also, since the object is called "SecretCommon",the filenames
should match that "secret_common.{ch}"


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


