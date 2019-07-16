Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25E3C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E3A20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E3A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnS4Y-0002Ll-So
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 14:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnS4O-0001vv-6p
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnS4M-0000QH-4c
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:20:56 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnS4L-0000Pq-PE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:20:53 -0400
Received: by mail-wr1-f52.google.com with SMTP id x4so21975102wrt.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 11:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pth5W4gqaUkJJSEizpIi7rxFL1KM2VM75hUhjXd0jTw=;
 b=qrfoDEkCHMSNE7yHsTLt4fZU150z3gYSZXROmI1wr3xSm/ie6RB2mOA8Km3lRYOGlI
 31PEgVxVo+D8bHPegxKLRznPi8fs9ZjCRNqoWhUJsqLgb7RJReNKiEObP9AhkWOEStXO
 vNBn9q87fEvYKukA7O8/9OsEfVl5NB+r94otNHe7TzpOxv4Bs2blaJ4maQHg4SLNoaaA
 FQ7fhx0wDiPYZRTknDVtkErAOKMTKUhRFN3Eb/3tc4nuZkT/eFJBUyTreBxcj4sr5Faa
 1xb2EUP5qpp51s6esggPTOZ0oApfDl/gEp476G0AvV0wzOP6tPNxH24wdCpnNUnFHcJp
 lmhw==
X-Gm-Message-State: APjAAAXYXR5cCy9wwUtMYcflj7/O41QrZDoeFj8KH7vQfVsW0iVjoxuz
 O/Kr7m1G7woZmE8LhK4chU3w8tywXC8=
X-Google-Smtp-Source: APXvYqzumTgZAUsSeFYlkRWaZw0gWAn5bT3SPBui5HitPHYsc872oaMKWRG87rmw4Qs8up9jOATDIg==
X-Received: by 2002:adf:b612:: with SMTP id f18mr25732634wre.97.1563301252032; 
 Tue, 16 Jul 2019 11:20:52 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id l8sm36096338wrg.40.2019.07.16.11.20.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 11:20:51 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ff1c3cea-0de0-1717-44f2-f57b2c30a359@redhat.com>
Date: Tue, 16 Jul 2019 20:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.52
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
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
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 7/16/19 7:09 PM, Aleksandar Markovic wrote:
> On Tue, Jul 16, 2019 at 1:54 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 16/07/2019 13.17, Aleksandar Markovic wrote:
>>> Hello, Gerd, Daniel, and others involved.
>>>
>>> I have multiple reports from end users that say that transition from
>>> SDL 1.2 to SDL 2.0 was difficult, or even impossible for their hosts.
>>> In that light, they don't appreciate removing SDL 1.2 support from
>>> QEMU. The most notable example is Ubutnu 16.04, where it looks there
>>> is no way of installing SDL 2.0 that does not involve complete OS
>>> upgrade, which, for various reasons, many are not willing to do.
>>
>> What's the problem here? According to
>> https://packages.ubuntu.com/xenial/libsdl2-2.0-0 the library should be
>> available there.
>>
> 
> Yes, we, as developers, are good at upgrading, we like flexibility in
> our development systems, and naturally want to try latest and greatest
> tools and libraries.
> 
> However, in QA / build / test environments, the things seem to look
> different. Their main concern is stability and repeatibility of their
> systems. They don't like updates and upgrades. If a new of library
> is available for an OS, this does not mean it will be installed, or it
> will be desired to be installed.
> 
> It appears that Ubuntu 16.04 came originally with SDL 1.2, and
> SDL 2.0 was made available later on.

I am a bit confused, I checked the older Xenial image I can find is a
pre-release:

16.04.20151218.1-xenial-baseline

# lsb_release -a
LSB Version:
core-9.20160110ubuntu0.2-amd64:core-9.20160110ubuntu0.2-noarch:security-9.20160110ubuntu0.2-amd64:security-9.20160110ubuntu0.2-noarch
Distributor ID: Ubuntu
Description:    Ubuntu Xenial Xerus (development branch)
Release:        16.04
Codename:       xenial

# apt-cache search libsdl
libsdl1.2-dbg - Simple DirectMedia Layer debug files
libsdl1.2-dev - Simple DirectMedia Layer development files
libsdl1.2debian - Simple DirectMedia Layer

# apt-cache search libsdl2

# apt-get update

