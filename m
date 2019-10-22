Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D005CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA6720679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4S7QWXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA6720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxqP-0006HT-Ry
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxGN-0007EH-N0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxGM-0008QH-Iq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:44:03 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:32778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMxGM-0008Pt-9j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:44:02 -0400
Received: by mail-io1-xd44.google.com with SMTP id z19so21305642ior.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OCGkXFnU4OsZEBP/GIGg38T0H1SpL5cw+lVoLIDdrFk=;
 b=E4S7QWXhEMhUEowZIKmBh7NtC3VYJWELeOO4z0RVid7wdrxSOFh39pgpux5Wwb91m6
 1Zt9ZwUEKD8X31S/fSLz7qikhRt67ZpKqxqZbCTRhb1fgvC2ZdpjjW3YDIpIdGv6gSxj
 tuvng9E6F+BQtqjsLSaX2eGVf3pt3Pd2vqfAQ/hZzHExeygo0r4a+ChoDahtt90ud7OK
 dGlpHvXN6gJOC/SqbgmTOcxGiJClU+e5OwPhzNpz4mZzXpdE01DX0YEj7Y4w2JxDwyzR
 lFZuXxX24/LaQJgBQQEeEK34b3kEdAxj0j8zdj9GThRQYQgdVY349nJYgy8/ZKZ9gltY
 qEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OCGkXFnU4OsZEBP/GIGg38T0H1SpL5cw+lVoLIDdrFk=;
 b=MFzglzhkQn07XrpYPfsRi7cDUJTuicajVpcT++kPds5TwOPtlE84Rovw4u6PiBtR4Q
 pO/noZ/XwR3XsLg0TcZeZLiNFnZVfEiMSgwAoWR310z00FsZowjdmhcJTLOGWXn4SR7g
 B/Q2ApYXj9NP5vUwg0hnCOWbdiiwBm9HYbq8ivQLeB/zAkJOz5lCkuoS5rAO4afbf8Qk
 7tgEn1YpMLBt/nTyCUX4c8DAtjdcaGeASOzzVP+9NhflxfMcjhBNRYio79nDyWvkcgy+
 NMocXuVerxOJmsLWT1p6xsx7GTPFxYB5XEKNP1F3ZPS2WZXG9XD/9WxiWUsNN+MTCm+O
 tqjw==
X-Gm-Message-State: APjAAAX96d2HPrmaPKGY0/nPbOTq/ZhEjfgv/UVZfO7jSp+13bV5ooN5
 66QLN3nKgleY/XxK2Bw54LJoZc8MCjO3SyFSx+fFCw==
X-Google-Smtp-Source: APXvYqx7ygXu+u+5ewqKKCnykk5aU4VAZDv/Zk+S532vUBJU1KZSJsnnznsugS9EVFI5yKODa29k12HGxQ67wzHB1jo=
X-Received: by 2002:a5d:9a98:: with SMTP id c24mr4760068iom.203.1571762641397; 
 Tue, 22 Oct 2019 09:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191016090745.15334-1-clg@kaod.org>
 <CACPK8XdT0_JCxzfxd4dCafK0Ae9+18ZWcusuXV+d4eEmwwBnkA@mail.gmail.com>
 <CAFEAcA_6yxaanT2N6Twos_FxjJNgvVKShwgq=pR4fqmcZUsQFA@mail.gmail.com>
In-Reply-To: <CAFEAcA_6yxaanT2N6Twos_FxjJNgvVKShwgq=pR4fqmcZUsQFA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 17:43:49 +0100
Message-ID: <CAFEAcA8py1obBXc1o02wTRkXms9NwCnCT6Q9ZZ-4W=NzNocLrQ@mail.gmail.com>
Subject: Re: [PATCH] aspeed: Add an AST2600 eval board
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 14:54, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 17 Oct 2019 at 07:33, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Wed, 16 Oct 2019 at 09:08, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
> > >
> > > Define the board with 1 GiB of RAM but some boards can have up to 2
> > > GiB.
> > >
> > > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > ---
> > >
> > >  Changes since AST2600 patchset:
> > >
> > >  - lowered the RAM size to 1 GiB as it was breaking the tests on some
> > >    hosts.
> >
> > Peter,
> >
> > After chatting with C=C3=A9dric I agree we should merge this patch.
> >
> > As it turns out the EVBs have differing amounts of RAM; his has 1GB
> > while mine has 2GB. So we are not being inaccurate by setting 1GB as
> > the default here.
>
> That's convenient, means we don't have to figure out how to
> special-case the test infrastructure for it :-)

This is now OK on the 32-bit boxes, but still fails 'make check'
on my OSX system:

manooth$ QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64
tests/qom-test -p /aarch64/qom/ast2600-evb
/aarch64/qom/ast2600-evb: Broken pipe
/Users/pm215/src/qemu-for-merges/tests/libqtest.c:149: kill_qemu()
detected QEMU death from signal 6 (Abort trap: 6)
Abort trap: 6

Dropping from the pullreq again :-(

thanks
-- PMM

