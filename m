Received: from eggs.gnu.org ([2001:4830:134:3::10]:33562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSlyR-0002cz-MW
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSlyN-0003ZJ-VZ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:12:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSlyN-0003Tv-Oa
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:12:11 -0400
References: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1499263324-15184-12-git-send-email-anton.nefedov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d13f528-20c2-3c38-10cf-830e830f6716@redhat.com>
Date: Wed, 5 Jul 2017 17:12:00 +0200
MIME-Version: 1.0
In-Reply-To: <1499263324-15184-12-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 11/13] virtio-console: chardev hotswap
 support
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
> Also, avoid unsafe qemu_chr_fe_get_driver() usage even though the pointer
> is not really stored.

Please move that part to patch 5, together with other switches to
qemu_chr_fe_backend_connected.

Paolo
