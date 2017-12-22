Received: from eggs.gnu.org ([2001:4830:134:3::10]:58672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCjM-0003Xb-KC
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCjJ-0007Za-B4
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:06:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCjJ-0007YQ-5w
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:06:33 -0500
References: <1513697336-2863-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ff281e1b-3c8b-389b-1c87-a14bd3ecfe81@redhat.com>
Date: Fri, 22 Dec 2017 10:06:23 +0800
MIME-Version: 1.0
In-Reply-To: <1513697336-2863-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] net: Remove "-net channel" and update
 "-net nic" docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, peter.maydell@linaro.org



On 2017=E5=B9=B412=E6=9C=8819=E6=97=A5 23:28, Thomas Huth wrote:
> Remove the deprecated (and even undocumented) "-net channel" parameter,
> and update our docs with regards to the possibility to use "netdev=3D..=
."
> together with the "-net nic" option for embedded NICs.
>
> Thomas Huth (3):
>    net: Remove the legacy "-net channel" parameter
>    qemu-doc: The "-net nic" option can be used with "netdev=3D...", too
>    qemu-doc: Update the deprecation information of -tftp, -bootp, -redi=
r
>      and -smb
>
>   include/net/slirp.h |  2 --
>   net/net.c           |  7 -------
>   net/slirp.c         | 34 ----------------------------------
>   qemu-doc.texi       | 38 +++++++++++++++++++++-----------------
>   qemu-options.hx     | 14 ++++++++------
>   5 files changed, 29 insertions(+), 66 deletions(-)
>

Applied.

Thanks
