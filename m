Received: from eggs.gnu.org ([209.51.188.92]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gomYB-0008UF-93
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gomY9-0000zm-R0
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:52:55 -0500
References: <1548255083-8190-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ad237f21-f9f8-85f3-b444-3917fdcc0744@vivier.eu>
Date: Wed, 30 Jan 2019 10:52:46 +0100
MIME-Version: 1.0
In-Reply-To: <1548255083-8190-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Don't talk about the LGPL
 if the file is licensed under the GPL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 23/01/2019 15:51, Thomas Huth wrote:
> Some files claim that the code is licensed under the GPL, but then
> suddenly suggest that the user should have a look at the LGPL.
> That's of course non-sense, replace it with the correct GPL wording
> instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  crypto/afsplit.c           | 11 +++++------
>  include/crypto/afsplit.h   | 11 +++++------
>  include/hw/pci-host/gpex.h |  4 ++--
>  include/hw/pci-host/q35.h  |  4 ++--
>  include/qemu/range.h       | 11 +++++------
>  target/i386/hvf/hvf.c      |  6 +++---
>  util/range.c               | 11 +++++------
>  7 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/crypto/afsplit.c b/crypto/afsplit.c
> index 825e2cf..328d68c 100644
> --- a/crypto/afsplit.c
> +++ b/crypto/afsplit.c
> @@ -8,19 +8,18 @@
>   * Copyright (C) 2004, Clemens Fruhwirth <clemens@endorphin.org>
>   * Copyright (C) 2009-2012, Red Hat, Inc. All rights reserved.
>   *
> - * This library is free software; you can redistribute it and/or
> + * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
>   * as published by the Free Software Foundation; either version 2
>   * of the License, or (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * General Public License for more details.
>   *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #include "qemu/osdep.h"
> diff --git a/include/crypto/afsplit.h b/include/crypto/afsplit.h
> index 7dd21f0..4894d64 100644
> --- a/include/crypto/afsplit.h
> +++ b/include/crypto/afsplit.h
> @@ -3,19 +3,18 @@
>   *
>   * Copyright (c) 2015-2016 Red Hat, Inc.
>   *
> - * This library is free software; you can redistribute it and/or
> + * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
>   * as published by the Free Software Foundation; either version 2
>   * of the License, or (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * General Public License for more details.
>   *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #ifndef QCRYPTO_AFSPLIT_H
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index aef38b8..2af1c4a 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -13,8 +13,8 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>
>   */
>  
>  #ifndef HW_GPEX_H
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index 8f4ddde..5ed77fa 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -15,8 +15,8 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>
>   */
>  
>  #ifndef HW_Q35_H
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index ba606c6..71b8b21 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -3,19 +3,18 @@
>   *
>   * Copyright (c) 2015-2016 Red Hat, Inc.
>   *
> - * This library is free software; you can redistribute it and/or
> + * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public
>   * License as published by the Free Software Foundation; either
>   * version 2 of the License, or (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * General Public License for more details.
>   *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #ifndef QEMU_RANGE_H
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index e193022..689b585 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -13,10 +13,10 @@
>   * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> + * General Public License for more details.
>   *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   *
>   * This file contain code under public domain from the hvdos project:
>   * https://github.com/mist64/hvdos
> diff --git a/util/range.c b/util/range.c
> index 416df7c..098d9d2 100644
> --- a/util/range.c
> +++ b/util/range.c
> @@ -3,19 +3,18 @@
>   *
>   * Copyright (c) 2015-2016 Red Hat, Inc.
>   *
> - * This library is free software; you can redistribute it and/or
> + * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public
>   * License as published by the Free Software Foundation; either
>   * version 2 of the License, or (at your option) any later version.
>   *
> - * This library is distributed in the hope that it will be useful,
> + * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * General Public License for more details.
>   *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #include "qemu/osdep.h"
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
