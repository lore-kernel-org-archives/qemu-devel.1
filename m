Received: from eggs.gnu.org ([2001:4830:134:3::10]:60057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceNan-0002ER-Ge
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceNaj-0004t0-Gg
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:03:33 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceNaj-0004sg-AK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:03:29 -0500
Received: by mail-wr0-x244.google.com with SMTP id q39so2369149wrb.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:03:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1486658842-7143-1-git-send-email-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5bb696b-1c1f-f022-6646-bc23ed9a1c4d@redhat.com>
Date: Thu, 16 Feb 2017 16:03:31 +0100
MIME-Version: 1.0
In-Reply-To: <1486658842-7143-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/10] vnc: add support for multiple
 listening sockets.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>

On 09/02/2017 17:47, Gerd Hoffmann wrote:
>   Hi,
> 
> Here comes the UI patch queue, carrying only vnc updates this time.  Big
> chunk is the multiple sockets support patch series, but there are also
> some smaller fixes and cleanups.
> 
> v2: squash in the clang fix from Daniel.
> 
> please pull,
>   Gerd
> 
> The following changes since commit d0dff238a87fa81393ed72754d4dc8b09e50b08b:
> 
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170206' into staging (2017-02-07 15:29:26 +0000)
> 
> are available in the git repository at:
> 
> 
>   git://git.kraxel.org/qemu tags/pull-ui-20170209-2
> 
> for you to fetch changes up to 396f935a9aff3cefd288bdb2b20024fb9dcfa062:
> 
>   ui: add ability to specify multiple VNC listen addresses (2017-02-09 17:28:49 +0100)

Coverity reports a double invocation of vnc_display_close in
vnc_display_open.  Perhaps some "goto fail" must be changed to return?

Paolo
