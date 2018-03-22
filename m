Received: from eggs.gnu.org ([2001:4830:134:3::10]:52836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez34e-0004QB-Dk
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez34d-0002sw-GD
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:28:20 -0400
References: <20180322161226.29796-1-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bee349e1-d665-c7a2-f81e-c27cd142dff3@redhat.com>
Date: Thu, 22 Mar 2018 11:27:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180322161226.29796-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] coccinelle: re-run scripts from
 scripts/coccinelle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Markus Armbruster <armbru@redhat.com>

On 03/22/2018 11:12 AM, Laurent Vivier wrote:
> I've re-run some scripts from the coccinelle directory,
> and they have found some problems.
> 
> This series fixes them.
> 
> Laurent Vivier (4):
>    error: Strip trailing '\n' from error string arguments (again again)

This is user-visible, so appropriate during freeze as a bug fix.  It's 
closes to the error/qapi code that Markus normally maintains (and where 
I'm filling in while he is out), so I'll queue this one on my QAPI tree.

>    error: Remove NULL checks on error_propagate() calls
>    qdict: remove useless cast
>    Remove unnecessary variables for function return value

These are cosmetic; they should be no-ops.  2 and 3 are again best 
through error/qapi, while 4 is more generic, but there's little reason 
to split up the series just because 4 is not as closely related.  Unless 
anyone has an opinion otherwise, I'm planning to also include them in my 
QAPI tree for 2.12.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
