Received: from eggs.gnu.org ([2001:4830:134:3::10]:59405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e23cf-0000Z8-HM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e23ce-0003L7-Mz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:07:37 -0400
Date: Tue, 10 Oct 2017 16:37:10 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171010153710.GL1771@perard.uk.xensource.com>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170922154014.29350-6-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 05/34] misc: remove duplicated includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Daniel
	P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org

On Fri, Sep 22, 2017 at 12:39:45PM -0300, Philippe Mathieu-Daudé wrote:
> exec: housekeeping (funny since 02d0e095031)
> 
> applied using ./scripts/clean-includes
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  accel/tcg/translate-all.c          | 1 -
>  exec.c                             | 3 ---
>  hw/arm/spitz.c                     | 1 -
>  hw/char/xen_console.c              | 1 -
>  hw/core/machine.c                  | 1 -
>  hw/s390x/css.c                     | 1 -
>  target/openrisc/exception_helper.c | 1 -
>  tests/vhost-user-test.c            | 1 -
>  util/qemu-sockets.c                | 1 -
>  vl.c                               | 1 -
>  10 files changed, 12 deletions(-)
> 

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
