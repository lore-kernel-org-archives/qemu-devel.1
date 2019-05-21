Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F025C04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AF02173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AF02173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53922 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT4tC-0001VX-R8
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 09:33:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hT4rQ-0000NV-3c
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hT4rP-0005DK-10
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:31:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hT4rO-0005CC-RP; Tue, 21 May 2019 09:31:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B70E9820E9;
	Tue, 21 May 2019 13:31:11 +0000 (UTC)
Received: from gondolin (ovpn-204-120.brq.redhat.com [10.40.204.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 83F141001F5B;
	Tue, 21 May 2019 13:31:08 +0000 (UTC)
Date: Tue, 21 May 2019 15:31:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190521153104.403980b3.cohuck@redhat.com>
In-Reply-To: <CAFEAcA_9QZRyx8_8qT208vsopquW5j-bkyZpmRCAhP-sqJ+0kg@mail.gmail.com>
References: <20190521092048.28492-1-cohuck@redhat.com>
	<CAFEAcA_9QZRyx8_8qT208vsopquW5j-bkyZpmRCAhP-sqJ+0kg@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 21 May 2019 13:31:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 00/54] s390x update
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 14:24:07 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 21 May 2019 at 10:20, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > [Note: I'm only sending the changed headers update to spare everybody another
> > patch avalanche. The remainder of the patches is unchanged, save for the
> > changed commit ids of the cpumodel patches on top of the headers update.]
> >
> > The following changes since commit d8276573da58e8ce78dab8c46dd660efd664bcb7:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510' into staging (2019-05-16 13:15:08 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/cohuck/qemu tags/s390x-20190521-2
> >
> > for you to fetch changes up to 4d727d1aa0e5cbf9f5f00968698dfa34c7b47b08:
> >
> >   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines (2019-05-21 10:40:03 +0200)
> >
> > ----------------------------------------------------------------
> > s390x update:
> > - have the bios tolerate bootmap signature entries
> > - next chunk of vector instruction support in tcg
> > - a headers update against Linux 5.2-rc1
> > - add more facilities and gen15 machines to the cpu model  
> 
> Hi -- looks like the update-linux-headers change isn't quite right:
> 
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -122,6 +122,9 @@ for arch in $ARCHLIST; do
>          cp "$tmpdir/include/asm/unistd-oabi.h" "$output/linux-headers/asm-arm/"
>          cp "$tmpdir/include/asm/unistd-common.h"
> "$output/linux-headers/asm-arm/"
>      fi
> +    if [ $arch = arm64 ]; then
> +        cp "$tmpdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm/"
> +    fi
>      if [ $arch = x86 ]; then
>          cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
>          cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
> 
> ...it's copying the file into asm-arm/ rather than asm-arm64/.
> (I did a by-hand move of the file into the right directory and
> that was sufficient for the compile to succeed.)

I'm obviously not at my best at the moment :(

> 
> Also, can we keep the changes to scripts/ in a separate
> commit, please? The idea of header-update commits is that they
> should contain only the changes automatically generated
> by the script, with no hand-written additions.

This looks a bit like a chicken-and-egg problem, though... without the
change, we cannot point the script at a current kernel tree. I'd prefer
the two to stay together, but I can certainly point out the change to
the script more prominently.

