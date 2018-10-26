Received: from eggs.gnu.org ([2001:4830:134:3::10]:50488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyZo-0003Wi-6g
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyZl-00052Q-1K
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:38:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFyZk-000525-N0
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:38:40 -0400
Date: Fri, 26 Oct 2018 15:08:33 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <987110b6-9f7d-d82a-69b7-dcd78094c1a6@kaod.org>
Message-ID: <nycvar.YSQ.7.76.1810261507480.8270@xnncv>
References: <20181022121907.13635-1-ppandit@redhat.com>
	<20181023153710.GZ12127@umbus.hotspot.internet-for-guests.com>
	<679f5ba4-749b-72ee-62a0-40e5efc178e0@kaod.org>
	<nycvar.YSQ.7.76.1810251204450.11480@xnncv>
	<987110b6-9f7d-d82a-69b7-dcd78094c1a6@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/pnv: check size before data buffer
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Qemu Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Moguofang <moguofang@huawei.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

+-- On Fri, 26 Oct 2018, C=E9dric Le Goater wrote --+
| On 10/25/18 8:45 AM, P J P wrote:
| >  - While we refactor the routine for better, a patch below seem okay =
to fix=20
| >    the OOB access issue?
|=20
| I think it is fine. Please add something like : =20
|=20
| 	qemu_log_mask(LOG_GUEST_ERROR, "ECCB: invalid operation at @0x%08x"=20
| 			" size %d\n", opb_addr, sz);

Okay, will do.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
