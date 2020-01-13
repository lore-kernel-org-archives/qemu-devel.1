Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16003C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 12:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57762080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 12:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8U2xtCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57762080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqzEL-0005Q0-UF
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 07:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iqzDe-0004cs-TS
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 07:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iqzDZ-0002Wb-Tk
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 07:53:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iqzDY-0002Ut-Iz
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 07:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578919995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZp2Mp0m3jYLvi+X2RMNjmHHvxDQDdwhhLZAO8l2b/c=;
 b=b8U2xtCsdAzmiEGIs+HB1BQ7/yL3lLM5LSZQ1eQn4iEI4f53fOgu7GkPlGr0Or17Ashmrw
 72r8sCoW/350u8N5titnWGAml8K35sb/2KZB8OnF2/cuZNMF5x9pbP1SEaxvhti4jmUnra
 GmdfA5tEacdvzw1wnhlCKfdJnRUv/Ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-jIauDRo7Pf6PhRZt081pZg-1; Mon, 13 Jan 2020 07:53:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E66D5107ACC7;
 Mon, 13 Jan 2020 12:53:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7FFC60C05;
 Mon, 13 Jan 2020 12:52:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16C821138600; Mon, 13 Jan 2020 13:52:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [Qemu-devel] Maintainers,
 please tell us how to boot your machines!
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
 <3c7c7980-bb0a-c6f5-1f7d-56054190bb25@redhat.com>
 <87a7flf04y.fsf@dusky.pond.sub.org>
 <49740883-eb5a-1f6d-8dd4-9de1982aa6b1@amsat.org>
Date: Mon, 13 Jan 2020 13:52:53 +0100
In-Reply-To: <49740883-eb5a-1f6d-8dd4-9de1982aa6b1@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun, 22 Dec 2019 13:03:18
 +0100")
Message-ID: <875zhf1psq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jIauDRo7Pf6PhRZt081pZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paul Burton <pburton@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Chubb <peter.chubb@nicta.com.au>,
 Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Jia Liu <proljc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 David Hildenbrand <david@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Paul Durrant <paul.durrant@citrix.com>, Jan Kiszka <jan.kiszka@web.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>, Stafford Horne <shorne@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>,
 Thomas Huth <huth@tuxfamily.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 5/17/19 7:42 PM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>=20
>>> How do you want to proceed with all the information provided in this
>>> thread? I think a big table in the wiki collecting the answers is ideal=
.
>>> What do you think?
>>=20
>> Yes, please!  I haven't been able to find the time...
>
> I gathered all the information from this thread here:
> https://wiki.qemu.org/Testing/Acceptance#Machines
> (with a link in https://wiki.qemu.org/Testing#System_emulation).
>
> I also added other info I collected during 4.2 merge window.

Awesome.

What shall we do about the machine types that are not in this table?
Random example: nios2 machine 10m50-ghrd.

> Should we suggest a new policy that new machines must have a test?

I think that's fair.

> I'll later purpose some idea to deal with machines only running non
> opensource code.

Yes, please.

> I think most of the data from the acceptance tests we have could be
> generated (json?) and we could concat with another manual maintained
> json (or yaml to json?) to have this table easily updatable on the wiki.
> Now I remember why I had forgotten about HTML, it is painful to edit.

Also, it's prone to rot.

Generating the green rows from actual tests should avoid rot.  The other
rows need to come from somewhere else, though.

>
> Thanks all for sharing this information.
>
> Regards,
>
> Phil.


