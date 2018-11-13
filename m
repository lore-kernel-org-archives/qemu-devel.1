Received: from eggs.gnu.org ([2001:4830:134:3::10]:36057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMMrR-0001xc-GW
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMMrN-00054b-1T
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:47:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMMrM-00053i-Rd
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:47:16 -0500
References: <1542049690-12826-1-git-send-email-thuth@redhat.com>
	<1542049690-12826-2-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e498f34-a65f-5398-3c57-8f0ccbd2d350@redhat.com>
Date: Mon, 12 Nov 2018 18:47:11 -0600
MIME-Version: 1.0
In-Reply-To: <1542049690-12826-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 1/7] tests/pvpanic: Make the
 pvpanic test independent of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>

On 11/12/18 1:08 PM, Thomas Huth wrote:
> We want to get rid of global_qtest in the long run, thus do not
> use the wrappers like inb() and outb() here anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/pvpanic-test.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
