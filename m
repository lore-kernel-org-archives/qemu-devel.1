Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6BFC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FA72075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FA72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYQOi-0003ey-2V
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 03:31:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hYQNq-0003Dw-9l
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hYQNm-0008RK-GH
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:30:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hYQNW-00082Q-KY; Wed, 05 Jun 2019 03:30:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B071230860A4;
	Wed,  5 Jun 2019 07:30:20 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 41BE460C61;
	Wed,  5 Jun 2019 07:30:14 +0000 (UTC)
Date: Wed, 5 Jun 2019 09:30:12 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190605073012.nh5wprpjqoi5e4v4@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-3-drjones@redhat.com>
	<c2756de5-be71-45f8-8ca4-bf9f594d525d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2756de5-be71-45f8-8ca4-bf9f594d525d@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 05 Jun 2019 07:30:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/13] update-linux-headers: Add
 sve_context.h to asm-arm64
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, abologna@redhat.com, qemu-arm@nongnu.org,
	alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 09:21:18AM +0200, Auger Eric wrote:
> Hi,
> 
> On 5/12/19 10:36 AM, Andrew Jones wrote:
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  scripts/update-linux-headers.sh | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> > index c3819d2b983d..e1fce54f8aa3 100755
> > --- a/scripts/update-linux-headers.sh
> > +++ b/scripts/update-linux-headers.sh
> > @@ -99,6 +99,9 @@ for arch in $ARCHLIST; do
> >          cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
> >      done
> >  
> > +    if [ $arch = arm64 ]; then
> > +        cp "$tmpdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm64/"
> > +    fi
> >      if [ $arch = mips ]; then
> >          cp "$tmpdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mips/"
> >          cp "$tmpdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-mips/"
> > 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>

Thanks, but I noticed we don't need this anymore. Not since b1b9e0dc78a8e
applied an identical patch. I've dropped this from the v2 I'm working on
now.

Thanks,
drew

