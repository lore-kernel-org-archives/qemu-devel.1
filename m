Received: from eggs.gnu.org ([209.51.188.92]:48688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gomfU-0004Ir-Gl
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gomfM-0004yL-CA
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:00:26 -0500
References: <1548252536-6242-1-git-send-email-thuth@redhat.com>
	<1548252536-6242-4-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <eadb5ca9-213a-55b2-6f5d-4202375e5ff4@vivier.eu>
Date: Wed, 30 Jan 2019 10:59:54 +0100
MIME-Version: 1.0
In-Reply-To: <1548252536-6242-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 3/4] target/tricore: Fix
 LGPL version number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 23/01/2019 15:08, Thomas Huth wrote:
> It's either "GNU *Library* General Public version 2" or "GNU Lesser
> General Public version *2.1*", but there was no "version 2.0" of the
> "Lesser" library. So assume that version 2.1 is meant here.
> 
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/tricore/cpu-qom.h         | 2 +-
>  target/tricore/cpu.c             | 2 +-
>  target/tricore/cpu.h             | 2 +-
>  target/tricore/fpu_helper.c      | 2 +-
>  target/tricore/helper.c          | 2 +-
>  target/tricore/helper.h          | 2 +-
>  target/tricore/op_helper.c       | 2 +-
>  target/tricore/translate.c       | 2 +-
>  target/tricore/tricore-defs.h    | 2 +-
>  target/tricore/tricore-opcodes.h | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/target/tricore/cpu-qom.h b/target/tricore/cpu-qom.h
> index 6a69756..93c9d77 100644
> --- a/target/tricore/cpu-qom.h
> +++ b/target/tricore/cpu-qom.h
> @@ -4,7 +4,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 2edaef1..e8d37e4 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -6,7 +6,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index c3665c6..00e69dc 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -6,7 +6,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
> index 31df462..d8a6c0d 100644
> --- a/target/tricore/fpu_helper.c
> +++ b/target/tricore/fpu_helper.c
> @@ -6,7 +6,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index dad7eea..0769046 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -4,7 +4,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/tricore/helper.h b/target/tricore/helper.h
> index e634d0c..f60e810 100644
> --- a/target/tricore/helper.h
> +++ b/target/tricore/helper.h
> @@ -4,7 +4,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
> index b57f353..ed9dc0c 100644
> --- a/target/tricore/op_helper.c
> +++ b/target/tricore/op_helper.c
> @@ -4,7 +4,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index b5ab40d..14f0ddf 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -6,7 +6,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/tricore/tricore-defs.h b/target/tricore/tricore-defs.h
> index 40abfaa..e871aa1 100644
> --- a/target/tricore/tricore-defs.h
> +++ b/target/tricore/tricore-defs.h
> @@ -4,7 +4,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
> index 2c3baab..40bc121 100644
> --- a/target/tricore/tricore-opcodes.h
> +++ b/target/tricore/tricore-opcodes.h
> @@ -4,7 +4,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
