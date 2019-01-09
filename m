Received: from eggs.gnu.org ([209.51.188.92]:50835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghH3t-0000ag-O5
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghH3s-0003AN-SA
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:50:37 -0500
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
	<20190109112311.GB4867@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ddd78e0-90ed-a6e5-c454-f1a2e44c1a37@redhat.com>
Date: Wed, 9 Jan 2019 17:42:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190109112311.GB4867@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: add rough-block-status
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org

On 09/01/19 12:23, Kevin Wolf wrote:
> Also note that this is only metadata preallocation; full preallocation
> will still return allocated for the protocol layer and so it will always
> be slow.

Full preallocation these days can create images with preallocated but
known-zero blocks, I think?

Paolo
