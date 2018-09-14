Received: from eggs.gnu.org ([2001:4830:134:3::10]:48980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0sDm-0007Mx-A5
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0sDl-0007x0-IR
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:49:34 -0400
References: <20180912131853.1249324-1-jcody@redhat.com>
	<20180912131853.1249324-3-jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66bdfbfe-f76e-ce5b-39ee-fea59daa8ef8@redhat.com>
Date: Fri, 14 Sep 2018 12:49:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180912131853.1249324-3-jcody@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/4] block/rbd: Attempt to parse legacy
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 9/12/18 8:18 AM, Jeff Cody wrote:
> When we converted rbd to get rid of the older key/value-centric
> encoding format, we broke compatibility with image files with backing
> file strings encoded in the old format.
> 
> This leaves a bit of an ugly conundrum, and a hacky solution.
> 

> +        /* Take care whenever deciding to actually deprecate; once this ability
> +         * is removed, we will not be able to open any images with legacy-styled
> +         * backing image strings. */
> +        error_report("RBD options encoded in the filename as keyvalue pairs "
> +                     "is deprecated.  Future versions may cease to parse "
> +                     "these options in the future.");

Fam spotted offline that " in the future" is redundant with "Future 
versions", if you want to respin the pull request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
