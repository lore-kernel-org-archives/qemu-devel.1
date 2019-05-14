Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1899CC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAA62086A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAA62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39557 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQQ5F-0008Un-4e
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 01:34:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQQ3a-0007iP-MD
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQQ3Z-0001Km-Hg
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:32:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hQQ3W-0001Gd-Pl; Tue, 14 May 2019 01:32:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56BAC308AA12;
	Tue, 14 May 2019 05:32:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EAD155D706;
	Tue, 14 May 2019 05:32:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 43AD911385E4; Tue, 14 May 2019 07:32:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Jones <drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-9-drjones@redhat.com>
	<87ftpie3k9.fsf@dusky.pond.sub.org>
	<20190513183030.aap4gsxm7rbbkrbj@kamzik.brq.redhat.com>
Date: Tue, 14 May 2019 07:32:47 +0200
In-Reply-To: <20190513183030.aap4gsxm7rbbkrbj@kamzik.brq.redhat.com> (Andrew
	Jones's message of "Mon, 13 May 2019 20:30:30 +0200")
Message-ID: <874l5xa9ds.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 14 May 2019 05:32:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 08/13] target/arm/monitor: Add
 query-sve-vector-lengths
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

Andrew Jones <drjones@redhat.com> writes:

> On Mon, May 13, 2019 at 06:12:38PM +0200, Markus Armbruster wrote:
>> Andrew Jones <drjones@redhat.com> writes:
>> 
>> > Provide a QMP interface to query the supported SVE vector lengths.
>> > A migratable guest will need to explicitly specify a valid set of
>> > lengths on the command line and that set can be obtained from the
>> > list returned with this QMP command.
>> >
>> > This patch only introduces the QMP command with the TCG implementation.
>> > The result may not yet be correct for KVM. Following patches ensure
>> > the KVM result is correct.
>> >
>> > Signed-off-by: Andrew Jones <drjones@redhat.com>
>> > ---
>> >  qapi/target.json     | 34 ++++++++++++++++++++++++
>> >  target/arm/monitor.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
>> >  tests/qmp-cmd-test.c |  1 +
>> >  3 files changed, 97 insertions(+)
>> >
>> > diff --git a/qapi/target.json b/qapi/target.json
>> > index 1d4d54b6002e..ca1e85254780 100644
>> > --- a/qapi/target.json
>> > +++ b/qapi/target.json
>> > @@ -397,6 +397,40 @@
>> >  { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
>> >    'if': 'defined(TARGET_ARM)' }
>> >  
>> > +##
>> > +# @SVEVectorLengths:
>> > +#
>> > +# The struct contains a list of integers where each integer is a valid
>> 
>> Suggest to s/The struct contains/Contains/.
>
> OK
>
>> 
>> > +# SVE vector length for a KVM guest on this host. The vector lengths
>> > +# are in quadword (128-bit) units, e.g. '4' means 512 bits (64 bytes).
>> 
>> Any particular reason for counting quad-words instead of bytes, or
>> perhaps bits?
>
> It can be considered just bits here, but when set in sve-vls-map those
> bits are chosen to mean quadwords as that allows us to get up to 8192-bit
> vectors with a single 64-bit word. Maybe I should write more of that here
> to clarify.

Please do.

In general, QMP prefers the plain units over arbitrary multiples,
e.g. Byte, not Mebibyte.  Sadly, many violations of this rule have crept
in.

More complete documentation should help us determine the unit we want
here.

>> > +#
>> > +# @vls:      list of vector lengths in quadwords.
>> > +#
>> > +# Since: 4.1
>> > +##
>> > +{ 'struct': 'SVEVectorLengths',
>> > +  'data': { 'vls': ['int'] },
>> > +  'if': 'defined(TARGET_ARM)' }
>> > +
>> > +##
>> > +# @query-sve-vector-lengths:
>> > +#
>> > +# This command is ARM-only. It will return a list of SVEVectorLengths
>> 
>> No other target-specific command documents its target-specificness like
>> this.  Suggest
>
> Well, it's pretty similar to query-gic-capabilities, which is what I used
> as a template, but I'm happy to change it to whatever you suggest :)

Here's the documentation we generate for query-gic-capabilities:

 -- Command: query-gic-capabilities

     This command is ARM-only.  It will return a list of GICCapability
     objects that describe its capability bits.

     Returns: a list of GICCapability objects.

     Since: 2.6

     Example:
          -> { "execute": "query-gic-capabilities" }
          <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
                          { "version": 3, "emulated": false, "kernel": true } ] }

     If: 'defined(TARGET_ARM)'

The "If:" line is generated from the schema's condition.  It's not as
readable as I'd like it to be, but it's there, and it always matches the
code.

"This command is ARM-only" is redundant.  Escaped review.  A patch to
drop it would be welcome.

>>    # Query valid SVE vector length sets.
>> 
>> > +# objects. The list describes all valid SVE vector length sets.
>> > +#
>> > +# Returns: a list of SVEVectorLengths objects
>> > +#
>> > +# Since: 4.1
>> > +#
>> > +# -> { "execute": "query-sve-vector-lengths" }
>> > +# <- { "return": [ { "vls": [ 1 ] },
>> > +#                  { "vls": [ 1, 2 ] },
>> > +#                  { "vls": [ 1, 2, 4 ] } ] }
>> > +#
>> > +##
>> > +{ 'command': 'query-sve-vector-lengths', 'returns': ['SVEVectorLengths'],
>> > +  'if': 'defined(TARGET_ARM)' }
>> > +
>
> Yup, will do

Took me a few seconds to connect this to my "# Query valid SVE vector
length sets." line %-}

>> >  ##
>> >  # @CpuModelExpansionInfo:
>> >  #
[...]

