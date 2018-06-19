Received: from eggs.gnu.org ([2001:4830:134:3::10]:39087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVAMk-0008RF-Qt
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVAMh-0007Ry-Me
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:43:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVAMh-0007R6-HG
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:43:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D6AE401EF00
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 06:43:41 +0000 (UTC)
Date: Tue, 19 Jun 2018 08:43:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180619064334.a2f6yv7yyiwlyqsk@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-25-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180618161729.334-25-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 24/26] virtio-gpu: split virtio-gpu,
 introduce virtio-gpu-base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

On Mon, Jun 18, 2018 at 06:17:27PM +0200, Marc-Andr=E9 Lureau wrote:
> Add a base class that is common to virtio-gpu and vhost-user-gpu
> devices.

More verbose commit message please.  What functionality is common and
handled by the new (abstract?) base class?  (same for patch #25).

cheers,
  Gerd
