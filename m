Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB22EC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9362082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPBSBgzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9362082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIXr-0003YG-U1
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izIV6-0007mw-Ks
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izIV5-0004CW-Gz
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:05:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51235
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izIV5-00049E-Bn
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580900743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=/OoUr3MnVumXSBVRgCJmY3rML657ppjT/2O2KlEzTx0=;
 b=RPBSBgzodo9Imir+HOPQbFJ1Hp8GRvuX2sX09SWqxEO+R0UBwoXtvWTv/N+tK5+hOcSO8z
 oWEP9LR0Q+xAjMCpYEa3FxEbcylf2F9B7r1ASVeXXqwdxm7CvHGLKfHGKQnxtqJ4NZ3Y7X
 Iz5XnfZHpDUNnftxrmzLOj9+y1eN/78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-0LzGI0mWP7aed7u_lh75BQ-1; Wed, 05 Feb 2020 06:05:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF5D11007270;
 Wed,  5 Feb 2020 11:05:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-132.ams2.redhat.com [10.36.116.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4E9660BF7;
 Wed,  5 Feb 2020 11:05:35 +0000 (UTC)
Subject: Re: [PATCH RFC 2/2] docs: rstfy vfio-ap documentation
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
 "Jason J . Herne" <jjherne@linux.ibm.com>
References: <20200128180142.15132-1-cohuck@redhat.com>
 <20200128180142.15132-3-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a84a6919-c629-6a08-8e17-6bb068fb7334@redhat.com>
Date: Wed, 5 Feb 2020 12:05:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128180142.15132-3-cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0LzGI0mWP7aed7u_lh75BQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/01/2020 19.01, Cornelia Huck wrote:
> Move to system/, as this is mostly about configuring vfio-ap.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS                              |   2 +-
>  docs/system/index.rst                    |   1 +
>  docs/{vfio-ap.txt => system/vfio-ap.rst} | 755 ++++++++++++-----------
>  3 files changed, 387 insertions(+), 371 deletions(-)
>  rename docs/{vfio-ap.txt => system/vfio-ap.rst} (56%)

I'm not an expert in all that RST markdown syntax, but I think it's a
good idea to do this change, so FWIW:

Acked-by: Thomas Huth <thuth@redhat.com>


