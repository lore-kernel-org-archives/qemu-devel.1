Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DACC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818822133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818822133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49340 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbhuC-0003jb-SA
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58519)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbhse-0002ks-HG
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbhsd-0005Zi-A2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:48:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbhsW-0005MV-HD
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:48:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so1442256wmg.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 01:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8KrYVRy15+NMattYlddMS4RQ1AdJJla3fTP/QZ0Zgmo=;
 b=GV60AmqWxUu2RJ5H/722CitCndI1OtRtlGuY/HoN1jCehHWgHRgfFzWWqbikfYDekT
 zS5xhQMaFsCo8uqFuFtLDs8Vk5SUguN+HR26co8LOtQIW+6vluhHXSQTr8RkIseIkR5D
 sVC1bFffWEvjlNOwfVqQO42ZpOBqjFyXIbFI4hwDrckSQjuhC7ftJ0nsQQKI2LTJ+KXE
 YH8hDM2MyQIB8BryHoHj8YaRaawVQx2CuaEUsRU57wVbNnIt45lmUup+pETbWLO79n8y
 /wIxUG6kVc8NJJwaIfBoMeyrqtr73+5f59+Hm0nHK5rTM+sVxgSv8NN2hO12LDsKwGL5
 xxHA==
X-Gm-Message-State: APjAAAVNi/MMASS9LKFgRDMeh7nvPTUSFCHuUdN+I5H8Olsek8rZJIsu
 1IK4WT0kbhCld6DG90acnMDWcQ==
X-Google-Smtp-Source: APXvYqxwiA6uuuNqNFtWWM0DsvmazI7yVrVgPl1pST4Dw7xwdiKJ3B7/2nvpoxKg9fWq2pAb5HPUlA==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26mr6955306wma.105.1560502084629; 
 Fri, 14 Jun 2019 01:48:04 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id o2sm3501123wrq.56.2019.06.14.01.48.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 01:48:04 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190614072432.820-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ba92c012-15d8-321c-c802-2924bc4c8822@redhat.com>
Date: Fri, 14 Jun 2019 10:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614072432.820-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 0/6] configure: Try to fix --static linking
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
 integration@gluster.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Bharata B Rao <bharata@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 9:24 AM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Apparently QEMU static linking is slowly bitroting. Obviously it
> depends the libraries an user has installed, anyway it seems there
> are not much testing done.
> 
> This series fixes few issues, enough to build QEMU on a Ubuntu
> aarch64 host, but not yet on a x86_64 host:
> 
>     LINK    x86_64-softmmu/qemu-system-x86_64
>   /usr/bin/ld: cannot find -lgtk-3
>   /usr/bin/ld: cannot find -latk-bridge-2.0
>   /usr/bin/ld: cannot find -latspi
>   /usr/bin/ld: cannot find -lsystemd
>   /usr/bin/ld: cannot find -lgdk-3
>   /usr/bin/ld: cannot find -lwayland-egl
>   /usr/bin/ld: cannot find -lmirclient
>   /usr/bin/ld: cannot find -lmircore
>   /usr/bin/ld: cannot find -lmircookie
>   /usr/bin/ld: cannot find -lepoxy
>   /usr/bin/ld: cannot find -latk-1.0
>   /usr/bin/ld: cannot find -lgdk_pixbuf-2.0
>   /usr/bin/ld: cannot find -lselinux
>   /usr/bin/ld: cannot find -lgtk-3
>   /usr/bin/ld: cannot find -latk-bridge-2.0
>   /usr/bin/ld: cannot find -latspi
>   /usr/bin/ld: cannot find -lsystemd
>   /usr/bin/ld: cannot find -lgdk-3
>   /usr/bin/ld: cannot find -lwayland-egl
>   /usr/bin/ld: cannot find -lmirclient
>   /usr/bin/ld: cannot find -lmircore
>   /usr/bin/ld: cannot find -lmircookie
>   /usr/bin/ld: cannot find -lepoxy
>   /usr/bin/ld: cannot find -latk-1.0
>   /usr/bin/ld: cannot find -lgdk_pixbuf-2.0
>   /usr/bin/ld: cannot find -lselinux
>   /usr/bin/ld: attempted static link of dynamic object `/usr/lib/x86_64-linux-gnu/libz.so'
>   collect2: error: ld returned 1 exit status

This one is funny, when installing libvte on Ubuntu 18.04:

    LINK    x86_64-softmmu/qemu-system-x86_64
  c++: error: /usr/lib/x86_64-linux-gnu/libunistring.so: No such file or
directory
  c++: error: /usr/lib/x86_64-linux-gnu/libunistring.so: No such file or
directory
  c++: error: /usr/lib/x86_64-linux-gnu/libunistring.so: No such file or
directory
  c++: error: /usr/lib/x86_64-linux-gnu/libunistring.so: No such file or
directory

$ pkg-config --libs --static vte-2.91
-lvte-2.91 -lgtk-3 -latk-bridge-2.0 -latspi -ldbus-1 -lpthread -lsystemd
-lgdk-3 -lXinerama -lXi -lXrandr -lXcursor -lXcomposite -lXdamage
-lXfixes -lxkbcommon -lwayland-cursor -lwayland-egl -lwayland-client
-lepoxy -ldl -lpangocairo-1.0 -lpangoft2-1.0 -lharfbuzz -lm -lgraphite2
-lpango-1.0 -lm -latk-1.0 -lcairo-gobject -lcairo -lz -lpixman-1
-lfontconfig -lexpat -lfreetype -lexpat -lfreetype -lpng16 -lm -lz -lm
-lxcb-shm -lxcb-render -lXrender -lXext -lX11 -lpthread -lxcb -lXau
-lXdmcp -lgdk_pixbuf-2.0 -lm -lpng16 -lm -lz -lm -lgio-2.0 -lz -lresolv
-lselinux -lmount -lgmodule-2.0 -pthread -ldl -lgobject-2.0 -lffi
-lglib-2.0 -pthread -lpcre -pthread -lgnutls -lgmp
/usr/lib/x86_64-linux-gnu/libunistring.so -lidn2 -lhogweed -lgmp
-lnettle -ltasn1 -lp11-kit -lz

$ ls -ld /usr/lib/x86_64-linux-gnu/libunistring.so
ls: cannot access '/usr/lib/x86_64-linux-gnu/libunistring.so': No such
file or directory

$ ls -ld /usr/lib/x86_64-linux-gnu/libunistring.so*
lrwxrwxrwx. 1 root root      21 Mar  3  2018
/usr/lib/x86_64-linux-gnu/libunistring.so.2 -> libunistring.so.2.1.0
-rw-r--r--. 1 root root 1562664 Mar  3  2018
/usr/lib/x86_64-linux-gnu/libunistring.so.2.1.0

The fix is probably "sudo ln -s libunistring.so.2
/usr/lib/x86_64-linux-gnu/libunistring.so".

