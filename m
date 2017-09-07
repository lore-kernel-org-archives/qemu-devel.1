Received: from eggs.gnu.org ([2001:4830:134:3::10]:37064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpphv-0003PP-45
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpphq-0000WR-97
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:50:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpphq-0000WD-36
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 01:50:26 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-6-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f2b14829-bd81-f097-eff0-9fe77d82d097@redhat.com>
Date: Thu, 7 Sep 2017 07:50:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/19] target/s390x: move typedef of
 S390CPU to its definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 04.09.2017 17:43, David Hildenbrand wrote:
> Let's move it to the palce where struct S390CPU is defined.

s/palce/place/

> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu-qom.h | 2 --
>  target/s390x/cpu.h     | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Seems to compile fine for me with this patch applied, so:

Tested-by: Thomas Huth <thuth@redhat.com>
