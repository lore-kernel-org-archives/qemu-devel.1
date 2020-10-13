Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DE0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C34F20870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYgWl4C8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C34F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHgM-0003v3-62
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSHdt-0001hW-Nj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSHds-0003lg-7d
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602585291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGAeBAPtEDE8vVrqFP+uOOocT2TK4MHvUaLd/Bfy5II=;
 b=LYgWl4C8iBsOsfnnRslCkU4W1+OJEyJRSynBRFVPmcDpXerJV5nMrgP0WcNTpTc6V1dQJn
 5AUoyDvrLi3YljYQ57fFijP+k6d+msRfj7YCruNB/MPUAdswgdkYaZLlPH2IL4ssIvMThj
 DbsZazZa+LxALQYhIu+8f4JKPc4yH2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-uNbBizOtMlCW0PZpJwx9TQ-1; Tue, 13 Oct 2020 06:34:49 -0400
X-MC-Unique: uNbBizOtMlCW0PZpJwx9TQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBDF21868405
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 10:34:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE51960BF3;
 Tue, 13 Oct 2020 10:34:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 664141750A; Tue, 13 Oct 2020 12:34:46 +0200 (CEST)
Date: Tue, 13 Oct 2020 12:34:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] qemu-edid: drop cast
Message-ID: <20201013103446.ahhhplg5mwpppk7o@sirius.home.kraxel.org>
References: <20201013091615.14166-1-kraxel@redhat.com>
 <20201013092322.GE70612@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201013092322.GE70612@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 13, 2020 at 10:23:22AM +0100, Daniel P. Berrangé wrote:
> On Tue, Oct 13, 2020 at 11:16:15AM +0200, Gerd Hoffmann wrote:
> > Not needed and makes some compilers error out with:
> > 
> > qemu-edid.c:15:1: error: initializer element is not constant
> 
> Which compilers do this. If we're not seeing this failure in our
> CI, then we have a CI gap that likely needs filling.

x86_64-w64-mingw32-gcc (GCC) 4.9.3 20150626 (Fedora MinGW 4.9.3-1.el7)

take care,
  Gerd


