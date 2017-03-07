Received: from eggs.gnu.org ([2001:4830:134:3::10]:60881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clAYX-0003PM-Ug
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clAYU-0000pj-SP
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:33:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1clAYU-0000pQ-Mz
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:33:14 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488011202-32121-2-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1488875257-7870-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Date: Tue, 07 Mar 2017 09:33:11 +0100
In-Reply-To: <1488875257-7870-1-git-send-email-caoj.fnst@cn.fujitsu.com> (Cao
	jin's message of "Tue, 7 Mar 2017 16:27:37 +0800")
Message-ID: <87wpc1ebaw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10] msix: rename and create a wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Cao jin <caoj.fnst@cn.fujitsu.com> writes:

> Rename msix_init to msix_validate_and_init which doesn't assert;
> New a wrapper msix_init to assert programming error.
>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
