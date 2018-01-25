Received: from eggs.gnu.org ([2001:4830:134:3::10]:51543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eejPK-0006Y4-5b
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eejPJ-0007Ig-6y
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:25:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eejPJ-0007IX-0o
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:25:41 -0500
Date: Thu, 25 Jan 2018 16:25:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180125152523.qvzcffsq4qgtzuew@sirius.home.kraxel.org>
References: <20180122120351.22369-1-f4bug@amsat.org>
	<20180122120351.22369-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180122120351.22369-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/7] usb-ccid: convert
 CCIDCardClass::init -> realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, Jan 22, 2018 at 09:03:47AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/usb/ccid.h                 |  9 +++++--
>  hw/usb/ccid-card-emulated.c   | 45 ++++++++++++++++++----------------
>  hw/usb/ccid-card-passthru.c   | 10 ++++----
>  hw/usb/dev-smartcard-reader.c | 57 +++++++++++++++--------------------=
--------
>  4 files changed, 56 insertions(+), 65 deletions(-)

Conflicts with another patch doing simliar things (switch to realize,
use error_report(), ...).

usb pull request is in flight.  Can you have a look once it is merged?

thanks,
  Gerd
