Received: from eggs.gnu.org ([2001:4830:134:3::10]:52815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmW6l-0002Hz-Tb
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 22:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmW6i-0001Vr-Pz
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 22:18:27 -0400
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0413bb07-bd76-20fc-f29c-9b0bd60efd1d@redhat.com>
Date: Tue, 29 Aug 2017 04:18:20 +0200
MIME-Version: 1.0
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/79] Patch Round-up for stable 2.9.1,
 freeze on 2017-09-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

On 29.08.2017 02:13, Michael Roth wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v2.9.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.9-staging
>=20
> The release is planned for 2017-09-07:
>=20
>   http://wiki.qemu.org/Planning/2.9
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

I'd like to suggest the following patches:

601b9a9008c5a612d76073bb - target-s390x: Mask the SIGP order_code ...
b7da97eef74bf834be244de0 - monitor: Check whether TCG is enabled ...
17eb587aeb492fe68f8130b0 - slirp: tftp, copy sockaddr_size
99efaa2696caaf6182958e27 - hw/s390x/ipl: Fix crash with ...
36bed541ca886da735bef1e8 - fix qemu-system-unicore32 crashing ...
b190f477e29c7cd03a8fee49 - qemu-system-tricore: segfault when ...
8ccccff9dd7ba24c7a788611 - hw/ppc/spapr_rtc: Mark the RTC device ...
1f98e55385d11da1dc0de644 - hw/ppc/spapr_iommu: Fix crash when ...

Not sure, but maybe the following patch should be included, too, since
there were some bogus files in the old version of the U-Boot sources:

73663d71ef2bab201475d58e - PPC: E500: Update u-boot to v2017.07

 Thomas
