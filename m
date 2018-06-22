Received: from eggs.gnu.org ([2001:4830:134:3::10]:48006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWS6y-0004fm-Qs
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWS6y-0004lo-7W
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:52:48 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-13-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9a4dd42c-7a8d-8304-c619-ff258e3feb46@redhat.com>
Date: Fri, 22 Jun 2018 21:52:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-13-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/14] hw/net/smc91c111: Use
 qemu_log_mask(GUEST_ERROR) instead of hw_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>

On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
> hw_error() finally calls abort(), but there is no need to abort here.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/net/smc91c111.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
