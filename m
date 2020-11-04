Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FAAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 02:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB0E216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 02:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbd2Wmcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB0E216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka8X6-0004Kj-Rz
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 21:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1ka8WJ-0003u6-OV; Tue, 03 Nov 2020 21:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1ka8WH-00011c-Qr; Tue, 03 Nov 2020 21:27:31 -0500
Received: from sstabellini-ThinkPad-T480s (c-24-130-65-46.hsd1.ca.comcast.net
 [24.130.65.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F3F2C21534;
 Wed,  4 Nov 2020 02:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604456846;
 bh=AAO/693nsK4aj5g61yL0xiPaCLcEqYbqVqiD/UMxyDg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Wbd2WmcxvzgXxQuvpgP0ltdv3CQkkb4HZwVP1XvmO1qWWyKPjV4NuF2TFZU0Y/GeV
 A//QEjWq1xPg0Ygi3BWhqDBQ+b07XyL1toATNnFX3u9EFSEyBVe1uFRMJT8qBKJskk
 HjFjiw1L4lmc/SsHy9PgS7i6m2Dc2aVkkf1ePccA=
Date: Tue, 3 Nov 2020 18:27:18 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
In-Reply-To: <21e90ddb-fe8a-c780-2741-9b7a2f7f1c9a@redhat.com>
Message-ID: <alpine.DEB.2.21.2011031722100.3264@sstabellini-ThinkPad-T480s>
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
 <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
 <21e90ddb-fe8a-c780-2741-9b7a2f7f1c9a@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2447170-1604453887=:3264"
Content-ID: <alpine.DEB.2.21.2011031752410.3264@sstabellini-ThinkPad-T480s>
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 21:27:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2447170-1604453887=:3264
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.2011031752411.3264@sstabellini-ThinkPad-T480s>

On Tue, 3 Nov 2020, Philippe Mathieu-Daudé wrote:
> I forgot to Cc the 9pfs & Xen maintainers, doing it now ;)
> 
> On 11/3/20 6:01 PM, Philippe Mathieu-Daudé wrote:
> > On 11/3/20 5:52 PM, Daniel P. Berrangé wrote:
> >> On Tue, Nov 03, 2020 at 05:46:03PM +0100, Philippe Mathieu-Daudé wrote:
> >>> We test './configure --without-default-devices' since commit
> >>> 20885b5b169 (".travis.yml: test that no-default-device builds
> >>> do not regress") in Travis-CI.
> >>>
> >>> As we prefer to use GitLab-CI, add the equivalent job there.
> >>>
> >>> One minor difference: the GitLab Ubuntu docker image has the
> >>> Xen devel packages installed. As it is automatically selected,
> >>> we need to disable it with the --disable-xen option, else the
> >>> build fails:
> >>>
> >>>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function `xen_be_register_common':
> >>>   hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
> >>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to `local_ops'
> >>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference to `synth_ops'
> >>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference to `proxy_ops'
> >>>   collect2: error: ld returned 1 exit status
> >>
> >> Surely this is a build bug we need to fix rather than ignore in CI ?
> > 
> > Well it predates this series, so nobody really cared
> > (thus I wonder if it makes sense to invest resources
> > there).
> > 
> > Anyway I can have a look after 5.2-rc1.

Actually I care about Xen and 9pfs support, it is one of the few
combinations that I use regularly and it is even enabled in the Xilinx
product I look after. But admittedly I don't test QEMU master as much as
I should. With the recent changes to the build system it is not very
suprising that there are some issues. It would be great to have a Xen
and 9pfs test in the gitlab CI-loop.


FYI I tried to build the latest QEMU on Alpine Linux 3.12 ARM64 and I
get:

  ninja: unknown tool 'query'

Even after rebuilding ninja master by hand. Any ideas? I don't know much
about ninja.


So I gave up on that and I spinned up a Debian Buster x86 container for
this build. That one got past the "ninja: unknown tool 'query'" error.
The build completed without problems to the end.

Either way I can't reproduce the build error above.
--8323329-2447170-1604453887=:3264--

