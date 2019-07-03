Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532BFC06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF772189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF772189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiaXz-0003qx-FG
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46354)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hiaX0-0003NM-39
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hiaWy-0008G3-W5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:22:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hiaWy-0007yW-Pm
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:22:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id a10so585394wrp.9
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=SJ1fahOlpb+cyZMKAtgUik3nvFmhZ/LCE+gWzZuEx1c=;
 b=A5YBChTCd3HT63aoUp+n0FBOAU2A8AZLZc44VcpWEUAiNON3EXJQM/ixGiONdGsdzE
 2jtAmkDJDWFCgOCdKCdFGuQXI7/ojdN+ijq/U2Ktvcpd1m34n8NSrgio6Ip3qpw46/so
 ORLUvx2c53Fik8TyPv9cKt80mxHAHKdoNUePZoDDw2ljhTAOuofuCC1OnWxCIC1RcBQi
 fv8qCNVMARnohx8ZtLRfW1V2T6dZIKth38zaUKpZ7xzeTroqV3jmya0difu4ZRowp96X
 B7mEMlSGNfZ/sb4y2UCNw/aQ3BI77BAs/uQOTXpxQ4+4Pec1x6flhFOJqmp2vp2Xv5MZ
 50hQ==
X-Gm-Message-State: APjAAAXF2I4LaLjejqiiRhrfltlErRIVZetTDpMY9rD/gjxXg5rbgjDm
 ycrq2Fz5ifPOw5FYX+Q/5mJnQA==
X-Google-Smtp-Source: APXvYqzz+V6TkZlVpP0ef74J8JLbtDJ3O3tVoUin5Qg6+qO+00TUT8ps1Ex517vwwh+vou1zjCmskg==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr9600032wrn.285.1562142121681; 
 Wed, 03 Jul 2019 01:22:01 -0700 (PDT)
Received: from steredhat (host21-207-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.207.21])
 by smtp.gmail.com with ESMTPSA id h8sm1322922wmf.12.2019.07.03.01.22.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:22:01 -0700 (PDT)
Date: Wed, 3 Jul 2019 10:21:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Julio Montes <julio.montes@intel.com>
Message-ID: <20190703082159.ewnjivevv2wzmdxm@steredhat>
References: <20190702190131.5780-1-julio.montes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190702190131.5780-1-julio.montes@intel.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] monitor: vnc: Fix compilation error if
 CONFIG_VNC is disable
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 07:01:31PM +0000, Julio Montes wrote:
> How to reproduce it?
> ===
> 
> ```
> $ ./configure --disable-spice --disable-vte --disable-vnc \
>     --disable-vnc-jpeg --disable-vnc-png --disable-vnc-sasl
> $ make
> ...
> monitor/hmp-cmds.c: In function ‘hmp_change’:
> monitor/hmp-cmds.c:1985:17: error: unused variable ‘hmp_mon’
>      [-Werror=unused-variable]
>      MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> ```
> 
> Fix
> ===
> 
> Move `hmp_mon` variable within the `CONFIG_VNC` block
> 

Hi Julio,
thanks for the patch, but Christophe sent a very similar patch last
week: https://patchew.org/QEMU/20190625123905.25434-1-dinechin@redhat.com/

Cheers,
Stefano

