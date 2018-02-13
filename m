Received: from eggs.gnu.org ([2001:4830:134:3::10]:33059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbe4-00031E-Ds
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbe0-0007VT-0J
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:33:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elbdz-0007Pg-Qt
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:33:15 -0500
References: <20180213100606.5379-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8649a5df-c30c-2858-7e44-7051d607336e@redhat.com>
Date: Tue, 13 Feb 2018 08:32:54 -0600
MIME-Version: 1.0
In-Reply-To: <20180213100606.5379-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] tests/migration: Add source to PC boot
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, drjones@redhat.com, wei@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com

On 02/13/2018 04:06 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The boot block used in the migration test is currently only
> shipped as a hex (with the source in the git commit message of ea0c6d62),
> change this to actually include the source.
> 
> A script is added to rebuild the header but the expectation is that
> the generated hex is shipped as well as the .s, so that
> there's no requirement to have just the right assembler etc.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   tests/migration-test.c                   | 52 ++----------------
>   tests/migration/rebuild-x86-bootblock.sh | 34 ++++++++++++
>   tests/migration/x86-a-b-bootblock.h      | 51 ++++++++++++++++++
>   tests/migration/x86-a-b-bootblock.s      | 92 ++++++++++++++++++++++++++++++++
>   4 files changed, 181 insertions(+), 48 deletions(-)
>   create mode 100755 tests/migration/rebuild-x86-bootblock.sh
>   create mode 100644 tests/migration/x86-a-b-bootblock.h
>   create mode 100644 tests/migration/x86-a-b-bootblock.s

Looks like you addressed all my v3 findings, so
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
