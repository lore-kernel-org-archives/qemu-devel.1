Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E8C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A6020881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A6020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTSYt-0007RI-Dz
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:49:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTSTm-0003kA-1N
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTSTk-0005As-Is
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:44:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hTSTk-0004jQ-Aj
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:44:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E281A5946F;
	Wed, 22 May 2019 14:44:14 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66010611A0;
	Wed, 22 May 2019 14:44:14 +0000 (UTC)
Date: Wed, 22 May 2019 11:44:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20190522144412.GR10764@habkost.net>
References: <20190422234742.15780-1-ehabkost@redhat.com>
	<20190509133537.GK7181@orkuz.int.mamuti.net>
	<20190509135617.GH4189@habkost.net>
	<20190509180603.424c8277@Igors-MacBook-Pro>
	<20190509163618.GN7181@orkuz.int.mamuti.net>
	<20190510203203.GW4189@habkost.net>
	<20190522082741.GI2545064@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522082741.GI2545064@orkuz.int.mamuti.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 22 May 2019 14:44:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] i386: "unavailable-features" QOM
 property
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
Cc: Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 22, 2019 at 10:27:41AM +0200, Jiri Denemark wrote:
> On Fri, May 10, 2019 at 17:32:03 -0300, Eduardo Habkost wrote:
> > On Thu, May 09, 2019 at 06:36:18PM +0200, Jiri Denemark wrote:
> > > On Thu, May 09, 2019 at 18:06:03 +0200, Igor Mammedov wrote:
> > > > On Thu, 9 May 2019 10:56:17 -0300
> > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > 
> > > > > On Thu, May 09, 2019 at 03:35:37PM +0200, Jiri Denemark wrote:
> > > > > > Would this unavailable-features property contain only canonical names of
> > > > > > the features or all possible aliases of all features? For example,
> > > > > > "tsc-adjust" can also be spelled as "tsc_adjust". When calling
> > > > > > query-cpu-model-expansion, we have a way to request all variants by
> > > > > > running full expansion on the result of a previous static expansion. Can
> > > > > > we get something like this for unavailable-features too?
> > > > > 
> > > > > I'd like to avoid that, and refer only to the canonical names.
> > > > 
> > > > Can we deprecate aliases to avoid confusion in future?
> > > > (there aren't that many of them that used pre-QOM name format)
> > > 
> > > If you come up with a way libvirt could use to detect which name it
> > > should use when talking to QEMU...
> > 
> > The property names are part of the API, and deprecation would
> > just be documented in the QEMU documentation.  Why would you need
> > to enumerate them dynamically at runtime?
> 
> The tricky part is to know which variant of a particular feature name we
> should use when talking to a specific version of QEMU. But I guess we
> can use the new "unavailable-features" property for this purpose. [...]

You can run device-list-properties on the typenames returned by
query-cpu-definitions, to check which CPU properties exist in a
QEMU binary.

>                                                           [...]   When
> the property is present, we can translate all feature names to their
> canonical names (via a static translation table in libvirt). We'd be
> using the old untranslated names when talking to any QEMU which does not
> support the "unavailable-features" property.

That would help us simplify the interface between QEMU and libvirt.

> 
> But I hope we won't get into a situation when some CPU feature needs to
> be renamed again, that would make a big mess.

I promise we'll try to avoid doing that.  :)

-- 
Eduardo

