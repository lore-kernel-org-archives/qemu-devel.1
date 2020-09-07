Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3EAC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB30E205CB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i72kDfgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB30E205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEPk-0002Nq-MY
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFEP3-0001Iv-LD
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:29:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31541
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFEP1-00033c-8C
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599474574;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPMsWu19jw+gz3DeeiNb5IfYY/YJ8LVqkvkIJJotT+o=;
 b=i72kDfgCWUaibLQTVumCSHaoSexo3UT+neSwuuAeYy8ppbCOWyZzW0L4RXIZIgfd+G3mJA
 W8YhL3jzuEN+T9SH+b8AXL5dy1ZpyEIqd7cdyg71NugDVtS3L9brwt8prGNB2aBlFMm2Yr
 ZkznwjMZAIspBsGJU3uCKn3ATYIJCRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-iMEVlKMFMTGnZofQoRqlZA-1; Mon, 07 Sep 2020 06:29:06 -0400
X-MC-Unique: iMEVlKMFMTGnZofQoRqlZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF6991007B09;
 Mon,  7 Sep 2020 10:29:03 +0000 (UTC)
Received: from redhat.com (ovpn-114-70.ams2.redhat.com [10.36.114.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C23F460C84;
 Mon,  7 Sep 2020 10:28:52 +0000 (UTC)
Date: Mon, 7 Sep 2020 11:28:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/4] Acceptance tests: use an available kernel image
 package for arm
Message-ID: <20200907102849.GE810755@redhat.com>
References: <20200907042000.415931-1-crosa@redhat.com>
 <20200907042000.415931-2-crosa@redhat.com>
 <001385a1-92eb-d311-88b5-8e1e7f6f1f48@redhat.com>
 <20200907093930.GD810755@redhat.com>
 <34814b29-a47a-efd3-971b-520bc5ac6309@redhat.com>
MIME-Version: 1.0
In-Reply-To: <34814b29-a47a-efd3-971b-520bc5ac6309@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 07, 2020 at 11:59:18AM +0200, Philippe Mathieu-Daudé wrote:
> On 9/7/20 11:39 AM, Daniel P. Berrangé wrote:
> > On Mon, Sep 07, 2020 at 10:06:13AM +0200, Philippe Mathieu-Daudé wrote:
> >> [Cc'ing Daniel who usually have good ideas for that
> >> kind if project-wide problem]
> >>
> >> On 9/7/20 6:19 AM, Cleber Rosa wrote:
> >>> Which means a newer kernel version.  Expected output was changed
> >>> to match the new kernel too.
> >>
> >> Nack.
> >>
> >> Acceptance tests are not to test the latest Linux kernel,
> >> they aim to assert a specific kernel tested by some developer
> >> still works while QEMU evolves.
> >> QEMU doesn't have to adapt to the latest kernel;
> >> QEMU should keep boot an old kernel.
> >>
> >> Testing new kernels is good, you are adding coverage. But
> >> this break the acceptance testing contract "keep testing
> >> the same thing over time".
> >>
> >> The problem you are trying to fix is the "where to keep
> >> assets from public locations where they are being removed?"
> >> one. Two years ago [*] you suggested to use some storage on
> >> the avocado-project.org:
> >>
> >>   For Avocado-VT, there are the JeOS images[1], which we
> >>   keep on a test "assets" directory.  We have a lot of
> >>   storage/bandwidth availability, so it can be used for
> >>   other assets proven to be necessary for tests.
> >>
> >>   As long as distribution rights and licensing are not
> >>   issues, we can definitely use the same server for kernels,
> >>   u-boot images and what not.
> >>
> >>   [1] - https://avocado-project.org/data/assets/
> > 
> > If I look at stuff under that directory I see a bunch of "Jeos" qcow2
> > images, and zero information about the corresponding source for the
> > images, nor any information about the licenses of software included.
> > IOW what is stored their right now does not appear to comply with the
> > GPL licensing requirements for providing full and corresponding source.
> > 
> >> It is time to have QEMU assets managed the same way.
> > 
> > I'd rather we didn't do anything relying on binary blobs with no
> > info about how they were built. Pointing to the 3rd party download
> > URLs was the easy way to ensure we don't have to worry about licensing
> > problems.
> 
> I tried to be very strict including the recipe about how to rebuild
> and description of the source (for licensing) in each commits (Alex
> Bennée once said Debian/Fedora based was OK):

..snip...

Well that looks better than what is done for the JEOS images currently
on avocado-project.org, as I can't tell what distro those came from
at all.

If we're hosting images built by some 3rd party, and we intend to rely
on the 3rd party to satisfy source availability, then we need to be sure
that the 3rd party is themselves still distributing the same images.

IIUC, from Cleber's commit here the original images we're pointing to
are now 404s. If the URLs moved, we just need to update to fix the URLs
to point the new location. If the content was entirely removed though,
we shouldn't mirror it ourselves, because we can't rely on the original
vendor to be providing the source at that point.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


