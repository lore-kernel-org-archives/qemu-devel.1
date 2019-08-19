Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC6BC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B0820651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B0820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzk8o-0006Hj-8b
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1hzk59-0002e6-1B
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hzk53-0005nD-Qv
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:00:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hzk53-0005n0-LU
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:00:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF18551F00;
 Mon, 19 Aug 2019 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-60.rdu2.redhat.com
 [10.10.124.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C6B61CB;
 Mon, 19 Aug 2019 16:00:21 +0000 (UTC)
Date: Mon, 19 Aug 2019 12:00:19 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190819160019.GB7887@localhost.localdomain>
References: <20190818231827.27573-1-philmd@redhat.com>
 <20190818231827.27573-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190818231827.27573-3-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 19 Aug 2019 16:00:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] tests/docker: update our Travis image
 to run acceptance tests locally
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
Cc: Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 01:18:25AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Since commit aa983ff67c3, Travis CI runs acceptance tests using
> the Avocado framework. Since Avocado requires Python 3, update
> our Docker image to be able to run these tests locally.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tests/docker/dockerfiles/travis.docker | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dock=
erfiles/travis.docker
> index 35714664a1..b5c5036534 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -13,6 +13,8 @@ RUN apt-get -y install \
>      lsof \
>      net-tools \
>      python2.7 \
> +    python3-pip \
> +    python3.5-venv \
>      python-yaml
>  # Travis tools require PhantomJS / Neo4j / Maven accessible
>  # in their PATH (QEMU build won't access them).
> --=20
> 2.20.1
>=20
>=20

Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>

