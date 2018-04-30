Received: from eggs.gnu.org ([2001:4830:134:3::10]:40553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5I8-000684-2U
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5I3-0004zU-Uk
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:40:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38184 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD5I3-0004z1-Pb
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:40:11 -0400
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
Date: Mon, 30 Apr 2018 11:39:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180430065235.577-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] qom: Document
 qom/device-list-properties implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 30/04/2018 08:52, Alexey Kardashevskiy wrote:
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 5636f4a..399ec74 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1491,6 +1491,10 @@
>  #
>  # List properties associated with a device.
>  #
> +# Note: the handler creates a device object, enumerates properties and destroys
> +# the object so it only lists properties defined in DeviceClass::props or
> +# created by DeviceClass::init()/TypeInfo::instance_init().
> +#
>  # @typename: the type name of a device
>  #
>  # Returns: a list of ObjectPropertyInfo describing a devices properties
> @@ -1506,6 +1510,11 @@
>  #
>  # List properties associated with a QOM object.
>  #
> +# Note: the handler creates an object, enumerates properties and destroys
> +# the object so it only lists properties created in TypeInfo::instance_init().
> +# Since the instance_init() callback of the device object adds
> +# DeviceClass::props as object properties, they will be listed as well.
> +#

This says what it does, but not why it is a problem.  Can you explain
that to me as well?

Thanks,

Paolo
