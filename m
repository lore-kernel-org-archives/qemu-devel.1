Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F16C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC46A20733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbXuH05h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC46A20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIuEC-0006N0-NS
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIuDV-0005YK-Nq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIuDU-00010p-Lo
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:12:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIuDU-00010T-IR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585573956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTZ2LUO/CtzNPU0vtP4VThmFD2Xb1FCDx37WXOgxlIc=;
 b=RbXuH05hyw2P8gwc6rcQi1uH0jpD0Jwda/dEV7b/G96Xo4vkArbP4LDsol/JxGDisUu7n4
 ho1bJpzq9NvGyw0nFhaki1/TXKg6USM3EsoZRYW/PtnsNcIWuwu30jMECVWaMfF37+oQMg
 Sn++ZRIn3zsgfFb1qi8pfDVrD0FOgjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-Q6K9og6QMn-vfnhuXp1RzA-1; Mon, 30 Mar 2020 09:12:34 -0400
X-MC-Unique: Q6K9og6QMn-vfnhuXp1RzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 284E618A5516;
 Mon, 30 Mar 2020 13:12:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1BC910027BC;
 Mon, 30 Mar 2020 13:12:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6352611385E2; Mon, 30 Mar 2020 15:12:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC 2/2] qapi: Make section headings start a new doc
 comment block
References: <20200320091805.5585-1-armbru@redhat.com>
 <20200320091805.5585-3-armbru@redhat.com>
 <CAFEAcA-dToo-PDpkJ_R6=y0=x9u7KK5mChKwU+_bhx73sDuWpA@mail.gmail.com>
Date: Mon, 30 Mar 2020 15:12:31 +0200
In-Reply-To: <CAFEAcA-dToo-PDpkJ_R6=y0=x9u7KK5mChKwU+_bhx73sDuWpA@mail.gmail.com>
 (Peter Maydell's message of "Mon, 23 Mar 2020 09:28:41 +0000")
Message-ID: <87369qvveo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 20 Mar 2020 at 09:18, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> Our current QAPI doc-comment markup allows section headers (introduced
>> with a leading '=3D' or '=3D=3D') anywhere in a free-form documentation
>> comment.  This works for Texinfo because the generator simply prints a
>> Texinfo section command at that point in the output stream.  For rST
>> generation, since we're assembling a tree of docutils nodes, this is
>> awkward because a new section implies starting a new section node at
>> the top level of the tree and generating text into there.
>>
>> Make section headers start a new free-form documentation block, so the
>> future rST document generator doesn't have to look at every line in
>> free-form blocks and handle headings in odd places.
>>
>> This change makes no difference to the generated Texinfo.
>
> I think this does make things easier for rST generation
> (which now can say "if the first line in the freeform doc
> is a section heading, do section heading stuff, discard that
> line, process rest of freeform doc as normal"), so on
> that basis I like it.

Good.

> I do kind of think it would be overall nicer to go further and
> say "section headings are special and not part of free-form doc
> comments at all" (both for the doc-comment author by mandating
> that they be standalone, and for the consumer of parsed info
> by separating section headings out from free-form doc comment
> rather than requiring the consumer to say "is this line heading
> syntax?"), but that would be more change, so pragmatically
> I'm happy if we just do what this patch suggests.

I think there are two separate issues: doc comment syntax and internal
representation.

Our internal representation reflects the input's flat structure: one
comment block after the other.  I wish it reflected the document's tree
structure instead, but I can't justify the effort to rework it.

What to put into syntax and what to leave to style is often debatable.
Putting headings into their own block makes them stand out even more,
which may be useful.  Baking that into the syntax feels a bit oppressive
to me.  Sometimes a bit of oppression can buy enough consistency to be
worth it.

Thanks!


