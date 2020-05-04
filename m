Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33980C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D2F2071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D2F2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXme-0006ID-4j
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVXi0-0006k3-67; Mon, 04 May 2020 05:48:20 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVXhz-0005zl-3Q; Mon, 04 May 2020 05:48:19 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MmlfM-1ilim03G22-00jtAt; Mon, 04 May 2020 11:48:14 +0200
Subject: Re: [PATCH] chardev: Add macOS to list of OSes that support -chardev
 serial
To: Mikhail Gusarov <dottedmag@dottedmag.net>, qemu-devel@nongnu.org
References: <20200426210956.17324-1-dottedmag@dottedmag.net>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <283aa50d-2899-c414-b566-aae0e12b52fb@vivier.eu>
Date: Mon, 4 May 2020 11:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426210956.17324-1-dottedmag@dottedmag.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w8mKWqrjuqJzEm4EpUTXc1mgS618S4qnWRw2zNlJGQRGVeN0V1Q
 j6tDN8pLyUWM0cGtQTXV5htzgppmFOYNabg8hNBfxKuUsG2IJCMMwt1VZlJbUUwgW1hpFnf
 mOBy2/X3pF0+TdSQEQUuaiIe8Rf4hZt3RmF9FNBOWO3uU0v/sD2FCUAy+c3t8YCipYghFK6
 r9XWiI3FDTL6pXiVMa/ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c6MIoP8jW64=:xg1RmtczvyQtHuW4FHbGJc
 Y5sEVrVSSNvs2t1oL8/8fjKEACeIAA4YGOtRPB4n03034XUtM4jfzN6S2g+JhULC+HVI/i2OB
 co33SymtE89yLv3BjxCSaHW4nrxkW1BrSXxJmKiODBY82ler1NRauFzyShDCb5QL8ZwcgwUOf
 dWqYCi4yYH6fz2ChRzxVlHCumkbNvjbti1BxzdMDkjnpzEkEuhbAmpoecrzeuU889vJMmYwg3
 G1SLJ5npXEqtL/h/cJD8oEmR4x93IBYkXCw5gtsGRRnxYJQ+5jF0R9hkjEIVehDg4q9ri0D6J
 Fxv8XEzg/qTyq3TMgyD3hV09X/cY+bLMJBNFHJKEjuFfsQZp/jXAQ0TiiyYooWg6us/TQJkdX
 vO6KcS2GbjPy28p6NfMPhIPXNHN9Z+jrcSoUnQx2C1/SJ7uMuSvaVgo2Em2Kwgham8TPuCqe1
 Ci1k7Vgeg60A1MZGwHcx98cv37tT8XLnmdQVertPBzRknQyfXaikTEbRnvxTOp9Rvzn5gHRId
 vaaC21OfWaEYGa2LBPtuW4zFQpFbSzD+vpyv0xMMj2ZpAmOJYF63paez2pUasNkpUMLFcVs7M
 ewHuJQheoQc1+yATZrEVm2k85LoaArVYKkL8CRV32wqihgAa8I0T5SY+/mC/1j/icj39PI6Gz
 BaNuVT0mk9/Je7A64IFRACoAAUEx82bSsy7ddWcFVGczt9hRa5NiI9WDmP9XLYTa090yi1q2d
 oxbyI9twAxGaPBZT+GjR/fcgeZvQZh0mEf8TSUT/4296TJ8pNlDhNGWOLNhHV6j86W9Pd2eUm
 DLzT3HmW519u8l9iRVOlEHd26nm7kJCcHj9wAGJaZLd++5BYa0OOSGuW2ordZSENh8AVzuB
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:20:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/04/2020 à 23:09, Mikhail Gusarov a écrit :
> macOS API for dealing with serial ports/ttys is identical to BSDs.
> 
> Signed-off-by: Mikhail Gusarov <dottedmag@dottedmag.net>
> ---
> 
> Note that the same file has a line
>> #endif /* linux || sun */
> that is severely out of date.
> 
>  chardev/char-serial.c | 2 +-
>  include/qemu/osdep.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 5b833ea077..7c3d84ae24 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -53,7 +53,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
>  
>  #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
>      || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
> -    || defined(__GLIBC__)
> +    || defined(__GLIBC__) || defined(__APPLE__)
>  
>  static void tty_serial_init(int fd, int speed,
>                              int parity, int data_bits, int stop_bits)
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 20f5c5f197..ff7c17b857 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -379,7 +379,7 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  #define HAVE_CHARDEV_SERIAL 1
>  #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    \
>      || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
> -    || defined(__GLIBC__)
> +    || defined(__GLIBC__) || defined(__APPLE__)
>  #define HAVE_CHARDEV_SERIAL 1
>  #endif
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