# apt-cache search libsdl2
libsdl2-2.0-0 - Simple DirectMedia Layer
libsdl2-dbg - Simple DirectMedia Layer debug files
libsdl2-dev - Simple DirectMedia Layer development files
libsdl2-doc - Reference manual for libsdl2
libsdl2-gfx-1.0-0 - drawing and graphical effects extension for SDL2
libsdl2-gfx-dbg - debugging symbols for SDL2_gfx
libsdl2-gfx-dev - development files for SDL2_gfx
libsdl2-gfx-doc - documentation files for SDL2_gfx
libsdl2-image-2.0-0 - Image loading library for Simple DirectMedia Layer
2, libraries
libsdl2-image-dbg - Image loading library for Simple DirectMedia Layer
2, debugging symbols
libsdl2-image-dev - Image loading library for Simple DirectMedia Layer
2, development files
libsdl2-mixer-2.0-0 - Mixer library for Simple DirectMedia Layer 2,
libraries
libsdl2-mixer-dbg - Mixer library for Simple DirectMedia Layer 2, debugging
libsdl2-mixer-dev - Mixer library for Simple DirectMedia Layer 2,
development files
libsdl2-net-2.0-0 - Network library for Simple DirectMedia Layer 2,
libraries
libsdl2-net-dbg - Network library for Simple DirectMedia Layer 2, debugging
libsdl2-net-dev - Network library for Simple DirectMedia Layer 2,
development files
libsdl2-ttf-2.0-0 - TrueType Font library for Simple DirectMedia Layer
2, libraries
libsdl2-ttf-dbg - TrueType Font library for Simple DirectMedia Layer 2,
debugging
libsdl2-ttf-dev - TrueType Font library for Simple DirectMedia Layer 2,
development files

# apt-cache show libsdl2-dev
Package: libsdl2-dev
Architecture: amd64
Version: 2.0.4+dfsg1-2ubuntu2.16.04.1
Priority: optional
Section: universe/libdevel
Source: libsdl2
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Debian SDL packages maintainers
<pkg-sdl-maintainers@lists.alioth.debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 3803
Depends: libasound2-dev, libdbus-1-dev, libegl1-mesa-dev,
libgl1-mesa-dev, libgles2-mesa-dev, libglu1-mesa-dev, libmirclient-dev,
libpulse-dev, libsdl2-2.0-0 (= 2.0.4+dfsg1-2ubuntu2.16.04.1),
libsndio-dev, libudev-dev, libwayland-dev, libx11-dev, libxcursor-dev,
libxext-dev, libxi-dev, libxinerama-dev, libxkbcommon-dev,
libxrandr-dev, libxss-dev, libxt-dev, libxv-dev, libxxf86vm-dev
Conflicts: libsdl-1.3-dev
Replaces: libsdl-1.3-dev
Filename:
pool/universe/libs/libsdl2/libsdl2-dev_2.0.4+dfsg1-2ubuntu2.16.04.1_amd64.deb
Size: 612948
MD5sum: 75ff5bbc4c5ec0c9b81052b3695aa642
SHA1: 7d9ddbb5217343400128149ceea497d29a188a5e
SHA256: 1b79ee19be271d26e28de1a83f8181afa36a7fdc5479faa9f5dfe07ba4c4c272
Homepage: http://www.libsdl.org/
Description: Simple DirectMedia Layer development files
Description-md5: 9a82f59c5790721baad7ffc5f181d3d6
Supported: 5y

Package: libsdl2-dev
Priority: optional
Section: universe/libdevel
Installed-Size: 3802
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Debian SDL packages maintainers
<pkg-sdl-maintainers@lists.alioth.debian.org>
Architecture: amd64
Source: libsdl2
Version: 2.0.4+dfsg1-2ubuntu2
Replaces: libsdl-1.3-dev
Depends: libasound2-dev, libdbus-1-dev, libegl1-mesa-dev,
libgl1-mesa-dev, libgles2-mesa-dev, libglu1-mesa-dev, libmirclient-dev,
libpulse-dev, libsdl2-2.0-0 (= 2.0.4+dfsg1-2ubuntu2), libsndio-dev,
libudev-dev, libwayland-dev, libx11-dev, libxcursor-dev, libxext-dev,
libxi-dev, libxinerama-dev, libxkbcommon-dev, libxrandr-dev, libxss-dev,
libxt-dev, libxv-dev, libxxf86vm-dev
Conflicts: libsdl-1.3-dev
Filename:
pool/universe/libs/libsdl2/libsdl2-dev_2.0.4+dfsg1-2ubuntu2_amd64.deb
Size: 613746
MD5sum: 470e753ffa16fec00c29215e0c94efc9
SHA1: db99050370630d36105131d60bad9daa95c530d8
SHA256: 461dc89140f2716f05e20cf35c2cf3f46b0ae6e32c5bed16136df08d28b2fde0
Description: Simple DirectMedia Layer development files
Description-md5: 9a82f59c5790721baad7ffc5f181d3d6
Homepage: http://www.libsdl.org/
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Origin: Ubuntu
Supported: 9m

# curl -v
http://archive.ubuntu.com/ubuntu/pool/universe/libs/libsdl2/libsdl2_2.0.4+dfsg1-2ubuntu2.dsc
2>&1 | fgrep Last-Modified
< Last-Modified: Thu, 10 Mar 2016 22:03:45 GMT

This package was available before the Xenial official release.

I am supposing your host does not have Internet access to run apt-update
then?

Regards,

Phil.

