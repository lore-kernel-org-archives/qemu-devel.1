Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D9AC5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F45C20767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLVGOHlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F45C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVHl-0004IX-Ma
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jEVGe-00037K-Ry
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jEVGc-00069i-L6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:45:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jEVGX-000630-N0
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584524732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHJVPS1+JB5RiySpzxvYTEE1kHlmxEQy49oRpPyXRKA=;
 b=cLVGOHlrnuPRreiXvCrvcI3l/4MudMIRbyrFroMzqBFUm0RDYI8Z/IgDGBinc+Ap1s+4Bw
 7fit3wMfMpX3ZYKi/6Up6Sg9yMiKW7khvd1Dd3LA/5siQDnvA2GB3PDzXedRcug335CDnk
 52TjPevZhOGtJOQZPjYpPngRl8v0z/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-1GzrOFWePeaJveDyDN9toQ-1; Wed, 18 Mar 2020 05:45:28 -0400
X-MC-Unique: 1GzrOFWePeaJveDyDN9toQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD540A1362;
 Wed, 18 Mar 2020 09:45:27 +0000 (UTC)
Received: from redhat.com (ovpn-115-92.ams2.redhat.com [10.36.115.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4706A9494E;
 Wed, 18 Mar 2020 09:45:20 +0000 (UTC)
Date: Wed, 18 Mar 2020 09:45:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/4] tests/test-util-sockets: Skip test on non-x86 Travis
 containers
Message-ID: <20200318094517.GD2173309@redhat.com>
References: <20200317200541.6246-1-philmd@redhat.com>
 <20200317200541.6246-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200317200541.6246-3-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 09:05:39PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Similarly to commit 4f370b1098, test-util-sockets fails in
> restricted non-x86 Travis containers since they apparently
> blacklisted some required system calls there.
> Let's simply skip the test if we detect such an environment.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/test-util-sockets.c | 7 +++++++
>  1 file changed, 7 insertions(+)

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


