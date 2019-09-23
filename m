Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD66C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BC02089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BC02089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQxQ-00029y-S2
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCQvV-0000c4-Fv
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCQvT-0002EG-B5
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:11:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCQvT-0002CZ-1E
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:10:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B63FC5859E;
 Mon, 23 Sep 2019 16:10:57 +0000 (UTC)
Received: from dhcp-17-179.bos.redhat.com (dhcp-17-179.bos.redhat.com
 [10.18.17.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC91100197A;
 Mon, 23 Sep 2019 16:10:52 +0000 (UTC)
Date: Mon, 23 Sep 2019 12:10:50 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/5] docker: move tests from python2 to python3
Message-ID: <20190923161050.GA29623@dhcp-17-179.bos.redhat.com>
References: <20190920221255.30412-1-jsnow@redhat.com>
 <20190920221255.30412-2-jsnow@redhat.com>
 <4ed65a51-051c-0a61-d63c-042306740a7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4ed65a51-051c-0a61-d63c-042306740a7d@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 23 Sep 2019 16:10:57 +0000 (UTC)
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
Cc: Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 21, 2019 at 10:48:06AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/21/19 12:12 AM, John Snow wrote:
> > As part of the push to drop python2 support, replace any explicit pyt=
hon2
> > dependencies with python3 versions.
> >=20
> > For centos, python2 still exists as an implicit dependency, but by ad=
ding
> > python3 we will be able to build even if the configure script begins =
to
> > require python 3.5+.
> >=20
> > Tested with centos7, fedora, ubuntu, ubuntu1804, and debian 9 (amd64)=
.
> > Tested under a custom configure script that requires Python 3.5+.
> >=20
> > the travis dockerfile is also moved to using python3, which was teste=
d
> > by running `make docker-test-build@travis`, which I hope is sufficien=
t.
> >=20
> > Signed-off-by: John Snow <jsnow@redhat.com>
>=20
> > Message-id: 20190920200049.27216-1-jsnow@redhat.com
>   ^ remove
>=20
> v1 has:
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> > ---
> >  tests/docker/dockerfiles/centos7.docker             | 2 +-
> >  tests/docker/dockerfiles/debian-ports.docker        | 2 +-
> >  tests/docker/dockerfiles/debian-sid.docker          | 2 +-
> >  tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 +-
> >  tests/docker/dockerfiles/debian10.docker            | 2 +-
> >  tests/docker/dockerfiles/debian8.docker             | 3 +--
>=20
> If you queue this patch at the end of your series, no need to patch
> debian8.docker.
>

Yep, agreed.

- Cleber.

