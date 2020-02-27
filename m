Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17359C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCD624695
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjlV90Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCD624695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GpE-0002Fr-1u
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7GoW-0001MJ-Ee
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7GoU-00053H-3I
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:54:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34926
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7GoT-00050L-Rh
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582800880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzsuHGiWKbJjz/GBd39TzvO4he9cbTBOd7/2LLsaGp8=;
 b=HjlV90Jf/y0lnE5rwdoDQM7+FxAEt8yKPIORzUl9aSS7gaFty599gxH9GtnofFvk4uRvVz
 PpsYgI2wTT2hcXqTSAwYQeHfjl68umjrPmmOIgUsO2DRXUntPdngrO75zMl24VAUi3fvoB
 P4R5A7lg6PoQwTUr27c97ITnP05rn/E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-xlVtEYyYOS-1kBsKJd5s0w-1; Thu, 27 Feb 2020 05:54:38 -0500
X-MC-Unique: xlVtEYyYOS-1kBsKJd5s0w-1
Received: by mail-wr1-f70.google.com with SMTP id z15so1158403wrw.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 02:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RvJYGb5l2LvhAtvzDaHsI6pAzF4cLaE643pQi22+ER4=;
 b=XXz6xsbiGP/vLll1jGSMFiwFDJOvEwrM9gRki8u39d3DTzCWTeaIUs+R3M47fhZKSW
 I2YvbzXznUj9+3ZhvlDWdrae8I+uo9pVL0Trtk5PWQhMj4RKNXHOKyuvmK2aO84KGRnu
 DU7ozK9N3uglk3F+dR7lH9ixe/d/BSVs3JMkVEWfysWD4GGabBeBjcZsi3sh49NCRLF+
 jVtfvvogmtjPtwGeT5vd6d4/3HRyjgBW3r+SbwB73g3vAT2KwuRUKt6nhVN/MWJn+T9Z
 pESTZXPH7Vg7d6Y7KMI/ouD3Uwu8bH5JJSWLLyMzxku3lXtwMyX5oqANOL5bay5MSWsR
 iImg==
X-Gm-Message-State: APjAAAUDq7CNUXHdcXhyMNAAhKId3GDKLSuZrEJsaY9phDJG0c3QKZZX
 dmrs6tjCdpafqq6cnwS/GLq1LdiXg7d4B97jiDlRXInGjV7tsSRnySJGJE8QrAmBwrf82FZ4zRI
 CxLMt9VlrdL6Q6as=
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr4771272wme.114.1582800877547; 
 Thu, 27 Feb 2020 02:54:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8YKkVri39KYmCV+Tlf5PLWyXNTqdQkIDkn/i/+PmwRCTU8GZiraJ0m3d4Q7kVnbat02aSKA==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr4771243wme.114.1582800877308; 
 Thu, 27 Feb 2020 02:54:37 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j5sm7599168wrx.56.2020.02.27.02.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 02:54:36 -0800 (PST)
Subject: Re: [PATCH v1 1/4] accel/tcg: use units.h for defining code gen
 buffer sizes
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4b3b8d43-25db-6ac2-dbc6-04f2aae56638@redhat.com>
Date: Thu, 27 Feb 2020 11:54:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226181020.19592-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 7:10 PM, Alex Benn=C3=A9e wrote:
> It's easier to read.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   accel/tcg/translate-all.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a08ab11f657..238b0e575bf 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -18,6 +18,7 @@
>    */
>  =20
>   #include "qemu/osdep.h"
> +#include "qemu/units.h"
>   #include "qemu-common.h"
>  =20
>   #define NO_CPU_IO_DEFS
> @@ -901,33 +902,33 @@ static void page_lock_pair(PageDesc **ret_p1, tb_pa=
ge_addr_t phys1,
>  =20
>   /* Minimum size of the code gen buffer.  This number is randomly chosen=
,
>      but not so small that we can't have a fair number of TB's live.  */
> -#define MIN_CODE_GEN_BUFFER_SIZE     (1024u * 1024)
> +#define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
>  =20
>   /* Maximum size of the code gen buffer we'd like to use.  Unless otherw=
ise
>      indicated, this is constrained by the range of direct branches on th=
e
>      host cpu, as used by the TCG implementation of goto_tb.  */
>   #if defined(__x86_64__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
>   #elif defined(__sparc__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
>   #elif defined(__powerpc64__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
>   #elif defined(__powerpc__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (32u * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (32 * MiB)
>   #elif defined(__aarch64__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
>   #elif defined(__s390x__)
>     /* We have a +- 4GB range on the branches; leave some slop.  */
> -# define MAX_CODE_GEN_BUFFER_SIZE  (3ul * 1024 * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (3 * GiB)
>   #elif defined(__mips__)
>     /* We have a 256MB branch region, but leave room to make sure the
>        main executable is also within that region.  */
> -# define MAX_CODE_GEN_BUFFER_SIZE  (128ul * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (128 * MiB)
>   #else
>   # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
>   #endif
>  =20
> -#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32u * 1024 * 1024)
> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
>  =20
>   #define DEFAULT_CODE_GEN_BUFFER_SIZE \
>     (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
>=20

Thanks!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


