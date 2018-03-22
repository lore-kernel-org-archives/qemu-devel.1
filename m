Received: from eggs.gnu.org ([2001:4830:134:3::10]:41099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez5gf-0000YA-1t
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez5ga-0000iH-KQ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:15:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ez5ga-0000hy-FB
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:15:40 -0400
References: <20180322180940.8253-1-jcmvbkbc@gmail.com>
	<20180322180940.8253-3-jcmvbkbc@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23678af9-2b19-98a1-5b70-99c443b9c6f3@redhat.com>
Date: Thu, 22 Mar 2018 14:15:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180322180940.8253-3-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/xtensa/import_core.sh: fix
 names of non-top level files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 03/22/2018 01:09 PM, Max Filippov wrote:
> Add .inc. to the names of files imported from configuration overlay in
> the import_core.sh script to follow the rule of naming non-top level
> source files.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   target/xtensa/import_core.sh | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

I'd squash this with 1/3 (otherwise, you have a one patch gap where the 
generator doesn't match the current tree contents, which may confuse 
someone doing a bisect).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
