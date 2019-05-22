Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DAFC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D4A20851
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D4A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43523 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRUa-0002Yk-3x
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:41:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTRTM-0001qh-VA
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTRTM-0006XK-1X
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:40:00 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTRTL-0006WY-Oj
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:39:59 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N0WLC-1gg0Ah2Jls-00wUvn; Wed, 22 May 2019 15:39:31 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190506141923.12183-1-philmd@redhat.com>
	<20190506141923.12183-2-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ebaeaac0-f15c-bb8d-7d9c-d41b76f0e515@vivier.eu>
Date: Wed, 22 May 2019 15:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190506141923.12183-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:APCr8uQTQ4mzqg6Ly2Q8mrVQcjE0tbuq0KoZXos/AOUR3WRUSQQ
	QEu36PBR/cSMaBqe3OCeyMzUaiKi9boeUo32nnL6NeeLmuFZhsJODFtBcr5BalZLyG3k2IA
	X8p81A18HdsCCSS//mEZUBttn1t1FfY3CovrM/i2iY212MmaCc/Uim1WRmLY1yfEWuYj0ar
	56/4RuotdFao+JbR3Enyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CWWxLLpiIuk=:QZASSQXYHIKAhFZnIwJ9x9
	jOoU0r9ndszaJFxbHBtDbF4g3jaTXJy12VuIp370oAM6I7fENqz7iWfQmUiP3o89rXu+nJ8P0
	Yv6j1+mZ8eUeXy2f9t7TyC+jK/C1icQYLMz7ld/RTH3cHgSFbgxPJDYjhp9No9UPUpYJyrOTk
	PZpCYtYPuxkLFK0c2jhuapBXh5Ks5a4JO6T3zQuU20WbVbLdkm5L6pImwxgXbb5BNwh7iY8O/
	kNrP05czle0EcAXmHjFN+scPsDAwiWdjcZsMahOXOghjb+smIigXMUubWLwnnODD5BTBSAxd/
	NKr1ZxPQUeSmcrKDrgPywGtp0pfmLrjIv4MdZtaP2B99voLHtI5k811egjGSTCsl1wQUcYDsY
	tGFv2VBBDUUFqrwL/nfCNBvXrxV2l5CzLyfj0dqYLalcbsVP6axUiXilmx4ImREegGHxhywcp
	T4rlrD6KVJv2LtwVdQNDdM6gVcUIhQuIe3C5B7sibbU1gDYo8b3uz59gI2Fg0EwYYLHNB5NBQ
	la0tU46bf/IRnJHiQlYcKmLoV6MeQsjp/CkLqzWvszZfVwIAE5Bc+At72xrxBwVonfzQ3wUu9
	Qo+JDBr7Wfcw/yn5JKdgm3MTEN6vxji5RN6L3AZTRNShEQTdPKlcRurhl8a7P7ttMfOqsj3z6
	UZYJn4rXDwbCDNGOV8wi/z49k1y5k198daby8a6rhR5ja7QwXGk4mMpMPQOPqa5aWG0j/MjJ8
	XmDHgAzUnQStbqAXeZbxuPNkTg71v6YIii4XgUHdBasEhhHV66ZrI3IWhTg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v3 1/2] roms: Correct the
 EDK2_BASETOOLS_OPTFLAGS variable description
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/2019 16:19, Philippe Mathieu-Daudé wrote:
> In commit 1cab464136b4 we incorrectly described the
> EDK2_BASETOOLS_OPTFLAGS can pass CPPFLAGS and CFLAGS
> options to the EDK2 build tools, but it only expands
> the CFLAGS (not to the CPPFLAGS).
> Update the description to be more accurate.
> 
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v3: Squeezed 2 spaces (Laszlo)
> ---
>   roms/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index 0ce84a45ad5..ea6aec56abd 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -121,8 +121,8 @@ build-efi-roms: build-pxe-roms
>   		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>   		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
>   
> -# Build scripts can pass compiler/linker flags to the EDK2 build tools
> -# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
> +# Build scripts can pass compiler/linker flags to the EDK2
> +# build tools via the EDK2_BASETOOLS_OPTFLAGS (CFLAGS) and
>   # EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
>   #
>   # Example:
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

