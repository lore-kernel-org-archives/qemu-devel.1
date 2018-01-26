Received: from eggs.gnu.org ([2001:4830:134:3::10]:42118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eeuQa-000666-7a
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 22:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eeuQX-0000Kw-2d
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 22:11:44 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eeuQW-0000KV-SJ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 22:11:41 -0500
Received: by mail-wr0-f178.google.com with SMTP id v15so9578585wrb.8
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 19:11:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180125175949.7780-3-pbonzini@redhat.com>
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-3-pbonzini@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Jan 2018 11:11:09 +0800
Message-ID: <CAK1Eb9k-P7c_5XcWAxz5e+VKyspiTEMSXYkeGLehwDAQP01fGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/5] lockable: add QemuLockable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 26, 2018 at 1:59 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
> new file mode 100644
> index 0000000000..f527d0ddb2
> --- /dev/null
> +++ b/include/qemu/lockable.h
> @@ -0,0 +1,88 @@
> +/*
> + * Polymorphic locking functions (aka poor man templates)
> + *
> + * Copyright Red Hat, Inc. 2017

It's curious why then change you made in v2 (2017 - 2018) is reverted
in v3 (similar to the commit message). I can fix this and other typos
when applying.

Fam
