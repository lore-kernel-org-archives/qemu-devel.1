Received: from eggs.gnu.org ([2001:4830:134:3::10]:35463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fY7KV-0007HE-Q0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fY7KQ-0004K0-Jn
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:05:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fY7KQ-0004I5-Bl
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:05:34 -0400
References: <1530022733-29581-1-git-send-email-esposem@usi.ch>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <b0ca6234-8ebc-734d-fead-80fb41f76f46@redhat.com>
Date: Wed, 27 Jun 2018 12:05:30 +0200
MIME-Version: 1.0
In-Reply-To: <1530022733-29581-1-git-send-email-esposem@usi.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost-user-test: added proper TestServer
 *dest initialization in test_migrate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Emanuele Giuseppe Esposito <esposem@usi.ch>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 26/06/2018 16:18, Emanuele Giuseppe Esposito wrote:
> server->bus in _test_server_free() could be NULL, since TestServer *dest in test_migrate() was not properly initialized like TestServer *s.
> Added init_virtio_dev(dest) and uninit_virtio_dev(dest), so the fields are properly set and when test_server_free(dest); is called, they can be correctly freed.
> 
> The reason for that is init_virtio_dev() calls qpci_init_pc(), that creates a QPCIBusPC * (returned as QPCIBus *), while test_server_free() calls qpci_free_pc(),
> that frees the QPCIBus *. Not calling init_virtio_dev() would leave the QPCIBus * of TestServer unset.
> 
> Problem came out once I modified  pci-pc.c and pci-pc.h, modifying QPCIBusPC by adding another field before QPCIBus bus. Re-running the tests showed vhost-user-test failing.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <esposem@usi.ch>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

I'm wondering if we have to have the same email address in both "From:"
and "Signed-off-by"?

Thanks,
Laurent
