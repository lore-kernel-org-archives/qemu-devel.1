Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418F4C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1747C21848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1747C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFUf-00058q-Co
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 15:04:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFKK-0005iI-2E
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFKI-0002w7-MD
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:53:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUFKG-0002th-Pl
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:53:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 866F437EEA;
	Fri, 24 May 2019 18:53:50 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BF00B6092D;
	Fri, 24 May 2019 18:53:46 +0000 (UTC)
Date: Fri, 24 May 2019 15:53:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190524185344.GJ10764@habkost.net>
References: <87woihi1wl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87woihi1wl.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 24 May 2019 18:53:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] qapi/misc.json is too big,
 let's bite off a few chunks
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 06:14:18PM +0200, Markus Armbruster wrote:
> It's nice when QAPI schema modules clearly belong to a single subsystem
> in addition to "QAPI Schema".  misc.json doesn't, and it's grown fat:
> 3000+ lines.  Let's move out some stuff.  Here are a few candidates:
>=20
> * Dump (Marc-Andr=E9)
>=20
>   dump-guest-memory, query-dump, DUMP_COMPLETED,
>   query-dump-guest-memory-capability
>=20
>   ~200 lines.
>=20
> * Machine core (Eduardo, Marcel)
>=20
>   query-machines, query-current-machine,=20
>=20
>   ~60 lines.  Hardly worthwhile from a "let's shrink misc.json" point o=
f
>   view.  Might be worthwhile from a "let's make get_maintainers.pl
>   work".
>=20
> * CPUs (Paolo, Richard)
>=20
>   query-cpus, query-cpus-fast
>=20
>   ~300 lines.  The commands are implemented in cpus.c, which MAINTAINER=
S
>   covers both under "Main loop" and under "Guest CPU cores (TCG) /
>   Overall".  Neither feels right to me for these QMP commands.

Should it include query-cpu-* (currently on target.json),
and query-hotpluggable-cpus?

>=20
> * NUMA (Eduardo)
>=20
>   query-memdev, set-numa-node
>=20
>   ~200 lines.
>=20
> Opinions?
>=20
> Additional candidates?

QOM: qom-list, qom-get, qom-set, qom-list-properties, object-add
object-del.

--=20
Eduardo

