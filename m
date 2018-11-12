Received: from eggs.gnu.org ([2001:4830:134:3::10]:54336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gME9y-0006JQ-9q
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gME9t-00008U-8I
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:29:54 -0500
Received: from mail-eopbgr780105.outbound.protection.outlook.com
	([40.107.78.105]:21568
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gME9s-0008QH-8B
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:29:48 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 12 Nov 2018 15:29:27 +0000
Message-ID: <BN6PR2201MB12514AA001E055E5B1B9738FC6C10@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540300056-7935-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540300056-7935-4-git-send-email-aleksandar.markovic@rt-rk.com>,
	<33595f9c-b463-d3c1-dcad-ec0aae1c67af@vivier.eu>
In-Reply-To: <33595f9c-b463-d3c1-dcad-ec0aae1c67af@vivier.eu>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/3] linux-user: Add support for
 SO_REUSEPORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, Yunqiang Su <ysu@wavecomp.com>

Hi, Laurent. Is there any chance that from this series this patch only make=
s into 3.1? One can argue that this is a bug fix, but it is your call.

Thanks, Aleksandar

________________________________________
From: Laurent Vivier <laurent@vivier.eu>
Sent: Tuesday, October 23, 2018 7:49:38 PM
To: Aleksandar Markovic; qemu-devel@nongnu.org
Cc: aurelien@aurel32.net; Aleksandar Rikalo; Aleksandar Markovic; Stefan Ma=
rkovic; Petar Jovanovic; riku.voipio@iki.fi; Yunqiang Su
Subject: Re: [PATCH v2 3/3] linux-user: Add support for SO_REUSEPORT

On 23/10/2018 14:07, Aleksandar Markovic wrote:
> From: Yunqiang Su <ysu@wavecomp.com>
>
> Add support for SO_REUSEPORT, including strace support. SO_REUSEPORT
> was introduced relatively recently, since Linux 3.9, so use
> '#if defined SO_REUSEPORT'.
>
> Signed-off-by: Yunqiang Su <ysu@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/strace.c  |  3 +++
>  linux-user/syscall.c | 10 ++++++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
