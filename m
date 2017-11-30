Received: from eggs.gnu.org ([2001:4830:134:3::10]:50492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKR6Q-0008Np-JC
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKR6H-00088w-Eq
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:50:18 -0500
References: <20171130140536.31164-1-cohuck@redhat.com>
	<cde3b71f-3760-5eb7-cfdb-35dd1cd356c8@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cdcf1379-1ec4-6a83-989b-ef6819bb6e0a@redhat.com>
Date: Thu, 30 Nov 2017 16:50:00 +0100
MIME-Version: 1.0
In-Reply-To: <cde3b71f-3760-5eb7-cfdb-35dd1cd356c8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: nuke DPRINTF in helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, borntraeger@de.ibm.com

On 30.11.2017 15:29, David Hildenbrand wrote:
> On 30.11.2017 15:05, Cornelia Huck wrote:
>> It is not used anywhere.
Right, looks like I move the last user of this macro away during the
--disable-tcg rework.

Reviewed-by: Thomas Huth <thuth@redhat.com>
