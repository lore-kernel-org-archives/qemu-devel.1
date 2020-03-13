Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C20C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BC2206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKI5oRZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BC2206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfzL-0001Ou-OI
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eskultet@redhat.com>) id 1jCfyY-0000jE-UH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eskultet@redhat.com>) id 1jCfyT-0003z9-Ma
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:47:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1jCfyS-0003uN-MV
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584089221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01cObIdsnXAJqweEMp1IJOJGBzN1vdKyhb4xENxI0Mc=;
 b=RKI5oRZoEsNnWmwfRkvI9cUtMKq7B8zMBvO2UAmEk/1E6Q1wjWKW8k5WqJWLVOCdzKo/lu
 yarCqwea98XRahdtrEej57UiqXylNAuJG+aCGxMI3AK+0Oktf46mtdrK+OGDSDu39ur8Jn
 Pj4hq0BJnpic9XuX9gsE3KRsTkhOhUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-xDvDjbIPPWC6KcYqtt8RzA-1; Fri, 13 Mar 2020 04:46:59 -0400
X-MC-Unique: xDvDjbIPPWC6KcYqtt8RzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E765A18C8C11
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 08:46:58 +0000 (UTC)
Received: from beluga.usersys.redhat.com (unknown [10.43.2.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 299915C1C3;
 Fri, 13 Mar 2020 08:46:58 +0000 (UTC)
Date: Fri, 13 Mar 2020 09:46:55 +0100
From: Erik Skultety <eskultet@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 1/5] tests/docker: add CentOS 8 Dockerfile
Message-ID: <20200313084655.GC293912@beluga.usersys.redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-2-crosa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200312193616.438922-2-crosa@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 03:36:12PM -0400, Cleber Rosa wrote:
> Which is currenly missing, and will be referenced later in the
> contributed CI playbooks.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/docker/dockerfiles/centos8.docker | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/centos8.docker
>=20
> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/docke=
rfiles/centos8.docker
> new file mode 100644
> index 0000000000..bfa0d33c9c
> --- /dev/null
> +++ b/tests/docker/dockerfiles/centos8.docker
> @@ -0,0 +1,32 @@
> +FROM centos:8.1.1911
> +
> +RUN dnf -y update
> +ENV PACKAGES \
> +    SDL-devel \
> +    bison \
> +    bzip2 \
> +    bzip2-devel \
> +    dbus-daemon \
> +    flex \
> +    gcc \
> +    gcc-c++ \
> +    gettext \
> +    git \
> +    glib2-devel \
> +    libaio-devel \
> +    libepoxy-devel \
> +    lzo-devel \
> +    make \
> +    mesa-libEGL-devel \
> +    nettle-devel \
> +    perl-Test-Harness \
> +    pixman-devel \
> +    python36 \
> +    rdma-core-devel \
> +    spice-glib-devel \
> +    spice-server \
> +    tar \
> +    zlib-devel
> +
> +RUN dnf install -y $PACKAGES
> +RUN rpm -q $PACKAGES | sort > /packages.txt

How is the packages.txt consumed later?

Erik


