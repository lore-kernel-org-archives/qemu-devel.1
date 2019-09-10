Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FA320872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FA320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cPj-0002N0-5P
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i7c7x-00046j-II
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i7c7v-0001qF-JI
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:07:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46522)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i7c7v-0001q5-De
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:07:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA99BA3767D;
 Tue, 10 Sep 2019 09:07:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F22F19C4F;
 Tue, 10 Sep 2019 09:07:46 +0000 (UTC)
Date: Tue, 10 Sep 2019 10:07:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190910090743.GC8583@redhat.com>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
 <20190910084349.28817-45-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190910084349.28817-45-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 10 Sep 2019 09:07:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 44/45] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 09:43:48AM +0100, Alex Benn=C3=A9e wrote:
> From: Cleber Rosa <crosa@redhat.com>
>=20
> The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
> from tests/acceptance/linux_initrd.py, is currently failing to fetch
> the "vmlinuz" file.  The reason for the failure is that the Fedora
> project retires older versions from the "dl.fedoraproject.org" URL,
> and keeps them in "archives.fedoraproject.org".  As an added note,
> that test uses a Fedora 28 image, because of the specific Linux kernel
> version requirements of the test.
>=20
> For the sake of stability, let's use URLs from the archived and
> supposedely ever stable URLs.  The good news is that the currently
> supported versions are also hosted on the later.  This change limits
> itself to change the URLs, while keeping the fetched files the same
> (as can be evidenced by the unchanged hashes).

FWIW, I commented on the oiriginal patch before seeing this PR.
I don't think we should be using the archive URL for anything
which still exists on download.fedoraproject.org as that's placing
undesirable load on the Fedora master servers, instead of using its
primary CDN via the mirror services.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

