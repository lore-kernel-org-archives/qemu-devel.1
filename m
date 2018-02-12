Received: from eggs.gnu.org ([2001:4830:134:3::10]:55142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elGg9-00056s-RF
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elGg5-0002Cz-Dz
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:10:05 -0500
References: <1518439489-2724-1-git-send-email-thuth@redhat.com>
	<1518439489-2724-3-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77231d0b-7397-1e2b-74f3-c14e917f781e@redhat.com>
Date: Mon, 12 Feb 2018 10:09:44 -0600
MIME-Version: 1.0
In-Reply-To: <1518439489-2724-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] tests/m48t59: Make the test
 independent of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org

On 02/12/2018 06:44 AM, Thomas Huth wrote:
> Stop using the functions that require global_qtest here and pass
> around the QTestState instead (global_qtest should finally get
> removed since this causes problems with tests running in parallel).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/m48t59-test.c | 60 ++++++++++++++++++++++++++---------------------------
>   1 file changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
