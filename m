Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0F3C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE632083E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE632083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53755 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE5kw-00036C-9a
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 01:26:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5k4-0002mv-1g
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5k2-000346-N3
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:25:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hE5k2-00033h-EN
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:25:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so1242292wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 22:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=XcIXF9GlADAWxdmtTGdOkycgT98Zr2w70tgjhi+Mjdw=;
	b=WA1hb3xAfJiomcoohPOGu/8fAbf27D1lk3ZVPDL1RLceNkVI+FEKhvYbQJ1QyfaqAP
	649ydyirkUMfr3fQ3UhNV6k7k7BNRGuz2oQaYldfMXRI5pvMXk8dN8w2R67PRiYK07qk
	pUpPQx8mWileAiP6I9GLRcWKYW7m/hVT6ICzufyuCkMT50AHE5VeIQVaZ1qMut0MkY1F
	XpQSUqFDlkW4Mhgr31P5FGeDt5CC1jjX3U1iV+QSs2PlMOoHfZenTP9z2GsXHSzxoNTV
	Ubj2d4RXQEvdnVsV7C3uk/HXGjx6ctYTjhw+pz4bU3KHEou46Db3VBVK9R7pami6a6l3
	gTEQ==
X-Gm-Message-State: APjAAAXNf7q3NUDGPnap3GqCOwcOvECK1QlnkGTX3k7GXC6nebxQdUmP
	EK0795TL0pR592ApYtT+ffZaPQ==
X-Google-Smtp-Source: APXvYqw96Qh8KF2KHAO5p6lF6TUwOziJx7R6yy+43cs0AvY9ij9l/UVa1BC0earIgPdjyMZR0HXOmw==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr26834570wrs.166.1554873945528; 
	Tue, 09 Apr 2019 22:25:45 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	f15sm42280055wru.21.2019.04.09.22.25.44
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 22:25:44 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	Markus Armbruster <armbru@redhat.com>
References: <20190409174018.25798-1-armbru@redhat.com>
	<CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <68a71d55-a7e1-f308-ef6c-8d8f58749bbb@redhat.com>
Date: Wed, 10 Apr 2019 07:25:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410052543.TM5l-cSdftcHZJhCUA6cPsr2e9-wQ0vsGYYQSW-8mXw@z>

On 4/9/19 10:08 PM, Peter Maydell wrote:
> On Wed, 10 Apr 2019 at 00:40, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
>> computation of @dt_size overflows to a negative number, which then
>> gets converted to a very large size_t for g_malloc0() and
>> load_image_size().  In the (fortunately improbable) case g_malloc0()
>> succeeds and load_image_size() survives, we'd assign the negative
>> number to *sizep.  What that would do to the callers I can't say, but
>> it's unlikely to be good.
>>
>> Fix by rejecting images whose size would overflow.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> I think this patch is missing some attributions for the
> security researchers who found the issue initially.
> PJP's patch for this from a couple of weeks back has a
> reported-by credit:
> https://patchew.org/QEMU/20190322073555.20889-1-ppandit@redhat.com/

Oh I missed that thread while on PTO. This answers my "how did you
figure that out?" question :)

Thanks,

Phil.

