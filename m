Received: from eggs.gnu.org ([2001:4830:134:3::10]:53444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej999-0004aG-Vm
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej998-00076J-WE
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:43:16 -0500
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-19-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9fa2031-a042-165a-47fd-e0d4b4a24738@redhat.com>
Date: Tue, 6 Feb 2018 13:43:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180205151835.20812-19-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 18/26] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

On 02/05/2018 09:18 AM, Max Reitz wrote:
> This new field can be set by block drivers to list the runtime options
> they accept that may influence the contents of the respective BDS. As of
> a follow-up patch, this list will be used by the common
> bdrv_refresh_filename() implementation to decide which options to put
> into BDS.full_open_options (and consequently whether a JSON filename has
> to be created), thus freeing the drivers of having to implement that
> logic themselves.
> 
> Additionally, this patch adds the field to all of the block drivers that
> need it and sets it accordingly.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +    /* Pointer to a NULL-terminated array of names of significant options that
> +     * can be specified for bdrv_open(). A significant option is one that
> +     * changes the data of a BDS.
> +     * If this pointer is NULL, the array is considered empty.
> +     * "filename" and "driver" are always considered significant. */
> +    const char *const *sgfnt_runtime_opts;

Warning: Bikeshedding follows:

s/sgfnt/vital/

might read easier (same number of letters, but has some vowels rthr thn 
bng crptc bbrvtn).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
