Received: from eggs.gnu.org ([2001:4830:134:3::10]:41808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKi6-0004Nn-J6
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKi2-0004k6-Jy
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:20:22 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dnKi2-0004jt-CQ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:20:18 -0400
Received: by mail-wm0-x22e.google.com with SMTP id u26so24200083wma.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 01:20:18 -0700 (PDT)
Date: Thu, 31 Aug 2017 09:20:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170831082015.GF13619@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-11-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-11-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/13] hvf: implement vga dirty page
 tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 03:26:59AM -0500, Sergio Andres Gomez Del Real wrote:
> +static void hvf_log_start(MemoryListener *listener,
> +                          MemoryRegionSection *section, int old, int new)
> +{
> +    if (old != 0)
> +        return;

QEMU coding style uses curly braces even when the if statement body only
has 1 line.

> +
> +    hvf_set_dirty_tracking(section, 1);
> +}
> +
> +static void hvf_log_stop(MemoryListener *listener,
> +                         MemoryRegionSection *section, int old, int new)
> +{
> +    if (new != 0)
> +        return;

Same here.
