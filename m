Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DB3C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 17:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F4A2071A
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 17:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIWXlrLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F4A2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkWJx-0003qI-JW
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 13:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkWJI-0003K6-UD; Sun, 14 Jun 2020 13:20:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51002)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkWJH-000649-9f; Sun, 14 Jun 2020 13:20:44 -0400
Received: by mail-wm1-x341.google.com with SMTP id l17so12394980wmj.0;
 Sun, 14 Jun 2020 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vbT2L0fbDrNvbbXhktdgUoYQFpLHq5vFpADch9qrRg4=;
 b=hIWXlrLA5TKZC9dURJCMRqdN70uFGYiQR/q3Js0ocyWtAkUnN31qm9Hl0cpfUACFfe
 jtCt16DGwu5sjv7bHOrZJZh0jIylX0wuSOdrC9dtjJQRWSJB+Y3BlSZHM99qxBV2dqkb
 wYnBV6yMNmpAI7dJl7d2M833z747v2JeZoknS6sZC51qxkcP5tEmtrj6p1pf9qXIXjo4
 gDoqORPbegxr/IL14jTNFtcneiLlO+Ypu0FAGvh1szqyQfzWdy/ccJA6P9v0r/bL1FM/
 Vrrj76zdNuXez3qBJ+WEzFyaKClZMvzgN00F4UdVwebO/hjEeRmvEQKNewpqzW58d2tz
 QL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vbT2L0fbDrNvbbXhktdgUoYQFpLHq5vFpADch9qrRg4=;
 b=mqjqY2j2kcc7D76No3cQFfsvPLmBwgFHhGORHjvkp76a8Eaf284rPgV0CZ0vnRuDVh
 m+CHGM1hQXwHco9g5IkHbptPHmMiGOkAX3NQHrcr/61u2tqjYGD/wiGIHvExtXe17nI/
 9Fsq1JmDDWFxztL7gRmHUSCIkzpfcIpH5B7fDtpslx5yi7H7r8GPlqFSeWZJ721WdNRI
 YxEQqXy35Q7bcZ6GJpMgfrHIX5xrSAYlv4W3QC/CiUPK1LD3jwxNlqt/aeq/Ek+HvWVZ
 wST7b+PtWZyzEEFvsJt8At2YtgZSN61kKgLaN4JWQEs5YKQ++YA1Ebfq2wE/Poy5ofB+
 diDw==
X-Gm-Message-State: AOAM532SFFBuPr69o5syvsLPLaEZAEVLjjeJMDPzbWLSITU1xCS0Di80
 bUxit0dAcV/eowOZRr5msBk=
X-Google-Smtp-Source: ABdhPJzGu6e6zosBOc92T49abmw8hlnrGcOQK2Deu0a9T6GesOtaD0FGU+FG6NVGNoUq4HZSPT0sNw==
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr9064388wmf.21.1592155230370;
 Sun, 14 Jun 2020 10:20:30 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id f71sm18089509wmf.22.2020.06.14.10.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2020 10:20:29 -0700 (PDT)
Subject: Re: [PATCH 21/22] adb: use adb_device prefix for ADB device trace
 events
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, laurent@vivier.eu, fthain@telegraphics.com.au
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
 <20200614142840.10245-22-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb9d9259-5c92-4ca1-2636-681febbf5ddd@amsat.org>
Date: Sun, 14 Jun 2020 19:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200614142840.10245-22-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

