Received: from eggs.gnu.org ([2001:4830:134:3::10]:56702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZugq-0001Es-NN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZugm-0003cb-PH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:27:52 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZugm-0003cI-IM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:27:48 -0500
Received: by mail-wr0-f194.google.com with SMTP id z48so4582892wrz.6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 00:27:48 -0800 (PST)
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7ec43ca-632f-c402-0bea-f7df552b4604@redhat.com>
Date: Fri, 12 Jan 2018 09:27:44 +0100
MIME-Version: 1.0
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/46] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>, qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, den@openvz.org

On 11/12/2017 14:21, Mihail Abakumov wrote:
> How it works:
> The WinDbg debugger has the possibility of connecting to a remote debug service
> (Kdsrv.exe) in the Windows kernel. Therefore, it is possible to connect to the
> guest system running in the QEMU emulator. Kernel debugging is possible only
> with the enabled debugging mode, may change at the same time. Our module of
> WinDbg debugger for QEMU is an alternative of the remote debugging service in
> the kernel. Thus, the debugger connects to the debugging module, not to the
> kernel of the operating system. The module obtains all the necessary information
> answering debugger requests from the QEMU emulator. At the same time for
> debugging there is no need to enable debugging mode in the kernel. This leads to
> hidden debugging. Our module supports all features of WinDbg regarding remote
> debugging, besides interception of events and exceptions. Only i386 is supported
> now.

How hard would it be to support x86_64?  I'm not sure how useful this is
for 32-bit only.

Paolo
