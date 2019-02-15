Received: from eggs.gnu.org ([209.51.188.92]:50045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gug36-0005PQ-9r
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gug34-0006Db-Ey
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:09:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gug34-0006B6-5z
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:09:10 -0500
Date: Fri, 15 Feb 2019 17:09:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190215160903.GB7941@localhost.localdomain>
References: <20181107131000.27744-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107131000.27744-1-danielhb413@gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 0/3] HMP/snapshot changes - do
 not use ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com, armbru@redhat.com

Am 07.11.2018 um 14:09 hat Daniel Henrique Barboza geschrieben:
> changes in v3:
> - rebased to v3.1.0-rc0 tag
> - hmp-commands.hx documentation now mentions the change of semantics
> starting version 3.2.
> - previous version link:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg00629.html
> 
> 
> It is not uncommon to see bugs being opened by testers that attempt to
> create VM snapshots using HMP. It turns out that "0" and "1" are quite
> common snapshot names and they trigger a lot of bugs. I gave an example
> in the commit message of patch 1, but to sum up here: QEMU treats the
> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
> is documented as such, but this can lead to strange situations.
> 
> Given that it is strange for an API to consider a parameter to be 2 fields
> at the same time, and inadvently treating them as one or the other, and
> that removing the ID field is too drastic, my idea here is to keep the
> ID field for internal control, but do not let the user set it.
> 
> This series simplifies the meaning of savevm/loadvm/delvm to be up to
> par to what the QEMU code (and Libvirt) is already doing: snapshot
> operations using "tag" semantics only, leaving the "id" to be
> automatically calculated by the block drivers and used internally
> only.
> 
> This change of semantics does not affect existing snapshots. What
> changes is that any HMP operations with them will use the
> updated semantics.

Thanks, applied to the block branch.

Kevin
