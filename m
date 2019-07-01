Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16004C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE79F2064B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE79F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxYf-000771-5h
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58495)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhxWs-0005Sj-7f
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhxWq-0000yb-9T
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:43:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhxWo-0000w4-EA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:43:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so16137786wma.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Twwz+ZF2ZEc5wIb7DKQ0L5qv4JeSvRkBNmtz4dVJrA=;
 b=ALD4N7ImiwPfZDe/k2/GzXibYFw6PgUZqnEiKx1qAxxZ1DNZwDssQ9nwxXXUNMGa6j
 zJNJMLprSCwij2xlVfJWReVJdAS0Irb1pYMBXUFPkul09NxMIvwfxr8lW76bbCx5rKkg
 39yyW8ZNoGAA4XQbBwSmsJoT2DBy7JibECs5Hh/+1j5eZCO90tiYMdDlfJI/l5p7UHGx
 dhTIvUQs3KdLNLSycdkNbuf314J95tsMzg5FIcUAIBCDZHmnRJ/9yt2NNWmYWqIpul/H
 TDp6F7zpLMvzFg0vY2IIaGUc2++6fY7gO5IHqTA8ZThsrQYWifLWHvXOJs22X1WDtWDD
 2OKQ==
X-Gm-Message-State: APjAAAUTEu7X0VBWw0kmuJm7CkMBaCGcSLqQ4HPw5PUpbGdNqDr2urwa
 vAW7yQ950YkyK7BiZhKkNPRZrg==
X-Google-Smtp-Source: APXvYqzsl8aa3klMFQoG0qlzgH4O7b7iSrSorveveVblkiXqVA+JeSX9NGfSfAaCkREJnnlKAevoAg==
X-Received: by 2002:a05:600c:303:: with SMTP id
 q3mr17850692wmd.130.1561992213185; 
 Mon, 01 Jul 2019 07:43:33 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id n10sm10422392wrw.83.2019.07.01.07.43.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 07:43:32 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190614100718.14019-1-philmd@redhat.com>
 <20190701143657.GM3573@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8f9ef359-fbf3-d508-315e-350227294173@redhat.com>
Date: Mon, 1 Jul 2019 16:43:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701143657.GM3573@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 0/9] configure: Fix softmmu --static
 linking
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Bharata B Rao <bharata@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 4:36 PM, Daniel P. Berrangé wrote:
> On Fri, Jun 14, 2019 at 12:07:09PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> Apparently QEMU static linking is slowly bitroting. Obviously it
>> depends the libraries an user has installed, anyway it seems there
>> are not much testing done.
> 
> Bitrotting implies that it actually worked in the first place.
> 
> AFAIK, configure has never been capable of auto-enabling the
> correct set of libraries for static linking, if you have the
> equiv dyn libraries present.
> 
> I always assumed that anyone who is static loinking QEMU is
> passing a big long list of --disable-XXXX args to turn off
> all the 3rd party libs for which they don't have a static
> build present.
> 
>> This series fixes few issues, enough to build QEMU on a Ubuntu
>> 18.04 host.
>>
>> Peter commented on v1:
>>
>>   The main reason for supporting static linking is so we can build
>>   the user-mode emulators. Almost always the problems with
>>   static linking the softmmu binaries and the tools are
>>   issues with the distro's packaging of the static libraries
>>   (pkg-config files which specify things that don't work for
>>   static is a common one).
>>
>>   So we could put in a lot of checking of "is what pkg-config
>>   tells us broken". Or we could just say "we don't support static
>>   linking for anything except the usermode binaries". We
>>   should probably phase in deprecation of that because it's
>>   possible somebody's using it seriously, but it seems like
>>   a fairly weird thing to do to me.
>>
>> I share his view on this (restricting static linking to qemu-user)
>> but since the work was already done when I read his comment, I still
>> send the v2.
> 
> I share Peter's view that we ought to restrict static linking to be
> allowed exclusively for user-mode-only builds of QEMU. This is a use
> case with a compelling reason to need static builds. It is not bitrotting
> as the main distros all do a static user-mode only QEMU build, alongside
> the main everything, fully dynamic build.
> 
> Static builds of system emulators & other tools get essentially no
> testing by developers, distros, or our CI systems. If they do work
> it is largely by luck, and likely requires the user to pass many
> --disable-XXX flags. While your patches do make configure a bit
> nicer in this respect, if we're going to deprecate static builds
> of non-user-mode parts, then making static builds easier feels
> undesirable.

OK, I agree then.

> 
> Lets just get a deprecation warning in right now for this imminent
> release.
> 
> Regards,
> Daniel
> 

