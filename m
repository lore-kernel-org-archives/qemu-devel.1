Received: from eggs.gnu.org ([2001:4830:134:3::10]:42880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPngV-0005Wl-FL
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPngQ-0005PI-FV
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:02:15 -0500
Date: Thu, 22 Nov 2018 13:02:05 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181122120205.jhmzcd6h2nmnytyu@sirius.home.kraxel.org>
References: <20181121203720.75916-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121203720.75916-1-r.bolshakov@yadro.com>
Subject: Re: [Qemu-devel] [PATCH] roms: seabios: Rename CROSS_COMPILE to
 CROSS_PREFIX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Wed, Nov 21, 2018 at 11:37:21PM +0300, Roman Bolshakov wrote:
> SeaBIOS introduced CROSS_PREFIX in 2013 but it's not set in roms
> Makefile.

> -		CROSS_COMPILE=$(x86_64_cross_prefix) \
> +		CROSS_PREFIX=$(x86_64_cross_prefix) \

I'm wondering how that slipped though, IIRC I had actually tested
seabios crossbuilds ...

Queued up (for 4.0).

thanks,
  Gerd
