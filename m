Received: from eggs.gnu.org ([209.51.188.92]:59103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1gnaoc-0008K2-FL
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 22:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1gnaob-0001uK-Dt
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 22:08:58 -0500
Date: Sun, 27 Jan 2019 12:08:53 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20190127030853.GV3235@lianli.shorne-pla.net>
References: <1548252536-6242-1-git-send-email-thuth@redhat.com>
	<1548252536-6242-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548252536-6242-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] target/openrisc: Fix LGPL version
 number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Wed, Jan 23, 2019 at 03:08:54PM +0100, Thomas Huth wrote:
> It's either "GNU *Library* General Public version 2" or "GNU Lesser
> General Public version *2.1*", but there was no "version 2.0" of the
> "Lesser" library. So assume that version 2.1 is meant here.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/openrisc/cpu.c              | 2 +-
>  target/openrisc/exception.h        | 2 +-
>  target/openrisc/gdbstub.c          | 2 +-
>  target/openrisc/helper.h           | 2 +-
>  target/openrisc/interrupt_helper.c | 2 +-
>  target/openrisc/sys_helper.c       | 2 +-
>  target/openrisc/translate.c        | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index fb7cb5c..541b2a6 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -6,7 +6,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/openrisc/exception.h b/target/openrisc/exception.h
> index 4ec56b4..c9c4e47 100644
> --- a/target/openrisc/exception.h
> +++ b/target/openrisc/exception.h
> @@ -6,7 +6,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
> index f9af650..43b1a18 100644
> --- a/target/openrisc/gdbstub.c
> +++ b/target/openrisc/gdbstub.c
> @@ -7,7 +7,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
> index 9db9bf3..96d79a8 100644
> --- a/target/openrisc/helper.h
> +++ b/target/openrisc/helper.h
> @@ -6,7 +6,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
> index 9c5489f..ab4ea88 100644
> --- a/target/openrisc/interrupt_helper.c
> +++ b/target/openrisc/interrupt_helper.c
> @@ -7,7 +7,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index b66a45c..05f66c4 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -7,7 +7,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index c089914..89680f8 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -7,7 +7,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of

All of this looks ok to me, though I didn't the licenses:

Acked-by: Stafford Horne <shorne@gmail.com>
