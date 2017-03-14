Received: from eggs.gnu.org ([2001:4830:134:3::10]:59406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cniZE-0006u0-94
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cniZ6-0006mR-ML
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:16:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cniZ6-0006l8-Di
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:16:24 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 727BB80F6D
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:16:24 +0000 (UTC)
Message-ID: <1489482980.27633.0.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 14 Mar 2017 10:16:20 +0100
In-Reply-To: <20170313195547.21466-8-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-8-eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 07/30] trace: Fix parameter types in ui
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Mo, 2017-03-13 at 14:55 -0500, Eric Blake wrote:
> An upcoming patch will let the compiler warn us when we are silently
> losing precision in traces; update the trace definitions to pass
> through the full value at the callsite.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
