Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5F7C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D751F20665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D751F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCUMF-00023I-VS
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 15:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCULT-0001OQ-Lw
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCULS-0007OG-Mb
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iCULQ-0007Nb-FP; Mon, 23 Sep 2019 15:50:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8166A3083362;
 Mon, 23 Sep 2019 19:49:59 +0000 (UTC)
Received: from dhcp-17-179.bos.redhat.com (dhcp-17-179.bos.redhat.com
 [10.18.17.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E2795D713;
 Mon, 23 Sep 2019 19:49:53 +0000 (UTC)
Date: Mon, 23 Sep 2019 15:49:51 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 03/16] tests/docker: remove python2.7 from docker9-mxe
Message-ID: <20190923194951.GD6528@dhcp-17-179.bos.redhat.com>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
 <20190919171015.12681-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190919171015.12681-4-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 23 Sep 2019 19:49:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 06:10:02PM +0100, Alex Benn=E9e wrote:
> From: John Snow <jsnow@redhat.com>
>=20
> When it was based on docker8 which uses python-minimal, it needed this.

Assuming this docker8 was a typo? I mean, s/docker8/debian8/ ?

- Cleber

> It no longer does.
>=20
> Goodbye, python2.7.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-Id: <20190918222546.11696-1-jsnow@redhat.com>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian9-mxe.docker | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker=
/dockerfiles/debian9-mxe.docker
> index 7431168dad9..62ff1cecf2d 100644
> --- a/tests/docker/dockerfiles/debian9-mxe.docker
> +++ b/tests/docker/dockerfiles/debian9-mxe.docker
> @@ -16,7 +16,6 @@ RUN apt-key adv --keyserver keyserver.ubuntu.com --re=
cv-keys C6BF758A33A3A276 &&
>  RUN apt-get update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
> -        libpython2.7-stdlib \
>          $(apt-get -s install -y --no-install-recommends gw32.shared-mi=
ngw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
> =20
> -ENV PATH $PATH:/usr/lib/mxe/usr/bin/=20
> +ENV PATH $PATH:/usr/lib/mxe/usr/bin/
> --=20
> 2.20.1
>=20
>=20

