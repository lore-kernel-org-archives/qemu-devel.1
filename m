Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D97C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB77216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB77216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48515 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOc37-0003zR-JI
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 01:56:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOc2C-0003Hq-NO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOc2A-00025L-LX
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:56:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hOc29-000237-MK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:55:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58AD0307EA8E;
	Thu,  9 May 2019 05:55:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 006D01001DE7;
	Thu,  9 May 2019 05:55:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 89C081132B35; Thu,  9 May 2019 07:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190419061429.17695-1-ehabkost@redhat.com>
	<87ftprre87.fsf@dusky.pond.sub.org>
	<20190506195321.GB28722@habkost.net>
	<877eb173a3.fsf@dusky.pond.sub.org>
	<20190508194622.GD4189@habkost.net>
Date: Thu, 09 May 2019 07:55:52 +0200
In-Reply-To: <20190508194622.GD4189@habkost.net> (Eduardo Habkost's message of
	"Wed, 8 May 2019 16:46:22 -0300")
Message-ID: <87bm0c893r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 09 May 2019 05:55:54 +0000 (UTC)
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
	Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, May 08, 2019 at 10:34:44AM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > On Mon, May 06, 2019 at 01:53:28PM +0200, Markus Armbruster wrote:
>> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> >> 
>> >> > This series adds a new CPUClass::class_name_format field, which
>> >> > allows us to delete 16 of the 21 *_cpu_class_by_name() functions
>> >> > that exist today.
>> >> 
>> >> Which five remain, and why?
>> >
>> > alpha_cpu_class_by_name:
>> > * Translates aliases based on alpha_cpu_aliases;
>> > * Falls back to "ev67" unconditionally
>> >   (there's a "TODO: remove match everything nonsense" comment).
>> >
>> > cris_cpu_class_by_name:
>> > * Translates "any" alias to "crisv32" if CONFIG_USER_ONLY.
>> >
>> > ppc_cpu_class_by_name:
>> > * Supports lookup by PVR if CPU model is a 8 digit hex number;
>> > * Converts CPU model to lowercase.
>> >
>> > superh_cpu_class_by_name:
>> > * Translates "any" alias to TYPE_SH7750R_CPU.
>> >
>> > sparc_cpu_class_by_name:
>> > * Replaces whitespaces with '-' on CPU model name.
>> 
>> I'm of course asking because I wonder whether we can dumb down this CPU
>> naming business to something simpler and more regular.
>
> We can, but that's not on my list of priorities.  Any volunteers?

Fair enough.  Except for...

>> 
> [...]
>> Observations:
>> 
>> * The CPU type name format is generally "%s-T-cpu", where T is either
>>   <TARGET> or <TARGET>64.
>> 
>>   Exceptions:
>> 
>>   - openrisc, sh4 uses or1k, superh instead.  Looks pointless to me.
>> 
>>   - i386 uses x86_64 instead of i38664.  Makes sense.
>> 
>>   - hppa, microblaze, nios2 and tilegx use CPU type name format "T-cpu",
>>     ignoring the user's cpu model.  These exceptions looks pointless to
>>     me.
>> 
>> * The user's CPU model is generally the "%s" part of the format.
>> 
>>   Exceptions:
>> 
>>   - alpha additionaly recognizes full type names.  If that's useful for
>>     alpha (I'm not sure it is), why isn't it useful for all other
>>     targets?
>> 
>>   - cris and sh4 additionaly recognize an "any" alias, cris only #ifdef
>>     CONFIG_USER_ONLY.
>> 
>>     Until PATCH 4, arm also recognizes an "any" alias #ifdef
>>     CONFIG_USER_ONLY.  PATCH 4 drops that, because it's redundant with
>>     the "any" CPU, which is a copy instead of an alias.  Sure we want to
>>     do have different targets do "any" in different ways?
>> 
>>     See aliases below.
>> 
>>   - ppc additionaly recognizes PVR aliases and additional (case
>>     insensitive) aliases.  Feels overengineered to me.  See aliases
>>     below.
>> 
>>   - sparc additionally recognizes aliases with ' ' instead of '-'.
>>     Feels pointless to me.  See aliases below.

... this, perhaps:

>> * What about deprecating pointless exceptions?

Deprecating unwanted stuff now is likely to make a later cleanup so much
easier.

>> * Aliases
>> 
>>   We have several targets roll their own CPU name aliases code.
>>   Assuming aliases are here to stay (i.e. we're not deprecating all of
>>   them): what about letting each CPU type specify a set of aliases, so
>>   we can recognize them in generic code?
>
> Yes.  I considered adding alias support to generic code, but
> decided to do this one step at a time.

Okay.  Consider adding suitable TODO comments.

