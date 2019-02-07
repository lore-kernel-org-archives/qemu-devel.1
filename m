Received: from eggs.gnu.org ([209.51.188.92]:49868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjgm-0002jN-OT
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjgk-0005Hy-T5
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:26:00 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:59922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1grjgi-0005FS-UZ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:25:58 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <c741408825d01f5a186901c5a8248126ffebe9fd.1549545591.git.berto@igalia.com>
References: <cover.1549545591.git.berto@igalia.com>
	<c741408825d01f5a186901c5a8248126ffebe9fd.1549545591.git.berto@igalia.com>
Date: Thu, 07 Feb 2019 14:25:54 +0100
Message-ID: <w51imxvhgrh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] main-loop: Don't leak GSources
 attached to a GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu 07 Feb 2019 02:23:21 PM CET, Alberto Garcia wrote:
> After g_source_attach() the GMainContext holds a reference to the
> GSource, so the caller does not need to keep it.
>
> pty_chr_state() and qio_task_thread_worker() are not doing this, so

s/are not doing this/are not releasing their references/

I'll correct this if I need to send a new version of the series,
otherwise please fix when committing this patch.

Berto
