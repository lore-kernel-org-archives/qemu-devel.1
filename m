Received: from eggs.gnu.org ([2001:4830:134:3::10]:48459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewRXE-0001ze-CG
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewRXD-000247-Lj
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:59:04 -0400
References: <1521100145-15304-1-git-send-email-thuth@redhat.com>
	<1521100145-15304-4-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <698485ba-6cf4-ccf5-041b-4f05d5c543f1@redhat.com>
Date: Thu, 15 Mar 2018 06:58:50 -0500
MIME-Version: 1.0
In-Reply-To: <1521100145-15304-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] tests/cdrom-test: Test that -cdrom
 parameter is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 03/15/2018 02:49 AM, Thomas Huth wrote:
> Commit 1454509726719e0933c800 recently broke the "-cdrom" parameter
> on a couple of boards without that we noticed it immediately. Thus

s/without that we noticed/without us noticing/

> add a test which checks that "-cdrom" can at least be used to start
> QEMU with certain machine types.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include |  7 +++++-
>   tests/cdrom-test.c     | 63 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 68 insertions(+), 2 deletions(-)
> 
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
