Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847E1C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D81021670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D81021670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjRxw-0001Tf-Ll
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 13:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjRxS-0000zA-HP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjRxR-0002vg-7d
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:25:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjRxR-0002up-16
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:25:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so2056478wrm.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 10:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jGIDxmS0R90YKTSO4KB66ZvGPl0qP2zLaVqIESN1sZ8=;
 b=JdEOlt1bfNtprDtRAd8SBnGpp4mzHh5zPjdkeBPr3g0N4mDDZQ/zf1gCSEQLXtglF7
 CWfUyMJjLSobi1Xf+l6bpWXzmoLuP6DO6arhCLCwlPmcTAzFzvNYthdaKT+fRML731Yp
 ACLZjhH12CMOsNSaXnY6nsaHDv7Wx8bcOIYxsx89PLNo18shRMAsp68j/3/EWXhrhGzR
 ZTmv52NnwTnmom2+M2wHcLVxmhqtzo255ClAiHFM1nng5qNUr+hBjkpQ5MlvEMSMT3V/
 KiCaDPkKe7NpTYOfty8q/4ABStYCnjUXSqLFW4lM/MECAoEAZndYCrcmdOMrv5wmSxL2
 MBNw==
X-Gm-Message-State: APjAAAWKLh0fpNLVPEfPMdkvMvm+ojntQOgt5jxEh4apbbV5kr3/KmZv
 ZNg8q9GR8mj5PYBN9CcUjSZUXw==
X-Google-Smtp-Source: APXvYqw6R5BKd5rCuQdvjSvJhr1wXtx5N0xcyE4VGWT3s5AcoEnP5JBY3HOQxF9QJl2jcJ0HkGwygA==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr4681500wrn.316.1562347511826; 
 Fri, 05 Jul 2019 10:25:11 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id j189sm9016321wmb.48.2019.07.05.10.25.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 10:25:11 -0700 (PDT)
To: qemu-devel@nongnu.org, no-reply@patchew.org, julio.montes@intel.com
References: <156234722758.4200.12901651265660617488@c4a48874b076>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f07efb8a-0010-09f4-2d25-a803a3dc9161@redhat.com>
Date: Fri, 5 Jul 2019 19:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156234722758.4200.12901651265660617488@c4a48874b076>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix linker error when ISAPC is
 disabled
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
Cc: pbonzini@redhat.com, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 7:20 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190704180350.2086-1-julio.montes@intel.com/
> 
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> The full log is available at
> http://patchew.org/logs/20190704180350.2086-1-julio.montes@intel.com/testing.s390x/?type=message.
> ---

make[1]: *** No rule to make target 'config-devices.mak', needed by
'config-devices.h-timestamp'.  Stop.
make: *** [Makefile:472: aarch64_be-linux-user/all] Error 2
make: *** Waiting for unfinished jobs....

I guess linux-user (and bsd-user) doesn't need that header...

