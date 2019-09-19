Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E84C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0B321907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0B321907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzE3-0005kb-Mf
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAz9m-00023C-E9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAz9k-0003jG-PE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:19:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAz9k-0003iX-Hi
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:19:44 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75D7DC04BD33
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 16:19:43 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id c1so1260609wrb.12
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qkXAkFUJb4I5HOf7gs6usTH4iUfcPF2Y0LAfRm/Tdr4=;
 b=SoOMwYKE8de2AMtrkQENVt/cgo3wWWyAtVvmzu2uPZIhgI9J/yqVeW51o5fqQSvUZj
 AiaoWS1c+PdANApoMxt+hs2T6rcKRcQe6td7sO4e3O5r+CeLcD3bP7inJj51c1Y4hNkw
 tL5bqxHPNZpjnTcgEjARt39/tCgIrl5PU9kjEaaEuzxuB9tVuaOsDvDQgPLP3Wm3/kro
 TZLcq+/tt/8rgztIbS2LGZPuJIgVv983DsANomxPTOZU1Sdq1abrL2jmOe5vuLoq5L2e
 MAS4p7sc9scIReQsCkuJm3vHPa4ILQr1l/KTOFmKeQJKqMuPriy4+Qd0wgiyyk68k6Nn
 aOsg==
X-Gm-Message-State: APjAAAUr+3IXafvN7KJihgCaD2P7vG0TlZIe7iohTRq48I43F8dnOq5J
 5MzeZf1hjYaf4sZydLz88CM3o8Y9Qzm/xXdCS5qNTbn7wed+Xv7ZwVkokp4fao97tLCZxY8Rq60
 lS+d3Zd+BDKbqINE=
X-Received: by 2002:adf:dbce:: with SMTP id e14mr8384919wrj.56.1568909982280; 
 Thu, 19 Sep 2019 09:19:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZ28nY8kyQqx/SmMUXaI84HAQWy0gc85nWYV/eU3v7qu+qsjAnLlNR8dvhCjlV/+MsRuhz6Q==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr8384906wrj.56.1568909982103; 
 Thu, 19 Sep 2019 09:19:42 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v11sm15194337wrv.54.2019.09.19.09.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 09:19:41 -0700 (PDT)
Subject: Re: [PATCH] Acceptance test machine_m68k_nextcube.py: relax the error
 code pattern
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190919161400.26399-1-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8a087ca1-cdae-20ee-d939-a47be4f25235@redhat.com>
Date: Thu, 19 Sep 2019 18:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919161400.26399-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Thomas Huth <huth@tuxfamily.org>, Willian Rampazzo <wrampazz@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Thomas

On 9/19/19 6:14 PM, Cleber Rosa wrote:
> Instead of looking for a specific error, let's relax the pattern
> because different errors have been seen (I'm consistenly getting 52)
> and the real goal of this test is to validate the framebuffer
> operation, and not to reproduce one specific error.

This might be because I wrote this test before Thomas added the serial
controller (commit b17bed5b1727e3aa9e37fc8e8c3222130ceab22f).

> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/machine_m68k_nextcube.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptan=
ce/machine_m68k_nextcube.py
> index e09cab9f20..fcd2c58ee7 100644
> --- a/tests/acceptance/machine_m68k_nextcube.py
> +++ b/tests/acceptance/machine_m68k_nextcube.py
> @@ -116,6 +116,6 @@ class NextCubeMachine(Test):
>              if len(line):
>                  console_logger.debug(line)
>          self.assertIn('Testing the FPU, SCC', text)
> -        self.assertIn('System test failed. Error code 51', text)
> +        self.assertIn('System test failed. Error code', text)
>          self.assertIn('Boot command', text)
>          self.assertIn('Next>', text)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

