Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7554FC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 19:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4016021726
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 19:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4016021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOSXE-00007l-BR
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 15:47:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOSWL-00089Y-W0
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hOSWK-0003hQ-T4
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:46:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hOSWJ-0003XG-8c
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:46:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD58AC05D271;
	Wed,  8 May 2019 19:46:24 +0000 (UTC)
Received: from localhost (ovpn-116-61.gru2.redhat.com [10.97.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 07FCE62671;
	Wed,  8 May 2019 19:46:23 +0000 (UTC)
Date: Wed, 8 May 2019 16:46:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190508194622.GD4189@habkost.net>
References: <20190419061429.17695-1-ehabkost@redhat.com>
	<87ftprre87.fsf@dusky.pond.sub.org>
	<20190506195321.GB28722@habkost.net>
	<877eb173a3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eb173a3.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 08 May 2019 19:46:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/7] Delete 16 *_cpu_class_by_name()
 functions
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 08, 2019 at 10:34:44AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Mon, May 06, 2019 at 01:53:28PM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> > This series adds a new CPUClass::class_name_format field, which
> >> > allows us to delete 16 of the 21 *_cpu_class_by_name() functions
> >> > that exist today.
> >> 
> >> Which five remain, and why?
> >
> > alpha_cpu_class_by_name:
> > * Translates aliases based on alpha_cpu_aliases;
> > * Falls back to "ev67" unconditionally
> >   (there's a "TODO: remove match everything nonsense" comment).
> >
> > cris_cpu_class_by_name:
> > * Translates "any" alias to "crisv32" if CONFIG_USER_ONLY.
> >
> > ppc_cpu_class_by_name:
> > * Supports lookup by PVR if CPU model is a 8 digit hex number;
> > * Converts CPU model to lowercase.
> >
> > superh_cpu_class_by_name:
> > * Translates "any" alias to TYPE_SH7750R_CPU.
> >
> > sparc_cpu_class_by_name:
> > * Replaces whitespaces with '-' on CPU model name.
> 
> I'm of course asking because I wonder whether we can dumb down this CPU
> naming business to something simpler and more regular.

We can, but that's not on my list of priorities.  Any volunteers?

> 
[...]
> * Aliases
> 
>   We have several targets roll their own CPU name aliases code.
>   Assuming aliases are here to stay (i.e. we're not deprecating all of
>   them): what about letting each CPU type specify a set of aliases, so
>   we can recognize them in generic code?

Yes.  I considered adding alias support to generic code, but
decided to do this one step at a time.

-- 
Eduardo

