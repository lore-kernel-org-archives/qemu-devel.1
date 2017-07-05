Received: from eggs.gnu.org ([2001:4830:134:3::10]:33799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSlyx-0002se-It
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSlyu-0004JH-Em
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:12:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSlyu-0004IJ-7v
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:12:44 -0400
References: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1499263324-15184-14-git-send-email-anton.nefedov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9eba9b34-a3c7-792a-ca46-6bd8b5b60381@redhat.com>
Date: Wed, 5 Jul 2017 17:12:37 +0200
MIME-Version: 1.0
In-Reply-To: <1499263324-15184-14-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 13/13] serial: chardev hotswap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com



On 05/07/2017 16:02, Anton Nefedov wrote:
>  {
> -    if (!qemu_chr_fe_get_driver(&s->chr)) {
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
>          error_setg(errp, "Can't create serial device, empty char device");

Same here.

Paolo
