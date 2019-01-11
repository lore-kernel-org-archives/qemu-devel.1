Received: from eggs.gnu.org ([209.51.188.92]:38991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gi0gd-0007mL-F4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gi0gc-0001AV-LL
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:33:39 -0500
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-16-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a7ef73f-97a4-d270-9836-3936b7be1046@redhat.com>
Date: Fri, 11 Jan 2019 18:32:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190111140857.4211-16-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 15/15] ui/console: Add
 "ui/pixelformat.h" to declare PixelFormat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

On 11/01/19 15:08, Philippe Mathieu-Daud=C3=A9 wrote:
> PixelFormat is used by "ui/console.h" and by "ui/qemu-pixman.h".

ui/console.h already includes ui/qemu-pixman.h, just move it there?

Paolo

> Create the new header "ui/pixelformat.h" to declare this structure,
> and remove the forward declaration from "qemu/typedefs.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because "ui/console.h" has on license, so I added a default one.
