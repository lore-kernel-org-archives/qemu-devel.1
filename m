Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA9CC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D308920883
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D308920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDRqi-0002rT-3v
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 06:50:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDRps-0002af-If
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDRpr-0005jp-0c
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:49:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDRpq-0005iD-LX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:49:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so15788082wrd.3
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 03:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cMO8fgG8oUKdpAQ6b/BB5inP8x37fRYiU2uodUnk0XQ=;
	b=W1e1hJU5anIpuFMTXaUZ7zwCEnvpK9NMwj2pe1EOfUNNIzwG3Z0HLlu6j1mz7l/ZQu
	yO1IZ5U5e/ALq2Ib1Q/pNY2gHger4tVOcNIKXNamgBKR3B4W+eUxmj0txmx4bWlaAG6Q
	4WQ3hAcmaeBiZMSOe3npSwH39Q78LdttO0M+Jq/28JUjMRvlizsyBNyO2ZGl+/sXBBMv
	t5MggZh3E65+tdYkIUGdVS6QAVeAm822c7ACemHbOXzu0g813g6mfygZoW5P5bx3bs4c
	xAmPvr06yoKl2SivHFkd7jHxhDNnMIiqQ0EoNz0Lljz5TsjSD+I6tGPADZnX415RCMmi
	g2fQ==
X-Gm-Message-State: APjAAAU9tKTsx8N3dPW5iPwtZIk/inpLz1y+VUU87Ln+vRX8YiNfOglS
	rwadT7L3uSAT2A02A1W/yGrRaA==
X-Google-Smtp-Source: APXvYqyNaFJn2UIE6/g8jsZ3OFvCH8Fpg557iKAV40aUqVkRI9YB1RWEcaqlFQVrZ9boUS68KPM5IQ==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr18600193wrw.203.1554720545578;
	Mon, 08 Apr 2019 03:49:05 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	m13sm9270686wmg.42.2019.04.08.03.49.04
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 03:49:04 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bac30071-64ea-3dff-976b-9c8d8b1f16a3@redhat.com>
Date: Mon, 8 Apr 2019 12:49:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-5-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 04/15] loader-fit: Wean off error_printf()
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Paul Burton <pburton@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408104903.IXUbhSdoShnzqdksFavOxEYQtBgo-kUYgchlvnAwT0Q@z>

