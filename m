Received: from eggs.gnu.org ([2001:4830:134:3::10]:48637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb3Fz-0004uR-UI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb3Fw-0000OL-Pn
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:48:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb3Fw-0000Nh-KY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:48:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C68E883C5
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:48:47 +0000 (UTC)
Date: Mon, 15 Jan 2018 11:48:41 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180115114841.GH8218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] RFE for patchew docker result reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, famz@redhat.com

Currently if I look at the patchew website for build logs, the 'docker'
job results are listed as a single expandable item.

Patchew runs 3 separate docker builds, however, and there's a tonne of
output to scroll through to find which one actually failed.

Thus, my RFE is to split the build log up so that instead of a single
"docker" result, it shows  "docker quick", "docker biuld" and
"docker mingw" as separate build logs / results. This would make it
easier to see at a glance which scenario failed.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
