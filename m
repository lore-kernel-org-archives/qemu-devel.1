Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57402C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216C920704
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj0hp0QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216C920704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGDm-0004kj-8d
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iuGCr-00047U-K5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iuGCp-0002Fo-Jc
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:38:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iuGCp-0002F3-Cj
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579700282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2DbjmjaIUD592zRYJbkcAaQOtdIDRefwiLI3DsEIaA=;
 b=Oj0hp0QDngxU7ds5nibF2QFB6UUzE5xRCgEFTC4QhpZ5h7v2sKfXqpdJzxGWaFGbus6QPY
 2e96V/G8Gdx7BZ0+XnpeOPAPwMb24FP4tUNO2iiXWTCkVHp2tvROytLnfH7r+A8RzeqeFA
 gLWM6WmGG3DHowhJJBVCilYAdpJgLkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-S72rqEE1Pa6ay-915SFwWw-1; Wed, 22 Jan 2020 08:38:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E46408010CB;
 Wed, 22 Jan 2020 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-68.gru2.redhat.com
 [10.97.116.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71B867C35A;
 Wed, 22 Jan 2020 13:37:50 +0000 (UTC)
Subject: Re: [PATCH v1 0/3] current testing/next queue
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200122102223.20036-1-alex.bennee@linaro.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <f4d6b334-1a4f-78be-c0d1-f53cf2e288d6@redhat.com>
Date: Wed, 22 Jan 2020 11:37:48 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200122102223.20036-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: S72rqEE1Pa6ay-915SFwWw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 1/22/20 8:22 AM, Alex Benn=C3=A9e wrote:
> Hi,
>
> There isn't much in my queue at the moment. The move of the various
> compilers to buster fixes one of the shippable problems. I have a
> longer series cooking to support multiarch docker builds which I'll
> try and get posted by the end of this week.

Do you mind to pick this up too? ->

[PATCH 0/1] travis.yml: Missing genisoimage package

https://www.mail-archive.com/qemu-devel@nongnu.org/msg669898.html

- Wainer


>
> Alex Benn=C3=A9e (2):
>    tests/docker: move most cross compilers to buster base
>    tests/docker: better handle symlinked libs
>
> Thomas Huth (1):
>    gitlab-ci: Refresh the list of iotests
>
>   .gitlab-ci.yml                                   | 12 ++++++------
>   tests/docker/Makefile.include                    | 16 ++++++++--------
>   tests/docker/docker.py                           |  3 ++-
>   tests/docker/dockerfiles/debian-amd64.docker     |  2 +-
>   .../docker/dockerfiles/debian-armel-cross.docker |  2 +-
>   .../docker/dockerfiles/debian-armhf-cross.docker |  2 +-
>   .../dockerfiles/debian-mips64el-cross.docker     |  2 +-
>   .../dockerfiles/debian-mipsel-cross.docker       |  2 +-
>   .../dockerfiles/debian-ppc64el-cross.docker      |  2 +-
>   .../docker/dockerfiles/debian-s390x-cross.docker |  2 +-
>   10 files changed, 23 insertions(+), 22 deletions(-)
>


