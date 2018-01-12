Received: from eggs.gnu.org ([2001:4830:134:3::10]:57266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZwxo-00053a-DF
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZwxm-0003IQ-U3
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:53:32 -0500
Date: Fri, 12 Jan 2018 10:53:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180112105320.GB17392@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180111195225.4226-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 02/10] block/qapi: Add qcow2 create
 options to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Thu, Jan 11, 2018 at 08:52:17PM +0100, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1749376c61..9341f6708d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3320,6 +3320,37 @@
>  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
>  
>  ##
> +# @BlockdevQcow2CompatLevel:
> +# @0_10:    The original QCOW2 format as introduced in qemu 0.10 (version 2)
> +# @1_1:     The extended QCOW2 format as introduced in qemu 1.1 (version 3)
> +#
> +# Since: 2.10
> +##
> +{ 'enum': 'BlockdevQcow2CompatLevel',
> +  'data': [ '0_10', '1_1' ] }
> +
> +
> +##
> +# @BlockdevCreateOptionsQcow2:
> +#
> +# Driver specific image creation options for qcow2.
> +#
> +# TODO Describe fields
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsQcow2',
> +  'data': { 'size':             'size',
> +            '*compat':          'BlockdevQcow2CompatLevel',
> +            '*backing-file':    'str',
> +            '*backing-fmt':     'BlockdevDriver',

For anything non-trivial, the caller is going to have to stuff a
JSON string into 'backing-file' value. It feels like we should
be referencing 'BlockdevOptions' here in some manner.

> +            '*encrypt':         'QCryptoBlockCreateOptions',
> +            '*cluster-size':    'size',
> +            '*preallocation':   'PreallocMode',
> +            '*lazy-refcounts':  'bool',
> +            '*refcount-bits':   'int' } }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
