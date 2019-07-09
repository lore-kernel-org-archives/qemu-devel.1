Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B3AC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8831A216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8831A216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkjkw-0006Zz-Qt
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 02:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkjk5-0006BB-Km
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkjk4-0001Cs-M0
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkjk4-0001CA-Fg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:36:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05E229FDFB
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2019 06:36:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C864482772;
 Tue,  9 Jul 2019 06:36:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40FA21138648; Tue,  9 Jul 2019 08:36:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-8-armbru@redhat.com>
 <20190620084158.GI25448@redhat.com>
 <87ef3jrzxc.fsf@dusky.pond.sub.org>
 <20190708225410.GA5198@habkost.net>
Date: Tue, 09 Jul 2019 08:36:35 +0200
In-Reply-To: <20190708225410.GA5198@habkost.net> (Eduardo Habkost's message of
 "Mon, 8 Jul 2019 19:54:10 -0300")
Message-ID: <87v9wb90jw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 09 Jul 2019 06:36:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/17] MAINTAINERS: Merge sections CPU,
 NUMA into Machine core
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
Cc: kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Jun 24, 2019 at 01:22:07PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Wed, Jun 19, 2019 at 10:10:40PM +0200, Markus Armbruster wrote:
>> >> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> >> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >> ---
>> >>  MAINTAINERS | 16 ++++------------
>> >>  1 file changed, 4 insertions(+), 12 deletions(-)
>> >
>> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> >
>> >>=20
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index 1aef0afaf7..f18fddbbbb 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -1268,8 +1268,12 @@ S: Supported
>> >>  F: hw/core/machine.c
>> >>  F: hw/core/null-machine.c
>> >>  F: hw/cpu/cluster.c
>> >> +F: numa.c
>> >> +F: qom/cpu.c
>> >
>> > Not a blocker for this patch, but as a later patch, I'd encourage you =
to
>> > move qom/cpu.c somewhere else. Pretty much anywhere else would be bett=
er
>> > than under qom/ IMHO :-)
>>=20
>> Eduardo, any ideas?
>
> Sorry for the late reply.  I suggest hw/core/cpu.c.

Can do.  Also: include/qom/cpu.h -> include/hw/core/cpu.h.

There's also hw/cpu/ and include/hw/cpu/.  I presume they are less
suited than hw/core and include/hw/core/.

