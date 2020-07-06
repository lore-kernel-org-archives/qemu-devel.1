Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8624FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5058E2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1vpAEqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5058E2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsR3y-00031Q-KK
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 09:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsR3F-0002J5-Bv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:20:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsR3D-0001Df-QQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594041650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R+ReZ5aSGizCwaPpjWaMwbBmzGJlbAubcNaApokNMkA=;
 b=T1vpAEqcwPL2rOWJ29uQZ3m7TSm8I9WAlsRTRIdsLl/cBJaoiTJagrNGRTK+Mw2En13TeL
 WZ+xi3JBsLtdyZDMrKJ6BLqGKtTQZ++pYVqY6VVvUkfJ98t/17k5sFMEBO6x0zPWu+K6Gs
 8qaVY6VMLqONXCD+x54o4E5vC0Lm6w0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-KcjOsNGsP1yIeV-FhbgFCQ-1; Mon, 06 Jul 2020 09:20:46 -0400
X-MC-Unique: KcjOsNGsP1yIeV-FhbgFCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A00A4107ACCA;
 Mon,  6 Jul 2020 13:20:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0FA9129F95;
 Mon,  6 Jul 2020 13:20:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C65109D71; Mon,  6 Jul 2020 15:20:41 +0200 (CEST)
Date: Mon, 6 Jul 2020 15:20:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 00/10] Modules 20200702 patches
Message-ID: <20200706132041.za32cy3kejeari2u@sirius.home.kraxel.org>
References: <20200702122048.27798-1-kraxel@redhat.com>
 <CAFEAcA9PVnKo8S7=bSggS2FpS5YoBexZD7nM54XFHto333_OhQ@mail.gmail.com>
 <20200703103949.7vz3dmy4br55rh4b@sirius.home.kraxel.org>
 <d9e28e08-e8d3-edd4-dcf0-af207a5ad3b8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d9e28e08-e8d3-edd4-dcf0-af207a5ad3b8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> >>>   build: fix device module builds

> >> No code review at all? :-(
> > 
> > Well, there have been 5 revisions on the list, partly due to bugs being
> > fixed, partly with changes as response to review comments.  So it got
> > some review (not much though) even though the v5 series (posted on June
> > 22th, so there was more than a week time) didn't got any acks so far.
> > 
> >> In particular the "build: fix device module
> >> builds" commit (as you note in your commit message) does not look at
> >> all right.
> > 
> > I think this stop-gap will do fine as long as we don't have any
> > target-specific modules.
> 
> Yeah, it's hackish but target-specific modules would be a huge
> complication so I don't think we'd be having them anytime soon.  With
> Meson removing the unnest-vars logic, the hack would also go away on its
> own.  So I guess it's okay.

OK, good.  So how to go forward now?

  (1) Merge pull req as-is?
  (2) Re-spin with discussion summary added to patch "4/10 build: fix
      device module builds".
  (3) Something else?

Any chance for an ack in case we go (2) or (3) ?

thanks & take care,
  Gerd