On 4/8/19 10:36 AM, Markus Armbruster wrote:
> load_fit() reports errors with error_printf() instead of
> error_report().  Worse, it even reports errors it actually recovers
> from, in fit_cfg_compatible() and fit_load_fdt().  Messed up in
> initial commit 51b58561c1d.
> 
> Convert the helper functions for load_fit() to Error.  Make sure each
> failure path sets an error.
> 
> Fix fit_cfg_compatible() and fit_load_fdt() not to report errors they
> actually recover from.
> 
> Convert load_fit() to error_report().
> 
> Cc: Paul Burton <pburton@wavecomp.com>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/loader-fit.c | 62 +++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 447f60857d..f27b6af942 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "qemu/units.h"
>  #include "exec/memory.h"
>  #include "hw/loader.h"
> @@ -33,7 +34,7 @@
>  #define FIT_LOADER_MAX_PATH (128)
>  
>  static const void *fit_load_image_alloc(const void *itb, const char *name,
> -                                        int *poff, size_t *psz)
> +                                        int *poff, size_t *psz, Error **errp)
>  {
>      const void *data;
>      const char *comp;
> @@ -46,6 +47,7 @@ static const void *fit_load_image_alloc(const void *itb, const char *name,
>  
>      off = fdt_path_offset(itb, path);
>      if (off < 0) {
> +        error_setg(errp, "can't find node %s", path);
>          return NULL;
>      }
>      if (poff) {
> @@ -54,6 +56,7 @@ static const void *fit_load_image_alloc(const void *itb, const char *name,
>  
>      data = fdt_getprop(itb, off, "data", &sz);
>      if (!data) {
> +        error_setg(errp, "can't get %s/data", path);
>          return NULL;
>      }
>  
> @@ -73,7 +76,7 @@ static const void *fit_load_image_alloc(const void *itb, const char *name,
>  
>          uncomp_len = gunzip(uncomp_data, uncomp_len, (void *) data, sz);
>          if (uncomp_len < 0) {
> -            error_printf("unable to decompress %s image\n", name);
> +            error_setg(errp, "unable to decompress %s image", name);
>              g_free(uncomp_data);
>              return NULL;
>          }
> @@ -85,18 +88,19 @@ static const void *fit_load_image_alloc(const void *itb, const char *name,
>          return data;
>      }
>  
> -    error_printf("unknown compression '%s'\n", comp);
> +    error_setg(errp, "unknown compression '%s'", comp);
>      return NULL;
>  }
>  
>  static int fit_image_addr(const void *itb, int img, const char *name,
> -                          hwaddr *addr)
> +                          hwaddr *addr, Error **errp)
>  {
>      const void *prop;
>      int len;
>  
>      prop = fdt_getprop(itb, img, name, &len);
>      if (!prop) {
> +        error_setg(errp, "can't find %s address", name);
>          return -ENOENT;
>      }
>  
> @@ -108,13 +112,14 @@ static int fit_image_addr(const void *itb, int img, const char *name,
>          *addr = fdt64_to_cpu(*(fdt64_t *)prop);
>          return 0;
>      default:
> -        error_printf("invalid %s address length %d\n", name, len);
> +        error_setg(errp, "invalid %s address length %d", name, len);
>          return -EINVAL;
>      }
>  }
>  
>  static int fit_load_kernel(const struct fit_loader *ldr, const void *itb,
> -                           int cfg, void *opaque, hwaddr *pend)
> +                           int cfg, void *opaque, hwaddr *pend,
> +                           Error **errp)
>  {
>      const char *name;
>      const void *data;
> @@ -126,26 +131,26 @@ static int fit_load_kernel(const struct fit_loader *ldr, const void *itb,
>  
>      name = fdt_getprop(itb, cfg, "kernel", NULL);
>      if (!name) {
> -        error_printf("no kernel specified by FIT configuration\n");
> +        error_setg(errp, "no kernel specified by FIT configuration");
>          return -EINVAL;
>      }
>  
> -    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz);
> +    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz, errp);
>      if (!data) {
> -        error_printf("unable to load kernel image from FIT\n");
> +        error_prepend(errp, "unable to load kernel image from FIT: ");
>          return -EINVAL;
>      }
>  
> -    err = fit_image_addr(itb, img_off, "load", &load_addr);
> +    err = fit_image_addr(itb, img_off, "load", &load_addr, errp);
>      if (err) {
> -        error_printf("unable to read kernel load address from FIT\n");
> +        error_prepend(errp, "unable to read kernel load address from FIT: ");
>          ret = err;
>          goto out;
>      }
>  
> -    err = fit_image_addr(itb, img_off, "entry", &entry_addr);
> +    err = fit_image_addr(itb, img_off, "entry", &entry_addr, errp);
>      if (err) {
> -        error_printf("unable to read kernel entry address from FIT\n");
> +        error_prepend(errp, "unable to read kernel entry address from FIT: ");
>          ret = err;
>          goto out;
>      }
> @@ -172,7 +177,7 @@ out:
>  
>  static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
>                          int cfg, void *opaque, const void *match_data,
> -                        hwaddr kernel_end)
> +                        hwaddr kernel_end, Error **errp)
>  {
>      const char *name;
>      const void *data;
> @@ -187,16 +192,18 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
>          return 0;
>      }
>  
> -    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz);
> +    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz, errp);
>      if (!data) {
> -        error_printf("unable to load FDT image from FIT\n");
> +        error_prepend(errp, "unable to load FDT image from FIT: ");
>          return -EINVAL;
>      }
>  
> -    err = fit_image_addr(itb, img_off, "load", &load_addr);
> +    err = fit_image_addr(itb, img_off, "load", &load_addr, errp);
>      if (err == -ENOENT) {
>          load_addr = ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
> +        error_free(*errp);
>      } else if (err) {
> +        error_prepend(errp, "unable to read FDT load address from FIT: ");
>          ret = err;
>          goto out;
>      }
> @@ -229,7 +236,7 @@ static bool fit_cfg_compatible(const void *itb, int cfg, const char *compat)
>          return false;
>      }
>  
> -    fdt = fit_load_image_alloc(itb, fdt_name, NULL, NULL);
> +    fdt = fit_load_image_alloc(itb, fdt_name, NULL, NULL, NULL);
>      if (!fdt) {
>          return false;
>      }
> @@ -252,11 +259,12 @@ out:
>  
>  int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
>  {
> +    Error *err = NULL;
>      const struct fit_loader_match *match;
>      const void *itb, *match_data = NULL;
>      const char *def_cfg_name;
>      char path[FIT_LOADER_MAX_PATH];
> -    int itb_size, configs, cfg_off, off, err;
> +    int itb_size, configs, cfg_off, off;
>      hwaddr kernel_end;
>      int ret;
>  
> @@ -267,6 +275,7 @@ int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
>  
>      configs = fdt_path_offset(itb, "/configurations");
>      if (configs < 0) {
> +        error_report("can't find node /configurations");
>          ret = configs;
>          goto out;
>      }
> @@ -301,20 +310,21 @@ int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
>      }
>  
>      if (cfg_off < 0) {
> -        /* couldn't find a configuration to use */
> +        error_report("can't find configuration");
>          ret = cfg_off;
>          goto out;
>      }
>  
> -    err = fit_load_kernel(ldr, itb, cfg_off, opaque, &kernel_end);
> -    if (err) {
> -        ret = err;
> +    ret = fit_load_kernel(ldr, itb, cfg_off, opaque, &kernel_end, &err);
> +    if (ret) {
> +        error_report_err(err);
>          goto out;
>      }
>  
> -    err = fit_load_fdt(ldr, itb, cfg_off, opaque, match_data, kernel_end);
> -    if (err) {
> -        ret = err;
> +    ret = fit_load_fdt(ldr, itb, cfg_off, opaque, match_data, kernel_end,
> +                       &err);
> +    if (ret) {
> +        error_report_err(err);
>          goto out;
>      }

Very nice cleanup, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


