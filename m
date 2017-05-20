Received: from eggs.gnu.org ([2001:4830:134:3::10]:55439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aconole@redhat.com>) id 1dC2nG-00077H-B1
	for qemu-devel@nongnu.org; Sat, 20 May 2017 07:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aconole@redhat.com>) id 1dC2nD-0003QK-90
	for qemu-devel@nongnu.org; Sat, 20 May 2017 07:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aconole@redhat.com>) id 1dC2nD-0003Pm-37
	for qemu-devel@nongnu.org; Sat, 20 May 2017 07:43:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 021C4C05678D
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 11:43:29 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
References: <20170520080658.337-1-maxime.coquelin@redhat.com>
Date: Sat, 20 May 2017 07:43:23 -0400
In-Reply-To: <20170520080658.337-1-maxime.coquelin@redhat.com> (Maxime
	Coquelin's message of "Sat, 20 May 2017 10:06:58 +0200")
Message-ID: <f7tmva7lpno.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] vhost_net: do not expose MTU feature bit
 to kernel backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org

Maxime Coquelin <maxime.coquelin@redhat.com> writes:

> This patch removes MTU from the list of features supported by
> the kernel backend, so that vhost kernel backend does not have
> to advertise it to be negotiated.
>
> Cc: Aaron Conole <aconole@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>
