Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F596C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4902070D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D41kOPlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4902070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVv3Q-0002wr-Hs
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:39:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVv2D-0002Rv-Qq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVv2C-0002Wp-UA
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:38:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVv2C-0002W9-Hi
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:38:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id v22so1092593wml.1
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=9lxoeb2H3rwDCfwf1JWyx5x6/iO+krrE04V0zB31At0=;
	b=D41kOPlohT9pGsGy27+0mIPpXRfpwXP5EkbW0tWG+M+i6Nvc0184FLBJU4DHboA/FL
	TAqzyB+v/xkqi3h3u6AEBkbVMuilJF/ISjJzH59iSGY4MtR+j1/kLwHaiww3ecqBlK0H
	URVpidVlMkxinSiP5w4aDx9YJUYQAfkXbmHx0m96UaOspllaHA0gc8ilQqCn/N9HQv/2
	6RL7L7vTCjEebao6DsZB7dvrts3Jhth1O7E35AA+YpyCisr7IiZGeALig8+CF5Gu/+8U
	12eeaYA4Sc/WRjOYiqRe1YRChVaVZPf8nHXnekEc7ILcdjHyt/phkT0bDbGGAeSHiYKk
	mR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=9lxoeb2H3rwDCfwf1JWyx5x6/iO+krrE04V0zB31At0=;
	b=NZjbaTVOCGfYqBqSgBk5sZGAjIc5P8RMNssaQ9q++wP1WHa08JY18qv9Nx1RsCxq/7
	zLyZ+jdCUMr2X9wlT6iK29sAbfwx3/yeDApAMY6KCQ5AX6lxMlLvJmiyWBuZeZeGhj8S
	2+go4iqUI1ehaTuBYjiMfKO6gt62tOzoIAxf2AappwkAtvWuAtsCyUXJdlAHFA2c8OSl
	El7htbUjqVm0dnf6en9OWzd5qB7JB6StmzqfhOJgjg/PvfG1uIfIiSUkkiZpALwUfzrx
	1kHecftNQSIs6bPmgeojxIuxq5rby0dCvWQb25MogorFcVAqZICzMH8tEbIQctwHiB0i
	PbxA==
X-Gm-Message-State: APjAAAXuxsxK6ng2ZZaIF2EHRfHibpZhMNv5urzQoM4MYxJBwATu5vfe
	quD/Xi6wUCvMgJcEFFlvXP0wgQ==
X-Google-Smtp-Source: APXvYqxomwlg/EZQxGddaBYVf7TtPgsSk3cZk/DH4vt8qkbGSHXtiR9E5ZcJfbR9jRRh8OrqsUQGQw==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr6393774wmh.86.1559122689762; 
	Wed, 29 May 2019 02:38:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id e15sm3633813wme.0.2019.05.29.02.38.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 02:38:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 1F22A1FF87;
	Wed, 29 May 2019 10:38:08 +0100 (BST)
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
In-reply-to: <87lfyqla7r.fsf@dusky.pond.sub.org>
Date: Wed, 29 May 2019 10:38:08 +0100
Message-ID: <874l5dsirj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> We have a bunch of headers without multiple inclusion guards.  Some are
> clearly intentional, some look accidental.  Too many for me to find out
> by examining each of them, so I'm asking their maintainers.
>
> Why do I ask?  I'd like to mark the intentional ones and fix the
> accidental ones, so they don't flunk "make check-headers" from "[RFC v4
> 0/7] Baby steps towards saner headers" just because they lack multiple
> inclusion guards.
>
> Just in case: what's a multiple inclusion guard?  It's
>
>     #ifndef UNIQUE_GUARD_SYMBOL_H
>     #define UNIQUE_GUARD_SYMBOL_H
>     ...
>     #endif
>
> with nothing but comments outside the conditional, so that the header
> can safely be included more than once.
>
> I append the alphabetical list of headers without multiple inclusion
> guards (as reported by scripts/clean-header-guards -nv), followed by the
> same list sorted into maintainer buckets.  If you're cc'ed, please find
> your bucket(s), and tell me which headers intentionally lack guards.
>
>
> =3D Headers without inclusion guards =3D
<snip>
> include/exec/cpu_ldst_template.h
> include/exec/cpu_ldst_useronly_template.h
> include/exec/memory_ldst.inc.h
> include/exec/memory_ldst_cached.inc.h
> include/exec/memory_ldst_phys.inc.h

These are all included multiple times with different #define's to expand
out our various helpers. Eventually I hope to make them go away but for
now they are fine.

--
Alex Benn=C3=A9e

