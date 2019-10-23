Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F301CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D297A2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D297A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNEoe-0004ky-Gu
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEOO-0002EY-A9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEOJ-0002XI-Rw
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEOJ-0002WD-7y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:01:23 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30F055AFE9
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:01:21 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id i23so2144543wmb.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C2Z/rTiEMaiDytYVEo6f72hYjHtOqpzp1cbeYjpz/Xw=;
 b=a3HYsyguMQP9UdoLYZObivgbnq5Y0pkWDE6P2GhFqK939odv9ZDuy8uhl5Y6UH81vA
 NBzFAxdv9ei5pCcZKqryucdRG2ly0lMRfx+thdNXg2aIMhC3PZgenbYHEQyNPMMXY6Pb
 2Ky0kUPr6Aac/gGTFwe7ObGEnohrlV4UbqUe9praOdX0wqHWQo8ahYA0WHIPInXejcIE
 97bcnXCdUcIL+Jgi0mVdZKEB9yHcZEMs5WRVnfIkxi69TW/ydj0fCaEjoiAY70CiKxmt
 juII14siCFqi7gn6acpxN2ar/iznfrHJf+2LOITSoa6EJumZEYV0rMlnFzq3k6Xmx0Fk
 tf5w==
X-Gm-Message-State: APjAAAX4AvmaNAHnTO0k5G/URNvVsNrcC2PkFa/wgg08H3+FvnTb9tbn
 1JTawRu+d03UqkjaI0BWHK7c2xxvNsAWS7uTKrAkEzwVBRUXI2WFqfhpgrXP9vg845JNlzXMllC
 iodh5k+CqnjVzvAk=
X-Received: by 2002:a5d:5392:: with SMTP id d18mr8464465wrv.382.1571828479785; 
 Wed, 23 Oct 2019 04:01:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwebaogxXHrqdg5Ip6m9LEvtHQyVHO3gUa2HwuXpFaSPlX+NkV08ZfV3zz3RHKEH/F8yea9AA==
X-Received: by 2002:a5d:5392:: with SMTP id d18mr8464449wrv.382.1571828479562; 
 Wed, 23 Oct 2019 04:01:19 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id u1sm21455278wrp.56.2019.10.23.04.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 04:01:18 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
To: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20191016112209.9024-1-chen.zhang@intel.com>
 <20191016112209.9024-2-chen.zhang@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e294876e-d26b-b401-78ab-487e1b44685f@redhat.com>
Date: Wed, 23 Oct 2019 13:01:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016112209.9024-2-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Chen,

On 10/16/19 1:22 PM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> This patch introduce a new module named Advanced Watch Dog,
> and defined the input and output parameter. AWD use standard chardev
> as the way of communicationg with the outside world.
> Demo command:
> -object advanced-watchdog,id=heart1,server=on,awd_node=h1,notification_node=heartbeat0,opt_script=opt_script_path,iothread=iothread1,pulse_interval=1000,timeout=5000
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   net/Makefile.objs |   1 +
>   net/awd.c         | 261 ++++++++++++++++++++++++++++++++++++++++++++++
>   qemu-options.hx   |   6 ++
>   3 files changed, 268 insertions(+)
>   create mode 100644 net/awd.c
> 
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> index c5d076d19c..139b1394e9 100644
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -19,6 +19,7 @@ common-obj-y += colo-compare.o
>   common-obj-y += colo.o
>   common-obj-y += filter-rewriter.o
>   common-obj-y += filter-replay.o
> +common-obj-y += awd.o
Can you add a net/Kconfig file introducing the ADVANCED_WATCHDOG selector?

config COLO_ADVANCED_WATCHDOG
     bool
     default n

Then use here:

     common-obj-$(COLO_ADVANCED_WATCHDOG) += awd.o

Thanks,

Phil.

>   
>   tap-obj-$(CONFIG_LINUX) = tap-linux.o
>   tap-obj-$(CONFIG_BSD) = tap-bsd.o
[...]

