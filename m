Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE4CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118B520872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118B520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cGR-0006iU-KB
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7bsK-0002ER-3N
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7bsJ-0001GF-0z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:51:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7bsI-0001FX-Oq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:51:46 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPK73-1hmOFz1oyL-00Pb9n; Tue, 10 Sep 2019 10:51:30 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190908061543.25136-1-f4bug@amsat.org>
 <20190908061543.25136-3-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <46d65df5-b947-8e65-fd02-22da9c763b1a@vivier.eu>
Date: Tue, 10 Sep 2019 10:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190908061543.25136-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r+n20bXl2VC0wwGQBzK55YFA/xBrTJeuf/qwGLHSxbnJSsZuOgv
 HCeo0BHRzICZnHSd8YGZY/kNB635Vvk1L/+VaIqm4HQrGLxW9JcvfTO5S3FczjXGUAppr65
 Jm49VLeCZegXAgQi+IibxCWi1LpUmQ30bENLWlLlZfjOiSIa1PYIcBIeXfL48POxv37nQDY
 bcUiGZDmCV6DUDcnmlVsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l0atQ13zvkE=:9HAjx9V3HUFPiT8kQymYjX
 shGYJrPd80nL2DXGbgc3b6NRD9IMRGl/sY6cPqi5t1hKo3vxBGojB6eqBo0yDGNyO0JfG8oX8
 uWPh2bqtOqG3P1mwouxnuY4NbbN15H7EJCFSIIjukTDM1agcviOn+6mboOXFRcJOq4k2jOdfa
 ef6oFJP/jgWYmhjZqfkzr15+rveujgVR39z6h5arDhiBb8TX1akoLOMCPxX3r+Ds0VC25Fhma
 LPjC//82D4fF5GiOE9QIe0UxyaRKHNsyKSBQWNOlikR1a7reOssdJwPN0qshMQAGGWBQ5kAZ4
 xJF4VDhFdGVZhBczKTrfEaH+C6CGUmUgQtw2E5swwMQ6J1/crpT2Tv5GbyZ8z0JAOyYxfAfkS
 gmKhZn/wiqleYY/aEY+bOzXFaozyezoJLvf3CKNu/6dffVoUQQZK/i24t14eRFYyBkvf1PnV5
 UEpLONDUchjElS03ShZIHeqFllq1zpRv2097GloIxRKC0plIE70RR3TXvVSBmOnXsG0lRuLgc
 arIdBfD8nhqrydMdHjmGlvnUWJmUC8XXFu84HFKbnM3+xnVEa/q7ARY7YvP2OZB+1j/Qddmuo
 QV/qoLTclSZQ0ezkY3wgM37RLR7XAbyFe/ujXOv8orNMxlKRnPEiw1+viedp2GOgk4SQthbdU
 YlDZfsHbmwaTWMWkMFFmL5NzdPC36lqbzVFI7CTWoce6RfR4Su/2n3dAXzZ2GsTtGAydTzoTa
 jpfeDfSF8Jb7podtA74IJbZxfVtFwFPHpvR3q0Kqhg4DzfdVCJtXSuUSh8UFe9skZxSz49X/E
 o9BX3HmlRPMuZULaxrlIw4WqPhiCcoblKEosMvD0xSHn8xlUGA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH v6 2/8] linux-user/strace: Add
 print_timezone()
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
Cc: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 08/09/2019 à 08:15, Philippe Mathieu-Daudé a écrit :
> Suggested-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> checkpatch error:
> ERROR: storage class should be at the beginning of the declaration
> ---
>  linux-user/strace.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index f326c357a2..5ee9d62c25 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -63,6 +63,7 @@ UNUSED static void print_string(abi_long, int);
>  UNUSED static void print_buf(abi_long addr, abi_long len, int last);
>  UNUSED static void print_raw_param(const char *, abi_long, int);
>  UNUSED static void print_timeval(abi_ulong, int);
> +UNUSED static void print_timezone(abi_ulong, int);
>  UNUSED static void print_number(abi_long, int);
>  UNUSED static void print_signal(abi_ulong, int);
>  UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen);
> @@ -1254,6 +1255,26 @@ print_timeval(abi_ulong tv_addr, int last)
>          gemu_log("NULL%s", get_comma(last));
>  }
>  
> +static void
> +print_timezone(abi_ulong tz_addr, int last)
> +{
> +    if (tz_addr) {
> +        struct target_timezone *tz;
> +
> +        tz = lock_user(VERIFY_READ, tz_addr, sizeof(*tz), 1);
> +        if (!tz) {
> +            print_pointer(tz_addr, last);
> +            return;
> +        }
> +        gemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
> +                 tswapal(tz->tz_minuteswest), tswapal(tz->tz_dsttime),

tz_minuteswest and tz_dsttime are abi_int, so it should be "%d" and
tswap32().

> +                 get_comma(last));
> +        unlock_user(tz, tz_addr, 0);
> +    } else {
> +        gemu_log("NULL%s", get_comma(last));
> +    }
> +}
> +
>  #undef UNUSED
>  
>  #ifdef TARGET_NR_accept
> 


