Received: from eggs.gnu.org ([2001:4830:134:3::10]:54014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQ2U-0000NR-GA
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQ2T-0007ax-Qs
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:59:38 -0400
References: <20180323143202.28879-1-lvivier@redhat.com>
	<20180323143202.28879-3-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c54fe9f-fccc-58fc-6d43-22b1d53183f3@redhat.com>
Date: Fri, 23 Mar 2018 11:59:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180323143202.28879-3-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] error: Strip trailing '\n' from
 error string arguments (again again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>

On 03/23/2018 09:31 AM, Laurent Vivier wrote:
> Re-run Coccinelle script scripts/coccinelle/err-bad-newline.cocci,
> and found new error_report() occurences with '\n'.

s/occurences/occurrences/

> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   target/i386/hvf/hvf.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
