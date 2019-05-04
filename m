Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC82C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 11:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7850D206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 11:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7850D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtEn-0003fL-9s
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 07:53:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMtDs-0003Gt-NA
	for qemu-devel@nongnu.org; Sat, 04 May 2019 07:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMtDr-0003zD-LL
	for qemu-devel@nongnu.org; Sat, 04 May 2019 07:52:56 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMtDr-0003ym-FW
	for qemu-devel@nongnu.org; Sat, 04 May 2019 07:52:55 -0400
Received: by mail-wr1-f49.google.com with SMTP id l2so11083215wrb.9
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 04:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yWuzI25mfazZ9/4FDgDKKezBoaaReNKxvhm7fIUTb0M=;
	b=ijFoIDIcXAMu7WXOyi5S3P53HzbZMQ4FVA+wwrEW0/Ktz8ir0DH+2+z8VAWQ0qcKFA
	8z+WHajghym/uWkyAyklNwUoDy1h7CG7I3yTidTbDMbbga+7LnTIa07ZQNO7+r4fvO7G
	cO+GxSqKzrPJeIYWzj45AO3GDUbZQ8ZUHMsVDZmgcAzt4Kar5GctF3c+rjHD2R05VW+Y
	Y/oc+qeeWtcI3qJCLlZhodzZh+VDMx39g8fCwOHf2ziA5Q90q5tda6RS1yhfdv3uYZpu
	AOC597wQCyVR+lAMuHSQ+loUwnlmcBffn5lcM6X2ZZMxlRtksa8iJfb8ZR7ZieLjZBW5
	XErA==
X-Gm-Message-State: APjAAAVHyyKTrsgIM6/MAMO0vu7LDoqhqFA6jSXvzNH7WXcA7SJotGEW
	BeR09zeEqAKUguc2ljcXc+ffWg==
X-Google-Smtp-Source: APXvYqx2NRBsiP8wWguOo8cPRyPQ4RDoca5M0IWtiMAZW3YGKXDGKSmXQMhkY7V2t1MUyYXwB4yFKQ==
X-Received: by 2002:adf:e88b:: with SMTP id d11mr11025771wrm.327.1556970774134;
	Sat, 04 May 2019 04:52:54 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id f2sm13151053wmh.3.2019.05.04.04.52.51
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 May 2019 04:52:52 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20190312234541.2887-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d5d84efd-ef8c-4e0d-d48a-6996d91832e7@redhat.com>
Date: Sat, 4 May 2019 13:52:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190312234541.2887-1-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.49
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Acceptance Tests: Test the
 Raspberry Pi 2 board
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504115251.eezgET06Xz3swV5oLd_kqOvsp3yzT7kU1chRUS0_vPQ@z>

On 3/13/19 12:45 AM, Philippe Mathieu-Daudé wrote:
> Add the raspi2 to the list of boards tested by the
> boot_linux_console Avocado test.
> 
> Based on "Acceptance Tests: target architecture support" v5:
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04111.html
> Based-on: <20190312171824.5134-1-crosa@redhat.com>
> 
> Philippe Mathieu-Daudé (2):
>   BootLinuxConsoleTest: Let extract_from_deb handle various compressions
>   Boot Linux Console Test: add a test for the Raspberry Pi 2
> 
>  tests/acceptance/boot_linux_console.py | 34 ++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)

I was hoping this series would be included in "Acceptance Tests: target
architecture support" by Eduardo (removing the 'print' debug line) but I
just realized I forgot to Cc him :S

