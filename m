Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67822C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E1D21D7D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RU+sf3Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E1D21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4dK-0001e4-HR
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG4bv-0000U4-Vk
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG4bt-0003k3-9B
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599675260;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fT+1VedVhPuO+jIIRzCGTXF91P4hE1qtgMJrgKokh3I=;
 b=RU+sf3Auis+I4hAmkl6LP9qG935SxVWdK+K74quCr7695TMSO/j0u5oUxiI6sBfA9j3Ojn
 TfGyxFzJb7cOqSDlpGuaIteLKeCczHtJulueiC6O+n9kaDdV3RnG1FjlALDLjNvqyZBCwn
 ADs2qLWwc3PENhuoKQ+aqNUZQBLZ000=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-WwRhYiM3Pr-cc0WTBdG-WA-1; Wed, 09 Sep 2020 14:14:04 -0400
X-MC-Unique: WwRhYiM3Pr-cc0WTBdG-WA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D7664080;
 Wed,  9 Sep 2020 18:14:03 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E26645C1DA;
 Wed,  9 Sep 2020 18:13:57 +0000 (UTC)
Date: Wed, 9 Sep 2020 19:13:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Message-ID: <20200909181355.GV1011023@redhat.com>
References: <2764135.D4k31Gy3CM@silver>
 <CAFEAcA8Wgbqm15DB1YLXBzQJwNeZjKGcdLFHe8G4FS6YT5Tcmw@mail.gmail.com>
 <13443969.F0S6BcH2UH@silver>
MIME-Version: 1.0
In-Reply-To: <13443969.F0S6BcH2UH@silver>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:20:24
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, qemu-devel@nongnu.org,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On Mittwoch, 9. September 2020 15:40:05 CEST Daniel P. Berrangé wrote:
> > Ideally any xcode setup would just invoke whatever our standard
> > build tools are IMHO, so it has zero possibility of introducing
> > new build problems.
> 
> Then you would not win anything on Mac. The problematic on macOS is that Apple 
> froze many standard FOSS tools that switched to GPL3. So by default you just 
> have e.g. GNU make 3.81 (2006), Bash 3.2.57 (2007), ...  unless you start to 
> manually install them (e.g. from Homebrew & Co). And being forced to use Meson 
> on Mac with all its Python dependencies does not make it easier.

It is going to need to use homebrew (or an equivalent) to bring in various
3rd party libraries QEMU depends on at build time, not least glib. So avoiding
homebrew for the build system doesn't appear like an obvious win to me.

I don't think QEMU wants to restrict itself to merely what is available in
the basic macOS install. We expect users to have to pull in stuff from
homebrew or an equivalent to get functionality that Apple has no intention
of ever shipping in their base OS install.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


