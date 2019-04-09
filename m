Received: from eggs.gnu.org ([209.51.188.92]:55972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDsJY-0007FW-Gr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDsJS-0002UU-OG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:05:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hDsJQ-0002T0-Ui
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:05:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id s81so10399532qke.13
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:05:23 -0700 (PDT)
Date: Tue, 9 Apr 2019 11:05:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190409110456-mutt-send-email-mst@kernel.org>
References: <20190409134536.15548-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190409134536.15548-1-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Olaf Hering <olaf@aepfle.de>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Apr 09, 2019 at 03:45:34PM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Two trivial fixes to avoid the latest EDK2 testing series to
> cause trouble to downstream distributions (in particular if
> they have PIE enforced).
> 
> Since v2:
> - addressed Laszlo's suggestion
> - reworded patch description
> 
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.html
> error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00992.html
> 
> Regards,
> 
> Phil.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


Peter do you want to merge this directly?

> Philippe Mathieu-Daudé (2):
>   roms: Rename the EFIROM variable to avoid clashing with iPXE
>   roms: Allow passing configure options to the EDK2 build tools
> 
>  roms/Makefile | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> -- 
> 2.20.1
