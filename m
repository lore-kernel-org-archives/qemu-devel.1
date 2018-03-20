Received: from eggs.gnu.org ([2001:4830:134:3::10]:41243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ey79l-0003Jm-CI
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ey79g-0005xp-Gc
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:37:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ey79g-0005x3-D4
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:37:40 -0400
References: <20180316062822.15425-1-famz@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3da0908b-5ccf-b233-f0b3-efc9df39a9c2@redhat.com>
Date: Tue, 20 Mar 2018 10:37:33 +0800
MIME-Version: 1.0
In-Reply-To: <20180316062822.15425-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.13 v3 0/2] slirp: Add query-usernet
 QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>



On 2018=E5=B9=B403=E6=9C=8816=E6=97=A5 14:28, Fam Zheng wrote:
> v3: - Add Eric's rev-by to patch 2.
>      - Address Eric's comments on patch 1:
>        * Fix spell/grammar: "programmed", "awaiting".
>        * Fix include "qapi/qapi-commands-net.h".
>        * Underscores to dashes.
>        * "Since 2.13" now.
>
> v2: Fix compiler error. [patchew]
>
> The command is a counterpart of HMP "info usernet" and is at least very=
 useful
> for the VM tests. So add it.
>
> Fam Zheng (2):
>    slirp: Add "query-usernet" QMP command
>    tests: Use query-usernet instead of 'info usernet'
>
>   net/slirp.c        |  26 +++++++
>   qapi/net.json      | 201 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   slirp/libslirp.h   |   2 +
>   slirp/misc.c       | 156 +++++++++++++++++++++++++++++------------
>   slirp/tcp.h        |  15 ----
>   tests/vm/basevm.py |  14 ++--
>   6 files changed, 347 insertions(+), 67 deletions(-)
>

Hi Samuel:

Does this looks good for you? I believe it's better to be merged through=20
your tree.

Thanks
