Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0300BC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C197B206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByYwD64x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C197B206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTT1i-0004M1-SH
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:24:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTSyo-0000B6-Va
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTSxI-0000tB-Nl
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:21:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTSxI-0000t3-AK
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588090771;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Wl474CYfiAXd7482oGXcyME2ZRQmVEC9XfQMnvGiRk=;
 b=ByYwD64x7hsGgWVLPriygl+7KcLXCBA5t/GzO32BfUIc6HQx0tR9WpcfKwrTF16S1c2IiX
 vJYr09cx+3OCZ7pYkjYcbtmMu6Y9hpTWjxWOLGgogSiEcEVwzuLA1Ra+ZqCuT9qhPZcduN
 /Bnx6tJoX8LYMercJzjEhZftePT1I/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-LrXyunj2Mj6cIJTapj-C5w-1; Tue, 28 Apr 2020 12:19:28 -0400
X-MC-Unique: LrXyunj2Mj6cIJTapj-C5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5084D1005510;
 Tue, 28 Apr 2020 16:19:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42138100164D;
 Tue, 28 Apr 2020 16:19:25 +0000 (UTC)
Date: Tue, 28 Apr 2020 17:19:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 09/14] iotests: filter few more luks specific create
 options
Message-ID: <20200428161922.GF1467943@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-10-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308151903.25941-10-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 08, 2020 at 05:18:58PM +0200, Maxim Levitsky wrote:
> This allows more tests to be able to have same output on both qcow2 luks =
encrypted images
> and raw luks images
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qemu-iotests/087.out       | 6 +++---
>  tests/qemu-iotests/134.out       | 2 +-
>  tests/qemu-iotests/158.out       | 4 ++--
>  tests/qemu-iotests/188.out       | 2 +-
>  tests/qemu-iotests/189.out       | 4 ++--
>  tests/qemu-iotests/198.out       | 4 ++--
>  tests/qemu-iotests/263.out       | 4 ++--
>  tests/qemu-iotests/284.out       | 6 +++---
>  tests/qemu-iotests/common.filter | 6 ++++--
>  9 files changed, 20 insertions(+), 18 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


