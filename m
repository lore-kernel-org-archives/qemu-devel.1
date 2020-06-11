Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E45C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0B5206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckR+lexM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0B5206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjSSx-000114-UK
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjSRo-0000ZJ-Q8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:01:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjSRn-0007fT-6N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591902065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5x8lb6RJui9IPuX8C5HM1hrWaW7CCbo+ZUaJqyNR4Tw=;
 b=ckR+lexMjKdhOIp2V6Jn60TFKB58OitNgYbCMWkdTZeXwyS2+3bZX3t3FeXi4odhjSTAMP
 qYj2ifOqOuMS+ZKfUWkkr87GALrmgRz/SCvMZ+EnYRBJxKwXFlqgGKn0+WsWev0cMM5Gb+
 ZP7QvzNvC5NdeYNpoyvK9Mr6+1uaRNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-MIHEKp-wM5yTukxpSV5a0A-1; Thu, 11 Jun 2020 15:01:04 -0400
X-MC-Unique: MIHEKp-wM5yTukxpSV5a0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C8A58064DD;
 Thu, 11 Jun 2020 19:01:03 +0000 (UTC)
Received: from work-vm (ovpn-114-116.ams2.redhat.com [10.36.114.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7776B78931;
 Thu, 11 Jun 2020 19:01:02 +0000 (UTC)
Date: Thu, 11 Jun 2020 20:00:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH 8/9] docs/xbzrle: update 'cache miss rate' and 'encoding
 rate' to docs
Message-ID: <20200611190059.GD2969@work-vm>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
 <20200603080904.997083-9-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <20200603080904.997083-9-maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  docs/xbzrle.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/xbzrle.txt b/docs/xbzrle.txt
> index 385b4993f8..6bd1828f34 100644
> --- a/docs/xbzrle.txt
> +++ b/docs/xbzrle.txt
> @@ -113,9 +113,11 @@ is recommended.
>      xbzrle transferred: I kbytes
>      xbzrle pages: J pages
>      xbzrle cache miss: K pages
> -    xbzrle overflow: L
> +    xbzrle cache miss rate: L
> +    xbzrle encoding rate: M
> +    xbzrle overflow: N
>  
> -xbzrle cache-miss: the number of cache misses to date - high cache-miss rate
> +xbzrle cache miss: the number of cache misses to date - high cache-miss rate
>  indicates that the cache size is set too low.
>  xbzrle overflow: the number of overflows in the decoding which where the delta
>  could not be compressed. This can happen if the changes in the pages are too
> -- 
> 2.17.1
> 
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


