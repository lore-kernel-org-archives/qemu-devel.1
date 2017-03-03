Received: from eggs.gnu.org ([2001:4830:134:3::10]:43056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjnxP-0000BU-Et
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:13:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjnxK-0006JY-7o
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:13:19 -0500
References: <1488548254-456-1-git-send-email-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <39ad7cac-b29e-b01e-723c-8cbdb1cf3ca9@redhat.com>
Date: Fri, 3 Mar 2017 15:13:10 +0100
MIME-Version: 1.0
In-Reply-To: <1488548254-456-1-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: QOM'ify sPAPRRTCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03.03.2017 14:37, C=C3=A9dric Le Goater wrote:
> Also use an 'Object *' under the sPAPR machine to hold the RTC
> object.

The change from TYPE_SYS_BUS_DEVICE to TYPE_DEVICE is certainly a good
idea! But what's the advantage of using Object* instead of DeviceState*
in sPAPRMachineState ?

 Thomas
