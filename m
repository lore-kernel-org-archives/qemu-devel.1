Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F595CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DD120684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6paklOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DD120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1IA-0004yO-2R
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iO17h-00070K-Bl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iO17g-0005Kw-84
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:03:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51062
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iO17f-0005Ka-Vm
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572015807;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbnF/Jbd0joyndP8ahbhGalwMtL1qaMHNl4dU8ZilD4=;
 b=h6paklOevEKZYCYDynMbYUvnf9KoHJMN75hXWFy/jyvl27GbGLLeOLzBkbmtEPPB4qUpgM
 g/spQ3TGOCngzObL1NFjg4wjYIsH0xA1GJ3y8WFoIc3G0bvCzUw2QclkdkVVWuA12NTlMt
 IpSF5zqMo7UPwSm5WWFcZUbEgk3K//o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-YsHDg3enPxWoZXIWzVQ9OQ-1; Fri, 25 Oct 2019 11:03:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9893B801E6F;
 Fri, 25 Oct 2019 15:03:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8251E5C1B5;
 Fri, 25 Oct 2019 15:03:21 +0000 (UTC)
Date: Fri, 25 Oct 2019 16:03:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Early 4.1.1 release for image corruption fixes?
Message-ID: <20191025150319.GD3581@redhat.com>
References: <20191025142915.GG7275@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191025142915.GG7275@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: YsHDg3enPxWoZXIWzVQ9OQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, mreitz@redhat.com, mdroth@linux.vnet.ibm.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 04:29:15PM +0200, Kevin Wolf wrote:
> Hi,
>=20
> the QEMU 4.1.0 release has two problems that can easily cause image
> corruption with any qcow2 images (no special configuration needed to
> trigger the bugs):
>=20
> 1. A locking bug in the qcow2 code. I just sent a pull request that
>    includes the fix for this. The important patch there is:
>=20
>    'qcow2: Fix corruption bug in qcow2_detect_metadata_preallocation()'
>=20
> 2. A kernel bug in the XFS driver that became visible by new I/O
>    patterns the qcow2 implementation started to use in 4.1. Max is
>    currently working on a workaround for this.
>=20
> The Planning/4.1 wiki page tells me that a 4.1.1 release is planned for
> end of November, which isn't too far, but I was wondering if want to
> have a stable release even earlier, right after the fixes for both
> problems are in.

IMHO data corruption for our primary image format is an excellent
reason to do a stable release at the soonest viable opportunity.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


