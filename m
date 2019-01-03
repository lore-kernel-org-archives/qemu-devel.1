Received: from eggs.gnu.org ([208.118.235.92]:50099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyvh-00015I-Ny
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyvd-0008N7-IC
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:04:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1geyvd-0008Ml-Ae
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:04:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so29613214wmf.5
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 01:04:37 -0800 (PST)
References: <154645087925.9907.8533035759502851896@02a1dbf831e2>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e122954c-760c-47ac-3858-1c25e0b2f9ff@redhat.com>
Date: Thu, 3 Jan 2019 10:04:29 +0100
MIME-Version: 1.0
In-Reply-To: <154645087925.9907.8533035759502851896@02a1dbf831e2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] cutils: Cleanup, improve documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: fam@euphon.net, david@redhat.com, qemu-trivial@nongnu.org, cohuck@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, kraxel@redhat.com, pbonzini@redhat.com

On 1/2/19 6:41 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20181226171538.21984-1-philmd@redhat.com/
[...]> === OUTPUT BEGIN ===
> Checking PATCH 1/3: util/cutils: Move size_to_str() from "qemu-common.h" to "cutils.h"...
> WARNING: Block comments use a leading /* on a separate line
> #42: FILE: include/qemu/cutils.h:160:
> +/**

I believe this warning is incorrect, since we use the /** marking for
Doxygen generated documentation. The offending comment is:

  /**
   * size_to_str:
   *
   * Return human readable string for size @val.
   * Use IEC binary units like KiB, MiB, and so forth.
   *
   * @val: The value to format.
   *       Can be anything that uint64_t allows (no more than "16 EiB").
   *
   * Caller is responsible for passing it to g_free().
   */
   char *size_to_str(uint64_t val);

Am I missing something?

> Checking PATCH 2/3: util/cutils: Move ctype macros to "cutils.h"...
> WARNING: Block comments use a leading /* on a separate line
> #100: FILE: include/qemu/cutils.h:6:
> +/** unsigned ctype macros:
> 
> ERROR: code indent should never use tabs
> #108: FILE: include/qemu/cutils.h:14:
> +#define qemu_isalnum(c)^I^Iisalnum((unsigned char)(c))$

OK, this is code movement I forgot to fix :/

> Checking PATCH 3/3: util/cutils: Move function documentations to the header...
> WARNING: Block comments use a leading /* on a separate line
> #73: FILE: include/qemu/cutils.h:156:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #95: FILE: include/qemu/cutils.h:179:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #124: FILE: include/qemu/cutils.h:208:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #154: FILE: include/qemu/cutils.h:238:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #183: FILE: include/qemu/cutils.h:267:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #214: FILE: include/qemu/cutils.h:298:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #225: FILE: include/qemu/cutils.h:309:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #235: FILE: include/qemu/cutils.h:319:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #263: FILE: include/qemu/cutils.h:347:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #273: FILE: include/qemu/cutils.h:357:
> +/**
> 
> WARNING: Block comments use a leading /* on a separate line
> #304: FILE: include/qemu/cutils.h:388:
> +/**
