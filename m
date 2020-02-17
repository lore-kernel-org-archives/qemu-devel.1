Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FECC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7E32070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+V1BZxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7E32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3msM-00012e-Pz
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 15:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j3moa-0004jw-TR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j3moZ-000427-M6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j3moZ-00041j-HW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581970583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ghy0AuavPf+zlT2qaTQtiOz8z2bWa3ToJknQXuNclPc=;
 b=F+V1BZxS2+vN/WMkHgZmPnsyDpSeRse9kva8sd+16KsfOwzh15WA0svGpO+dMBNms/3c9u
 pxC1nfldAZVILsZKh6B9PfJNHneK/7Hx+V3cBlUk5epw8xUA2d4FwRlsRAQzPo2/2KlM1t
 kSfNXmCc2h1Z5stbXIVOV0PTQ1uQKRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-DQIKe04sMzmjUh6MZjDXMA-1; Mon, 17 Feb 2020 15:16:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9BF3800D5E;
 Mon, 17 Feb 2020 20:16:13 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E2835D9E2;
 Mon, 17 Feb 2020 20:16:10 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/6] Travis: Change default environment to Ubuntu Bionic
Date: Mon, 17 Feb 2020 15:16:03 -0500
Message-Id: <20200217201609.788825-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DQIKe04sMzmjUh6MZjDXMA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of the Travis jobs currently run on Ubuntu 16.04 (Xenial),
and some are already using 18.04 (Bionic). Other job will [1]
need the swap very soon. On Travis's Bionic environment it is
allowed the use of nested virtualization, so some tests relying
on kvm can be executed (currently they are skipped).

There is one problem [2] with libssh-dev on Ubuntu Bionic
though. Considering that, on this series I simply does not install it,
so QEMU is built without libssh support. I don't think this is
an impediment for this change anyway, if there is a need to test libssh
support we can add a single Xenial-based job for that.

This series was tested on [3]. The following jobs are intermittently
failing, I ran 3x each:

'GCC check-acceptance': 1 (Interrupted test)
'GCC plugins check-tcg (user)': 1 (job timeout)
'GCC check-tcg (some-softmmu)': 2 (docker OCI runtime start failed)
'GCC plugins check-tcg (some-softmmu)':  1 (OCI runtime start failed)

I've seen [4] those errors related with docker OCI on Xenial too.

Thanks!
- wainer

REFERENCES
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg677078.html
[2] https://bugs.launchpad.net/qemu/+bug/1838763
[3] https://travis-ci.org/wainersm/qemu/builds/651549376
[4] https://travis-ci.org/qemu/qemu/builds/651506018

Wainer dos Santos Moschetta (6):
  travis.yml: Bump default environment to Ubuntu Bionic
  travis.yml: Fix 'GCC9 with sanitizers' job on Ubuntu Bionic
  travis.yml: Fix 'GCC check-acceptance' job on Ubuntu Bionic
  travis.yml: Fix 'Clang (main-softmmu)' job on Ubuntu Bionic
  travis.yml: Run '[ppc64] GCC check-tcg' job on Ubuntu Bionic
  travis.yml: Run '[aarch64] GCC check-tcg' job on Ubuntu Bionic

 .travis.yml | 79 ++++++++++-------------------------------------------
 1 file changed, 14 insertions(+), 65 deletions(-)

--=20
2.24.1


