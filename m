Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A637BC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EA7208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EA7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQFlJ-0006DM-PR
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 14:33:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQFjJ-0005Dz-2p
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQFjH-0001cP-SZ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQFjF-0001ae-Mq; Mon, 13 May 2019 14:31:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04BA23087942;
	Mon, 13 May 2019 18:31:13 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-151.ams2.redhat.com
	[10.36.116.151])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 687405C1B4;
	Mon, 13 May 2019 18:31:10 +0000 (UTC)
Date: Mon, 13 May 2019 20:31:07 +0200
From: Andrew Jones <drjones@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190513183107.7lsndkyp2p7yhra5@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-12-drjones@redhat.com>
	<875zqefkbg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zqefkbg.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 13 May 2019 18:31:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 11/13] target/arm/cpu64: max cpu: Introduce
 sve-vls-map
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, abologna@redhat.com, qemu-arm@nongnu.org,
	alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 05:25:23PM +0200, Markus Armbruster wrote:
> Andrew Jones <drjones@redhat.com> writes:
> 
> > Introduce another cpu property to control SVE vector lengths,
> > sve-vls-map, which allows the user to explicitly select the
> > set of vector lengths the guest can use. The map must conform
> > to QEMU's limits and architectural constraints, checked when
> > the property is set. Inconsistencies with sve-max-vq are also
> > checked. The bit number of a set bit in the map represents the
> > allowed vector length in number of quadwords.
> >
> > Note, as the map is implemented with a single 64-bit word we
> > currently only support up to 8192-bit vectors. As QEMU and
> > KVM only support up to 2048-bit vectors then this sufficient
> > now, and probably for some time. Extending the bitmap beyond
> > a single word will likely require changing the property to
> > a string and adding yet another parser to QEMU.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> 
> Please add an example of how the new property should be used on the
> command line to your commit message.  I'd ask for a documentation update
> as well if we had any to update.

Will do.

Thanks,
drew

