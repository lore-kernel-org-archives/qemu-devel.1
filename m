Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC965C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B2D208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B2D208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAJk-0007Nl-1Y
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 08:44:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQAIr-000708-HL
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQAIn-0006l3-NT
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:43:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQAIj-0006gE-Rh; Mon, 13 May 2019 08:43:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E784C05B038;
	Mon, 13 May 2019 12:43:28 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-151.ams2.redhat.com
	[10.36.116.151])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B142B1001E7D;
	Mon, 13 May 2019 12:43:23 +0000 (UTC)
Date: Mon, 13 May 2019 14:43:20 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190513124320.2l2k4pwyhcxvdsba@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<CAFEAcA8vY7WVws3rOqKxsaNTDSboecOeS4DM5rdsEZHt4Lkv-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8vY7WVws3rOqKxsaNTDSboecOeS4DM5rdsEZHt4Lkv-A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 13 May 2019 12:43:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] target/arm/kvm: enable SVE in guests
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
Cc: Markus Armbruster <armbru@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Andrea Bolognani <abologna@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 10:52:06AM +0100, Peter Maydell wrote:
> On Sun, 12 May 2019 at 09:36, Andrew Jones <drjones@redhat.com> wrote:
> >
> > With the recent KVM guest SVE support pull request [1] KVM will be
> > ready for guests with SVE. This series provides the QEMU bits for
> > that enablement. The series starts with the bits needed for the KVM
> > SVE ioctls. Then it enables the arm 'max'cpu type, which with TCG
> > already supports SVE, to also support SVE when using KVM. Next
> > a new QMP query is added that allows users to ask which vector
> > lengths are supported by the host, allowing them to select a valid
> > set of vectors for the guest. In order to select those vectors a
> > new property 'sve-vls-map' is added to the 'max' cpu type, and then
> > also to the 'host' cpu type. The table below shows the resulting user
> > interfaces.
> >
> >    CPU type | accel | sve-max-vq | sve-vls-map
> >    -------------------------------------------
> >  1)     max | tcg   |  $MAX_VQ   |  $VLS_MAP
> >  2)     max | kvm   |  $MAX_VQ   |  $VLS_MAP
> >  3)    host | kvm   |  N/A       |  $VLS_MAP
> >
> > Where for (1) $MAX_VQ sets the maximum vq and smaller vqs are
> > all supported when $VLS_MAP is zero, or when the vqs are selected
> > in $VLS_MAP.
> >
> > (2) is the same as (1) except KVM has the final say on what
> > vqs are valid.
> >
> > (3) doesn't accept sve-max-vq because a guest that uses this
> > property without sve-vls-map cannot be safely migrated.
> 
> Is this "migrated between two hosts with the same host CPU
> type but with different kernel versions which expose different
> subsets of the host's permitted vector lengths" ?
>

That's one example. Also, I see attempting to make/use only migrate-safe
cpu properties for our primary KVM cpu type ('host') as a step in the
right direction to eventually making a more migratable KVM cpu type. But
I do see that (3) is a bit of an oxymoron considering the 'host' cpu
type isn't really migrate-safe unless the hosts are identical (which
should technically require the same host kernel too) anyway.

Thanks,
drew

