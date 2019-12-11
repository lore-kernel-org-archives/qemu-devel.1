Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA3C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6143206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFPLtgfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6143206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7s3-0006es-Sc
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 14:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1if7rS-0006Ct-9y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1if7rQ-0001Al-Cg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:41:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57512
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1if7rQ-00019p-8u
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576093283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=zMtw3V82lx6Kxubc8aQYlAISHAKnchXe1QyUDM4axpw=;
 b=VFPLtgfELCz0GrOIWYxXsHrG7Ie04QPYsH16buyuPlH2o/ke3TJxI0ZcazR/se9dy2dFSU
 xrZj6mz+F2yRH88ubtODZIUF26js0NNgxAoBeanbc2deo8C5uzmXPoAHLw6nQXzObwyEHF
 q5iyTSDyz4AxkoHLRgrr8R44IPhdC70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-e4o9AKrfOoSjxjWQT_pI6Q-1; Wed, 11 Dec 2019 14:41:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9761010BCFE1;
 Wed, 11 Dec 2019 19:41:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-85.ams2.redhat.com [10.36.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E219C5E240;
 Wed, 11 Dec 2019 19:41:18 +0000 (UTC)
Subject: Re: [PATCH v2] ci: build out-of-tree
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576074829-56711-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <21424503-a8e4-789b-89aa-8e6ab3420701@redhat.com>
Date: Wed, 11 Dec 2019 20:41:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576074829-56711-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: e4o9AKrfOoSjxjWQT_pI6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/2019 15.33, Paolo Bonzini wrote:
> Most developers are using out-of-tree builds and it was discussed in the =
past
> to only allow those.  To prepare for the transition, use out-of-tree buil=
ds
> in all continuous integration jobs.
>=20
> Based on a patch by Marc-Andr=C3=A9 Lureau.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v1->v2: include all changes to .travis.yml...
>=20
>  .cirrus.yml    |  8 ++++++--
>  .gitlab-ci.yml | 28 +++++++++++++++++++++-------
>  .shippable.yml |  4 +++-
>  .travis.yml    | 13 ++++++++-----
>  configure      |  1 +
>  5 files changed, 39 insertions(+), 15 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


