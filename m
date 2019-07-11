Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E089C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1752121019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1752121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYlg-0007lM-E2
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hlYjs-0005Qw-3X
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hlYjq-00017w-Sb
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hlYjq-00017U-KL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:03:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8B2FC047B7A;
 Thu, 11 Jul 2019 13:03:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C8C15C221;
 Thu, 11 Jul 2019 13:03:53 +0000 (UTC)
Date: Thu, 11 Jul 2019 14:03:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190711130351.GK11930@redhat.com>
References: <20190711052608.GA2619@arch>
 <20190711121817.GB5846@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190711121817.GB5846@work-vm>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 11 Jul 2019 13:03:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] qemu compilation failure with nettle 3.5.1
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
Cc: Amol Surati <suratiamol@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 01:18:17PM +0100, Dr. David Alan Gilbert wrote:
> Copying in Daniel
>=20
> * Amol Surati (suratiamol@gmail.com) wrote:
> > Hi,
> >=20
> > The qemu upstream (at commit 6df2cdf44a at the moment) fails to compi=
le
> > with nettle 3.5.1. It seems that Nettle has deprecated a few parts of
> > its API.
> >=20
> > A workaround is to provide --disable-nettle during qemu configuration=
.
> >=20
> > A portion of the error log:
> >=20
> > error: =E2=80=98nettle_aes_encrypt=E2=80=99 is deprecated
> > error: =E2=80=98nettle_aes_decrypt=E2=80=99 is deprecated
> > error: =E2=80=98nettle_aes_encrypt=E2=80=99 is deprecated
> > error: =E2=80=98nettle_aes_decrypt=E2=80=99 is deprecated
> > error: =E2=80=98nettle_aes_set_encrypt_key=E2=80=99 is deprecated
> > error: =E2=80=98nettle_aes_set_decrypt_key=E2=80=99 is deprecated
> > error: =E2=80=98nettle_aes_set_encrypt_key=E2=80=99 is deprecated
> > error: =E2=80=98nettle_aes_set_decrypt_key=E2=80=99 is deprecated
> > error: =E2=80=98nettle_aes_set_encrypt_key=E2=80=99 is deprecated
> > error: =E2=80=98nettle_aes_set_decrypt_key=E2=80=99 is deprecated
> >=20
> >=20
> > The declaration of one of the functions from nettle's aes.h:
> >=20
> > void
> > aes_encrypt(const struct aes_ctx *ctx,
> >             size_t length, uint8_t *dst,
> >             const uint8_t *src) _NETTLE_ATTRIBUTE_DEPRECATED;

Yep, I'm already working on a patch, but in the meantime you should
use --disable-werror, as this is merely a deprecation, not any real
functional problem.



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

