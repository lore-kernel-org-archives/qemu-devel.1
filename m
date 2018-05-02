Received: from eggs.gnu.org ([2001:4830:134:3::10]:52620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDmct-0000Qr-Te
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDmco-00081C-Tr
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:56:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fDmco-00080p-Ok
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:56:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47949722DE
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 07:56:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180427192852.15013-1-lersek@redhat.com>
	<20180427192852.15013-6-lersek@redhat.com>
Date: Wed, 02 May 2018 09:56:28 +0200
In-Reply-To: <20180427192852.15013-6-lersek@redhat.com> (Laszlo Ersek's
	message of "Fri, 27 Apr 2018 21:28:52 +0200")
Message-ID: <874ljq8p8z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qapi: deprecate CpuInfoFast.arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org

Laszlo Ersek <lersek@redhat.com> writes:

> The TARGET_BASE_ARCH values from "configure" don't all map to the
> @CpuInfoArch enum constants; in particular "s390x" from the former does
> not match @s390 in the latter. Clients are known to rely on the @s390
> constant specifically, so we can't change it silently. Instead, deprecate
> the @CpuInfoFast.@arch member (in favor of @CpuInfoFast.@target) using the
> regular deprecation process.
>
> (No deprecation reminder is added to sysemu_target_to_cpuinfo_arch(): once
> @CpuInfoFast.@arch is removed, the assignment expression that calls
> sysemu_target_to_cpuinfo_arch() from qmp_query_cpus_fast() will have to
> disappear; in turn the static function left without callers will also
> break the build, thus it'll have to go.)
>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
