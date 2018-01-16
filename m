Received: from eggs.gnu.org ([2001:4830:134:3::10]:41716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKbc-0007Js-GF
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKbY-0006Gc-Gv
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:20:20 -0500
References: <1516002017-4981-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8655aba8-9d63-b101-e3fc-2dbc446ec2c3@redhat.com>
Date: Tue, 16 Jan 2018 14:20:00 +0800
MIME-Version: 1.0
In-Reply-To: <1516002017-4981-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Get rid of "vlan=X" example in
 the documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org



On 2018=E5=B9=B401=E6=9C=8815=E6=97=A5 15:40, Thomas Huth wrote:
> The vlan concept is marked as deprecated, so we should not use
> this for examples in the documentation anymore.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   qemu-options.hx | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 130016c..d0c8b06 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2257,8 +2257,8 @@ qemu-system-i386 linux.img -net nic -net tap
>   #launch a QEMU instance with two NICs, each one connected
>   #to a TAP device
>   qemu-system-i386 linux.img \
> -                 -net nic,vlan=3D0 -net tap,vlan=3D0,ifname=3Dtap0 \
> -                 -net nic,vlan=3D1 -net tap,vlan=3D1,ifname=3Dtap1
> +        -netdev tap,id=3Dnd0,ifname=3Dtap0 -device e1000,netdev=3Dnd0 =
\
> +        -netdev tap,id=3Dnd1,ifname=3Dtap1 -device rtl8139,netdev=3Dnd=
1
>   @end example
>  =20
>   @example

Applied.

Thanks
