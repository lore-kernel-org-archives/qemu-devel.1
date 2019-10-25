Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B40CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9D820867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9D820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNu8r-0005WX-IT
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iNtzB-0005G8-Bz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iNtzA-0003q3-2V
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iNtz9-0003ow-RL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:26:11 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B262B8553A
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:26:10 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id v26so526866wmh.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iOImrrVZ6kl+IW5m/QQYvroBH2CHjohxjcvj5nvJfPk=;
 b=etG+l5ev1uVsLhXjhykH7GzkhyzVLrnhs2hNxdBua7qKW/M8TJ9eRroKnM9kNSJRRc
 NdTHxFFfflAmxDXBDtT7VkkMlarQ24DVEhu4fv4gpOSpm8DzU6bU1OdWD7TzqCyELwYE
 JUYvp5PbKYFYG2ZqeFJ5/5UwbBH4XjAcna61crAtyRCigLfXrOBiFjKDC5L6gVB9YFUD
 lhl5xGbYGng7HvuBYCj/wLHw1CuwKqHul4Hl9O+t27Puzx4H0mrarr2SRJDK6Hdngoyd
 gdgWYiXMwtx7pnQn4Goaz8qmpVer5ThxOD5EG/+esu8nYE/v6jd939etDILCw0j3GXwA
 MtPw==
X-Gm-Message-State: APjAAAXpLGcN+EN7W+51yivOn1PPo+vtWc209iYNSHK6864TatDAkxCq
 npXNFcmlUI8yfuGDNChVpGyXRgJZ8afobMxNwi7VF8Ct2XSbDBCRtHnK5tJtr05cQ4rs3zmt0lr
 UKbg1adKQFVRXhk4=
X-Received: by 2002:adf:e886:: with SMTP id d6mr1519525wrm.188.1571988369475; 
 Fri, 25 Oct 2019 00:26:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNaTMqkXvQqfm62xB64lSNVEEgiTCybr2MqS75vxkUJrT1B0ptklhAola/itFZ/8PeWw9oeA==
X-Received: by 2002:adf:e886:: with SMTP id d6mr1519502wrm.188.1571988369151; 
 Fri, 25 Oct 2019 00:26:09 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id t13sm1368558wra.70.2019.10.25.00.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:26:08 -0700 (PDT)
Date: Fri, 25 Oct 2019 09:26:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] i386: Use g_autofree in a few places
Message-ID: <20191025072606.l4gcj5lidpm33xfb@steredhat>
References: <20191025025632.5928-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025025632.5928-1-ehabkost@redhat.com>
User-Agent: NeoMutt/20180716
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 11:56:32PM -0300, Eduardo Habkost wrote:
> Get rid of 12 explicit g_free() calls.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 41 +++++++++++++----------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
> 

The changes LGTM:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

