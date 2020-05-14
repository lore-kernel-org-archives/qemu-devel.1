Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97711C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570B520575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzY3nMfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570B520575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ79W-0004q3-HG
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZ77z-0002sv-AN
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:13:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZ77y-000631-K0
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589436833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4ntRBi5i8SxkNT1YXbO7caDrpoJq6HYyzyxLp8tEZg=;
 b=gzY3nMfdwziYgylspFIOBO/8VPB20RQPY7mXZLt+ofotVUrx3zyOTgZB413hEG24nLiDpz
 04sPq6s+ZBgS3/IFhp5+f147ZlMRe5UGG5pjEREjdebjFjFXh4OnwnIp/7nhhuuMX56npa
 ePutbm1yLI+62uswxY+0hoVYLWHO8/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-WOM-JQAsMgmluxxQ2EpKdQ-1; Thu, 14 May 2020 02:13:48 -0400
X-MC-Unique: WOM-JQAsMgmluxxQ2EpKdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D07AE461;
 Thu, 14 May 2020 06:13:47 +0000 (UTC)
Received: from gondolin (unknown [10.40.192.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C7D3783B3;
 Thu, 14 May 2020 06:13:46 +0000 (UTC)
Date: Thu, 14 May 2020 08:13:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-s390x@nongnu.org
Subject: Re: [PATCH 0/3] s390x: improve documentation
Message-ID: <20200514081344.419a904c.cohuck@redhat.com>
In-Reply-To: <20200505135025.14614-1-cohuck@redhat.com>
References: <20200505135025.14614-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Tue,  5 May 2020 15:50:22 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The documentation for the s390x system emulation target still has quite
> a bit of room for improvement, so I started adding some device documentation.
> 
> I'm not quite happy with the long command/output lines in the 3270 and
> vfio-ccw sections, but don't know how to make that more readable. Suggestions
> welcome.
> 
> Cornelia Huck (3):
>   docs/s390x: document the virtual css
>   docs/s390x: document 3270
>   docs/s390x: document vfio-ccw
> 
>  docs/system/s390x/3270.rst     | 32 +++++++++++++++++
>  docs/system/s390x/css.rst      | 64 ++++++++++++++++++++++++++++++++++
>  docs/system/s390x/vfio-ccw.rst | 58 ++++++++++++++++++++++++++++++
>  docs/system/target-s390x.rst   |  3 ++
>  4 files changed, 157 insertions(+)
>  create mode 100644 docs/system/s390x/3270.rst
>  create mode 100644 docs/system/s390x/css.rst
>  create mode 100644 docs/system/s390x/vfio-ccw.rst
> 

Anybody feel like taking a look?


