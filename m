Received: from eggs.gnu.org ([2001:4830:134:3::10]:36684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gPQ4P-0003yD-VG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gPQ4M-0004PR-Po
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:49:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gPQ4M-0004Oi-Kq
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:49:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E41DA307D850
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:49:17 +0000 (UTC)
Date: Wed, 21 Nov 2018 16:19:11 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181112131835.xccqqvhu63xhh7pk@sirius.home.kraxel.org>
Message-ID: <nycvar.YSQ.7.76.1811211613440.4176@xnncv>
References: <20181030082340.17170-1-kraxel@redhat.com>
	<20181112131835.xccqqvhu63xhh7pk@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] fmops: fix off-by-one in AR_TABLE and
 DR_TABLE array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

 Hello Gerd,

+-- On Mon, 12 Nov 2018, Gerd Hoffmann wrote --+
| On Tue, Oct 30, 2018 at 09:23:40AM +0100, Gerd Hoffmann wrote:
| > Fixes: CVE-2018-???
| > Cc: P J P <ppandit@redhat.com>
| 
| ping, do we have a cve number meanwhile?

No, the off-by-one does not seem to have an adverse effect. One byte past 
AR_TABLE[75] array would likely read into DR_TABLE[75] array, which would 
anyway be accessible to a driver. It does not seem to crash Qemu either. I 
think it's more of a bug fix, than security fix. Hope that's okay.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
