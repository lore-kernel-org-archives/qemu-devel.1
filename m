Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDADC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3B3252EA
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b12AEGea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3B3252EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNYN-0005zZ-T3
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSNWs-0004gX-EI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSNWp-0005qr-80
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602607917;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgRZQv4uzOZgHe4XSDNMCc7waPz7PS1b9GOllbE28h8=;
 b=b12AEGeaXS18yujKkTKNh7cz/qpujGjDnHGVEnXQ9w21C++hdvqwlvMldfL3XiqRaMf68i
 Y8EbCA6BvbQuu4zavnDLc8txMX39OBzt3Zp4x6QkydkMsi41hGPeA1HJLX845x9Qm0CoKJ
 1QeYCdKm2G2VCuwRYPhWzSx0/U0jPXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-I1Y5ExDvM1mXnEY3QniCPQ-1; Tue, 13 Oct 2020 12:51:45 -0400
X-MC-Unique: I1Y5ExDvM1mXnEY3QniCPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07AAF18B638B;
 Tue, 13 Oct 2020 16:51:44 +0000 (UTC)
Received: from redhat.com (ovpn-114-78.ams2.redhat.com [10.36.114.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0FCB10013D0;
 Tue, 13 Oct 2020 16:51:41 +0000 (UTC)
Date: Tue, 13 Oct 2020 17:51:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v3 0/3] unbreak non-tcg builds
Message-ID: <20201013165138.GT70612@redhat.com>
References: <20201013143806.14321-1-cfontana@suse.de>
 <cd8e9295-dcd0-18c4-e7a2-86bed74f967c@redhat.com>
 <ed8d664d-9af7-f4c6-1b2d-e0569eb27ab7@suse.de>
MIME-Version: 1.0
In-Reply-To: <ed8d664d-9af7-f4c6-1b2d-e0569eb27ab7@suse.de>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 06:47:42PM +0200, Claudio Fontana wrote:
> On 10/13/20 4:55 PM, Philippe Mathieu-Daudé wrote:
> > On 10/13/20 4:38 PM, Claudio Fontana wrote:
> >> This series now unbreaks current non-tcg builds
> >> (!CONFIG_TCG).
> >>
> >> tests Makefiles need to avoid relying on all non-native
> >> archs binaries to be present,
> >>
> >> bios-tables-test needs to skip tests that are tcg-only,
> >>
> >> and notably the replay framework needs to consider that
> >> it might not be functional (or its code present at all)
> >> without TCG.
> >>
> >> Tested ok target x86_64-softmmu on x86_64 host with:
> >>
> >> ./configure --enable-tcg --disable-kvm
> >> ./configure --enable-kvm --disable-tcg
> >> ./configure --enable-tcg --enable-kvm
> > 
> > If you want to avoid these configurations to bitrot,
> > consider covering them by adding Gitlab jobs :)))
> > 
> > 
> 
> That would be, providing a patch to  .travis.yml right?

Adding more jobs to Travis is discouraged. GitLab CI is our preferred
CI platform wherever possible. Others are only used where GitLab doesn't
support the required feature.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


