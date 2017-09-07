Received: from eggs.gnu.org ([2001:4830:134:3::10]:39470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dq0Ld-0000mr-DM
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dq0LY-0008TB-Le
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dq0LY-0008Sf-FR
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:12:08 -0400
Date: Thu, 7 Sep 2017 19:11:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907191159.767509da.cohuck@redhat.com>
In-Reply-To: <20170904154316.4148-20-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-20-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/19] s390x: get rid of
 cpu_s390x_create()
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

On Mon,  4 Sep 2017 17:43:16 +0200
David Hildenbrand <david@redhat.com> wrote:

> Now that there is only one user of cpu_s390x_create() left, make cpu
> creation looks like on x86.
> - Perform the model/properties split and checks in s390_init_cpus()
> - Parse features only once without having to remember if already parsed
> - Pass only the typename to s390x_new_cpu()
> - Use the typename of an existing CPU for hotplug via cpu-add
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 29 +++++++++++++++++++++++++++--
>  target/s390x/cpu.h         |  2 +-
>  target/s390x/helper.c      | 45 ++-------------------------------------------
>  target/s390x/internal.h    |  1 -
>  4 files changed, 30 insertions(+), 47 deletions(-)

LGTM
