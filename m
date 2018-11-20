Received: from eggs.gnu.org ([2001:4830:134:3::10]:44563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPFBW-0007CE-LL
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 18:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPFBV-0002Qj-Pm
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 18:11:58 -0500
References: <20181120225241.2371769-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <683a00c0-968e-944f-4636-1903581b0888@redhat.com>
Date: Tue, 20 Nov 2018 17:11:51 -0600
MIME-Version: 1.0
In-Reply-To: <20181120225241.2371769-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Skip 233 if certtool not installed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/20/18 4:52 PM, Eric Blake wrote:
> The use of TLS while building qemu is optional. While the
> 'certtool' binary should be available on every platform that
> supports building against TLS, that does not imply that the
> developer has installed it.  Make the test gracefully skip
> in that case.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> On Fedora, libvirt requires libtls-utils to be present, but not qemu.

Sorry for the typo; certtool is part of gnutls-utils

> 
> I'm fine if Kevin wants to pick this up in a pull request related
> to iotests in general; if not, I'll do a pull request through my
> NBD tree in time for -rc3.
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
