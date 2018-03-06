Received: from eggs.gnu.org ([2001:4830:134:3::10]:46501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etG15-0002xk-VF
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etG15-0006Mx-4H
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:04:43 -0500
Date: Tue, 6 Mar 2018 18:04:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180306170426.GJ7139@localhost.localdomain>
References: <cover.1520352600.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520352600.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Add checks for corruption in the
 snapshot table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 06.03.2018 um 17:14 hat Alberto Garcia geschrieben:
> Hey,
> 
> here's the new version of this series. It fixes a leak reported by
> Kevin and adds a couple of error_report_err() to make use of the
> message returned by qcow2_validate_table().

Thanks, applied to the block branch.

Kevin
