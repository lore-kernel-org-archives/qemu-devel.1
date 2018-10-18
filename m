Received: from eggs.gnu.org ([2001:4830:134:3::10]:34906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9I3-0003oY-2S
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9Hz-0003Rt-OX
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:28:42 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD9Hz-0003J9-D1
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:28:39 -0400
Received: by mail-wr1-f54.google.com with SMTP id e4-v6so33941761wrs.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:28:30 -0700 (PDT)
References: <87efcqniza.fsf@dusky.pond.sub.org>
	<20181016132035.GF7995@redhat.com> <87o9brl7zc.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8974e95-f3f3-f07e-78dd-11e8765854c2@redhat.com>
Date: Thu, 18 Oct 2018 16:28:27 +0200
MIME-Version: 1.0
In-Reply-To: <87o9brl7zc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] When it's okay to treat OOM as fatal?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On 18/10/2018 15:06, Markus Armbruster wrote:
> Device "qxl" creates a memory region "qxl.vgavram" with a size taken
> from uint32_t property "ram_size", silently rounded up to the next power
> of two.  It uses &error_fatal for error handling.

That's good to some extent---it means that the core code _is_ ready for
handling ENOMEM in this part of QEMU, it's just the device that doesn't
use it.

Paolo
