Received: from eggs.gnu.org ([2001:4830:134:3::10]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsmWH-0005MK-NQ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsmWC-0002Q9-Pu
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:02:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dsmWC-0002PT-K9
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:02:36 -0400
References: <20170915084030.40988-1-aik@ozlabs.ru>
	<20170915084030.40988-5-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <485a3d8c-d44c-be20-6700-324d142d95cf@redhat.com>
Date: Fri, 15 Sep 2017 11:02:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170915084030.40988-5-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 04/13] memory: Move FlatView
 allocation to a helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 15/09/2017 10:40, Alexey Kardashevskiy wrote:
> -static void flatview_init(FlatView *view)
> +static FlatView *flatview_alloc(void)
>  {
> +    FlatView *view;
> +
> +    view = g_new0(FlatView, 1);
>      view->ref = 1;
> -    view->ranges = NULL;
> -    view->nr = 0;
> -    view->nr_allocated = 0;
> +
> +    return view;
>  }

Maybe flatview_new for consistency with other functions?  Otherwise
definitely a good idea.

Paolo
