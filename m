Received: from eggs.gnu.org ([2001:4830:134:3::10]:40706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxrbj-0006yc-6t
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxrbf-00057x-By
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:57:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cxrbf-00057n-5m
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:56:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
	<20170320001249.25521-11-haozhong.zhang@intel.com>
Date: Tue, 11 Apr 2017 10:56:53 +0200
In-Reply-To: <20170320001249.25521-11-haozhong.zhang@intel.com> (Haozhong
	Zhang's message of "Mon, 20 Mar 2017 08:12:49 +0800")
Message-ID: <87wparcofe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v2 10/10] qapi: extend
 'query-memory-devices' to list devices of specified type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xen.org, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Konrad Rzeszutek Wilk <konrad@darnok.org>, Dan Williams <dan.j.williams@intel.com>

Haozhong Zhang <haozhong.zhang@intel.com> writes:

> Add an optional argument 'devtype' to 'query-memory-devices', which
> is either 'dimm' or 'nvdimm'. If 'devtype' is missed or 'dimm', all
> memory devices will be listed. If 'devtype' is 'nvdimm', only nvdimm
> devices will be listed.

Basically, the argument provides limited server-side filtering of the
output of query-memory-devices.

> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c                    |  3 +-
>  hw/mem/nvdimm.c          | 38 ++++++++++++++++++++++++++
>  hw/mem/pc-dimm.c         | 71 ++++++++++++++++++++++++++++--------------------
>  include/hw/mem/nvdimm.h  |  2 ++
>  include/hw/mem/pc-dimm.h |  1 +
>  qapi-schema.json         | 48 +++++++++++++++++++++++++++++---
>  qmp.c                    | 13 +++++++--
>  7 files changed, 140 insertions(+), 36 deletions(-)

Why is this server-side filtering worth the additional code and
complexity?  Why not simply filter in the client?  What's your use case?

[...]
