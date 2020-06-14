Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC8FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 17:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A8B206A4
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 17:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC4qFP4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A8B206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkWGR-0002Yx-9o
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 13:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkWFP-0001z8-NQ; Sun, 14 Jun 2020 13:16:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40446)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkWFO-0005Lf-1r; Sun, 14 Jun 2020 13:16:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so14754255wrc.7;
 Sun, 14 Jun 2020 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A6ygokNgtS7TmGmx0HclCMjm3stS0K7lkEtgQh2kHak=;
 b=cC4qFP4/8nGrjr/DyEu7ykPHjZVbF26XwkirvRv99+utVC3tLpxv0Y25lJUzxzfnjj
 r1hqLR9dTVspjgc0qTk+Yq4jpWHn0Nk6C5w/EZ9k+1zMtYyGTN2KiBRZPB0/Wghag+M9
 tUSEG2JLNTrTbuU6TlTfcpkdnioJLM1ZlTPy3DBE+oGxm+kMDkEkMzRGv+46v6advgv8
 Cmbr5iQF7u7iPG5Uv6/ZUPo4AALDQEGsD4oBXWhOziba8BuMXikOP7ktO/iv34IsDECG
 5+991dkpF7kJ2ltaHQ/aexOYjODJT3aQ9twXwKrNmbfJPNVWBCcBjSyK3seoUNF2iuX2
 Mhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=A6ygokNgtS7TmGmx0HclCMjm3stS0K7lkEtgQh2kHak=;
 b=JTNOHtoLkCOmDzAjWy5/j24wriCKza6fWKKyH6o7+Kdb/AJHm4j5GLrO2+9TKY6XVK
 3IeQopDG7sbNx7oeDkAuT3lmA2W7vsEqkFKNZxBvaBqipFej8z22flZMMVw3iAcW8VZ7
 Z8oIzT6zzU1FJVuAuQLNmDuSg3H9dWaqsSdHt1i4ZJl3Cqazc2hllrsoqt8ALuMIf3GI
 EbtHuUk5A7T5TyF0alrFSNonuk8IARun/K3BGqv2F+OVX6nSudvzOGwf2EKg9cztI6u4
 70nzlBzoZhMWDkH5vpDbz+JLsFTi5f/1JNFtzVdWEExWdOSALETF4/GxHPUMjJO/umCG
 e2yQ==
X-Gm-Message-State: AOAM531go8SoEX4bvOg0HEA6hXyafeZfRMghiiO74ykiBB2vP3LBRkG6
 G0XwPGL1d0gXrLFX5/afYE4=
X-Google-Smtp-Source: ABdhPJxMdKc9RnlZ8hXpM06w1Z5UpkGUZxzIO6YWUN+w813W12GTS/2n9zjh9AqOOq17f7UvhUO2Lg==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr25343257wrt.104.1592154989995; 
 Sun, 14 Jun 2020 10:16:29 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n189sm18833235wmb.43.2020.06.14.10.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2020 10:16:29 -0700 (PDT)
Subject: Re: [PATCH 22/22] adb: add ADB bus trace events
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, laurent@vivier.eu, fthain@telegraphics.com.au
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
 <20200614142840.10245-23-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <ab46d38d-9b64-18c9-bd2f-08e48b1dc82f@amsat.org>
Date: Sun, 14 Jun 2020 19:16:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200614142840.10245-23-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Mark,

