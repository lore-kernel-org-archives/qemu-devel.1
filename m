Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4315DC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA0320674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA0320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfNVN-0002xB-79
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hfNTi-00029H-E0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hfNTb-0003XW-5p
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:49:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hfNTN-0003Id-3g; Mon, 24 Jun 2019 07:49:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B172559473;
 Mon, 24 Jun 2019 11:49:19 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAEB919730;
 Mon, 24 Jun 2019 11:49:13 +0000 (UTC)
Date: Mon, 24 Jun 2019 13:49:11 +0200
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190624114911.xb4xdcbv55p2rufv@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-8-drjones@redhat.com>
 <20190624110526.GH2790@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624110526.GH2790@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 24 Jun 2019 11:49:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/14] target/arm/cpu64: max cpu:
 Introduce sve<vl-bits> properties
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 12:05:26PM +0100, Dave Martin wrote:
> On Fri, Jun 21, 2019 at 05:34:15PM +0100, Andrew Jones wrote:
> > Introduce cpu properties to give fine control over SVE vector lengths.
> > We introduce a property for each valid length up to the current
> > maximum supported, which is 2048-bits. The properties are named, e.g.
> > sve128, sve256, sve512, ..., where the number is the number of bits.
> > 
> > It's now possible to do something like -cpu max,sve-max-vq=4,sve384=off
> > to provide a guest vector lengths 128, 256, and 512 bits. The resulting
> > set must conform to the architectural constraint of having all power-of-2
> > lengths smaller than the maximum length present. It's also possible to
> > only provide sve<vl-bits> properties, e.g. -cpu max,sve512=on. That
> > example provides the machine with 128, 256, and 512 bit vector lengths.
> > It doesn't hurt to explicitly ask for all expected vector lengths,
> > which is what, for example, libvirt should do.
> > 
> > Note1, it is not possible to use sve<vl-bits> properties before
> > sve-max-vq, e.g. -cpu max,sve384=off,sve-max-vq=4, as supporting
> > that overly complicates the user input validation.
> > 
> > Note2, while one might expect -cpu max,sve-max-vq=4,sve512=on to be the
> > same as -cpu max,sve512=on, they are not. The former enables all vector
> > lengths 512 bits and smaller, while the latter only sets the 512-bit
> > length and its smaller power-of-2 lengths. It's probably best not to use
> > sve-max-vq with sve<vl-bits> properties, but it can't be completely
> > forbidden as we want qmp_query_cpu_model_expansion to work with guests
> > launched with e.g. -cpu max,sve-max-vq=8 on their command line.
> 
> Supporting both options together in a non-idempotent way seems to
> complicate things.
> 
> Would it be simpler to allow sve-max-vq only when there are no sve<bits>
> options?

Not really. Since we can't simply remove sve-max-vq from the 'max' cpu
type, then we'd still need conditions to check when we can use it. The
restriction that it has to come first reduces the complexity
substantially, and I think restricting to not being allowed
at all, when sve<vl-bits> are used, would only give us a net check
reduction of one or two.

> 
> Alternatively, the two options would be defined so that their meanings
> are independent of parse order.
> 
> So, way sve-max-vq=<max> means that:
> 
>  * all VQs up to max for which there is no corresponding sve<bits>=off,
>    are enabled; and
> 
>  * VQ max is enabled; and
> 
>  * all VQs exceeding max are disabled.
> 
> While sve<bits>=(on|off) means
> 
>  * the VQ coresponding to <bits> is enabled (for on) or disabled (for
>    off).
>  
> After parsing all the options, you check that the sve-max-vq and
> sve<bits> optinos are consistent.  If you disallow duplicate sve-max-vq
> or sve<bits> options, then there is no possibility of ambiguity and the
> order or options doesn't matter.

I don't want to put any final checks at the end of parsing all options,
because that won't work with the QMP query.

> 
> (There may be constraints on the way qemu options parsing works that
> make this hard, though...)

I can't think of any issue with the parsing, but the QMP query only using
the property get accessors, without any finalizing, does put constraints
on what we can do.

> 
> Having sve-max-vq in 128-bit units while sve<bits> are named in terms of
> bit counts also feels a bit odd now.

sve-max-vq already exists, so it'd have to be deprecated if we don't want
it anymore. And I think sve<vl-bits> is the right naming to go with for
that. Of course using sve-max-vq is completely optional. If you don't want
it for backward compatible reasons, or as a shorthand to restrict the
lengths, then you can just use the sve<vl-bits> properties. Indeed, with
KVM, if you use the 'host' cpu type (the default for use with KVM), then
you won't even have the sve-max-vq property. As 'host' never had it, I
didn't have to keep it, nor adopt it. And of course I didn't want to
adopt it.

Thanks,
drew

