Received: from eggs.gnu.org ([209.51.188.92]:55056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <neil@tembosocial.com>) id 1gyj5C-0006lh-EP
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <neil@tembosocial.com>) id 1gyj5B-0000BR-Op
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:12:06 -0500
Received: from 206-248-184-9.dsl.teksavvy.com ([206.248.184.9]:55136
	helo=puppet.polldev.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <neil@tembosocial.com>)
	id 1gyj5B-00009O-JE
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:12:05 -0500
From: Neil Skrypuch <neil@tembosocial.com>
Date: Tue, 26 Feb 2019 15:02:37 -0500
Message-ID: <1861629.DhqBqR4TJJ@neil>
In-Reply-To: <20190226153549.17867-1-stefanha@redhat.com>
References: <20190226153549.17867-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Qemu-devel] [PATCH] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Tuesday, February 26, 2019 10:35:49 AM EST Stefan Hajnoczi wrote:
> Suggested-by: Neil Skrypuch <neil@tembosocial.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json |  5 +++++
>  block/file-posix.c   | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)

Tested-by: Neil Skrypuch <neil@tembosocial.com>

Applied this patch against 3.1.0 and tested with -drive ...,file.drop-
cache=off and it resolves the issue mentioned in my previous email to the 
list, "[regression] Clock jump on VM migration".

Thanks,

- Neil