On 6/14/20 4:28 PM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/input/adb.c        | 23 ++++++++++++++++++++++-
>  hw/input/trace-events |  7 +++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index fe0f6c7ef3..4976f52c36 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -29,10 +29,18 @@
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
>  #include "adb-internal.h"
> +#include "trace.h"
>  
>  /* error codes */
>  #define ADB_RET_NOTPRESENT (-2)
>  
> +static const char *adb_commands[] = {
> +    "RESET", "FLUSH", "(Reserved 0x2)", "(Reserved 0x3)",
> +    "Reserved (0x4)", "(Reserved 0x5)", "(Reserved 0x6)", "(Reserved 0x7)",
> +    "LISTEN r0", "LISTEN r1", "LISTEN r2", "LISTEN r3",
> +    "TALK r0", "TALK r1", "TALK r2", "TALK r3",
> +};
> +
>  static void adb_device_reset(ADBDevice *d)
>  {
>      qdev_reset_all(DEVICE(d));
> @@ -86,9 +94,16 @@ static int do_adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf,
>  
>  int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
>  {
> +    int ret;
> +
> +    trace_adb_bus_request(buf[0] >> 4, adb_commands[buf[0] & 0xf], len);
> +
>      assert(s->autopoll_blocked);
>  
> -    return do_adb_request(s, obuf, buf, len);
> +    ret = do_adb_request(s, obuf, buf, len);
> +
> +    trace_adb_bus_request_done(buf[0] >> 4, adb_commands[buf[0] & 0xf], ret);
> +    return ret;
>  }
>  
>  int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
> @@ -160,6 +175,8 @@ void adb_set_autopoll_mask(ADBBusState *s, uint16_t mask)
>  
>  void adb_autopoll_block(ADBBusState *s)
>  {
> +    trace_adb_bus_autopoll_block("autopoll BLOCKED");

Regarding how trace backends work, in this case it is better
to use a boolean value and let the backend do the formatting:

       trace_adb_bus_autopoll_block(true);

The rationale is it is easier for backends to filter on a
bool (register) arg rather than fetching memory for strcmp.

So format can be:

adb_bus_autopoll_block(bool state) "autopoll is_blocked:%u"

Anyway if you want to keep as it, it is cleaner to change the
format as "autopoll %s".

> +
>      s->autopoll_blocked = true;

This can also be:

       trace_adb_bus_autopoll_block(s->autopoll_blocked);

>  
>      if (s->autopoll_enabled) {
> @@ -169,6 +186,8 @@ void adb_autopoll_block(ADBBusState *s)
>  
>  void adb_autopoll_unblock(ADBBusState *s)
>  {
> +    trace_adb_bus_autopoll_block("autopoll UNBLOCKED");
> +
>      s->autopoll_blocked = false;

Ditto:

       trace_adb_bus_autopoll_block(s->autopoll_blocked);

>  
>      if (s->autopoll_enabled) {
> @@ -183,7 +202,9 @@ static void adb_autopoll(void *opaque)
>      ADBBusState *s = opaque;
>  
>      if (!s->autopoll_blocked) {
> +        trace_adb_bus_autopoll_cb(s->autopoll_mask);
>          s->autopoll_cb(s->autopoll_cb_opaque);
> +        trace_adb_bus_autopoll_cb_done(s->autopoll_mask);
>      }
>  
>      timer_mod(s->autopoll_timer,
> diff --git a/hw/input/trace-events b/hw/input/trace-events
> index 6f0d78241c..119d1ce2bd 100644
> --- a/hw/input/trace-events
> +++ b/hw/input/trace-events
> @@ -14,6 +14,13 @@ adb_device_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x
>  adb_device_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
>  adb_device_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
>  
> +# adb.c
> +adb_bus_request(uint8_t addr, const char *cmd, int size) "device 0x%x %s cmdsize=%d"
> +adb_bus_request_done(uint8_t addr, const char *cmd, int size) "device 0x%x %s replysize=%d"
> +adb_bus_autopoll_block(const char *s) "%s"
> +adb_bus_autopoll_cb(uint16_t mask) "executing autopoll_cb with autopoll mask 0x%x"
> +adb_bus_autopoll_cb_done(uint16_t mask) "done executing autopoll_cb with autopoll mask 0x%x"
> +
>  # pckbd.c
>  pckbd_kbd_read_data(uint32_t val) "0x%02x"
>  pckbd_kbd_read_status(int status) "0x%02x"
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

