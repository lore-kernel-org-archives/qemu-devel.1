Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF28C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EA3204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHO9QgJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EA3204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfkNn-00078E-Ba
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 08:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfkKi-0005Ri-8C
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfkKh-0002Y7-3O
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:13:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfkKg-0002VP-Ro
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:13:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id k11so17634338wrl.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UksaqtF4N/TPnqD/x+MneQK0JrFAEjRTWNgnhoMnXwU=;
 b=MHO9QgJ62G1vTj1jSK8CSwS3w2D71/omOcfa9CfzR5j/sXo03g83Hd2OnVKUsC9Zvr
 twd2SBXPqBfMKMpd+adsmc2J1/RuHpftdWJsTgI6L6XN+l6q3spYFXusK/CGPwEkgJJI
 E0TckHGlGsjuLOlunxkMiNmVQHP4wiv+37KZvbfsfs7Dx0W3j1RyadKGS+ph6bjDwO+S
 db86suwf53guXpEhF54x5zeHHqC5wAvJPJrULCToI/tELq9OCRjHduPm7PCM02MOiu/N
 SKA5Dj/A8Y9C3OOgqcR/oWTafOyP1BWAjTDHb5WwPcr4LCWg9uOMkPWorlAdpO1MwrlB
 CPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UksaqtF4N/TPnqD/x+MneQK0JrFAEjRTWNgnhoMnXwU=;
 b=P/97ym7fkC+tIrjsPgKoMOdcqm2MaIZfxyg8+QqyM/nHn45C/eAJBe45BUGtt1ECIY
 U/n9hEALIotP/zp/sWmFZ8XdZkJrXUl6VL/RxsykvzqnX1rxOZqJotD7ZlIc5gq0RpZI
 iUjhJY4Wf+HARNvjvyyYFadwt+VdN7Cn5Ly6vwzN0BbA6FglustZw3uM0LCMc2fhGWXT
 RgEf0Ac6KM93AeldQ6C145/xda8QPQHt0cg6f1vgkS/Ml5lPc4hK4TAsPILINwM6vmUW
 H3Wa/noPxWxTi1PeniiB1ERuPOsRy9dnU4OPj4Dfua7pcR3L0v065fY1uJ5DUUOJN/fX
 3gwQ==
X-Gm-Message-State: APjAAAUauZBjp+rdf8593Gid1A33oJq+1zk1rYkpN5ClUnt7GBRnZGPB
 0BQj7I3p211FtoSfQ9lIk0LJng==
X-Google-Smtp-Source: APXvYqz1CwiM0jvK82K4dPV07IV+vJIDflKYZv9LRiufox2b/V4PB0DnOAVlYs+GgogDTl35w1g/Yw==
X-Received: by 2002:adf:f046:: with SMTP id t6mr11767694wro.307.1561464831574; 
 Tue, 25 Jun 2019 05:13:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l8sm30609191wrg.40.2019.06.25.05.13.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 05:13:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 890811FF87;
 Tue, 25 Jun 2019 13:13:50 +0100 (BST)
References: <20190624055442.2973-1-vandersonmr2@gmail.com>
 <20190624055442.2973-5-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190624055442.2973-5-vandersonmr2@gmail.com>
Date: Tue, 25 Jun 2019 13:13:50 +0100
Message-ID: <87h88d277l.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 4/4] adding -d hot_tbs:limit command
 line option
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
Cc: Riku Voipio <riku.voipio@iki.fi>, vandersonmr <vandersonmr2@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> add option to dump the N most hot TB blocks.
> -d hot_tbs:N
>
> Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
> ---
>  include/qemu/log-for-trace.h | 2 ++
>  linux-user/exit.c            | 3 +++
>  util/log.c                   | 9 +++++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index 2f0a5b080e..d65eb83037 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -21,6 +21,8 @@
>  /* Private global variable, don't use */
>  extern int qemu_loglevel;
>
> +extern int32_t max_num_hot_tbs_to_dump;
> +

This might as well be an int (especially as your using atoi to scan it).

>  #define LOG_TRACE          (1 << 15)
>
>  /* Returns true if a bit is set in the current loglevel mask */
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index bdda720553..08b86dfd61 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -28,6 +28,9 @@ extern void __gcov_dump(void);
>
>  void preexit_cleanup(CPUArchState *env, int code)
>  {
> +    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
> +        tb_dump_exec_freq(max_num_hot_tbs_to_dump);
> +    }

Rather than baking the individual flags here and the fact you'll need to
duplicate the test for system emulation why not have a common helper
which you call unconditionally here and in the tail end of vl.c's main:

  qemu_do_exit_logs()

where:

void qemu_do_exit_logs(void)
{
    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
        tb_dump_exec_freq(max_num_hot_tbs_to_dump);
    }
}

and we can extend that for other reports later...


>  #ifdef TARGET_GPROF
>          _mcleanup();
>  #endif
> diff --git a/util/log.c b/util/log.c
> index 1d1b33f7d9..e71c663143 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -30,6 +30,7 @@ FILE *qemu_logfile;
>  int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
> +int32_t max_num_hot_tbs_to_dump;
>
>  /* Return the number of characters emitted.  */
>  int qemu_log(const char *fmt, ...)
> @@ -273,6 +274,9 @@ const QEMULogItem qemu_log_items[] =3D {
>      { CPU_LOG_TB_NOCHAIN, "nochain",
>        "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
>        "complete traces" },
> +    { CPU_LOG_HOT_TBS, "hot_tbs(:limit)",
> +      "show TBs (until given a limit) ordered by their hotness.\n"
> +      "(if no limit is given, show all)" },
>      { 0, NULL, NULL },
>  };
>
> @@ -294,6 +298,11 @@ int qemu_str_to_log_mask(const char *str)
>              trace_enable_events((*tmp) + 6);
>              mask |=3D LOG_TRACE;
>  #endif
> +        } else if (g_str_has_prefix(*tmp, "hot_tbs")) {
> +            if (g_str_has_prefix(*tmp, "hot_tbs:") && (*tmp)[8] !=3D '\0=
') {
> +                max_num_hot_tbs_to_dump =3D atoi((*tmp) + 8);
> +            }
> +            mask |=3D CPU_LOG_HOT_TBS;
>          } else {
>              for (item =3D qemu_log_items; item->mask !=3D 0; item++) {
>                  if (g_str_equal(*tmp, item->name)) {


--
Alex Benn=C3=A9e

