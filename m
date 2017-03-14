Received: from eggs.gnu.org ([2001:4830:134:3::10]:59496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cniZS-00071e-1P
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cniZN-0006uf-3c
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cniZM-0006uL-Td
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:16:41 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28D9C461F7
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:16:41 +0000 (UTC)
Message-ID: <1489482998.27633.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 14 Mar 2017 10:16:38 +0100
In-Reply-To: <20170313195547.21466-12-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-12-eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 11/30] trace: Fix parameter types in
 hw/audio
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