On 6/14/20 4:28 PM, Mark Cave-Ayland wrote:
> This is to allow us to distinguish between ADB device events and ADB
> bus events separately.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/input/adb-kbd.c    | 12 ++++++------
>  hw/input/adb-mouse.c  | 12 ++++++------
>  hw/input/trace-events | 20 ++++++++++----------
>  3 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
> index 23760ecf7b..3cfb6a7a20 100644
> --- a/hw/input/adb-kbd.c
> +++ b/hw/input/adb-kbd.c
> @@ -243,7 +243,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
>      olen = 0;
>      switch (cmd) {
>      case ADB_WRITEREG:
> -        trace_adb_kbd_writereg(reg, buf[1]);
> +        trace_adb_device_kbd_writereg(reg, buf[1]);
>          switch (reg) {
>          case 2:
>              /* LED status */
> @@ -256,7 +256,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
>              case ADB_CMD_CHANGE_ID_AND_ACT:
>              case ADB_CMD_CHANGE_ID_AND_ENABLE:
>                  d->devaddr = buf[1] & 0xf;
> -                trace_adb_kbd_request_change_addr(d->devaddr);
> +                trace_adb_device_kbd_request_change_addr(d->devaddr);
>                  break;
>              default:
>                  d->devaddr = buf[1] & 0xf;
> @@ -270,8 +270,8 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
>                      d->handler = buf[2];
>                  }
>  
> -                trace_adb_kbd_request_change_addr_and_handler(d->devaddr,
> -                                                              d->handler);
> +                trace_adb_device_kbd_request_change_addr_and_handler(
> +                    d->devaddr, d->handler);
>                  break;
>              }
>          }
> @@ -294,7 +294,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
>              olen = 2;
>              break;
>          }
> -        trace_adb_kbd_readreg(reg, obuf[0], obuf[1]);
> +        trace_adb_device_kbd_readreg(reg, obuf[0], obuf[1]);
>          break;
>      }
>      return olen;
> @@ -321,7 +321,7 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
>      /* FIXME: take handler into account when translating qcode */
>      keycode = qcode_to_adb_keycode[qcode];
>      if (keycode == NO_KEY) {  /* We don't want to send this to the guest */
> -        trace_adb_kbd_no_key();
> +        trace_adb_device_kbd_no_key();
>          return;
>      }
>      if (evt->u.key.data->down == false) { /* if key release event */
> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
> index e2359fd74d..577a38ff2e 100644
> --- a/hw/input/adb-mouse.c
> +++ b/hw/input/adb-mouse.c
> @@ -121,7 +121,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>          s->dx = 0;
>          s->dy = 0;
>          s->dz = 0;
> -        trace_adb_mouse_flush();
> +        trace_adb_device_mouse_flush();
>          return 0;
>      }
>  
> @@ -130,7 +130,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>      olen = 0;
>      switch (cmd) {
>      case ADB_WRITEREG:
> -        trace_adb_mouse_writereg(reg, buf[1]);
> +        trace_adb_device_mouse_writereg(reg, buf[1]);
>          switch (reg) {
>          case 2:
>              break;
> @@ -152,7 +152,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>              case ADB_CMD_CHANGE_ID_AND_ACT:
>              case ADB_CMD_CHANGE_ID_AND_ENABLE:
>                  d->devaddr = buf[1] & 0xf;
> -                trace_adb_mouse_request_change_addr(d->devaddr);
> +                trace_adb_device_mouse_request_change_addr(d->devaddr);
>                  break;
>              default:
>                  d->devaddr = buf[1] & 0xf;
> @@ -172,8 +172,8 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>                      d->handler = buf[2];
>                  }
>  
> -                trace_adb_mouse_request_change_addr_and_handler(d->devaddr,
> -                                                                d->handler);
> +                trace_adb_device_mouse_request_change_addr_and_handler(
> +                    d->devaddr, d->handler);
>                  break;
>              }
>          }
> @@ -191,7 +191,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
>              olen = 2;
>              break;
>          }
> -        trace_adb_mouse_readreg(reg, obuf[0], obuf[1]);
> +        trace_adb_device_mouse_readreg(reg, obuf[0], obuf[1]);
>          break;
>      }
>      return olen;
> diff --git a/hw/input/trace-events b/hw/input/trace-events
> index a2888fd10c..6f0d78241c 100644
> --- a/hw/input/trace-events
> +++ b/hw/input/trace-events
> @@ -1,18 +1,18 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>  
>  # adb-kbd.c
> -adb_kbd_no_key(void) "Ignoring NO_KEY"
> -adb_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
> -adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
> -adb_kbd_request_change_addr(int devaddr) "change addr to 0x%x"
> -adb_kbd_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
> +adb_device_kbd_no_key(void) "Ignoring NO_KEY"
> +adb_device_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
> +adb_device_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
> +adb_device_kbd_request_change_addr(int devaddr) "change addr to 0x%x"
> +adb_device_kbd_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
>  
>  # adb-mouse.c
> -adb_mouse_flush(void) "flush"
> -adb_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
> -adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
> -adb_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
> -adb_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
> +adb_device_mouse_flush(void) "flush"

For the following: ...

> +adb_device_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
> +adb_device_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
> +adb_device_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
> +adb_device_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"

... you could use a common trace, using a device_type argument, i.e.:

adb_device_writereg(const char *device_type, int reg, uint8_t val) "%s
reg %d val 0x%2.2x"

But then you can not filter traces for a particular device.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>  # pckbd.c
>  pckbd_kbd_read_data(uint32_t val) "0x%02x"
> 


