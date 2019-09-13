Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B477FC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4214C206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4214C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ocr-00073m-5j
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8oc0-0006JM-C0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8obz-0005Ki-9R
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:39:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8obw-0005IT-ST; Fri, 13 Sep 2019 12:39:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 311678AC6FF;
 Fri, 13 Sep 2019 16:39:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E46F60925;
 Fri, 13 Sep 2019 16:39:49 +0000 (UTC)
Message-ID: <46eebf1924837b97ee28eeb1f43d199b80b4bacd.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Date: Fri, 13 Sep 2019 19:39:49 +0300
In-Reply-To: <5645f290-b34e-6b51-00cf-b7c4b4a0927a@virtuozzo.com>
References: <20190913152818.17843-1-mlevitsk@redhat.com>
 <20190913152818.17843-4-mlevitsk@redhat.com>
 <5645f290-b34e-6b51-00cf-b7c4b4a0927a@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 13 Sep 2019 16:39:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 3/3] qemu-iotests: Add test for bz
 #1745922
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-13 at 16:27 +0000, Vladimir Sementsov-Ogievskiy wrote:
> 13.09.2019 18:28, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >   tests/qemu-iotests/263     | 91 ++++++++++++++++++++++++++++++++++++++
> >   tests/qemu-iotests/263.out | 40 +++++++++++++++++
> >   tests/qemu-iotests/group   |  2 +
> >   3 files changed, 133 insertions(+)
> >   create mode 100755 tests/qemu-iotests/263
> >   create mode 100644 tests/qemu-iotests/263.out
> > 
> > diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
> > new file mode 100755
> > index 0000000000..d2c030fae9
> > --- /dev/null
> > +++ b/tests/qemu-iotests/263
> 
> [..]
> 
> > --- a/tests/qemu-iotests/group
> > +++ b/tests/qemu-iotests/group
> > @@ -274,5 +274,7 @@
> >   257 rw
> >   258 rw quick
> >   262 rw quick migration
> > +263 rw quick
> >   265 rw auto quick
> >   266 rw quick
> > +>>>>>>> patched
> > 
> 
> last line is a mistake.
Last minute merge mistake :-(

> 
> also, test failed for me:
> 
> 263      fail       [19:21:35] [19:21:35]                    output mismatch (see 263.out.bad)
> --- /work/src/qemu/maxim-luks/tests/qemu-iotests/263.out        2019-09-13 19:11:45.464727427 +0300
> +++ /work/src/qemu/maxim-luks/tests/qemu-iotests/263.out.bad    2019-09-13 19:21:35.535381253 +0300
> @@ -2,6 +2,7 @@
> 
>   testing LUKS qcow2 encryption
> 
> +qemu-img: TEST_DIR/t.IMGFMT: No crypto library supporting PBKDF in this build: Function not implemented
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
>   == reading the whole image ==
>   read 1048576/1048576 bytes at offset 0
> Failures: 263
> Failed 1 of 1 tests
> 
> 
> and if reconfigure with
>   --enable-gnutls --enable-gcrypt --enable-vhost-crypto --enable-crypto-afalg
> (don't know which one is actually needed)
> it works..
> 
> so, we at least should skip the test if it's unsupported
Don't know. I based this test on 188 and it also doesn't have anything special about this.
Its not in auto group though.
I guess we need to ask Daniel about this.



Best regards,
	Maxim Levitsky


