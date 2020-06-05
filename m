Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E828C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB2320772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fe8z9fgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB2320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8dh-0004Ro-RH
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jh8ce-00035F-FT
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:26:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jh8cd-00038P-Tw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZUS9RvvpzoNI2fiSrLpLWkF3txHkRAfk29CnEFunpI=;
 b=Fe8z9fgk/PaJ52jpLwYdyPqDHdTMVDUSrLmnMy0EZTci1HMtQD8QNP3CNvbB+5wrueAdJM
 jHNo+hhWFfDX7afyg/a2/r0kmX30ZuB1lrUTWYWObiBe2+IO5mxDXvK5DeX0i4U8/dnnCX
 SVD3FVi483L39q63U0vEouT8t0gcR9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-hl4BffPBM1eF1Mm64lJGmw-1; Fri, 05 Jun 2020 05:26:36 -0400
X-MC-Unique: hl4BffPBM1eF1Mm64lJGmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8BE4800685;
 Fri,  5 Jun 2020 09:26:35 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-112.ams2.redhat.com [10.36.113.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C3835D9D7;
 Fri,  5 Jun 2020 09:26:31 +0000 (UTC)
Date: Fri, 5 Jun 2020 11:26:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 00/16] python: add mypy support to python/qemu
Message-ID: <20200605092630.GE5869@linux.fritz.box>
References: <20200604202236.25039-1-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200604202236.25039-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.06.2020 um 22:22 hat John Snow geschrieben:
> Based-on: 20200604195252.20739-1-jsnow@redhat.com
> 
> This series is extracted from my larger series that attempted to bundle
> our python module as an installable module. These fixes don't require that,
> so they are being sent first as I think there's less up for debate in here.
> 
> This requires my "refactor shutdown" patch as a pre-requisite.

You didn't like my previous R-b? Here's a new one. :-)

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


