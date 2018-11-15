Received: from eggs.gnu.org ([2001:4830:134:3::10]:47047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNHxm-0007oU-JH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNHxh-00014N-Lz
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:45:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNHxh-00013p-GU
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:45:37 -0500
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1542287931.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6aa4b882-7b25-28cf-2807-2817b4e58f86@redhat.com>
Date: Thu, 15 Nov 2018 07:45:29 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1542287931.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 0/7] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>

On 11/15/18 7:22 AM, Simon Ruderich wrote:
> Hello again,
> 
> Please ignore v6, I forgot one patch. I hope I got it right this
> time.

Our automated tooling doesn't spot patches sent in reply to an earlier 
series; you may want to repost v7 as a new top-level thread (not 
in-reply-to any earlier message) to makes sure it gets seen by patchew.

> 
> As I got no replies to my last mails, here again the full patch
> set (rebased on current master) in the hope to get this merged.
> The first few patches are cleanup, the last two patches add the
> pmemload feature. Only 5/6 requires an ack (although all
> mentioned issues should be fixed), all other patches were already
> reviewed in the last round.
> 
> If there's anything else I can do to get this merged, please tell
> me.
> 
> Regards
> Simon Ruderich
> 
> Simon Ruderich (7):
>    cpus: correct coding style in qmp_memsave/qmp_pmemsave
>    cpus: convert qmp_memsave/qmp_pmemsave to use qemu_open
>    cpus: use size_t in qmp_memsave/qmp_pmemsave
>    hmp: use l for size argument in memsave/pmemsave
>    hmp: use F for filename arguments in memsave/pmemsave
>    qmp: add pmemload command
>    hmp: add pmemload command
> 
>   cpus.c          | 81 ++++++++++++++++++++++++++++++++++++++++---------
>   hmp-commands.hx | 18 +++++++++--
>   hmp.c           | 16 ++++++++--
>   hmp.h           |  1 +
>   qapi/misc.json  | 20 ++++++++++++
>   5 files changed, 118 insertions(+), 18 deletions(-)
> 
> No changes between v6 and v7, but v6 missed one patch.
> 
> Diff between v5 and v7:
> 
>      --- a/qapi/misc.json
>      +++ b/qapi/misc.json
>      @@ -1201,7 +1201,7 @@
>      #
>      # Returns: Nothing on success
>      #
>      -# Since: 3.1
>      +# Since: 3.2

Except the next release will be named 4.0, not 3.2 :)  (It's okay, 
there's a lot of mentions of 3.2 floating on the list right now, and 
we'll probably have to do a global search-and-replace at some point once 
we are into the new year)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
