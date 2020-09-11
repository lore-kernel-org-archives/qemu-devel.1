Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD9DC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438C921D79
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObPxuYOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438C921D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGhIJ-0000tK-4i
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGhHl-0000SW-GM
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGhHj-00013d-CU
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599823926;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fo/F4m2Px7ZyYtJwFgLh+xzYr0yheUCQPNc2bEMfXB8=;
 b=ObPxuYOBZfCyLG0zIU4ZhHm7KygfvJBFiRNYQQ8Zz/uJVox7fO/kISmgH8bXNZQMK7aC5v
 NsbFvM/5EzlpLHOASe+3Bw0RsBn3wnfLddQa4ruTaoH1BWpX/Q2X7Lrz1r1+nmHpgVrU5l
 1L6ODSHHLyeBX4TtNuInET5Py7ZdSmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-j4RvrpyMN0yr-W6N-R7OdA-1; Fri, 11 Sep 2020 07:31:57 -0400
X-MC-Unique: j4RvrpyMN0yr-W6N-R7OdA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B385E8015A4;
 Fri, 11 Sep 2020 11:31:56 +0000 (UTC)
Received: from redhat.com (ovpn-113-229.ams2.redhat.com [10.36.113.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60ABF5C221;
 Fri, 11 Sep 2020 11:31:48 +0000 (UTC)
Date: Fri, 11 Sep 2020 12:31:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
Message-ID: <20200911113145.GF1203593@redhat.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <20200911104642.GE1203593@redhat.com>
 <6599e4a5-cccb-d0f5-9408-25d59359d76f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6599e4a5-cccb-d0f5-9408-25d59359d76f@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: slp@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, marcandre.lureau@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 01:28:13PM +0200, Paolo Bonzini wrote:
> On 11/09/20 12:46, Daniel P. Berrangé wrote:
> > Do we actually need/want it to be in the same monolithic repo
> > as qemu, as opposed to a qemu-qapi-rust repo ?
> 
> I think QAPI and qemu-ga should be separate repos altogether.  QAPI
> should be included as a submodule in both qemu and qemu-ga.  qemu-ga
> instead has absolutely no dependency on QEMU and viceversa, and is a
> prime candidate for removing all traces of the configure script and
> being a pure meson project.

Yeah, qemu-ga has always been an odd fit, since it is a guest OS
component rather than host OS.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


