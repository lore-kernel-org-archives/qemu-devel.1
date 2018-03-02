Received: from eggs.gnu.org ([2001:4830:134:3::10]:45862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erihF-0004Y9-HK
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erihB-0001bm-Fd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:17:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1erihB-0001bX-9M
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:17:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09F868182D1E
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 11:17:38 +0000 (UTC)
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-8-peterx@redhat.com>
	<20180301154331.GN14643@redhat.com> <20180302042609.GA27381@xz-mi>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fc1731d-4611-555e-b78f-1efd67edf1df@redhat.com>
Date: Fri, 2 Mar 2018 12:17:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180302042609.GA27381@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/15] qio/chardev: update net listener
 gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 02/03/2018 05:26, Peter Xu wrote:
> Frankly speaking I was a bit confused when I started to read
> chardev/qio codes with so many hooks, e.g., when I saw:
> 
>      qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
>                                       chr, NULL);
> 
> I totally have no idea on what happened.  I need to go deeper into the
> net listener code to know that, hmm, it's setting up something to
> accept connections!
> 
> If I can have something like:
> 
>     tcp_chr_net_listener_setup(s, true);
> 
> It may be easier for me to understand that there's something either
> registered for the listening ports, and I don't need to care about
> which function will be called when accept happened.  Basically it
> "hides" some logic inside, that's IMHO where functions/macros help.

I tend to agree with Daniel, but I probably would be convinced if you
had a pair of functions tcp_chr_{start,stop}_listen instead of a bool
argument.

Paolo
