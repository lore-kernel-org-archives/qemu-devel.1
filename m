Received: from eggs.gnu.org ([2001:4830:134:3::10]:33637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMvwX-0007Sm-FD
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMvwT-00030l-DN
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:14:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMvwT-000308-7w
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:14:53 -0500
References: <154219299016.19470.9372139354280787961.stgit@wayrath>
	<154219301447.19470.4834273682384554888.stgit@wayrath>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ee022ac8-a83b-53c0-46d5-f2641a546240@redhat.com>
Date: Wed, 14 Nov 2018 08:14:46 -0600
MIME-Version: 1.0
In-Reply-To: <154219301447.19470.4834273682384554888.stgit@wayrath>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] i386: add properties for
 customizing L2 and L3 caches size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dario Faggioli <dfaggioli@suse.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 11/14/18 4:56 AM, Dario Faggioli wrote:
> Make it possible to specify a custom size for the L2 and
> L3 caches, from the command line.
> 
> This can be useful in cases where applications or libraries
> check, within the guest, the cache size and behave differently
> depending on what they actually see.
> 
> Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
> ---
> I am not entirely sure I got the include/hw/i386 bits right (i.e.,
> whether I should include the new properties in PC_COMPAT_3_0 and, if
> yes, if the stanzas are correct). I'll dig further (and accept any
> help/advice :-D )
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   0 files changed

That's an odd diffstat. Why is git not giving you the normal diffstat 
with an actual summary of files changed?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
