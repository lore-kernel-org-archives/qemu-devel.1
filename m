Received: from eggs.gnu.org ([2001:4830:134:3::10]:38692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fL6iE-0007cW-31
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fL6iA-0007bt-3a
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:48:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fL6i9-0007bn-VI
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:48:18 -0400
References: <20180518122304.31020-1-marcandre.lureau@redhat.com>
	<20180518122304.31020-2-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <811a060f-ea14-48c9-ceb2-b27b45bbc431@redhat.com>
Date: Tue, 22 May 2018 14:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180518122304.31020-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [edk2] [PATCH v3 1/4] OvmfPkg: add
 Tcg2PhysicalPresenceLibNull when !TPM2_ENABLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 05/18/18 14:23, marcandre.lureau@redhat.com wrote:

> diff --git a/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalPresenceLib.inf b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalPresenceLib.inf
> new file mode 100644
> index 000000000000..92ce5f04b37f
> --- /dev/null
> +++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalPresenceLib.inf
> @@ -0,0 +1,33 @@
> +## @file
> +#  NULL Tcg2PhysicalPresenceLib library instance
> +#
> +# Under SecurityPkg, the corresponding library instance will check and
> +# execute TPM 2.0 request from OS or BIOS; the request may ask for user
> +# confirmation before execution. This Null instance implements a no-op
> +# Tcg2PhysicalPresenceLibProcessRequest(), without user interaction.
> +#
> +# Copyright (C) 2018, Red Hat, Inc.
> +# Copyright (c) 2013 - 2016, Intel Corporation. All rights reserved.<BR>
> +# This program and the accompanying materials
> +# are licensed and made available under the terms and conditions of the BSD License
> +# which accompanies this distribution. The full text of the license may be found at
> +# http://opensource.org/licenses/bsd-license.php
> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
> +# WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
> +#
> +##
> +
> +[Defines]
> +  INF_VERSION                    = 0x00010005
> +  BASE_NAME                      = DxeTcg2PhysicalPresenceLibNull
> +  FILE_GUID                      = 2A6BA243-DC22-42D8-9C3D-AE3728DC7AFA
> +  MODULE_TYPE                    = DXE_DRIVER
> +  VERSION_STRING                 = 1.0
> +  LIBRARY_CLASS                  = Tcg2PhysicalPresenceLib|DXE_DRIVER DXE_RUNTIME_DRIVER DXE_SAL_DRIVER UEFI_APPLICATION UEFI_DRIVER
> +
> +[Sources]
> +  DxeTcg2PhysicalPresenceLib.c
> +
> +[Packages]
> +  MdeModulePkg/MdeModulePkg.dec
> +  SecurityPkg/SecurityPkg.dec

Here my suggestion was to drop MdeModulePkg.dec, and keep MdePkg.dec and
SecurityPkg.dec.

Anyway, I plan to fix that up for you.

With it fixed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
