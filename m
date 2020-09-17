Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A926CC2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6592072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEWdqPO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6592072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIrMx-0005x2-4M
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIrM0-0005LT-J0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIrLy-0007Gr-Nc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600339285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XDNNO0yJAzVj83lBqj23KrEVZiEAYppjOyTp4S/ABc8=;
 b=YEWdqPO8neKq1uMUYiCn6pvNzmkFe958OJmxX/H9aKJyi9ltpFmaYxLgxUc3taAmJOSRhw
 7NR5ssSBTrH1Vp5jJU/xMmJ8N+WV9Bo0rn+nEg54MQrTWBjEEqmqYDss6NlooIdnOTVFYF
 3rj1os27Gkr1ZGeNuDNXeZ8gB5Iscvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-tW2JtIzjMXC_fYJzsnU6pw-1; Thu, 17 Sep 2020 06:41:21 -0400
X-MC-Unique: tW2JtIzjMXC_fYJzsnU6pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A0D980B702
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 10:41:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D39855DEB8;
 Thu, 17 Sep 2020 10:41:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DCEAD9D5A; Thu, 17 Sep 2020 12:41:15 +0200 (CEST)
Date: Thu, 17 Sep 2020 12:41:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: Use patchew to push successfully applied series to GitLab
Message-ID: <20200917104115.yvlt5tmuq6jem7xy@sirius.home.kraxel.org>
References: <22951108-74c2-a98b-9316-b17c4d8188e0@redhat.com>
 <f90ee77c-11f8-e025-8f4f-38e78e0fe618@redhat.com>
 <20200917093442.GB1568038@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200917093442.GB1568038@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: patchew-devel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> What if we used git-publish to always push to gitlab when submitting
> patches, and have it include the gitlab ref in the cover letter.

Well, when pushing to gitlab anyway for CI runs this should be done
*before* publishing the patch series on the list ...

> That would trigger CI jobs in the user's fork, and patchew would not
> have to run anything itself. It would merely monitor the user's fork
> and report back to the list if the job failed.

That part would still work (when posting patches after CI run finished).

Right now running CI in my user account fails though, with this:

95608:45:05 INFO | Fetching https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb -> /builds/kraxel/qemu/avocado-cache/by_location/9b421efcfd044bf444a901be12757a1d9484ccbd/linux-image-dev-sunxi_5.75_armhf.deb.x38o9x5f
95708:45:05 INFO | Temporary asset file unavailable due to failed download attempt.
95808:45:05 ERROR| URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: certificate has expired (_ssl.c:1056)>

Probably happens to work with the qemu project account due to the file being
in the avocado cache already.  Shouldn't avocado be able to handle this better
btw, now that it supports a separate "download assets" step?

take care,
  Gerd


