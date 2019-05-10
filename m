Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C481C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBCB20881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBCB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7v8-0001DL-EP
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:58:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP7n6-0001yd-IT
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP7n5-0005ll-8e
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hP7n4-0005gt-JW; Fri, 10 May 2019 11:50:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C851788309;
	Fri, 10 May 2019 15:50:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A30DD5C69A;
	Fri, 10 May 2019 15:50:27 +0000 (UTC)
Date: Fri, 10 May 2019 16:50:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190510155024.GA19218@redhat.com>
References: <1550073299-3647-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1550073299-3647-1-git-send-email-thuth@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 10 May 2019 15:50:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] crypto: Fix LGPL information in the file
 headers
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 13, 2019 at 04:54:59PM +0100, Thomas Huth wrote:
> It's either "GNU *Library* General Public License version 2" or "GNU
> Lesser General Public License version *2.1*", but there was no "version
> 2.0" of the "Lesser" license. So assume that version 2.1 is meant here.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  crypto/block-luks.c           | 2 +-
>  crypto/block-luks.h           | 2 +-
>  crypto/block-qcow.c           | 2 +-
>  crypto/block-qcow.h           | 2 +-
>  crypto/block.c                | 2 +-
>  crypto/blockpriv.h            | 2 +-
>  crypto/cipher-builtin.c       | 2 +-
>  crypto/cipher-gcrypt.c        | 2 +-
>  crypto/cipher-nettle.c        | 2 +-
>  crypto/cipher.c               | 2 +-
>  crypto/hash-gcrypt.c          | 2 +-
>  crypto/hash-glib.c            | 2 +-
>  crypto/hash-nettle.c          | 2 +-
>  crypto/hash.c                 | 2 +-
>  crypto/init.c                 | 2 +-
>  crypto/ivgen-essiv.c          | 2 +-
>  crypto/ivgen-essiv.h          | 2 +-
>  crypto/ivgen-plain.c          | 2 +-
>  crypto/ivgen-plain.h          | 2 +-
>  crypto/ivgen-plain64.c        | 2 +-
>  crypto/ivgen-plain64.h        | 2 +-
>  crypto/ivgen.c                | 2 +-
>  crypto/ivgenpriv.h            | 2 +-
>  crypto/pbkdf-gcrypt.c         | 2 +-
>  crypto/pbkdf-nettle.c         | 2 +-
>  crypto/pbkdf-stub.c           | 2 +-
>  crypto/pbkdf.c                | 2 +-
>  crypto/random-gcrypt.c        | 2 +-
>  crypto/random-gnutls.c        | 2 +-
>  crypto/random-platform.c      | 2 +-
>  crypto/secret.c               | 2 +-
>  crypto/tlscreds.c             | 2 +-
>  crypto/tlscredsanon.c         | 2 +-
>  crypto/tlscredspriv.h         | 2 +-
>  crypto/tlscredspsk.c          | 2 +-
>  crypto/tlscredsx509.c         | 2 +-
>  crypto/tlssession.c           | 2 +-
>  crypto/xts.c                  | 2 +-
>  include/crypto/block.h        | 2 +-
>  include/crypto/cipher.h       | 2 +-
>  include/crypto/hash.h         | 2 +-
>  include/crypto/init.h         | 2 +-
>  include/crypto/ivgen.h        | 2 +-
>  include/crypto/pbkdf.h        | 2 +-
>  include/crypto/random.h       | 2 +-
>  include/crypto/secret.h       | 2 +-
>  include/crypto/tlscreds.h     | 2 +-
>  include/crypto/tlscredsanon.h | 2 +-
>  include/crypto/tlscredspsk.h  | 2 +-
>  include/crypto/tlscredsx509.h | 2 +-
>  include/crypto/tlssession.h   | 2 +-
>  include/crypto/xts.h          | 2 +-
>  52 files changed, 52 insertions(+), 52 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I'll queue this.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

