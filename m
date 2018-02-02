Received: from eggs.gnu.org ([2001:4830:134:3::10]:45327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ehdAV-0000TA-It
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ehd8m-00067X-3y
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:22:23 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:41475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ehd8l-00066l-QH
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:20:35 -0500
Received: by mail-vk0-f45.google.com with SMTP id g186so13680400vkd.8
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 07:20:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151752246058.3252.5362449406959598939@b81a8a9ec60f>
References: <20180201212917.18131-1-pbonzini@redhat.com>
	<151752246058.3252.5362449406959598939@b81a8a9ec60f>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 2 Feb 2018 13:53:33 +0800
Message-ID: <CAK1Eb9mBVjv_PFYJKhXDLG8LL6uasyQKb2MxDHN6Eh7rjH1K+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/5] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Feb 2, 2018 at 6:01 AM,  <no-reply@patchew.org> wrote:
> === OUTPUT BEGIN ===
> Checking PATCH 1/5: test-coroutine: add simple CoMutex test...
> ERROR: do not initialise statics to 0 or NULL
> #30: FILE: tests/test-coroutine.c:198:
> +static bool locked = false;
>
> total: 1 errors, 0 warnings, 74 lines checked

I think we should fix this one too. Otherwise,

Reviewed-by: Fam Zheng <famz@redhat.com>


>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> Checking PATCH 2/5: lockable: add QemuLockable...
> WARNING: line over 80 characters
> #58: FILE: include/qemu/compiler.h:144:
> +#define QEMU_GENERIC2(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC1(x, __VA_ARGS__))
>
> WARNING: line over 80 characters
> #59: FILE: include/qemu/compiler.h:145:
> +#define QEMU_GENERIC3(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC2(x, __VA_ARGS__))
>
> WARNING: line over 80 characters
> #60: FILE: include/qemu/compiler.h:146:
> +#define QEMU_GENERIC4(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC3(x, __VA_ARGS__))
>
> WARNING: line over 80 characters
> #61: FILE: include/qemu/compiler.h:147:
> +#define QEMU_GENERIC5(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC4(x, __VA_ARGS__))
>
> WARNING: line over 80 characters
> #62: FILE: include/qemu/compiler.h:148:
> +#define QEMU_GENERIC6(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC5(x, __VA_ARGS__))
>
> WARNING: line over 80 characters
> #63: FILE: include/qemu/compiler.h:149:
> +#define QEMU_GENERIC7(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC6(x, __VA_ARGS__))
>
> WARNING: line over 80 characters
> #64: FILE: include/qemu/compiler.h:150:
> +#define QEMU_GENERIC8(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC7(x, __VA_ARGS__))
>
> WARNING: line over 80 characters
> #65: FILE: include/qemu/compiler.h:151:
> +#define QEMU_GENERIC9(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC8(x, __VA_ARGS__))
>
> WARNING: line over 80 characters
> #66: FILE: include/qemu/compiler.h:152:
> +#define QEMU_GENERIC10(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC9(x, __VA_ARGS__))
>
> WARNING: line over 80 characters
> #124: FILE: include/qemu/lockable.h:28:
> + * to QEMU_MAKE_LOCKABLE.  For optimized builds, we can rely on dead-code elimination
>
> WARNING: architecture specific defines should be avoided
> #127: FILE: include/qemu/lockable.h:31:
> +#ifdef __OPTIMIZE__
>
> total: 0 errors, 11 warnings, 242 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 3/5: coroutine-lock: convert CoQueue to use QemuLockable...
> Checking PATCH 4/5: coroutine-lock: make qemu_co_enter_next thread-safe...
> Checking PATCH 5/5: curl: convert to CoQueue...
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
