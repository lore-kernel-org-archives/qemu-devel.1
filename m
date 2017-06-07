Received: from eggs.gnu.org ([2001:4830:134:3::10]:60546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIdw7-0005KO-Kg
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIdw3-0006QD-JT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:35:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIdw3-0006Ow-6d
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:35:55 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170606165510.33057-3-pasic@linux.vnet.ibm.com> (Halil Pasic's
	message of "Tue, 6 Jun 2017 18:55:09 +0200")
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-3-pasic@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 18:35:51 +0200
Message-ID: <87wp8ndac8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] vmstate: error hint for failed
 equal checks part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> Verbose error reporting for the _EQUAL family. Modify the standard _EQUAL
> so the hint states the assertion probably failed due to a bug. Introduce
> _EQUAL_HINT for specifying a context specific hint.
>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> Keeping this separate for now because we may want something different
> here. E.g. no new macros and adding an extra NULL parameter for all
> pre-existing  _EQUAL usages.


I think that the best thing is to just add the HINT always.  I checked
and there are only 25 uses of VMSTATE_*_EQUAL.  I agree with dave that
adding a NULL there, and make they work is a better strategy.

We are adding 8 new macros so we don't have to change 25 callers?

Later, Juan.
