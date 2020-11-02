Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36990C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5854B206B7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffq9zfxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5854B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZanH-0005YJ-Te
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZaka-0004gi-Gn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZakY-0006QH-I1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604327037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUpUZfnGoXTU1G0NIBD/T5XiD6X7q+ofnByW2taVBu4=;
 b=Ffq9zfxaxSmiNGg/WN0X0iuY/7DMeYL8D2yQWT3rTeRNmYmdWKzIa2lpng3xQaTvrnDOGk
 /aDxNtTIC3irQsR4jTsyqGre5Vl0gTxPLJ9mltXCb2+eczqSSZ5p5FY4K1SOk3Dwv3hh2p
 Smaw3wlCQldTmjiwgqD3VvptFvGZk8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-GO5bixzDM4q7nmDytk1_mg-1; Mon, 02 Nov 2020 09:23:52 -0500
X-MC-Unique: GO5bixzDM4q7nmDytk1_mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA7FC801FCC;
 Mon,  2 Nov 2020 14:23:51 +0000 (UTC)
Received: from redhat.com (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2221475124;
 Mon,  2 Nov 2020 14:23:46 +0000 (UTC)
Date: Mon, 2 Nov 2020 14:23:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] docs: add "page source" link to sphinx documentation
Message-ID: <20201102142343.GD138796@redhat.com>
References: <20201102130926.161183-1-berrange@redhat.com>
 <20201102130926.161183-5-berrange@redhat.com>
 <CAFEAcA8RS2h5V-pSN2B35B-eV4-+wjj2Cdd=PvFTF_qnib9OfQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RS2h5V-pSN2B35B-eV4-+wjj2Cdd=PvFTF_qnib9OfQ@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 01:52:04PM +0000, Peter Maydell wrote:
> On Mon, 2 Nov 2020 at 13:09, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Add a link to the top of the sidebar in every docs page that takes the
> > user back to the source code in gitlab.
> 
> This doesn't exactly link back to the source code, which is a bit
> confusing I think. Eg the 'page source' link in
> https://berrange.gitlab.io/qemu/system/quickstart.html
> goes to
> https://gitlab.com/qemu-project/qemu/-/blob/master/docs/system/quickstart.rst
> 
> which is a gitlab rendered version of the rST, not a view of
> the actual sources. Is it possible to link directly to an
> "actually the source code" view?

At the top of that page there are two buttons for switching between the
rendered view and source view. I don't think they're directly linkable
as it is switched with javascript.

At least the user can see exactly what source filename is involved though,
which was the key goal I had.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


