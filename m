Received: from eggs.gnu.org ([2001:4830:134:3::10]:33029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX5FW-00049Q-4M
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX5FR-0007jM-Tn
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:12:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gX5FR-0007iV-Js
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:12:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so6128485wml.3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 06:12:25 -0800 (PST)
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-18-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2e26a7cc-8788-b16f-dd35-434570cd43d4@redhat.com>
Date: Wed, 12 Dec 2018 15:12:21 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-18-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/71] tests: remove rule for nonexisting
 qdev-monitor-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 12/3/18 4:32 PM, Paolo Bonzini wrote:
> This test was merged into drive_del-test in 2014.

in e2f3f221885.

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/Makefile.include | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3e3b16b..2718548 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -726,7 +726,6 @@ tests/qom-test$(EXESUF): tests/qom-test.o
>  tests/test-hmp$(EXESUF): tests/test-hmp.o
>  tests/machine-none-test$(EXESUF): tests/machine-none-test.o
>  tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
> -tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
>  tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
>  tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
>  tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
> 
