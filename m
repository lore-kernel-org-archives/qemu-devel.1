Received: from eggs.gnu.org ([2001:4830:134:3::10]:46479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eYVIW-0002vl-32
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 06:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eYVIS-0000ga-6X
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 06:08:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eYVIS-0000g9-05
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 06:08:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECE4BC047B65
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 11:08:50 +0000 (UTC)
Date: Mon, 8 Jan 2018 12:08:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180108110849.325psbrk6g7bstsc@sirius.home.kraxel.org>
References: <20171218191228.31018-1-berrange@redhat.com>
	<20171218191228.31018-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218191228.31018-2-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 01/13] ui: remove 'sync' parametr from
 vnc_update_client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>

On Mon, Dec 18, 2017 at 07:12:16PM +0000, Daniel P. Berrange wrote:
> There is only one caller of vnc_update_client and that always passes false
> for the 'sync' parameter.

Unused since commit 50628d3479e4f9aa97e323506856e394fe7ad7a6.
Good catch.

What is the state of this series btw (/me busy wading through my
email backlog ...) ?

cheers,
  Gerd
