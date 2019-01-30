Received: from eggs.gnu.org ([209.51.188.92]:50760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gommG-0000lN-0i
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gomm9-00089Z-Hy
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:07:27 -0500
References: <1548769438-28942-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a726d274-800b-1529-f6ba-941e9a05fdfd@vivier.eu>
Date: Wed, 30 Jan 2019 11:07:05 +0100
MIME-Version: 1.0
In-Reply-To: <1548769438-28942-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2] target/m68k: Fix LGPL
 information in the file headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, liam.merwick@oracle.com

On 29/01/2019 14:43, Thomas Huth wrote:
> It's either "GNU *Library* General Public License version 2" or
> "GNU Lesser General Public License version *2.1*", but there was
> no "version 2.0" of the "Lesser" license. So assume that version
> 2.1 is meant here.
> Also some files mention the GPL instead of the LGPL after declaring
> that the files are licensed under the LGPL, so change these spots to
> use LGPL, too.
> 
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Fixed typos in the patch description
> 
>  linux-user/m68k/target_cpu.h     | 4 ++--
>  linux-user/m68k/target_structs.h | 2 +-
>  target/m68k/cpu.h                | 4 ++--
>  target/m68k/fpu_helper.c         | 4 ++--
>  target/m68k/gdbstub.c            | 2 +-
>  target/m68k/helper.c             | 4 ++--
>  target/m68k/op_helper.c          | 2 +-
>  target/m68k/translate.c          | 4 ++--
>  8 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
> index 611df06..7a26f3c 100644
> --- a/linux-user/m68k/target_cpu.h
> +++ b/linux-user/m68k/target_cpu.h
> @@ -7,12 +7,12 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> + * Lesser General Public License for more details.
>   *
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> diff --git a/linux-user/m68k/target_structs.h b/linux-user/m68k/target_structs.h
> index a003676..e373d48 100644
> --- a/linux-user/m68k/target_structs.h
> +++ b/linux-user/m68k/target_structs.h
> @@ -6,7 +6,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index b288a38..f154565 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -7,12 +7,12 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> + * Lesser General Public License for more details.
>   *
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index 6eeffdf..b35489b 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -7,12 +7,12 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> + * Lesser General Public License for more details.
>   *
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
> index 99e5be8..fd2bb46 100644
> --- a/target/m68k/gdbstub.c
> +++ b/target/m68k/gdbstub.c
> @@ -7,7 +7,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 917d46e..3e26d33 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -7,12 +7,12 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> + * Lesser General Public License for more details.
>   *
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 8d09ed9..76f4399 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -6,7 +6,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 752e46e..6217a68 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -7,12 +7,12 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> + * Lesser General Public License for more details.
>   *
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
