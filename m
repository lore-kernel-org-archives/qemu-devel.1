Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE53C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A3F208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A3F208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58844 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfjLV-0008P7-7C
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 07:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfjJD-0006pa-Mj
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfjJC-0002hu-Mt
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:08:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfjJC-0002gy-Gn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:08:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so2538495wme.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 04:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9XSVVmWixQjmBWf3lTouWBIggVXGo0LLCON+rT2xFAM=;
 b=fV+I2xcm9gJAEZiQxG/qye1lu2n0PjKDhpftMS16ZmaJ7x/wT2de1eVlB20OEQAgai
 Rid9Ia40kqrRKzb3vXxVtMXaoWCymnCNIF/VaBEvcB6PZMx14zLZHiTwYXNxRqsOtw5J
 wq0nw64Q/hutvei+jVq6MqefyET8ka9ftd1QQP2YJaCCWj4Pt/oRfFofVeKwXrD/DG84
 WDkO/LlWDRqiAmZzG1ggXQdEDOLZXK+MXCqeDjoJ5razDUYD8ICzZTNcGZ92dMRJVKDp
 x8dMCuTl2lCBx5h2FlwSj7qgIiK182PnrOWsowfZozzadSOjGN8zGY9dntmHkgjP0u+6
 9g8w==
X-Gm-Message-State: APjAAAWwwkC8Cul3m6VAxeyEJ8rvxYyelMbBFlWBMzNhSIFRX+O05Twc
 A1mmbwavOsHi11pxUjWdLlczDg==
X-Google-Smtp-Source: APXvYqyvhcIo8EilwZyCE2N5PEyrFrrOvyMFApeu14Pt2/sDtgc1XFaafKMtoUEpcuD0/13Zxth7Hw==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr19609147wmf.138.1561460897488; 
 Tue, 25 Jun 2019 04:08:17 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id f12sm30042866wrg.5.2019.06.25.04.08.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 04:08:17 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190625081339.9176-1-pbonzini@redhat.com>
 <4bc3239b-f3cf-3374-5d50-8980b413dfaa@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <50e4fc4f-412e-167e-eb0f-0b7abff48753@redhat.com>
Date: Tue, 25 Jun 2019 13:08:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4bc3239b-f3cf-3374-5d50-8980b413dfaa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] minikconf: do not include variables from
 MINIKCONF_ARGS in config-all-devices.mak
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
Cc: Christophe de Dinechin <cdupontd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/19 12:52 PM, Philippe Mathieu-Daudé wrote:
> On 6/25/19 10:13 AM, Paolo Bonzini wrote:
>> When minikconf writes config-devices.mak, it includes all variables including
>> those from MINIKCONF_ARGS.  This causes values from config-host.mak to "stick" to
>> the ones used in generating config-devices.mak, because config-devices.mak is
>> included after config-host.mak.  Avoid this by omitting assignments coming
>> from the command line in the output of minikconf.
>>
>> Reported-by: Christophe de Dinechin <cdupontd@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

