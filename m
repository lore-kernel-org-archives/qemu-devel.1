Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3840C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68422086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68422086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw2JX-00036g-3e
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60598)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw2J9-0002YZ-Pm
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw2J8-0000zO-VM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:39:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw2J8-0000z7-Pl
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:39:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so5195849wmf.5
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 03:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/y2HB6NbOqaIJ6ZMf+HAGclDWqsxl4p9yHPdxJiii20=;
 b=HTlZi92RwzvTVEbK7bfL0OMFL5IWBNPNLXDo/WWPfkT5OoMxlqf+LOlFt6C3zpJGq/
 Jw9Wqy/iK6B2s/TT+5SoAbd6lfD0GUK8GdRHeFW6RgSUYFoTucW7SmwjYCpuxrEnpvHy
 PLZonpH1Nmmm7PYhnFs6R5abtc1xHaZVKBDo706+XUV11/2gNVHRMpNuvjTGGWHFRSes
 xpss59r1ikPeiZ59+fCbfH40kb8guGt9IxaKQaCtYWUK02/Fb0LbXi0rUQ2ctvjo9SBc
 hwxa/Qs3KsAzd5svtta3SxrX9A4U0t5UDTWYYRT2UCI8YDbFdhpHfx6tlvNHebpOtfHD
 LDEA==
X-Gm-Message-State: APjAAAV02Hz5on2txREu431FTdQ01Pb/0MptbOZzgNMx84m3BRPLH2Wy
 uK5yI5z14ephva9kUv7iu36XKEqGK2k=
X-Google-Smtp-Source: APXvYqwkZAyywAK1IBVnxPZN+UvgAz5pGIXxWu+BYYEYYMsr2lbfn3BUjqgzLJq/QwTh9oI2Pmv80g==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr2484597wmk.52.1565347177723;
 Fri, 09 Aug 2019 03:39:37 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id a26sm8889790wmg.45.2019.08.09.03.39.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 03:39:37 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-25-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6c3bf43b-571e-c137-f657-0efcd335a0bd@redhat.com>
Date: Fri, 9 Aug 2019 12:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809064645.22656-25-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 24/29] Include sysemu/hostmem.h less
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
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 8:46 AM, Markus Armbruster wrote:
> Move the HostMemoryBackend typedef from sysemu/hostmem.h to
> qemu/typedefs.h.  This renders a few inclusions of sysemu/hostmem.h
> superfluous; drop them.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

