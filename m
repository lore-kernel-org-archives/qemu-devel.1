Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEBC3A59E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A753E2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A753E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybHF-0001IR-JU
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 08:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1hybGB-0000hF-VB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hybG9-0005xq-UG
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hybG9-0005xK-PR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:23:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA446C04FFE0;
 Fri, 16 Aug 2019 12:23:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 215517DA53;
 Fri, 16 Aug 2019 12:23:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67EAC10E6CCA; Fri, 16 Aug 2019 14:22:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-4-ehabkost@redhat.com>
 <87pnl5sks3.fsf@dusky.pond.sub.org>
 <20190816074932.GK13569@beluga.usersys.redhat.com>
Date: Fri, 16 Aug 2019 14:22:58 +0200
In-Reply-To: <20190816074932.GK13569@beluga.usersys.redhat.com> (Erik
 Skultety's message of "Fri, 16 Aug 2019 09:49:32 +0200")
Message-ID: <87h86hpae5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 16 Aug 2019 12:23:08 +0000 (UTC)
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
Cc: Peter Krempa <pkrempa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Like Xu <like.xu@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Erik Skultety <eskultet@redhat.com> writes:

> On Fri, Aug 16, 2019 at 08:10:20AM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>
>> > We have this issue reported when using libvirt to hotplug CPUs:
>> > https://bugzilla.redhat.com/show_bug.cgi?id=1741451
>> >
>> > Basically, libvirt is not copying die-id from
>> > query-hotpluggable-cpus, but die-id is now mandatory.
>>
>> Uh-oh, "is now mandatory": making an optional property mandatory is an
>> incompatible change.  When did we do that?  Commit hash, please.
>>
>> [...]
>>
>
> I don't even see it as being optional ever - the property wasn't even
> recognized before commit 176d2cda0de introduced it as mandatory.

Compatibility break.

Commit 176d2cda0de is in v4.1.0.  If I had learned about it a bit
earlier, I would've argued for a last minute fix or a revert.  Now we
have a regression in the release.

Eduardo, I think this fix should go into v4.1.1.  Please add cc:
qemu-stable.

How can we best avoid such compatibility breaks to slip in undetected?

A static checker would be nice.  For vmstate, we have
scripts/vmstate-static-checker.py.  Not sure it's used.

