Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768FFC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5AA2332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5AA2332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Zma-0001TN-DX
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 19:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0Zlg-0000aQ-FA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0Zlf-0007zM-A9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:11:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0Zlc-0007xo-Vm; Wed, 21 Aug 2019 19:11:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F06DB10F23E1;
 Wed, 21 Aug 2019 23:11:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 859BC60C05;
 Wed, 21 Aug 2019 23:11:43 +0000 (UTC)
Message-ID: <cce83b06bdf927a5c7898bce475f58ef7c717b91.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 22 Aug 2019 02:11:42 +0300
In-Reply-To: <CAMRbyyvaOPSD0jxxFzkpnjEWyeNpbbU3r+2U+RKE=4x_1RteOw@mail.gmail.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-6-mlevitsk@redhat.com>
 <CAMRbyyvaOPSD0jxxFzkpnjEWyeNpbbU3r+2U+RKE=4x_1RteOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 21 Aug 2019 23:11:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 05/13] qcrypto-luks: clear the
 masterkey and password before freeing them always
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 02:01 +0300, Nir Soffer wrote:
> On Wed, Aug 14, 2019, 23:23 Maxim Levitsky <mlevitsk@redhat.com> wrote:
> 
> > While there are other places where these are still stored in memory,
> > this is still one less key material area that can be sniffed with
> > various side channel attacks
> > 
> > 
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 52 ++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 44 insertions(+), 8 deletions(-)
> > 
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index e1a4df94b7..336e633df4 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> > @@ -1023,8 +1023,18 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
> >   cleanup:
> >      qcrypto_ivgen_free(ivgen);
> >      qcrypto_cipher_free(cipher);
> > -    g_free(splitkey);
> > -    g_free(possiblekey);
> > +
> > +    if (splitkey) {
> > +        memset(splitkey, 0, splitkeylen);
> > 
> 
> I think we need memset_s() or similar replacement, see
> 
> https://www.cryptologie.net/article/419/zeroing-memory-compiler-optimizations-and-memset_s/

You raise a very very good point here! Thanks!!

Best regards,
	Maxim Levitsky




