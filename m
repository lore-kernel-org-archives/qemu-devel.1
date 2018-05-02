Received: from eggs.gnu.org ([2001:4830:134:3::10]:52756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDmdq-0000yj-DL
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDmdp-0000Mv-LH
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:57:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fDmdp-0000MV-GO
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:57:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F331040704BE
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 07:57:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180427192852.15013-1-lersek@redhat.com>
	<20180427192852.15013-5-lersek@redhat.com>
Date: Wed, 02 May 2018 09:57:31 +0200
In-Reply-To: <20180427192852.15013-5-lersek@redhat.com> (Laszlo Ersek's
	message of "Fri, 27 Apr 2018 21:28:51 +0200")
Message-ID: <87zi1i7ams.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/5] qapi: discriminate CpuInfoFast on
 SysEmuTarget, not CpuInfoArch
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

> Add a new field @target (of type @SysEmuTarget) to the output of the
> @query-cpus-fast command, which provides more information about the
> emulation target than the field @arch (of type @CpuInfoArch). Make @target
> the new discriminator for the @CpuInfoFast return structure. Keep @arch
> for compatibility.
>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
