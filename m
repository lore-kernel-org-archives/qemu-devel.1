Received: from eggs.gnu.org ([2001:4830:134:3::10]:51851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnJIi-00074W-6B
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnJIe-0002oP-Pf
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:17:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnJIe-0002nP-KF
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:17:44 -0400
References: <1489381017-15733-1-git-send-email-gerg@uclinux.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7bb358c7-20b6-285f-e30a-4a9ea55f280f@redhat.com>
Date: Mon, 13 Mar 2017 14:17:38 +0800
MIME-Version: 1.0
In-Reply-To: <1489381017-15733-1-git-send-email-gerg@uclinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv2] hw/net: implement MIB counters in
 mcf_fec driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Ungerer <gerg@uclinux.org>
Cc: huth@tuxfamily.org, qemu-devel@nongnu.org, laurent@vivier.eu



On 2017=E5=B9=B403=E6=9C=8813=E6=97=A5 12:56, Greg Ungerer wrote:
> The FEC ethernet hardware module used on ColdFire SoC parts contains a
> block of RAM used to maintain hardware counters. This block is accessib=
le
> via the usual FEC register address space. There is currently no support
> for this in the QEMU mcf_fec driver.
>
> Add support for storing a MIB RAM block, and provide register level
> access to it. Also implement a basic set of stats collection functions
> to populate MIB data fields.
>
> This support tested running a Linux target and using the net-tools
> "ethtool -S" option. As of linux-4.9 the kernels FEC driver makes
> accesses to the MIB counters during its initialization (which it never
> did before), and so this version of Linux will now fail with the QEMU
> error:
>
>      qemu: hardware error: mcf_fec_read: Bad address 0x200
>
> This MIB counter support fixes this problem.
>
> Signed-off-by: Greg Ungerer<gerg@uclinux.org>
> Reviewed-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   hw/net/mcf_fec.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   1 file changed, 115 insertions(+)
>
> v2: clean up checkpatch issues

Applied, thanks.
