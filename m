Received: from eggs.gnu.org ([2001:4830:134:3::10]:46233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRDmp-0005qq-LE
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRDml-0003e8-Pd
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:02:07 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:41294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRDml-0003db-JG
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:02:03 -0500
Received: by mail-wm0-x230.google.com with SMTP id g75so2111850wme.0
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 01:02:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171218135417.28301-1-berrange@redhat.com>
	<20171218135417.28301-2-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b38ef134-69ac-5b90-adb4-6a38190d2dcf@redhat.com>
Date: Tue, 19 Dec 2017 09:48:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171218135417.28301-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] chardev: convert the socket server
 to QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 18/12/2017 14:54, Daniel P. Berrange wrote:
> Instead of creating a QIOChannelSocket directly for the chardev
> server socket, use a QIONetListener. This provides the ability
> to listen on multiple sockets at the same time, so enables
> full support for IPv4/IPv6 dual stack.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 72 +++++++++++++++++++++------------------------------
>  1 file changed, 29 insertions(+), 43 deletions(-)

Queued, thanks.

As a follow-up, it's probably worth creating two new functions for
respectively tcp_chr_set_client_ioc_name+tcp_chr_new_client and
tcp_chr_set_client_ioc_name+qio_channel_socket_connect_async
(with tcp_chr_set_client_ioc_name inlined).

Paolo
