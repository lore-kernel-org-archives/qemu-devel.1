Received: from eggs.gnu.org ([2001:4830:134:3::10]:49639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyWK-0000Fn-Tk
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyWH-0007No-Mn
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:35:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFyWH-0007NL-GV
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3B8A81F0F
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 09:35:04 +0000 (UTC)
Date: Fri, 26 Oct 2018 15:04:55 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <7210c7e6-4b85-053c-83c5-524a3b74ef6f@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810261458190.8270@xnncv>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
	<7210c7e6-4b85-053c-83c5-524a3b74ef6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 2/3] adlib: mark as insecure and deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

+-- On Fri, 26 Oct 2018, Paolo Bonzini wrote --+
| I am dumb and I don't understand.  In set_ar_dr you get
| 
| 	v = 0xff
| 	ar = 15
| 	dr = 15
| 
| and OPL->AR_TABLE[60] is accessed.  The size of the array is 75, which
| seems to be actually 14 more than required.  Likewise OPL->DR_TABLE[60]
| is accessed.
| 
| The next accesses use SLOT->ksr which is 0 so it's fine too.

In set_ar_dr

  SLOT->AR = ar ? &OPL->AR_TABLE[ar<<2] : RATE_0;

SLOT->AR is set to point to OPL->DR_TABLE[60] and while so if s->ksr is set to 
15, in CALC_FCSLOT()

  SLOT->evsa = SLOT->AR[ksr];  <= accesses OPL->AR_TABLE[60 + 15];

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
