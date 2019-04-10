Received: from eggs.gnu.org ([209.51.188.92]:48044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAKI-00016y-7t
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAKG-0006uz-4u
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:19:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEAKF-0006tu-MX
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:19:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so2233677wre.7
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 03:19:27 -0700 (PDT)
References: <20190409230022.6462-1-lersek@redhat.com>
	<20190409230022.6462-9-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d8371bd-b778-659e-cc71-b4c1ee65ea34@redhat.com>
Date: Wed, 10 Apr 2019 12:19:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190409230022.6462-9-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 08/12] pc-bios: add edk2
 firmware binaries and variable store templates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

On 4/10/19 1:00 AM, Laszlo Ersek wrote:
> Add the files built by the last patch: (compressed) binaries, and the
> cumulative license text that covers them.
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Notes:
>     v4:
>     
>     - no change
>     
>     v3:
>     
>     - pick up Michal's R-b
>     
>     - pick up Phil's R-b
>     
>     - pick up Michael's R-b
>     
>     - Compress FD files with bzip2 rather than xz, so that decompression at
>       "make install" time succeed on older build OSes too. The total size
>       grows from 9,394,072 bytes to 9,492,846. [Peter]
>     
>     - do not pick up Igor's T-b therefore
>     
>     v2:
>     
>     - capture the compressed build outputs of the last patch; slightly
>       update the commit message [Dan, Michael, Phil]
>     
>     - consequently, do not pick up Michal's and Michael's R-b's
> 
>  pc-bios/edk2-licenses.txt              | 209 ++++++++++++++++++++
>  pc-bios/edk2-aarch64-code.fd.bz2       | Bin 0 -> 1177603 bytes
>  pc-bios/edk2-arm-code.fd.bz2           | Bin 0 -> 1173662 bytes
>  pc-bios/edk2-arm-vars.fd.bz2           | Bin 0 -> 263 bytes
>  pc-bios/edk2-i386-code.fd.bz2          | Bin 0 -> 1688659 bytes
>  pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 0 -> 1881979 bytes
>  pc-bios/edk2-i386-vars.fd.bz2          | Bin 0 -> 190 bytes
>  pc-bios/edk2-x86_64-code.fd.bz2        | Bin 0 -> 1669280 bytes
>  pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 0 -> 1901210 bytes
>  9 files changed, 209 insertions(+)
> 
> diff --git a/pc-bios/edk2-licenses.txt b/pc-bios/edk2-licenses.txt
> new file mode 100644
> index 000000000000..8bdb1abc993e
> --- /dev/null
> +++ b/pc-bios/edk2-licenses.txt
> @@ -0,0 +1,209 @@
> +==> edk2/License.txt <==
> +Copyright (c) 2004 - 2016, Intel Corporation. All rights reserved.
> +Copyright (c) 2008 - 2010, Apple Inc. All rights reserved.
> +Copyright (c) 2011 - 2015, ARM Limited. All rights reserved.
> +Copyright (c) 2014 - 2015, Linaro Limited. All rights reserved.
> +Copyright (c) 2013 - 2015, Red Hat, Inc.
> +
> +Redistribution and use in source and binary forms, with or without
> +modification, are permitted provided that the following conditions
> +are met:
> +
> +* Redistributions of source code must retain the above copyright
> +  notice, this list of conditions and the following disclaimer.
> +* Redistributions in binary form must reproduce the above copyright
> +  notice, this list of conditions and the following disclaimer in
> +  the documentation and/or other materials provided with the
> +  distribution.
> +
> +THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> +"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> +LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> +FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> +COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> +INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> +BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> +LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> +CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> +LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> +ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> +POSSIBILITY OF SUCH DAMAGE.
> +
> +==> edk2/OvmfPkg/License.txt <==
> +Copyright (c) 2012, Intel Corporation. All rights reserved.
> +
> +Redistribution and use in source and binary forms, with or without
> +modification, are permitted provided that the following conditions
> +are met:
> +
> +* Redistributions of source code must retain the above copyright
> +  notice, this list of conditions and the following disclaimer.
> +* Redistributions in binary form must reproduce the above copyright
> +  notice, this list of conditions and the following disclaimer in
> +  the documentation and/or other materials provided with the
> +  distribution.
> +
> +THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> +"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> +LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> +FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> +COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> +INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> +BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> +LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> +CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> +LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> +ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> +POSSIBILITY OF SUCH DAMAGE.
> +
> +
> +Some files are subject to the following license, the MIT license. Those files
> +are located in:
> +- OvmfPkg/Include/IndustryStandard/Xen/
> +- OvmfPkg/XenBusDxe/
> +- OvmfPkg/XenPvBlkDxe/
> +
> +Permission is hereby granted, free of charge, to any person obtaining a copy
> +of this software and associated documentation files (the "Software"), to deal
> +in the Software without restriction, including without limitation the rights
> +to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> +copies of the Software, and to permit persons to whom the Software is
> +furnished to do so, subject to the following conditions:
> +
> +The above copyright notice and this permission notice shall be included in
> +all copies or substantial portions of the Software.
> +
> +THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> +AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> +LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> +OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> +THE SOFTWARE.
> +
> +==> edk2/CryptoPkg/Library/OpensslLib/openssl/LICENSE <==
> +
> +  LICENSE ISSUES
> +  ==============
> +
> +  The OpenSSL toolkit stays under a double license, i.e. both the conditions of
> +  the OpenSSL License and the original SSLeay license apply to the toolkit.
> +  See below for the actual license texts.
> +
> +  OpenSSL License
> +  ---------------
> +
> +/* ====================================================================
> + * Copyright (c) 1998-2018 The OpenSSL Project.  All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer. 
> + *
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in
> + *    the documentation and/or other materials provided with the
> + *    distribution.
> + *
> + * 3. All advertising materials mentioning features or use of this
> + *    software must display the following acknowledgment:
> + *    "This product includes software developed by the OpenSSL Project
> + *    for use in the OpenSSL Toolkit. (http://www.openssl.org/)"
> + *
> + * 4. The names "OpenSSL Toolkit" and "OpenSSL Project" must not be used to
> + *    endorse or promote products derived from this software without
> + *    prior written permission. For written permission, please contact
> + *    openssl-core@openssl.org.
> + *
> + * 5. Products derived from this software may not be called "OpenSSL"
> + *    nor may "OpenSSL" appear in their names without prior written
> + *    permission of the OpenSSL Project.
> + *
> + * 6. Redistributions of any form whatsoever must retain the following
> + *    acknowledgment:
> + *    "This product includes software developed by the OpenSSL Project
> + *    for use in the OpenSSL Toolkit (http://www.openssl.org/)"
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE OpenSSL PROJECT ``AS IS'' AND ANY
> + * EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
> + * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE OpenSSL PROJECT OR
> + * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
> + * OF THE POSSIBILITY OF SUCH DAMAGE.
> + * ====================================================================
> + *
> + * This product includes cryptographic software written by Eric Young
> + * (eay@cryptsoft.com).  This product includes software written by Tim
> + * Hudson (tjh@cryptsoft.com).
> + *
> + */
> +
> + Original SSLeay License
> + -----------------------
> +
> +/* Copyright (C) 1995-1998 Eric Young (eay@cryptsoft.com)
> + * All rights reserved.
> + *
> + * This package is an SSL implementation written
> + * by Eric Young (eay@cryptsoft.com).
> + * The implementation was written so as to conform with Netscapes SSL.
> + * 
> + * This library is free for commercial and non-commercial use as long as
> + * the following conditions are aheared to.  The following conditions
> + * apply to all code found in this distribution, be it the RC4, RSA,
> + * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
> + * included with this distribution is covered by the same copyright terms
> + * except that the holder is Tim Hudson (tjh@cryptsoft.com).
> + * 
> + * Copyright remains Eric Young's, and as such any Copyright notices in
> + * the code are not to be removed.
> + * If this package is used in a product, Eric Young should be given attribution
> + * as the author of the parts of the library used.
> + * This can be in the form of a textual message at program startup or
> + * in documentation (online or textual) provided with the package.
> + * 
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. All advertising materials mentioning features or use of this software
> + *    must display the following acknowledgement:
> + *    "This product includes cryptographic software written by
> + *     Eric Young (eay@cryptsoft.com)"
> + *    The word 'cryptographic' can be left out if the rouines from the library
> + *    being used are not cryptographic related :-).
> + * 4. If you include any Windows specific code (or a derivative thereof) from 
> + *    the apps directory (application code) you must include an acknowledgement:
> + *    "This product includes software written by Tim Hudson (tjh@cryptsoft.com)"
> + * 
> + * THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + * 
> + * The licence and distribution terms for any publically available version or
> + * derivative of this code cannot be changed.  i.e. this code cannot simply be
> + * copied and put under another distribution licence
> + * [including the GNU Public Licence.]
> + */
> +
> diff --git a/pc-bios/edk2-aarch64-code.fd.bz2 b/pc-bios/edk2-aarch64-code.fd.bz2
> new file mode 100644
> index 000000000000..b213334d9553
> Binary files /dev/null and b/pc-bios/edk2-aarch64-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-arm-code.fd.bz2 b/pc-bios/edk2-arm-code.fd.bz2
> new file mode 100644
> index 000000000000..a494a8391eed
> Binary files /dev/null and b/pc-bios/edk2-arm-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-arm-vars.fd.bz2 b/pc-bios/edk2-arm-vars.fd.bz2
> new file mode 100644
> index 000000000000..2a5a9af31a6c
> Binary files /dev/null and b/pc-bios/edk2-arm-vars.fd.bz2 differ
> diff --git a/pc-bios/edk2-i386-code.fd.bz2 b/pc-bios/edk2-i386-code.fd.bz2
> new file mode 100644
> index 000000000000..5440ca856db6
> Binary files /dev/null and b/pc-bios/edk2-i386-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-i386-secure-code.fd.bz2 b/pc-bios/edk2-i386-secure-code.fd.bz2
> new file mode 100644
> index 000000000000..24ae88ac3e40
> Binary files /dev/null and b/pc-bios/edk2-i386-secure-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-i386-vars.fd.bz2 b/pc-bios/edk2-i386-vars.fd.bz2
> new file mode 100644
> index 000000000000..4a1bc4523880
> Binary files /dev/null and b/pc-bios/edk2-i386-vars.fd.bz2 differ
> diff --git a/pc-bios/edk2-x86_64-code.fd.bz2 b/pc-bios/edk2-x86_64-code.fd.bz2
> new file mode 100644
> index 000000000000..6a0b1f983199
> Binary files /dev/null and b/pc-bios/edk2-x86_64-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-x86_64-secure-code.fd.bz2 b/pc-bios/edk2-x86_64-secure-code.fd.bz2
> new file mode 100644
> index 000000000000..3ef6452c0375
> Binary files /dev/null and b/pc-bios/edk2-x86_64-secure-code.fd.bz2 differ
> 
