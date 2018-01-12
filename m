Received: from eggs.gnu.org ([2001:4830:134:3::10]:39146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZv4i-0004xQ-91
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZv4d-0006MH-A6
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:52:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:41036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZv4d-0006L6-4Q
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:52:27 -0500
Received: by mail-wm0-f65.google.com with SMTP id g75so10573571wme.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 00:52:26 -0800 (PST)
References: <151300265515.23197.14451909023530590924@bfc911d3884a>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aba868e2-8712-6baf-8d31-546fbe8ead17@redhat.com>
Date: Fri, 12 Jan 2018 09:52:23 +0100
MIME-Version: 1.0
In-Reply-To: <151300265515.23197.14451909023530590924@bfc911d3884a>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 00/46] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mikhail.abakumov@ispras.ru
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, den@openvz.org

On 11/12/2017 15:30, no-reply@patchew.org wrote:
> /var/tmp/patchew-tester-tmp-vkmit7_m/src/target/i386/misc_helper.c: In function ‘cpu_x86_read_msr’:
> /var/tmp/patchew-tester-tmp-vkmit7_m/src/target/i386/misc_helper.c:229:1: error: control reaches end of non-void function [-Werror=return-type]
>  }
>  ^
> cc1: all warnings being treated as errors

This is a problem with patch 45; cpu_x86_read_msr and cpu_x86_write_msr
are not needed for user-mode emulation.
