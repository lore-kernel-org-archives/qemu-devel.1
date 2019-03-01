Received: from eggs.gnu.org ([209.51.188.92]:37034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzeYe-0007yc-CO
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzeYd-0000yT-LO
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:34:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gzeYd-0000w6-9h
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:34:19 -0500
Date: Fri, 1 Mar 2019 10:33:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190301103346.00389986@redhat.com>
In-Reply-To: <20190301074448.8926-1-richardw.yang@linux.intel.com>
References: <20190301074448.8926-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qom: remove type_initialize() in
 object_new_with_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, afaerber@suse.de

On Fri,  1 Mar 2019 15:44:48 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> Here is the abstraction of current call flow of object_new_with_type()
> 
>     object_initialize_with_type
>         type_initialize
> 	object_initialize_with_type
> 	    type_initialize
> 
> This is not necessary to spread type_initialize in two places.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  qom/object.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index b8c732063b..6252cca418 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -585,7 +585,6 @@ static Object *object_new_with_type(Type type)
>      Object *obj;
>  
>      g_assert(type != NULL);
> -    type_initialize(type);
>  
>      obj = g_malloc(type->instance_size);
>      object_initialize_with_type(obj, type->instance_size, type);
Are you sure it's correct?

see how type->instance_size

PS:
there is also unit-tests which might detect issues in patches before
one sends them. To execute them run: make  check
