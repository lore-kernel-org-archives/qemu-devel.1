Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49295C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F36721882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F36721882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hidAd-0002nB-Cg
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 07:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60529)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hid3S-0004CJ-36
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hid3R-0000tW-2w
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:04:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hid3P-0000mo-3G
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:03:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D5485946B;
 Wed,  3 Jul 2019 11:03:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB2317F499;
 Wed,  3 Jul 2019 11:03:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42D8C1132ABF; Wed,  3 Jul 2019 13:03:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190702113414.6896-1-armbru@redhat.com>
 <CAFEAcA9oPS2FbBgm+SQYqMbwzg+Dwmm0W9U8Vc-2LX7TmzAADg@mail.gmail.com>
 <87v9wjy9ut.fsf@dusky.pond.sub.org>
 <CAFEAcA_EJVYwkvCd+bouW5nvbiA8DzJ48pq70m6AAg=j3Dichw@mail.gmail.com>
Date: Wed, 03 Jul 2019 13:03:43 +0200
In-Reply-To: <CAFEAcA_EJVYwkvCd+bouW5nvbiA8DzJ48pq70m6AAg=j3Dichw@mail.gmail.com>
 (Peter Maydell's message of "Wed, 3 Jul 2019 11:17:43 +0100")
Message-ID: <87r277wfao.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 03 Jul 2019 11:03:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/4] Build system patches for 2019-07-02
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 3 Jul 2019 at 06:18, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > This seems to break the incremental builds (most hosts):
>> >
>> > make: Entering directory '/home/petmay01/qemu-for-merges/build/w64'
>> > make: *** No rule to make target 'subdir-slirp', needed by
>> > 'config-host.h'.  Stop.
>> > make: *** Waiting for unfinished jobs....
>> > config-host.mak is out-of-date, running configure
>> > Install prefix    c:/Program Files/QEMU
>> > [rest of configure output snipped; no other output]
>>
>> PATCH 3 changes the dependency configure writes to config-host.h like
>> this:
>>
>>      if [ "$slirp" = "git" -o "$slirp" = "internal" ]; then
>>     -    echo "config-host.h: subdir-slirp" >> $config_host_mak
>>     +    echo "config-host.h: slirp/all" >> $config_host_mak
>>      fi
>>
>> For me, make complains, reruns configure (which adjusts the dependency),
>> then happily makes everything.
>>
>> Hmm, I see.  Without -k, make stops after rerunning configure.
>>
>> Is that a problem?
>
> Yes: most people don't run 'make -k'. We should strive to avoid
> breaking incremental builds, I think they are the most common
> way developers build QEMU.

Okay.  I'll try temporary work-arounds for v2.  Thanks.

