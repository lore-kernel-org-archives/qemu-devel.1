Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dv1X0-0001NT-4U
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dv1Wu-0000h1-L5
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dv1Wu-0000gZ-F0
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:28:36 -0400
Date: Thu, 21 Sep 2017 15:28:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170921152829.3ae552f5@nial.brq.redhat.com>
In-Reply-To: <20170918160012.4317-4-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/27] target/s390x: get rid of
 next_core_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>

On Mon, 18 Sep 2017 17:59:48 +0200
David Hildenbrand <david@redhat.com> wrote:

> core_id is not needed by linux-user, as the core_id a.k.a. CPU address
> is only accessible from kernel space.
> 
> Therefore, drop next_core_id and make cpu_index get autoassigned again
> for linux-user.
> 
> While at it, shield core_id and cpuid completely from linux-user. cpuid
> can also only be queried from kernel space.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

[...]
