Received: from eggs.gnu.org ([2001:4830:134:3::10]:39317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVxqg-0006EP-J1
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVxqd-00025r-Gb
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:33:58 -0400
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f9aba1f2-009a-1648-5d01-5e947bb86394@redhat.com>
Date: Thu, 21 Jun 2018 13:33:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180620100825.22476-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/7] s390x/tcg: drop tod_basetime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 20.06.2018 12:08, David Hildenbrand wrote:
> Never set to anything but 0.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c         | 1 -
>  target/s390x/cpu.h         | 1 -
>  target/s390x/misc_helper.c | 4 ++--
>  3 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
