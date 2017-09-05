Received: from eggs.gnu.org ([2001:4830:134:3::10]:54034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpD3m-000131-IS
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpD3a-0002TH-4Q
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:34:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpD3Z-0002R5-VF
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:34:18 -0400
Date: Tue, 5 Sep 2017 14:34:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170905143411.0ef874d4.cohuck@redhat.com>
In-Reply-To: <20170904154316.4148-6-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On Mon,  4 Sep 2017 17:43:02 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's move it to the palce where struct S390CPU is defined.

s/palce/place/

Can also fix on applying.

> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu-qom.h | 2 --
>  target/s390x/cpu.h     | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
