Received: from eggs.gnu.org ([2001:4830:134:3::10]:57410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d86un-0004eS-1W
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d86um-0005TX-BY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:19:05 -0400
Date: Tue, 9 May 2017 17:18:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170509151856.GH5243@noname.str.redhat.com>
References: <20170502155452.7033-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502155452.7033-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/5] Improve I/O tests coverage of LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 02.05.2017 um 17:54 hat Daniel P. Berrange geschrieben:
> The main goal of this series is to get the I/O tests passing
> 100% with LUKS when run with './check -luks'. It also adds a
> few more combinations to the LUKS/dmcrypt interoperability
> test.
> 
> To make LUKS testing not quite as slow, we drop the PBKDF
> iteration count down to a very small value. This doesn't
> remove all overhead, as formatting the volume will always
> measure PBKDF timing over a 1 second interval.

It looks like patch 2 needs a rebase before it can be applied to my
block branch.

Kevin
