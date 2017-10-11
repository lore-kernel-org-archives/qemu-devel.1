Received: from eggs.gnu.org ([2001:4830:134:3::10]:57990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2CTd-00035E-CX
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2CTa-0005b1-9k
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2CTa-0005Yu-4A
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:34:50 -0400
Date: Wed, 11 Oct 2017 10:34:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171011103438.2688f1b8.cohuck@redhat.com>
In-Reply-To: <20170928203708.9376-21-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-21-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 20/30] s390x/tcg: implement SIGP SENSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>

On Thu, 28 Sep 2017 22:36:58 +0200
David Hildenbrand <david@redhat.com> wrote:

> Add it as preparation for TCG. Sensing coul later be done completely

s/coul/could/

> lockless.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/sigp.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
