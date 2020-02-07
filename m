Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05060C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D8422314
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8cB6pg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D8422314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00Fr-0001RG-0h
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j00F3-0000yS-1V
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j00F1-0000nA-W3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:48:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j00F1-0000md-T7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581068883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSjoUif4OOgn5tnMUAUMJM5Phj+0k1qUdgJDsIstd6Q=;
 b=N8cB6pg9mObbgRVj+Yw1TLFejhvkMZ88nnN8s+We+bp3cbqTPeaLTSpej6F4CBH3OOdjj5
 esvh4wO1ZXkGwG5BWJ1iQe9JioSB01vZyKzW95YbxUohcybcgn1QkPOVaIOktZR2gZEWX+
 V1+2pYO5r0xP+keeC0QdLulEU/AeZ6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-zfs3-OtiMuqxBGIN4i0rNA-1; Fri, 07 Feb 2020 04:48:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E276800D54;
 Fri,  7 Feb 2020 09:48:00 +0000 (UTC)
Received: from gondolin (ovpn-117-112.ams2.redhat.com [10.36.117.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D832E8E611;
 Fri,  7 Feb 2020 09:47:53 +0000 (UTC)
Date: Fri, 7 Feb 2020 10:47:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] travis.yml: Test the s390-ccw build, too
Message-ID: <20200207104751.36609b11.cohuck@redhat.com>
In-Reply-To: <20200206202543.7085-1-thuth@redhat.com>
References: <20200206202543.7085-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: zfs3-OtiMuqxBGIN4i0rNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: David Hildenbrand <david@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  6 Feb 2020 21:25:43 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Since we can now use a s390x host on Travis, we can also build and
> test the s390-ccw bios images there. For this we have to make sure
> that roms/SLOF is checked out, too, and then move the generated *.img
> files to the right location before running the tests.

Oh, nice.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 6c0ec6cf69..c0eeff9caa 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -508,6 +508,16 @@ matrix:
>        env:
>          - TEST_CMD="make check check-tcg V=1"
>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
> +      script:
> +        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
> +        - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
> +        - |
> +          if [ "$BUILD_RC" -eq 0 ] ; then
> +              mv pc-bios/s390-ccw/*.img pc-bios/ ;
> +              ${TEST_CMD} ;

Out of curiousity: Which kind of tests are run for the net image?

> +          else
> +              $(exit $BUILD_RC);
> +          fi
>  
>      # Release builds
>      # The make-release script expect a QEMU version, so our tag must start with a 'v'.

Acked-by: Cornelia Huck <cohuck@redhat.com>


