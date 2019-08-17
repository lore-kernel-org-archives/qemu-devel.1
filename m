Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEA5C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 05:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09C72173B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 05:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09C72173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyrNG-000679-4f
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 01:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1hyrMX-0005Yv-F3
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 01:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hyrMV-0005hV-NR
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 01:34:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hyrMV-0005hC-GW
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 01:34:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45509806CD;
 Sat, 17 Aug 2019 05:34:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EFED90C41;
 Sat, 17 Aug 2019 05:34:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA9B410E6CCA; Sat, 17 Aug 2019 07:34:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-4-ehabkost@redhat.com>
 <87pnl5sks3.fsf@dusky.pond.sub.org>
 <20190816074932.GK13569@beluga.usersys.redhat.com>
 <87h86hpae5.fsf@dusky.pond.sub.org>
 <20190816174241.GE3908@habkost.net>
Date: Sat, 17 Aug 2019 07:34:41 +0200
In-Reply-To: <20190816174241.GE3908@habkost.net> (Eduardo Habkost's message of
 "Fri, 16 Aug 2019 14:42:41 -0300")
Message-ID: <8736i0iccu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Sat, 17 Aug 2019 05:34:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] pc: Don't make CPU properties
 mandatory unless necessary
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
Cc: Yash Mankad <ymankad@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Like Xu <like.xu@linux.intel.com>, Erik Skultety <eskultet@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>,
 "Danilo C. L. de Paula" <ddepaula@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Aug 16, 2019 at 02:22:58PM +0200, Markus Armbruster wrote:
>> Erik Skultety <eskultet@redhat.com> writes:
>> 
>> > On Fri, Aug 16, 2019 at 08:10:20AM +0200, Markus Armbruster wrote:
>> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> >>
>> >> > We have this issue reported when using libvirt to hotplug CPUs:
>> >> > https://bugzilla.redhat.com/show_bug.cgi?id=1741451
>> >> >
>> >> > Basically, libvirt is not copying die-id from
>> >> > query-hotpluggable-cpus, but die-id is now mandatory.
>> >>
>> >> Uh-oh, "is now mandatory": making an optional property mandatory is an
>> >> incompatible change.  When did we do that?  Commit hash, please.
>> >>
>> >> [...]
>> >>
>> >
>> > I don't even see it as being optional ever - the property wasn't even
>> > recognized before commit 176d2cda0de introduced it as mandatory.
>> 
>> Compatibility break.
>> 
>> Commit 176d2cda0de is in v4.1.0.  If I had learned about it a bit
>> earlier, I would've argued for a last minute fix or a revert.  Now we
>> have a regression in the release.
>> 
>> Eduardo, I think this fix should go into v4.1.1.  Please add cc:
>> qemu-stable.
>
> I did it in v2.
>
>> 
>> How can we best avoid such compatibility breaks to slip in undetected?
>> 
>> A static checker would be nice.  For vmstate, we have
>> scripts/vmstate-static-checker.py.  Not sure it's used.
>
> I don't think this specific bug would be detected with a static
> checker.  "die-id is mandatory" is not something that can be
> extracted by looking at QOM data structures.  The new rule was
> being enforced by the hotplug handler callbacks, and the hotplug
> handler call tree is a bit complex (too complex for my taste, but
> I digress).

QOM does too much in code.  Turing tarpit.

> We could have detected this with a simple CPU hotplug automated
> test case, though.  Or with a very simple -device test case like
> the one I have submitted with this patch.

The external QOM interface is huge.  Even if we had an army of
industrious gnomes writing simple test cases for all of it, we'd still
need a fleet of machines to actually run them, and at least a batallion
of gnomes to maintain them.

The extremely basic qom-test gobbles up a painful amount of CPU cycles
already:

$ time for i in `find bld/*-softmmu -maxdepth 1 -name qemu-system-\* -perm /u+x`; do QTEST_QEMU_BINARY=$i bld/tests/qom-test; done
/aarch64/qom/versatileab: OK
[260 lines of the form name/of/test: OK omitted...]
/xtensaeb/qom/lx60: OK

real	3m33.001s
user	2m18.081s
sys	1m31.809s

> This was detected by libvirt automated test cases.  It would be

Nice.

> nice if this was run during the -rc stage and not only after the
> 4.1.0 release, though.

We don't always get lucky.

> I don't know details of the test job.  Danilo, Mirek, Yash: do
> you know how this bug was detected, and what we could do to run
> the same test jobs in upstream QEMU release candidates?

Thinking about how to make the best use of the tests we have is in
order.

