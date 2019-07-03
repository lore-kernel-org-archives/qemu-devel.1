Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9052C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817BD21850
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817BD21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higIP-0005n2-GH
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1higGx-0005D8-Sp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1higGw-0005el-CE
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:30:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54127)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1higGw-0005eK-2c
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:30:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61F77A3B60;
 Wed,  3 Jul 2019 14:30:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 711B9832B4;
 Wed,  3 Jul 2019 14:30:03 +0000 (UTC)
Date: Wed, 3 Jul 2019 15:30:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190703143001.GE23082@redhat.com>
References: <20190703135411.28436-1-berrange@redhat.com>
 <43fe3646-1ee5-238e-3f0b-dc0b2e976b6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43fe3646-1ee5-238e-3f0b-dc0b2e976b6e@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 03 Jul 2019 14:30:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] doc: document that the monitor console is
 a privileged control interface
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, P J P <ppandit@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 03, 2019 at 04:24:26PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 7/3/19 3:54 PM, Daniel P. Berrang=C3=A9 wrote:
> > A supposed exploit of QEMU was recently announced as CVE-2019-12928
> > claiming that the monitor console was insecure because the "migrate"
> > comand enabled arbitrary command execution for a remote attacker.
> >=20
> > For this to be a flaw the user launching QEMU must have configured
> > the monitor in a way that allows for other userrs to access it. The
> > exploit report quoted use of the "tcp" character device backend for
> > QMP.
> >=20
> > This would indeed allow any network user to connect to QEMU and
> > execute arbitrary comamnds, however, this is not a flaw in QEMU.
>=20
> comamnds -> commands
>=20
> > It is the normal expected behaviour of the monitor console and the
> > commands it supports. Given a monitor connection, there are many
> > ways to access host filesystem content besides the migrate command.
> >=20
> > The reality is that the monitor console (whether QMP or HMP) is
> > considered a privileged interface to QEMU and as such must only
> > be made available to trusted users. IOW, making it available with
> > no authentication over TCP is simply a, very serious, user
> > configuration error not a security flaw in QEMU itself.
> >=20
> > The one thing this bogus security report highlights though is that
> > we have not clearly documented the security implications around the
> > use of the monitor. Add a few paragraphs of text to the security
> > docs explaining why the monitor is a privileged interface and making
> > a recommendation to only use the UNIX socket character device backend=
.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  docs/security.texi | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >=20
> > diff --git a/docs/security.texi b/docs/security.texi
> > index 927764f1e6..5bff01449d 100644
> > --- a/docs/security.texi
> > +++ b/docs/security.texi
> > @@ -129,3 +129,39 @@ those resources that were granted to it.
> >  system calls that are not needed by QEMU, thereby reducing the host =
kernel
> >  attack surface.
> >  @end itemize
> > +
> > +@section Sensitive configurations
> > +
> > +There are aspects of QEMU that can have non-obvious security implica=
tions
> > +which users & management applications must be aware of.
> > +
> > +@subsection Monitor console (QMP and HMP)
> > +
> > +The monitor console (whether used with QMP or HMP) provides an RPC i=
nterface
> > +to dynamically control many aspects of QEMU's runtime operation. Man=
y of the
> > +commands exposed will instruct QEMU to access content on the host fi=
lesysystem
> > +and/or trigger spawning of external processes.
> > +
> > +For example, the @code{migrate} command allows for the spawning of a=
rbitrary
> > +processes for the purpose of tunnelling the migration data stream. T=
he
> > +@code{blockdev-add} command instructs QEMU to open arbitrary files, =
exposing
> > +their content to the guest as a virtual disk.
> > +
> > +Unless QEMU is otherwise confined using technologies such as SELinux=
, AppArmor,
> > +or Linux namespaces, the monitor console should be considered to hav=
e privileges
> > +equivalent to those of the user account QEMU is running under.
> > +
> > +It is further important to consider the security of the character de=
vice backend
> > +over which the monitor console is exposed. It needs to have protecti=
on against
> > +malicious third parties which might try to make unauthorized connect=
ions, or
> > +perform man-in-the-middle attacks. Many of the character device back=
ends do not
> > +satisfy this requirement and so must not be used for the monitor con=
sole.
> > +
> > +The general recommendation is that the monitor console should be exp=
osed over
> > +a UNIX domain socket backend to the local host only. Use of the TCP =
based
> > +character device backend is inappropriate unless configured to use b=
oth TLS
> > +encryption and authorization control policy on client connections.
> > +
> > +In summary the monitor console is considered a privileged control in=
terface to
>=20
> I'd have written "In summary, " or "In summary: " but I'm not sure this
> is correct/better ;)

Using a comma is a reasonable thing here.

>=20
> > +QEMU and as such should only be made accessible to a trusted managem=
ent
> > +application or user.
> >=20
>=20
> Thanks for writing this down.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

