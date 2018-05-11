Received: from eggs.gnu.org ([2001:4830:134:3::10]:33111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHD3S-0006bf-OZ
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHD3R-0006qN-Qk
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:46:10 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-11-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0fa62186-3ff3-f3e2-02bd-777fda2030c5@redhat.com>
Date: Fri, 11 May 2018 13:46:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180509165530.29561-11-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/13] tests: Add QDict clone-flatten test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/09/2018 11:55 AM, Max Reitz wrote:
> This new test verifies that qdict_flatten() does not modify a shallow
> clone of the given QDict.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/check-qdict.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 

I'm not sure I even want to know how long it took you to debug the crash 
that you obviously hit before adding the fix in 9/13 plus this test ;)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
