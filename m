Received: from eggs.gnu.org ([2001:4830:134:3::10]:53213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctGzD-0005hg-Ha
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctGzC-0005aB-TZ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:02:19 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-8-git-send-email-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <abade63f-a47c-2fb7-6da2-9d17525ceb6a@redhat.com>
Date: Wed, 29 Mar 2017 19:02:11 +0200
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.9 7/8] nbd: Tidy up blockdev-add interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com



On 29/03/2017 18:45, Markus Armbruster wrote:
> Unfortunately, SocketAddress is also visible in -drive since 2.8.  Add
> still more gunk to nbd_process_legacy_socket_options().  You can now
> shorten
> 
>     -drive if=none,driver=nbd,server.type=inet,server.data.host=127.0.0.1,server.data.port=12345
> 
> to
> 
>     -drive if=none,driver=nbd,server.type=inet,server.host=127.0.0.1,server.port=12345

I think it's reasonable to assume nobody has used this and break it.

Paolo
