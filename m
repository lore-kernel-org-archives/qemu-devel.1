Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDBCC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8202080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8202080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6gL-00008I-5w
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hg6Yg-0004aq-7e
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hg6Yf-0000YR-5S
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:57:50 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hg6Ye-0000Mn-T3
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:57:49 -0400
Received: by mail-wr1-f54.google.com with SMTP id x4so2406419wrt.6
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 04:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:references:to:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3RIWYQo2xsO/H0aefoqbA59gX8qjE1yxHNyyCEEvpDg=;
 b=Gmy9lnDdPbhemJ6eQBrgB3Hn8HVkGUp1nkORX0VvqKpO+kCY0ZSAcwJVmPhW2jyfXY
 opMv85rDoNF1o1Hbq2JccXiG9mFWsMnKUlVdgtfvs1UZK0K5UvXLRc8su2MVP/mNeC0J
 0BENNMjAXN3MHn7GYIvx+iCApC8hpEQB4qtGWoz0DZfVwOgQjuao0uK78E3q8PDa4Y1a
 mOM/+MML0oQam7OPEFvjJu1G24eiBpzslnXgB5R50F3zPltP8JtJLoVj3+YI1Zad39Hk
 aVl88/+TXki090hzYcGl4UxrrQAqZRB/D2E4VC43/TMgQ3BLbrojqvUnTp3s7dSRWN1X
 FQfA==
X-Gm-Message-State: APjAAAW/H9Q7xIbwJ0e+W4NuQcszT699eaXwOqzhk61YlC8uB3AEiuiX
 swi67nx42SAp2QfQASzAO66J/w==
X-Google-Smtp-Source: APXvYqxSp2KUpHwTJt2oYu30GLQCXV6r++r78stvhzF4QoXkA/LGeHiiwtxeU1TmR6+9ewNB1/yf8w==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr3430942wro.36.1561550264473; 
 Wed, 26 Jun 2019 04:57:44 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id a84sm2809474wmf.29.2019.06.26.04.57.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 04:57:44 -0700 (PDT)
References: <f8f439b4-3835-686c-2c1e-20fe78d6bbf1@redhat.com>
To: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?=
 <vilanova@ac.upc.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
X-Forwarded-Message-Id: <f8f439b4-3835-686c-2c1e-20fe78d6bbf1@redhat.com>
Message-ID: <d75c0641-01a3-ac5c-2f4d-b41505747815@redhat.com>
Date: Wed, 26 Jun 2019 13:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f8f439b4-3835-686c-2c1e-20fe78d6bbf1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.54
Subject: [Qemu-devel] trace: floating-point values blacklisted
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

[I forgot to Cc the list, resending]

Hi Stefan, Lluís,

When trying to add a trace event to report a float value, I get:

trace-events:11: Argument type 'float' is not in whitelist. Only
standard C types and fixed size integer types should be used. struct,
union, and other complex pointer types should be declared as 'void *'
Traceback (most recent call last):
  File "./scripts/tracetool.py", line 152, in <module>
    main(sys.argv)
  File "./scripts/tracetool.py", line 143, in main
    events.extend(tracetool.read_events(fh, arg))
  File "./scripts/tracetool/__init__.py", line 365, in read_events
    event = Event.build(line)
  File "./scripts/tracetool/__init__.py", line 283, in build
    args = Arguments.build(groups["args"])
  File "./scripts/tracetool/__init__.py", line 133, in build
    validate_type(arg_type)
  File "./scripts/tracetool/__init__.py", line 86, in validate_type
    "declared as 'void *'" % name)

Floating-point types are specified in the optional Annex F of the
standard ("IEC 60559 floating-point arithmetic").

Is there a specific reason to not trace them, or simply nobody ever had
to trace them?

Thanks,

Phil.

