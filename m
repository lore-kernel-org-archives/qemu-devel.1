Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3D5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660BD21973
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAb7sTTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660BD21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwba-00023E-Do
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFwat-0001V6-KD
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:40:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34879
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFwar-00071K-Qw
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599644445;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnJgB0Iz2FmBZfS1/q1zn9DMMDlR8rVz8Or6L95EaGM=;
 b=GAb7sTTPHjPWcLPtpPd/Go6oXSsz+Akuy5lC4aTSbuv+eqMY5a8e1orJts/oifbBC4Vgp7
 O63oPzFJ5+Sf7nZkDPIh8xH+jNnKSfRKt+QIGBMdNtLm5j8PFTa3d6MpQpLoLKbtYsm2OP
 /YC3KfdvjVmk4SWtv249/KRHOqWypXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-2MwAmHL5P4mPUcqcsXkDmg-1; Wed, 09 Sep 2020 05:40:16 -0400
X-MC-Unique: 2MwAmHL5P4mPUcqcsXkDmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1627087309F;
 Wed,  9 Sep 2020 09:40:15 +0000 (UTC)
Received: from redhat.com (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FE645D9E8;
 Wed,  9 Sep 2020 09:40:07 +0000 (UTC)
Date: Wed, 9 Sep 2020 10:40:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: [PATCH 06/16] ci: Enable msys2 ci in cirrus
Message-ID: <20200909094004.GN1011023@redhat.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-7-luoyonggang@gmail.com>
 <20200909082718.GH1011023@redhat.com>
 <CAE2XoE8hHtoV_oUY2KiU=2Papjt_A4-eSF5MabPsMxnHf2uSRw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8hHtoV_oUY2KiU=2Papjt_A4-eSF5MabPsMxnHf2uSRw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 05:36:49PM +0800, 罗勇刚(Yonggang Luo) wrote:
> On Wed, Sep 9, 2020 at 4:27 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Wed, Sep 09, 2020 at 03:48:10AM +0800, Yonggang Luo wrote:
> > > Install msys2 in a proper way refer to
> > https://github.com/cirruslabs/cirrus-ci-docs/issues/699
> > > The https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 need to be
> > updated.
> > > There is no need of --cross-prefix, open mingw64.exe instead of
> > msys2.exe then we don't
> > > need the --cross-prefix, besides we using environment variable settings:
> > >     MSYS: winsymlinks:nativestrict
> > >     MSYSTEM: MINGW64
> > >     CHERE_INVOKING: 1
> > > to opening mingw64 native shell.
> > > We now running tests with make -i check to skip tests errors.
> > >
> > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > ---
> > >  .cirrus.yml                         | 24 +++++++++++++++++++++
> > >  scripts/ci/windows/msys2-build.sh   | 28 ++++++++++++++++++++++++
> > >  scripts/ci/windows/msys2-install.sh | 33 +++++++++++++++++++++++++++++
> > >  3 files changed, 85 insertions(+)
> > >  create mode 100644 scripts/ci/windows/msys2-build.sh
> > >  create mode 100644 scripts/ci/windows/msys2-install.sh
> > >
> > > diff --git a/.cirrus.yml b/.cirrus.yml
> > > index 3dd9fcff7f..49335e68c9 100644
> > > --- a/.cirrus.yml
> > > +++ b/.cirrus.yml
> > > @@ -63,3 +63,27 @@ macos_xcode_task:
> > >                     --enable-werror --cc=clang || { cat config.log; exit
> > 1; }
> > >      - gmake -j$(sysctl -n hw.ncpu)
> > >      - gmake check
> > > +
> > > +windows_msys2_task:
> > > +  windows_container:
> > > +    image: cirrusci/windowsservercore:cmake
> > > +    os_version: 2019
> > > +    cpu: 8
> > > +    memory: 8G
> > > +  env:
> > > +    MSYS: winsymlinks:nativestrict
> > > +    MSYSTEM: MINGW64
> > > +    CHERE_INVOKING: 1
> > > +  printenv_script:
> > > +    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
> > > +  install_script:
> > > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O
> > http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz
> > "
> > > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O
> > http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig
> > "
> > > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U
> > --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
> > > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
> > > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfirm
> > -S bash pacman pacman-mirrors msys2-runtime"
> > > +    - taskkill /F /IM gpg-agent.exe
> > > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
> > > +    - C:\tools\msys64\usr\bin\bash.exe -lc "sh
> > scripts/ci/windows/msys2-install.sh"
> > > +  script:
> > > +    - C:\tools\msys64\usr\bin\bash.exe -lc "sh
> > scripts/ci/windows/msys2-build.sh"
> > > diff --git a/scripts/ci/windows/msys2-build.sh
> > b/scripts/ci/windows/msys2-build.sh
> > > new file mode 100644
> > > index 0000000000..d9d046b5b0
> > > --- /dev/null
> > > +++ b/scripts/ci/windows/msys2-build.sh
> > > @@ -0,0 +1,28 @@
> > > +mkdir build
> > > +cd build
> > > +../configure \
> > > +--python=python3 \
> > > +--ninja=ninja \
> > > +--enable-stack-protector \
> > > +--enable-guest-agent \
> > > +--disable-pie \
> > > +--enable-gnutls --enable-nettle \
> > > +--enable-sdl --enable-sdl-image --enable-gtk --disable-vte
> > --enable-curses --enable-iconv \
> > > +--enable-vnc --enable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png \
> > > +--enable-slirp=git \
> > > +--disable-brlapi --enable-curl \
> > > +--enable-fdt \
> > > +--disable-kvm --enable-hax --enable-whpx \
> > > +--enable-libnfs --enable-libusb --enable-live-block-migration
> > --enable-usb-redir \
> > > +--enable-lzo --enable-snappy --enable-bzip2 --enable-zstd \
> > > +--enable-membarrier --enable-coroutine-pool \
> > > +--enable-libssh --enable-libxml2 \
> > > +--enable-jemalloc --enable-avx2 \
> > > +--enable-replication \
> > > +--enable-tools \
> > > +--enable-bochs --enable-cloop --enable-dmg --enable-qcow1 --enable-vdi
> > --enable-vvfat --enable-qed --enable-parallels \
> > > +--enable-sheepdog \
> > > +--enable-capstone=git
> >
> > Why do we need to have all these disable/enable args ?   AFAIK, configure
> > should just "do the right thing" and automatically detect and enable
> > libraries which are present in the environment.
> >
> > Te intent is that a bare "configure" should complete successfully on all
> > supported platforms. Ff something breaks at build time, that is
> > generally considered a bug in the configure script as it should
> > automatically
> > disable any features that are broken on a given platform.
> >
> Gotcha, I'll leave only configure latter, currently I use this to detect
> which msys2 package not installed yet.

With all those args removed, there's no real reason for this separate
shell script. Just put the configure && make commands dirctly in
the cirrus.yml file, similar to the other builds in that file.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


