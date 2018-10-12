Received: from eggs.gnu.org ([2001:4830:134:3::10]:53167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAwsC-0004tm-B0
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAws8-0007PB-9m
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAws6-0007JY-8y
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:48:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41D5E62EA9
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 12:48:49 +0000 (UTC)
Date: Fri, 12 Oct 2018 14:48:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181012124845.yriqk5v46qprcps5@sirius.home.kraxel.org>
References: <20181008185013.19371-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008185013.19371-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sdl2: Support all virtio-gpu formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Oct 08, 2018 at 08:50:13PM +0200, Max Reitz wrote:
> There are some 2D resource formats that can be used through virtio-gpu,
> but which are not supported by SDL2 when used for a scanout; these are
> all alpha-channel formats and also XBGR (RGBX in non-BE pixman).
> 
> Add these formats in the switch converting pixman to SDL format
> constants so a guest cannot crash the VM by triggering the
> g_assert_not_reached() with an unsupported format.

fixed (sdl2_2d_check_format update) & queued.

cheers,
  Gerd
