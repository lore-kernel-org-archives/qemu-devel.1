Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FEFC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC072064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJc3fUX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC072064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUo7-0007YI-GP
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1isUlV-00058V-31
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1isUlT-0004aY-VX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:46:32 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:33294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1isUlR-0004U9-Jp; Fri, 17 Jan 2020 11:46:29 -0500
Received: by mail-yb1-xb43.google.com with SMTP id n66so6440758ybg.0;
 Fri, 17 Jan 2020 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ajV1/PYLosp7/N6LIdluScNNKiTvqm6he4Yn7gT2BVk=;
 b=vJc3fUX/SPC68z1LqhjIEpwwAF515l5Xg+AbNcKbj3bCcTJHWPm1yoONSGD3VTwIIi
 C3KOmR7fhGnn8vOIUP4FF4QhfelSDzlgK1QF4CdeX2vBBCklqPAh8DdgXlqy9pwV+1aK
 ifxhs/sQKt7QcyX9K4FFkAUE93tAqmOASVfNFcrd6akO5oSU75Sri06YHKZ3mpLlB9je
 yKdqsH142zoYjEUjxm4TCFK1AzzBIq11xxrmXOJg+XaBiUF43M9zmovMDuAnbvx2EkuZ
 UGjhukj24rGO60GbMitNk0ScGQXAvnvgPgBoIjrKxEYdGCl8/Cgx5HpMo++I/tZq0eR1
 d39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ajV1/PYLosp7/N6LIdluScNNKiTvqm6he4Yn7gT2BVk=;
 b=BpaVdHknOYdK6iEgosGKvW7LJ7A+/veLUx7nVtq9W/apasvmJDhZLL2aGq+rb6JIrg
 6qKlldbbg4+jDcc9nF4hmxTUlItCtnP3Kwv7NnWbtpnIB+/TTMt4QSEN5VBAMg344fqC
 F/aM5lNTvVMMypksI9bvFXT58NlrOKw/WQnsF6F52yCLJLzq8cAMKJuqNhv3yOSmnq1n
 T1hZnY/qveqD89PgCqB+z546qZ41mMI8RgF5C9matna44fFHd1nz6Z/vjqVDePUO1uFe
 uQ1UwIEUahil9kBzf/Fl6TOgHt0RSnC0qayRPS0gjPkFSZBdMc8UhR8JE+9Aip0S9tsX
 9p2w==
X-Gm-Message-State: APjAAAXVtDu2REsrzbfRkuQBlcSCnky6902EHC//E67ESWTdXm+b5HcJ
 WDo8Ld0xPXkjOmh5kIbNzd8=
X-Google-Smtp-Source: APXvYqwIE7RyAiG3R2ZYx/eBv1e7x+gEokHKcOdlefsWchOegil3Xb4imjTX/yj4vRiX0vMgXnfkbw==
X-Received: by 2002:a25:6e04:: with SMTP id j4mr30706909ybc.36.1579279587601; 
 Fri, 17 Jan 2020 08:46:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id q185sm11316617ywh.61.2020.01.17.08.46.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 08:46:26 -0800 (PST)
Date: Fri, 17 Jan 2020 08:46:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/6] dma/pl330: Convert to support tracing
Message-ID: <20200117164625.GA27197@roeck-us.net>
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-2-linux@roeck-us.net>
 <CAFEAcA_k8xdzmsgMK+m6wSgnBN53UjCNU4nTBx=hnHnHz+Su6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_k8xdzmsgMK+m6wSgnBN53UjCNU4nTBx=hnHnHz+Su6g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 17, 2020 at 01:23:46PM +0000, Peter Maydell wrote:
> On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Replace debug logging code with tracing.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  hw/dma/pl330.c      | 88 +++++++++++++++++++++++----------------------
> >  hw/dma/trace-events | 24 +++++++++++++
> 
> > +static void pl330_hexdump(uint8_t *buf, size_t size)
> > +{
> > +    unsigned int b, i, len;
> > +    char tmpbuf[80];
> > +
> > +    for (b = 0; b < size; b += 16) {
> > +        len = size - b;
> > +        if (len > 16) {
> > +            len = 16;
> > +        }
> > +        tmpbuf[0] = '\0';
> > +        for (i = 0; i < len; i++) {
> > +            if ((i % 4) == 0) {
> > +                strcat(tmpbuf, " ");
> > +            }
> > +            sprintf(tmpbuf + strlen(tmpbuf), " %02x", buf[b + i]);
> > +        }
> > +        trace_pl330_hexdump(b, tmpbuf);
> > +    }
> > +}
> >
> 
> > @@ -1175,11 +1186,8 @@ static int pl330_exec_cycle(PL330Chan *channel)
> >          int len = q->len - (q->addr & (q->len - 1));
> >
> >          dma_memory_read(&address_space_memory, q->addr, buf, len);
> > -        if (PL330_ERR_DEBUG > 1) {
> > -            DB_PRINT("PL330 read from memory @%08" PRIx32 " (size = %08x):\n",
> > -                      q->addr, len);
> > -            qemu_hexdump((char *)buf, stderr, "", len);
> > -        }
> > +        trace_pl330_exec_cycle(q->addr, len);
> > +        pl330_hexdump(buf, len);
> 
> Won't this now do all the work of constructing the hexdump strings,
> even if tracing is disabled ?
> 
That is correct. Can I check
	if (trace_event_get_state(TRACE_PL330_HEXDUMP) &&
	    qemu_loglevel_mask(LOG_TRACE)) {
directly in pl330_hexdump(), or is there some other means to handle
this kind of situation ?

Thanks,
Guenter

