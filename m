Received: from eggs.gnu.org ([2001:4830:134:3::10]:37056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dq0FC-0007IX-TW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dq0F7-0004uz-Rj
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:05:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dq0F7-0004uN-MK
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:05:29 -0400
Date: Thu, 7 Sep 2017 19:05:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907190521.242b5967.cohuck@redhat.com>
In-Reply-To: <20170904154316.4148-19-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-19-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/19] s390x: implement
 query-hotpluggable-cpus
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

On Mon,  4 Sep 2017 17:43:15 +0200
David Hildenbrand <david@redhat.com> wrote:

> CPU hotplug is only possible on a per core basis on s390x.
> 
> As we now have ms->possible_cpus, we can get rid of the global variable
> cpu_states.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 90 +++++++++++++++++++++++++++++++++-------------
>  qapi-schema.json           | 16 +++++++++
>  2 files changed, 81 insertions(+), 25 deletions(-)

LGTM
