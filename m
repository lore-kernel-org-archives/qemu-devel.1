Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C93DC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CA520823
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CA520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdWnK-0006Nw-6o
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33871)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdWkD-0003n2-Dg
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdWkC-0006Cd-6X
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:19:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hdWkB-0006A7-Ou
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:19:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD3AD309703F
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 09:18:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB4675D9D6;
 Wed, 19 Jun 2019 09:18:53 +0000 (UTC)
Date: Wed, 19 Jun 2019 11:18:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190619091852.GA15551@linux.fritz.box>
References: <20190617184903.19436-1-armbru@redhat.com>
 <20190617184903.19436-17-armbru@redhat.com>
 <20190618090153.GE28525@redhat.com>
 <20190618103449.GE4296@localhost.localdomain>
 <87lfxy5b4p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87lfxy5b4p.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 19 Jun 2019 09:18:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 16/16] vl: Deprecate -mon pretty=... for HMP
 monitors
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.06.2019 um 08:42 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 18.06.2019 um 11:01 hat Daniel P. Berrang=E9 geschrieben:
> >> On Mon, Jun 17, 2019 at 08:49:03PM +0200, Markus Armbruster wrote:
> >> > From: Kevin Wolf <kwolf@redhat.com>
> >> >=20
> >> > The -mon pretty=3Don|off switch of the -mon option applies only to=
 QMP
> >> > monitors. It's silently ignored for HMP. Deprecate this combinatio=
n so
> >> > that we can make it an error in future versions.
> >>=20
> >> No objection to merging this PR as is, but how about we extend the
> >> deprecation to QMP too ?
> >>=20
> >> I was responsible for adding this option back in 2010 and I don't
> >> think I've used it since 2012 when I added pretty printing support
> >> to scripts/qmp/qmp-shell. I struggle to imagine good reasons for
> >> using QMP directly with pretty printing, as opposed to doing it
> >> via qmp-shell or another wrapper tool.
> >
> > qemu-iotests uses it. It doesn't only make the output (and espeically
> > diffs on failure) much more readable, but in fact also avoids very lo=
ng
> > lines in the refernce output that used to break patch emails when we
> > didn't use pretty printing yet.
> >
> > So let's keep it for QMP, please.
>=20
> Perhaps we can get rid of it if we find a suitable filter.
>=20
> Hmm, Python comes with one: "python -m json.tool".  It expects just one
> expression, and fails if anything follows:
>=20
>     $ printf '{"execute": "qmp_capabilities"}\n{"execute": "query-versi=
on"}\n' | socat UNIX:/work/armbru/images/test-qmp STDIO | python3 -m json=
.tool
>     Extra data: line 2 column 1 (char 134)
>=20
> To pretty print a sequence of expressions, you have to wrap a loop
> around it:
>=20
>     $ printf '{"execute": "qmp_capabilities"}\n{"execute": "query-versi=
on"}\n' | socat UNIX:/work/armbru/images/test-qmp STDIO | { while read li=
ne; do echo "$line" | python3 -m json.tool; done; }

Yes, it's doable. It's not a very nice command line, but it does its
job.

What do we win by removing pretty printing from qemu? We invest some
work doing the patches, reviewing them, etc. and save the whole
complexity of adding a few newlines and spaces to an already existing
string buffer in a single place (qjson.c).

In exchange, we have to add the above overlong command line to every
qemu-iotests case for which pretty printed QMP is useful, and lose the
ability to just do -qmp-pretty stdio manually (which I do every now and
then) instead of having to dig up the above line in some script to copy
it.

It doesn't look like a net win to me.

> I figure we'd want to loop in Python instead of shell.
>=20
> My point is: pretty-printing is trivial in Python.  The case for
> maintaining C code to do it seems weak.

The pretty printing is fairly trivial in C, too, when you already
generate JSON. The code seems to have been last touched in 2014, and
before that in 2010 when it was introduced. The maintenance burden
doesn't seem to be that bad.

Removing features that have users can be justified sometimes, but it
does need a justification, in my opinion.

Kevin

