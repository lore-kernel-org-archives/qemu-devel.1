Received: from eggs.gnu.org ([2001:4830:134:3::10]:38721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn3eo-0005X2-7N
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn3eh-0001n7-PE
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:07:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55875)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dn3eh-0001mu-F9
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:07:43 -0400
Date: Wed, 30 Aug 2017 15:07:38 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170830140738.GS18526@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/13] hvf: add code base from Google's
 QEMU repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 03:26:51AM -0500, Sergio Andres Gomez Del Real wrote:
> This file begins tracking the files that will be the code base for HVF
> support in QEMU. This code base is part of Google's QEMU version of
> their Android emulator, and can be found at
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev
> 
> This code is based on Veertu Inc's vdhh (Veertu Desktop Hosted
> Hypervisor), found at https://github.com/veertuinc/vdhh. Everything is
> appropriately licensed under GPL v2.

The licensing seems a little more complicated than that

Per the QEMU LICENSE file new contributions must be  GPL v2-or-later


> diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
> new file mode 100644
> index 0000000000..0a1a5134f8
> --- /dev/null
> +++ b/target/i386/hvf-all.c
> @@ -0,0 +1,999 @@
> +// Copyright 2008 IBM Corporation
> +//           2008 Red Hat, Inc.
> +// Copyright 2011 Intel Corporation
> +// Copyright 2016 Veertu, Inc.
> +// Copyright 2017 The Android Open Source Project
> +// 
> +// QEMU Hypervisor.framework support
> +// 
> +// This software is licensed under the terms of the GNU General Public
> +// License version 2, as published by the Free Software Foundation, and
> +// may be copied, distributed, and modified under those terms.
> +// 
> +// This program is distributed in the hope that it will be useful,
> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +// GNU General Public License for more details.

This is v2-only.

If this v2-only license is inherited due to the file being derived
from another pre-existing file in QEMU that was v2-only, we could
possibly make an exception to allow another v2-only file in tree.
Preferably it should be v2-or-later though.

> diff --git a/target/i386/hvf-utils/vmcs.h b/target/i386/hvf-utils/vmcs.h
> new file mode 100644
> index 0000000000..6f7ccb361a
> --- /dev/null
> +++ b/target/i386/hvf-utils/vmcs.h
> @@ -0,0 +1,368 @@
> +/*-
> + * Copyright (c) 2011 NetApp, Inc.
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY NETAPP, INC ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL NETAPP, INC OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + *
> + * $FreeBSD$
> + */

A BSD license variant. OK since its GPL compatible and just a header file
copied from a 3rd party project.

> diff --git a/target/i386/hvf-utils/vmx.h b/target/i386/hvf-utils/vmx.h
> new file mode 100644
> index 0000000000..8a080e6777
> --- /dev/null
> +++ b/target/i386/hvf-utils/vmx.h
> @@ -0,0 +1,200 @@
> +/*
> + * Copyright (C) 2016 Veertu Inc,
> + * Copyright (C) 2017 Google Inc,
> + * Based on Veertu vddh/vmm/vmx.h
> + *
> + * Interfaces to Hypervisor.framework to read/write X86 registers and VMCS.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

This is  v2-or-v3-only, which is not OK for QEMU.

It needs to be v2-or-later



> diff --git a/target/i386/hvf-utils/x86.c b/target/i386/hvf-utils/x86.c
> new file mode 100644
> index 0000000000..e3db2c9c8b
> --- /dev/null
> +++ b/target/i386/hvf-utils/x86.c
> @@ -0,0 +1,174 @@
> +/*
> + * Copyright (C) 2016 Veertu Inc,
> + * Copyright (C) 2017 Google Inc,
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

Again  v2-or-v3-only.

There's many more files with this same problem but I'll stop pointing
them out now.

If this is to be included in QEMU,  Veertu & Google (and any other
copyright holders) would have to agree to change these files to
v2-or-later

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
