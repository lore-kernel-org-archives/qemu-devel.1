Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A79C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5DF20661
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9n3zjWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5DF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaUm-0000E4-LD
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVaIl-0002fM-35
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:34:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVaIk-0001Vf-4K
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588595664;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2f+94WevF1xVUd8sbVDd41rMqJVjknOhhTXpotJzdo=;
 b=b9n3zjWhB5AZuKef/lulv/pkaWIOt6KUMO+6TdQspb8V+WeguVBvi5Q0nZ72UoFCg6kniE
 97UQGo2s/+AOcWNMl+LIEq+H/nmP4MeTTs7V1KvZ1/oSIyTIAHebeJNsCFuWskdudQMt+K
 fY2sSh8AmMuLfTlf3H3IUXP/ZU6Quxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-8eHI874jMzaLLiPM5v2hog-1; Mon, 04 May 2020 08:34:20 -0400
X-MC-Unique: 8eHI874jMzaLLiPM5v2hog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82D7619200C3;
 Mon,  4 May 2020 12:34:18 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBA3F6B8E6;
 Mon,  4 May 2020 12:34:13 +0000 (UTC)
Date: Mon, 4 May 2020 13:34:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/20] Trivial branch for 5.1 patches
Message-ID: <20200504123410.GJ115875@redhat.com>
References: <20200504115758.283914-1-laurent@vivier.eu>
 <CAFEAcA_FDt+1+ezAyRE-fwdd=VuG5YNThkKiHHTUOYqtRHLoyg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_FDt+1+ezAyRE-fwdd=VuG5YNThkKiHHTUOYqtRHLoyg@mail.gmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 01:17:19PM +0100, Peter Maydell wrote:
> On Mon, 4 May 2020 at 13:05, Laurent Vivier <laurent@vivier.eu> wrote:
> >
> > The following changes since commit 2ef486e76d64436be90f7359a3071fb2a56c=
e835:
> >
> >   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' =
into s=3D
> > taging (2020-05-03 14:12:56 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.1-pull-req=
uest
> >
> > for you to fetch changes up to 4341a0106781043a708c061b676312e5bb5d4488=
:
> >
> >   hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warnin=
g (202=3D
> > 0-05-04 12:06:21 +0200)
> >
> > ----------------------------------------------------------------
> > trivial patches (20200504)
> >
> > Silent static analyzer warning
> > Remove dead assignments
> > Support -chardev serial on macOS
> > Update MAINTAINERS
> > Some cosmetic changes
>=20
>=20
> Compile failure, OSX:
> /Users/pm215/src/qemu-for-merges/block/file-posix.c:1620:9: error:
> unused variable 'ret' [-Werror,-Wunused-variable]
>     int ret;
>         ^
>=20
> Compile failure, aarch32 (but probably the result of whatever
> crypto options/dependent libraries are on that setup):
>=20
> In file included from /home/peter.maydell/qemu/crypto/cipher.c:157:0:
> /home/peter.maydell/qemu/crypto/cipher-builtin.c: In function
> 'qcrypto_cipher_aes_xts_encrypt':
> /home/peter.maydell/qemu/crypto/cipher-builtin.c:136:36: error:
> passing argument 1 of 'qcrypto_cipher_aes_ecb_encrypt' discards
> 'const' qualifier from pointer target type
> [-Werror=3Ddiscarded-qualifiers]
>      qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
>                                     ^
> /home/peter.maydell/qemu/crypto/cipher-builtin.c:77:13: note: expected
> 'AES_KEY * {aka struct aes_key_st *}' but argument is of type 'const
> AES_KEY * {aka const struct aes_key_st *}'
>  static void qcrypto_cipher_aes_ecb_encrypt(AES_KEY *key,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/peter.maydell/qemu/crypto/cipher-builtin.c: In function
> 'qcrypto_cipher_aes_xts_decrypt':
> /home/peter.maydell/qemu/crypto/cipher-builtin.c:147:36: error:
> passing argument 1 of 'qcrypto_cipher_aes_ecb_decrypt' discards
> 'const' qualifier from pointer target type
> [-Werror=3Ddiscarded-qualifiers]
>      qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
>                                     ^
> /home/peter.maydell/qemu/crypto/cipher-builtin.c:103:13: note:
> expected 'AES_KEY * {aka struct aes_key_st *}' but argument is of type
> 'const AES_KEY * {aka const struct aes_key_st *}'
>  static void qcrypto_cipher_aes_ecb_decrypt(AES_KEY *key,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This failure shows that patch 4 is wrong. The cast is not redundant,
it is explicitly required in order to discard 'const'. Please just
drop patch 4.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


