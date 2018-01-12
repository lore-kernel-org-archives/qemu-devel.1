Received: from eggs.gnu.org ([2001:4830:134:3::10]:35413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZuyj-0000Nl-15
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZuyf-0000y1-TZ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:46:21 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:39861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZuyf-0000wt-MR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:46:17 -0500
Received: by mail-wr0-f182.google.com with SMTP id z48so4621884wrz.6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 00:46:17 -0800 (PST)
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
	<151299848379.4808.3642740896471704807.stgit@Misha-PC.lan02.inno>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbda204a-1d86-cf1f-c470-8f8f53b8f7d7@redhat.com>
Date: Fri, 12 Jan 2018 09:46:12 +0100
MIME-Version: 1.0
In-Reply-To: <151299848379.4808.3642740896471704807.stgit@Misha-PC.lan02.inno>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 01/46] windbg: added empty windbgstub
 files
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
> +# WinDbg support
> +ifeq ($(TARGET_NAME), i386)
> +obj-y += windbgstub.o windbgstub-utils.o
> +endif
> +

Please add CONFIG_WINDBGSTUB=y to default-i386/softmmu.mak, and use
obj-$(CONFIG_WINDBGSTUB) here.

> +obj-y += helper.o cpu.o gdbstub.o windbgstub.o xsave_helper.o

Same here; put windbgstub.o in a separate obj-$(CONFIG_WINDBGSTUB) line.

Paolo
