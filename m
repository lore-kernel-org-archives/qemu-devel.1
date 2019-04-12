Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DCC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79EF2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79EF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hErQ0-0002pw-0Q
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 04:20:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1hErP6-0002Qv-Dz
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1hErP5-000856-F4
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:19:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1hErP5-00083p-4s
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:19:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FB6558E48;
	Fri, 12 Apr 2019 08:19:17 +0000 (UTC)
Received: from beluga.usersys.redhat.com (unknown [10.43.2.166])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 647EA19728;
	Fri, 12 Apr 2019 08:19:14 +0000 (UTC)
Date: Fri, 12 Apr 2019 10:19:12 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190412081912.GC16137@beluga.usersys.redhat.com>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
	<7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
	<869394fb-7b3d-cc01-7329-e931a260e73c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <869394fb-7b3d-cc01-7329-e931a260e73c@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 12 Apr 2019 08:19:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
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
Cc: Laszlo Ersek <lersek@redhat.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412081912.nCDCNhWck0-D-QVGSF5grUfAPfvx3ivpUy530sBdlbw@z>

On Fri, Apr 12, 2019 at 09:45:02AM +0200, Paolo Bonzini wrote:
> On 11/04/19 21:02, Singh, Brijesh wrote:
> >
> >
> > On 4/11/19 1:10 PM, Laszlo Ersek wrote:
> >> On 04/11/19 19:59, Singh, Brijesh wrote:
> >>> There are limited numbers of the SEV guests that can be run concurr=
ently.
> >>> A management applications may need to know this limit so that it ca=
n place
> >>> SEV VMs on hosts which have suitable resources available.
> >>>
> >>> Currently, this limit is not exposed to the application. Add a new
> >>> 'sev-max-guest' field in the query-sev-capabilities to provide this
> >>> information.
> >>>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Cc: Markus Armbruster <armbru@redhat.com>
> >>> Cc: Eric Blake <eblake@redhat.com>
> >>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>> Cc: Laszlo Ersek <lersek@redhat.com>
> >>> Cc: Erik Skultety <eskultet@redhat.com>
> >>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> >>> ---
> >>>   qapi/target.json  | 6 ++++--
> >>>   target/i386/sev.c | 6 ++++--
> >>>   2 files changed, 8 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/qapi/target.json b/qapi/target.json
> >>> index 1d4d54b600..b45121d30b 100644
> >>> --- a/qapi/target.json
> >>> +++ b/qapi/target.json
> >>> @@ -183,7 +183,8 @@
> >>>     'data': { 'pdh': 'str',
> >>>               'cert-chain': 'str',
> >>>               'cbitpos': 'int',
> >>> -            'reduced-phys-bits': 'int'},
> >>> +            'reduced-phys-bits': 'int',
> >>> +            'sev-max-guests': 'int'},
> >>
> >> Would it be useful to make this new field optional? E.g. if it was
> >> missing, libvirtd could assume "no limit".
> >>
> >
> > I am not sure if we need to make this field optional - mainly because
> > in SEV context hardware will always have some limits (at least in
> > foreseeable future). The architecture provides us a CPUID to query
> > this capabilities so I am assuming that future CPUs will populate
> > some values in it.
>
> Since this field is not specific to guest configuration, I don't think
> it belongs in query-sev-capabilities; QEMU does not care about >1 guest=
.

Neither pdh nor cert-chain are specific to the guest config. I see why th=
is
should be better suited for query-sev, the same goes for libvirt - I thin=
k we
shouldn't have gone with reporting the SEV platform caps in domain capabi=
lities,
we should have IMHO report it both in the host capabilities (platform spe=
cific
stuff) and in domain capabilities to indicate that both libvirt and QEMU
support the SEV feature. Having said that, we have a precedent which I th=
ink
we might be better off with following rather than splitting the informati=
on
among multiple commands.

Regards,
Erik

