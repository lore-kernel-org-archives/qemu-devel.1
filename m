Received: from eggs.gnu.org ([2001:4830:134:3::10]:43234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGWVh-00009s-4G
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGWVg-0001VC-25
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:20:28 -0400
References: <20180509210023.20283-1-mreitz@redhat.com>
	<20180509210023.20283-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9d54e40-419a-8cf0-73df-339e52eb4630@redhat.com>
Date: Wed, 9 May 2018 16:20:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180509210023.20283-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/7] block: Add Error parameter to
 bdrv_amend_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 05/09/2018 04:00 PM, Max Reitz wrote:
> Looking at the qcow2 code that is riddled with error_report() calls,
> this is really how it should have been from the start.
> 
> Along the way, turn the target_version/current_version comparisons at
> the beginning of qcow2_downgrade() into assertions (the caller has to
> make sure these conditions are met), and rephrase the error message on
> using compat=1.1 to get refcount widths other than 16 bits.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
