Received: from eggs.gnu.org ([2001:4830:134:3::10]:35265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMc9k-0006gL-TN
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMc2d-0001UR-Mi
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:00:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMc2d-0000Xs-Bt
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:59:55 -0500
References: <20181113165539.14376-1-danielhb413@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4328b12f-6132-c893-3449-7c5410b6b4da@redhat.com>
Date: Tue, 13 Nov 2018 10:59:24 -0600
MIME-Version: 1.0
In-Reply-To: <20181113165539.14376-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 v2 1/1] qga: update docs with
 systemd suspend support info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On 11/13/18 10:55 AM, Daniel Henrique Barboza wrote:
> Commit 067927d62e ("qga: systemd hibernate/suspend/hybrid-sleep
> support") failed to update qapi-schema.json after adding systemd
> hibernate/suspend/hybrid-sleep capabilities to guest-suspend-* QGA
> commands.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>   qga/qapi-schema.json | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

As a doc fix, I'm recommending the maintainer include it in 3.1.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
