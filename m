Received: from eggs.gnu.org ([2001:4830:134:3::10]:37421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVFSn-0004ul-6h
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVFSj-0004Ua-67
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:42:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gVFSi-0004UG-SF
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:42:33 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-20-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d412f01a-2b40-8ecd-b2f1-53119b9e7ce0@redhat.com>
Date: Fri, 7 Dec 2018 13:42:28 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-20-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/71] tests: qgraph API for the qtest
 driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> 
> Add qgraph API that allows to add/remove nodes and edges from the graph,
> implementation of Depth First Search to discover the paths and basic unit
> test to check correctness of the API.
> Included also a main executable that takes care of starting the framework,
> create the nodes, set the available drivers/machines, discover the path and
> run tests.
> 
> graph.h provides the public API to manage the graph nodes/edges
> graph_extra.h provides a more private API used successively by the gtest integration part
> qos-test.c provides the main executable
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> [Paolo's changes compared to the Google Summer of Code submission:
>  * added subprocess to test options
>  * refactored object creation to support live migration tests
>  * removed driver .before callback (unused)
>  * removed test .after callbacks (replaced by GTest destruction queue)]
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/tests/libqos/qgraph.c b/tests/libqos/qgraph.c
> new file mode 100644
> index 0000000..03783f5
> --- /dev/null
> +++ b/tests/libqos/qgraph.c
> @@ -0,0 +1,760 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.

The license statement is inaccurate. There is no "GNU *Lesser* General
Public License version *2*" ... so I'm assuming you wanted to use one of
these two options:

- GNU Library General Public License, version 2.0
- GNU Lesser General Public License, version 2.1

I assume you wanted to use the latter, so please replace the "2" with
"2.1" in all license statements here.

 Thomas
