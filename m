Received: from eggs.gnu.org ([2001:4830:134:3::10]:58927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYTE0-0005UJ-0N
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 02:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYTDz-0005vg-Cs
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 02:51:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYTDz-0005vT-6y
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 02:51:35 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5591976EA
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 07:51:35 +0000 (UTC)
Message-ID: <1485849093.23903.16.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 08:51:33 +0100
In-Reply-To: <20170130104540.14660-1-marcandre.lureau@redhat.com>
References: <20170130104540.14660-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] spice: wakeup QXL worker to pick up mouse
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Mo, 2017-01-30 at 14:45 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Without it, server-mode mouse is "slow" to update position: QXL will
> wait until new display commands come. This is very visible with
> virtio-gpu.

Added to ui queue.

thanks,
  Gerd
