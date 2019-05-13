Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C806C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE41206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE41206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAFm-0005Fz-L8
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 08:40:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQAEW-0004WA-34
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQAEU-0004eP-TW
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:39:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQAES-0004dL-77; Mon, 13 May 2019 08:39:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C40C30821FF;
	Mon, 13 May 2019 12:39:03 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-151.ams2.redhat.com
	[10.36.116.151])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 86F2D1001E7D;
	Mon, 13 May 2019 12:39:00 +0000 (UTC)
Date: Mon, 13 May 2019 14:38:57 +0200
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190513123857.xjgwnkdlizdunlpz@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<9f57bfa56715b3128c1823150457ddb866e6054c.camel@redhat.com>
	<20190513111555.GC28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513111555.GC28398@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 13 May 2019 12:39:03 +0000 (UTC)
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	Andrea Bolognani <abologna@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 12:15:56PM +0100, Dave Martin wrote:
> On Mon, May 13, 2019 at 10:32:46AM +0100, Andrea Bolognani wrote:
> > On Sun, 2019-05-12 at 10:36 +0200, Andrew Jones wrote:
> > [...]
> > >    CPU type | accel | sve-max-vq | sve-vls-map
> > >    -------------------------------------------
> > >  1)     max | tcg   |  $MAX_VQ   |  $VLS_MAP
> > >  2)     max | kvm   |  $MAX_VQ   |  $VLS_MAP
> > >  3)    host | kvm   |  N/A       |  $VLS_MAP
> > > 
> > > Where for (1) $MAX_VQ sets the maximum vq and smaller vqs are
> > > all supported when $VLS_MAP is zero, or when the vqs are selected
> > > in $VLS_MAP.
> > 
> > I'm a bit confused by the nomenclature here. VL clearly stands for
> > Vector Length, but what does VQ stand for? You seem to be using the
> > two terms pretty much interchangeably throughout the cover letter.
> 
> From the Linux end, "vector length" or VL refers to the size of a vector
> register, either in no particular unit or in bytes.
> 
> "VQ" refers specifically to the vector length in 128-bit quadwords.
> 
> In some situations, neither terminology is obviously better than the
> other, such as in the way KVM_REG_ARM64_SVE_VLS is encoded.
> 
> > [...]
> > > There is never any need to provide both properties, but if both
> > > are provided then they are checked for consistency.
> > 
> > I would personally just error out when both are provided.
> > 
> > > The QMP query returns a list of valid vq lists. For example, if
> > > a guest can use vqs 1, 2, 3, and 4, then the following list will
> > > be returned
> > > 
> > >  [ [ 1 ], [ 1, 2 ], [ 1, 2, 3 ], [ 1, 2, 3, 4 ] ]
> > > 
> > > Another example might be 1, 2, 4, as the architecture states 3
> > > is optional. In that case the list would be
> > > 
> > >  [ [ 1 ], [ 1, 2 ], [ 1, 2, 4 ] ]
> > 
> > I think the proposed QMP command is problematic, because it reports
> > the valid vector lengths for either KVM or TCG based on which
> > accelerator is currently enabled: it should report all information
> > at all times instead, similarly to how query-gic-capabilities does
> > it.
> 
> I wonder if this is premature flexibility?
> 
> The size of these lists is going to get cumbersome if the architecture
> is ever extended.  Even today, we might need over 100 items in this
> (nested) list.  If this is to be presented to the user this will be
> far from friendly, it could get much worse if the architecutre changes
> in future to allow larger vectors or more flexible virtualisation.
> 
> Could we just have a list of supported vector lengths and a possibly
> empty list of additional capabilities that describe what kinds of
> flexibility are allowed?
> 
> So, for example, we might support vector lengths of 1, 2, 4 and 8
> quadwords, with the the ability to clamp the max vector length the
> guest sees: the kernel ABI guarantees that you can do this, even
> if you can't disable/enable each individual vector length independently.
> 
> So, [ 1, 2, 4, 8 ] seems sufficient to describe this in a forwards
> compatible way.
> 
> Some day, we might report { "independent", [ 1, 2, 4, 8, 16, 32, ... ] }
> 
> I'm guessing about the data representation here.
> 

I think that could work, and something along those lines even crossed my
mind. Let's see what libvirt folk say. I'm not overly concerned about
user friendless here though, as users aren't running QMP commands and
parsing json by hand too much.

Thanks,
drew


