Received: from eggs.gnu.org ([2001:4830:134:3::10]:59534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cniZg-0007BO-5l
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cniZb-00071g-7W
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:17:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cniZb-00071I-1j
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:16:55 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43DDD76E0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:16:55 +0000 (UTC)
Message-ID: <1489483011.27633.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 14 Mar 2017 10:16:51 +0100
In-Reply-To: <20170313195547.21466-28-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-28-eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 27/30] trace: Fix parameter types in
 hw/usb
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
> through the full value at the callsite, as well as updating a couple
> of callers to use consistent typing to common trace calls.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
