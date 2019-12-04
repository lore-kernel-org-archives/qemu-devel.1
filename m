Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B616BC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 20:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF45205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 20:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrA4d2Gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF45205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icavj-000625-Fs
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 15:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1icasf-0004On-UU
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 15:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1icasZ-0002u9-Ub
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 15:04:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1icasW-0002pv-7M
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 15:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575489840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oEuiuQCOAYeBF72c0fzU8Ny5hTktnDMgZ3DYsBqPvbc=;
 b=BrA4d2GgDngg1zLWvhYbQIAIj0DU+rMz6rLq7/CzpSKbC5j+wR1d1MpX7HRSw6IXEFHZCq
 U3HFOPR0TRUZcMOw1ZUR/YzynTcR4w/SNcCsrhvSQns+e2iw8/5lBfdvpqzGSBy8KkCEtF
 CGI3wXV97Ss158hmHoPY/RYeUQtNBP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-2OeOLKNOPoSBvsqAFamm7g-1; Wed, 04 Dec 2019 15:03:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0A762275;
 Wed,  4 Dec 2019 20:03:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-37.rdu2.redhat.com
 [10.10.125.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F10A65C1B0;
 Wed,  4 Dec 2019 20:03:46 +0000 (UTC)
Date: Wed, 4 Dec 2019 15:03:45 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 0/7] Enable Travis builds on arm64, ppc64le and s390x
Message-ID: <20191204200345.GE31995@localhost.localdomain>
References: <20191204154618.23560-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204154618.23560-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 2OeOLKNOPoSBvsqAFamm7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-block@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Eric Auger <eric.auger@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 04, 2019 at 04:46:11PM +0100, Thomas Huth wrote:
> Travis recently added build hosts for arm64, ppc64le and s390x, so
> this is a welcome addition to our Travis testing matrix.
>=20
> Unfortunately, the builds are running in quite restricted LXD containers
> there, for example it is not possible to create huge files there (even
> if they are just sparse), and certain system calls are blocked. So we
> have to change some tests first to stop them failing in such environments=
.
>

Hi Thomas,

FIY, Avocado[1] has been running checks on those arches for a little
over two weeks and in my experience, there are still some reliability
issues (besides the other limitations you're already aware).

During the last week I've stopped seeing "machines" that wouldn't boot,
or severe networking limitations, but things are still not as smooth
as I'd like.

Anyway, I think we should insist on it, and give it a bit more time,
so I definitely agree with and appreciate this work.

[1] https://travis-ci.org/avocado-framework/avocado/builds

- Cleber.

> v2:
>  - Added "make check-tcg" and Alex' patch to disable cross-containers
>  - Explicitely set "dist: xenial" for arm64 and ppc64le since some
>    iotests are crashing on bionic on these hosts.
>  - Dropped "libcap-dev" from the package list since it will be replaced
>    by libcapng-dev soon.
>=20
> Alex Benn=E9e (1):
>   configure: allow disable of cross compilation containers
>=20
> Thomas Huth (6):
>   iotests: Provide a function for checking the creation of huge files
>   iotests: Skip test 060 if it is not possible to create large files
>   iotests: Skip test 079 if it is not possible to create large files
>   tests/hd-geo-test: Skip test when images can not be created
>   tests/test-util-filemonitor: Skip test on non-x86 Travis containers
>   travis.yml: Enable builds on arm64, ppc64le and s390x
>=20
>  .travis.yml                   | 86 +++++++++++++++++++++++++++++++++++
>  configure                     |  8 +++-
>  tests/hd-geo-test.c           | 12 ++++-
>  tests/qemu-iotests/005        |  5 +-
>  tests/qemu-iotests/060        |  3 ++
>  tests/qemu-iotests/079        |  3 ++
>  tests/qemu-iotests/220        |  6 +--
>  tests/qemu-iotests/common.rc  | 10 ++++
>  tests/tcg/configure.sh        |  6 ++-
>  tests/test-util-filemonitor.c | 11 +++++
>  10 files changed, 138 insertions(+), 12 deletions(-)
>=20
> --=20
> 2.18.1
>=20


