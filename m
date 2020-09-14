Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7BEC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C3B21741
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLNpAvOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C3B21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmrz-0003G1-Uj
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kHmqC-0001nS-HL
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kHmqA-0001ls-Vv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600083610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5PwiPbalmUdzIZCxX1vTBRsxrxt/zFN7ZOEVClmulM=;
 b=XLNpAvOOVTO8idz2R9v00Z9X2aC6F2HCPA+x+7M3B3JopUCmRUn17WBTguQFxrJ4BSoTlt
 FzL9OuQIQ3GuMqN+vMuLiNiOQpzB0rctdXRYGmdyhntkQM6u5jkf/8qv98ajqgJU9QAcUE
 G6+AxaBiym/9L64RiYABw/q3uUMS6jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-lVG1cl8aOqq886atPSBE8w-1; Mon, 14 Sep 2020 07:40:08 -0400
X-MC-Unique: lVG1cl8aOqq886atPSBE8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00FFA6408C;
 Mon, 14 Sep 2020 11:40:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6FF5DA7E;
 Mon, 14 Sep 2020 11:40:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 19EE71FCEE; Mon, 14 Sep 2020 13:40:05 +0200 (CEST)
Date: Mon, 14 Sep 2020 13:40:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 08/10] pc-bios: refresh edk2 build artifacts for
 edk2-stable202008
Message-ID: <20200914114005.z23yjc4wbqem4reh@sirius.home.kraxel.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-9-lersek@redhat.com>
 <b2037644-bf48-e86f-23e3-f2c68e7ddc1f@redhat.com>
 <20200914095438.wkc2fou3ijrctmfl@sirius.home.kraxel.org>
 <a1ec5724-bebd-3fe7-a1a2-db8065266feb@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a1ec5724-bebd-3fe7-a1a2-db8065266feb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu devel list <qemu-devel@nongnu.org>, Bruce Rogers <brogers@suse.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 12:53:00PM +0200, Philippe Mathieu-Daudé wrote:
> +Michael & Bruce
> 
> On 9/14/20 11:54 AM, Gerd Hoffmann wrote:
> >   Hi,
> > 
> >> The CI idea is to have reproducible builds if possible.
> >> When the submodule is updated (or the QEMU scripts containing the
> >> -D defines), it triggers the 'build-edk2' job which produce these
> >> same binaries.
> >> My original idea was to push the tag on GitLab that triggers the
> >> job, then download the produced binaries, test them, then commit
> >> them.
> > 
> > Now with CI in place we maybe should step back and have a look at the
> > big picture.
> > 
> > Should we simply stop committing firmware binaries into git and provide
> > them as CI artifacts instead?
> 
> What I'm not sure about is how to keep the built artifacts forever.

Dunno.  gitlab has support for various packages and container images,
but not for tarballs or rpms or raw binaries.  Possibly we could publish
them as gitlab pages.

> Also we need to modify the source tarball generator script to fetch
> the artifacts and include them, isn't it?

An firmware download script certainly makes sense.

Whenever we want continue including the firmware in the tarballs when
we dropped it from the git repo is up for debate ;)

take care,
  Gerd


