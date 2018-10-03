Received: from eggs.gnu.org ([2001:4830:134:3::10]:39449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7l0q-0008WM-N7
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7l0p-0002xP-S0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:32:40 -0400
References: <20181003171947.588103-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d9490dd-972f-ad50-2a7d-4024415a4ec8@redhat.com>
Date: Wed, 3 Oct 2018 12:32:32 -0500
MIME-Version: 1.0
In-Reply-To: <20181003171947.588103-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd: Flip qemu-nbd to prefer newstyle;
 add -O for old behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>

On 10/3/18 12:19 PM, Eric Blake wrote:
> Oldstyle NBD negotiation cannot perform any of the extensions that
> we have recently been relying on.  While you can always pass -x ""
> to get newstyle negotiation, these days, it is better to just default
> to newstyle (with an empty export name) and fall back to oldstyle
> only on an explicit request.
> 
> For comparison:
> 
> nbdkit 1.3 switched its default to newstyle (Jan 2018):
> https://github.com/libguestfs/nbdkit/commit/b2a8aecc
> https://github.com/libguestfs/nbdkit/commit/8158e773
> 
> nbd 3.10 dropped oldstyle long ago (Mar 2015):
> https://github.com/NetworkBlockDevice/nbd/commit/36940193

Oh, I should also add:

qemu as client can manage either style since 2.6.0, commit 69b49502d8

> +++ b/qemu-nbd.c
> @@ -86,6 +86,7 @@ static void usage(const char *name)
>   "  -v, --verbose             display extra debugging information\n"
>   "  -x, --export-name=NAME    expose export by name\n"
>   "  -D, --description=TEXT    with -x, also export a human-readable description\n"
> +"  -O, --oldstyle            force oldstyle negotiation\n"

and maybe I should touch up the -x and -D wording, to at least mention 
that -x defaults to "" without -O.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
