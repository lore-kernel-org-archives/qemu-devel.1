Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE7C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF441206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF441206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lIS-0004eF-0p
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8lFG-0002ZF-9j
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8lFF-0005I2-7l
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:04:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8lFF-0005Hj-2s
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:04:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6231F10CC1E5;
 Fri, 13 Sep 2019 13:04:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7834410E;
 Fri, 13 Sep 2019 13:04:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47E0B113865F; Fri, 13 Sep 2019 15:04:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <695325d7-a0c3-73c1-97ab-f62fb345c622@unipi.it>
 <87blwzho1y.fsf@dusky.pond.sub.org>
 <2fb98b77-efab-6092-dd5a-fa50c3c4b3f9@redhat.com>
 <58e7895e-4910-4d4c-79d8-dead7de69ab7@unipi.it>
Date: Fri, 13 Sep 2019 15:04:05 +0200
In-Reply-To: <58e7895e-4910-4d4c-79d8-dead7de69ab7@unipi.it> (Giuseppe
 Lettieri's message of "Mon, 2 Sep 2019 22:50:13 +0200")
Message-ID: <87blvocpq2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 13 Sep 2019 13:04:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping?
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
 "Daniel P. Berrange" <berrange@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Giuseppe Lettieri <giuseppe.lettieri@unipi.it> writes:

> Hi all,
>
> I have been thinking of the submodule suggestion and I have also
> prepared a patch for it (attached). However, I am not sure about what
> we want to achieve with it. In particular, I am not sure that the
> option is useful for end users. The problem is that netmap, unlike
> capstone and slirp, is a library plus a kernel module. If netmap is
> not installed in the system, the --enable-netmap=git option will
> successfully build qemu with netmap support, but then -netdev netmap
> will fail at runtime.

Yes.

What happens when I build with --enable-netmap=system on host A, then
run the resulting binary on some host B that doesn't have netmap
installed?

>                       On the other end, if netmap is installed in the
> system, using the =git option may cause qemu to be built against a
> different, possibly incompatible version.

Yes.  We default to netmap=system, though.  If you break things by
passing arcane arguments to configure, you get to keep the pieces :)

> If the option is only useful for developers to check that some qemu
> change does not break anything, then probably it should be enabled in
> some other, less visible way. What do you think?

I think an --enable-netmap patterned after --enable-capstone and
--enable-slirp has sufficiently low visibility as long as the default is
sane.

We clearly want configure to pick netmap=system when the system provides
netmap.

What shall configure pick when the system doesn't provide it?  If you
think netmap=git is too dangerous for general audience, consider
disabling netmap then.  Experts can still compile-test with
--enable-netmap=git.  Our CI certainly should.

