Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF35C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A2C2173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A2C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlH7-0000ET-Jj
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:48:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hOlFZ-0007yk-CK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hOlFY-0006rJ-3r
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:46:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hOlFX-0006qu-SC; Thu, 09 May 2019 11:46:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B37A307DAC1;
	Thu,  9 May 2019 15:46:22 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-72.brq.redhat.com [10.40.204.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5EE658821;
	Thu,  9 May 2019 15:46:18 +0000 (UTC)
Date: Thu, 9 May 2019 17:46:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190509174613.53edb606@Igors-MacBook-Pro>
In-Reply-To: <877eb173a3.fsf@dusky.pond.sub.org>
References: <20190419061429.17695-1-ehabkost@redhat.com>
	<87ftprre87.fsf@dusky.pond.sub.org>
	<20190506195321.GB28722@habkost.net>
	<877eb173a3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 09 May 2019 15:46:22 +0000 (UTC)
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
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 08 May 2019 10:34:44 +0200
Markus Armbruster <armbru@redhat.com> wrote:

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
> 
> Let's review what we have.
> 
> For all <TARGET> in target/*:
> 
> * arm i386 lm32 m68k mips moxie openrisc riscv s390x s390x tricore
>   unicore32 xtensa
> 
>   CPU type name format is <TARGET>_CPU_TYPE_NAME("%s"), which boils down
>   to:
> 
>   - arm lm32 m68k moxie riscv s390x tricore unicore32 xtensa
>     "%s-<TARGET>-cpu"
> 
>   - openrisc
>     "%s-or1k-cpu"
> 
>   - i386
>     "%s-x86_64-cpu" #ifdef TARGET_X86_64
>     "%s-i386-cpu" #else
> 
>   - mips
>     "%s-mips64-cpu" #ifdef TARGET_MIPS64
>     "%s-mips-cpu" #else
> 
>   The %s gets replaced by the user's cpu model.
> 
> * hppa microblaze nios2 tilegx
> 
>   CPU type name format is <TARGET>-cpu.  The user's cpu model seems
>   silently ignored.
> 
> * alpha cris ppc sh4 sparc
> 
>   No format, using ->class_by_name()
> 
>   - alpha
> 
>     CPU type name format is "%s-alpha-cpu".
> 
>     alpha_cpu_class_by_name() recognizes the full name, the full name
>     without "-alpha-cpu" suffix, and a bunch of aliases.
> 
>   - cris
> 
>     CPU type name format is "%s-cris-cpu".
> 
>     cris_cpu_class_by_name() recognizes the name without the "-cris-cpu"
>     suffix, plus "any" as alias for "crisv32-cris-cpu" #ifdef
>     CONFIG_USER_ONLY (this is the default CPU type for machine
>     "axis-dev88"; the other machine "none" has no default).
> 
>   - ppc
> 
>     CPU type name format is
>     "%s-powerpc64-cpu" #ifdef TARGET_PPC64
>     "%s-powerpc-cpu" #else
> 
>     ppc_cpu_class_by_name() recognizes the name without the suffix, plus
>     the CPU type's PVR (8 digit hex number), plus a bunch of (case
>     insensitive) aliases.
> 
>   - sh4
> 
>     CPU type name format is "%s-superh-cpu".
> 
>     superh_cpu_class_by_name() recognizes the name without the suffix,
>     plus "any" as alias for "sh7750r-superh-cpu" (this is the default
>     CPU type for machine "shix"; machines "r2d" defaults to "sh7751r",
>     and "none" has no default).
> 
>   - sparc
> 
>     CPU type name format is
>     "%s-sparc64-cpu" #ifdef TARGET_SPARC64
>     "%s-sparc-cpu" #else
> 
>     sparc_cpu_class_by_name() recognizes the name without the suffix,
>     mapping any spaces in the user's cpu model to '-'.
> 
> Observations:
> 
> * The CPU type name format is generally "%s-T-cpu", where T is either
>   <TARGET> or <TARGET>64.
> 
>   Exceptions:
> 
>   - openrisc, sh4 uses or1k, superh instead.  Looks pointless to me.
> 
>   - i386 uses x86_64 instead of i38664.  Makes sense.
> 
>   - hppa, microblaze, nios2 and tilegx use CPU type name format "T-cpu",
>     ignoring the user's cpu model.  These exceptions looks pointless to
>     me.
> 
> * The user's CPU model is generally the "%s" part of the format.
> 
>   Exceptions:
> 
>   - alpha additionaly recognizes full type names.  If that's useful for
>     alpha (I'm not sure it is), why isn't it useful for all other
>     targets?
> 
>   - cris and sh4 additionaly recognize an "any" alias, cris only #ifdef
>     CONFIG_USER_ONLY.
> 
>     Until PATCH 4, arm also recognizes an "any" alias #ifdef
>     CONFIG_USER_ONLY.  PATCH 4 drops that, because it's redundant with
>     the "any" CPU, which is a copy instead of an alias.  Sure we want to
>     do have different targets do "any" in different ways?
> 
>     See aliases below.
> 
>   - ppc additionaly recognizes PVR aliases and additional (case
>     insensitive) aliases.  Feels overengineered to me.  See aliases
>     below.
> 
>   - sparc additionally recognizes aliases with ' ' instead of '-'.
>     Feels pointless to me.  See aliases below.
> 
> * What about deprecating pointless exceptions?
Last time I was refactoring all this CPU name thingy, there wasn't way to deprecate anything
so I had to keep it. But I'd support deprecation in there now.

The same applies to aliases, sometimes its code even too complicated (ppc).
I'd ditch it if possible.
(added in loop PPC folks for opinions)

> 
> * Aliases
> 
>   We have several targets roll their own CPU name aliases code.
>   Assuming aliases are here to stay (i.e. we're not deprecating all of
>   them): what about letting each CPU type specify a set of aliases, so
>   we can recognize them in generic code?
> 


