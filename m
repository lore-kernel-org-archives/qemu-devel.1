Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3910C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30192067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30192067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1CJ-00021r-MH
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iK1Ag-00014k-6X
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iK1Af-0006j5-0j
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:18:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iK1Ab-0006hj-AO; Mon, 14 Oct 2019 10:17:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 949255859E;
 Mon, 14 Oct 2019 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DA205C28C;
 Mon, 14 Oct 2019 14:17:48 +0000 (UTC)
Date: Mon, 14 Oct 2019 16:17:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/5] iotests: Skip "make check-block" if QEMU does not
 support virtio-blk
Message-ID: <20191014141747.GG7173@localhost.localdomain>
References: <20191011145047.19051-1-thuth@redhat.com>
 <20191011145047.19051-5-thuth@redhat.com>
 <20191014112126.GF7173@localhost.localdomain>
 <d82aa777-e193-a484-980a-d0152989e920@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82aa777-e193-a484-980a-d0152989e920@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 14 Oct 2019 14:17:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.10.2019 um 13:27 hat Thomas Huth geschrieben:
> On 14/10/2019 13.21, Kevin Wolf wrote:
> > Am 11.10.2019 um 16:50 hat Thomas Huth geschrieben:
> >> The next patch is going to add some python-based tests to the "auto"
> >> group, and these tests require virtio-blk to work properly. Running
> >> iotests without virtio-blk likely does not make too much sense anyway,
> >> so instead of adding a check for the availability of virtio-blk to each
> >> and every test (which does not sound very appealing), let's rather add
> >> a check for this at the top level in the check-block.sh script instead
> >> (so that it is possible to run "make check" without the "check-block"
> >> part for qemu-system-tricore for example).
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  tests/check-block.sh | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tests/check-block.sh b/tests/check-block.sh
> >> index 679aedec50..7582347ec2 100755
> >> --- a/tests/check-block.sh
> >> +++ b/tests/check-block.sh
> >> @@ -26,10 +26,24 @@ if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null ; then
> >>      exit 0
> >>  fi
> >>  
> >> -if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
> >> +if [ -n "$QEMU_PROG" ]; then
> >> +    qemu_prog="$QEMU_PROG"
> >> +else
> >> +    for binary in *-softmmu/qemu-system-* ; do
> >> +        if [ -x "$binary" ]; then
> >> +            qemu_prog="$binary"
> >> +            break
> >> +        fi
> > 
> > Wouldn't it be better to check the availability of virtio-blk here, so
> > that if the current binary doesn't support it, we keep searching and
> > maybe pick up a different binary that supports it?
> 
> That's a good idea, indeed, but then I also need to adjust the code in
> the "check" script accordingly.

I see. If this just copies the logic that qemu-iotests already uses, I
think I would be okay with taking it as is for now.

> > Or actually, should we work with a whitelist?
> 
> I don't think that a hard-coded list will work well: Since we introduced
> the Kconfig build system, it's now possible for example to also build an
> qemu-system-aarch64 binary that does not contain any of the boards that
> support virtio. So while virtio-blk is available by default in
> qemu-system-aarch64, some builds might not contain it.

Hm, good point. I'm just worried that the default config will end up
running the tests on a machine type where it works, but if you use the
wrong set of configure options, you end up with a setup where 'make
check' fails because it uses a machine type that the iotests don't
support.

Kevin

