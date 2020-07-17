Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C4AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C512067D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C512067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQU4-0003Cj-Q9
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jwQTH-0002m0-Pf
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:32:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:41284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jwQTD-0006be-VV
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:32:15 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 751B974633F;
 Fri, 17 Jul 2020 15:32:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4FC4C74633D; Fri, 17 Jul 2020 15:32:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4D88B745702;
 Fri, 17 Jul 2020 15:32:07 +0200 (CEST)
Date: Fri, 17 Jul 2020 15:32:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 4/5] util: add qemu_get_host_physmem utility function
In-Reply-To: <20200717105139.25293-5-alex.bennee@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2007171529440.1227@zero.eik.bme.hu>
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-5-alex.bennee@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1856710570-1594992727=:1227"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, berrange@redhat.com, Stefan Weil <sw@weilnetz.de>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, f4bug@amsat.org,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1856710570-1594992727=:1227
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 17 Jul 2020, Alex Bennée wrote:
> This will be used in a future patch. For POSIX systems _SC_PHYS_PAGES
> isn't standardised but at least appears in the man pages for
> Open/FreeBSD. The result is advisory so any users of it shouldn't just
> fail if we can't work it out.
>
> The win32 stub currently returns 0 until someone with a Windows system
> can develop and test a patch.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> ---
> include/qemu/osdep.h | 10 ++++++++++
> util/oslib-posix.c   | 11 +++++++++++
> util/oslib-win32.c   |  6 ++++++
> 3 files changed, 27 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 4841b5c6b5f..7ff209983e2 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -665,4 +665,14 @@ static inline void qemu_reset_optind(void)
>  */
> char *qemu_get_host_name(Error **errp);
>
> +/**
> + * qemu_get_host_physmem:
> + *
> + * Operating system agnostiv way of querying host memory.

Typo: agnostiv -> agnostic

> + *
> + * Returns amount of physical memory on the system. This is purely
> + * advisery and may return 0 if we can't work it out.
> + */
> +size_t qemu_get_host_physmem(void);
> +
> #endif
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 36bf8593f8c..d9da782b896 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -839,3 +839,14 @@ char *qemu_get_host_name(Error **errp)
>
>     return g_steal_pointer(&hostname);
> }
> +
> +size_t qemu_get_host_physmem(void)
> +{
> +#ifdef _SC_PHYS_PAGES
> +    long pages = sysconf(_SC_PHYS_PAGES);
> +    if (pages > 0) {
> +        return pages * qemu_real_host_page_size;

The Linux man page warns that this product may overflow so maybe you could 
return pages here.

> +    }
> +#endif
> +    return 0;
> +}
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 7eedbe5859a..31030463cc9 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -828,3 +828,9 @@ char *qemu_get_host_name(Error **errp)
>
>     return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
> }
> +
> +size_t qemu_get_host_physmem(void)
> +{
> +    /* currently unimplemented */
> +    return 0;
> +}

For Windows this may help:

https://stackoverflow.com/questions/5553665/get-ram-system-size

not sure about other OSes.

Regards,
BALATON Zoltan
--3866299591-1856710570-1594992727=:1227--

