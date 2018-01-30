Received: from eggs.gnu.org ([2001:4830:134:3::10]:53643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1egapY-0005op-Qz
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1egaos-00026U-Ab
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:40:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1egaos-00024o-1x
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:39:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EBD633BC5
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 18:39:45 +0000 (UTC)
Date: Tue, 30 Jan 2018 18:39:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180130183931.GF2536@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] 4.14 linux kernel vs postcopy migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, aarcange@redhat.com
Cc: peterx@redhat.com, quintela@redhat.com

Hi,
  It looks like the 4.14 linux kernel has something which breaks
postcopy;  4.13 and 4.15 both seem OK, but both Peter and myself ran
into problems with double faults after postcopy migration on a Fedora
27 host, and I've recreated the same problem on upstream kernels
=66rom v4.14.0 through v4.14.0.
  The stand alone userfaultfd tests seem ok though.

I might try some further bisecting, but for now I think I'll just
flip to a bleeding edge 4.15.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
