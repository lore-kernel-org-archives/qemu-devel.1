Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF400C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6FD2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ye6BkY0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6FD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3H3U-0003NN-0p
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3H2m-0002st-TN
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:53:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29977
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3H2k-0007w4-MO
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596624789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQQ21fegludhCy34Y4t7bGKV4uBZE6+fYnXwlbH/Scw=;
 b=Ye6BkY0JQgCjRbbCL/2pVa+AwFGHzoZYYRP39lmRv33sSSxMT5C+sq5Fk+Pymm7xZgiKfI
 tGXM09aAruOfzHhZuf00SkrsQeQZv81OcGu07oYt7oAhGfIcTFreTJbfO5B6JuPrUY6PCP
 vPQoDFiXxzIgFMZ+M68LzR1khOcf35w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-kut9K-ToPhG_q2W42CydwQ-1; Wed, 05 Aug 2020 06:53:04 -0400
X-MC-Unique: kut9K-ToPhG_q2W42CydwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D1FF801A03;
 Wed,  5 Aug 2020 10:53:03 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6C4C5DA6A;
 Wed,  5 Aug 2020 10:53:02 +0000 (UTC)
Date: Wed, 5 Aug 2020 11:53:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v2 4/4] net/colo: Match is-enabled probe to tracepoint
Message-ID: <20200805105301.GE361702@stefanha-x1.localdomain>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-5-r.bolshakov@yadro.com>
 <3f6bcf74d3c348f9b7744305a6343a79@intel.com>
 <20200721140657.GI843362@redhat.com>
 <20200729123322.GB34804@SPB-NB-133.local>
 <20200729123452.GD3451141@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200729123452.GD3451141@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Daniel Berrange <berrange@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2020 at 01:34:52PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jul 29, 2020 at 03:33:22PM +0300, Roman Bolshakov wrote:
> > On Tue, Jul 21, 2020 at 03:06:57PM +0100, Daniel P. Berrang=E9 wrote:
> > > On Sat, Jul 18, 2020 at 05:58:56PM +0000, Zhang, Chen wrote:
> > > >=20
> > > >=20
> > > > > -----Original Message-----
> > > > > From: Roman Bolshakov <r.bolshakov@yadro.com>
> > > > > Sent: Friday, July 17, 2020 5:35 PM
> > > > > To: qemu-devel@nongnu.org
> > > > > Cc: Daniel P. Berrang=E9 <berrange@redhat.com>; Stefan Hajnoczi
> > > > > <stefanha@redhat.com>; Cameron Esfahani <dirty@apple.com>; Roman
> > > > > Bolshakov <r.bolshakov@yadro.com>; Philippe Mathieu-Daud=E9
> > > > > <philmd@redhat.com>; Zhang, Chen <chen.zhang@intel.com>; Li Zhiji=
an
> > > > > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>
> > > > > Subject: [PATCH v2 4/4] net/colo: Match is-enabled probe to trace=
point
> > > > >=20
> > > > > Build of QEMU with dtrace fails on macOS:
> > > > >=20
> > > > >   LINK    x86_64-softmmu/qemu-system-x86_64
> > > > > error: probe colo_compare_miscompare doesn't exist
> > > > > error: Could not register probes
> > > > > ld: error creating dtrace DOF section for architecture x86_64
> > > > >=20
> > > > > The reason of the error is explained by Adam Leventhal [1]:
> > > > >=20
> > > > >   Note that is-enabled probes don't have the stability magic so I=
'm not
> > > > >   sure how things would work if only is-enabled probes were used.
> > > > >=20
> > > > > net/colo code uses is-enabled probes to determine if other probes=
 should be
> > > > > used but colo_compare_miscompare itself is not used explicitly.
> > > > > Linker doesn't include the symbol and build fails.
> > > > >=20
> > > > > The issue can be resolved if is-enabled probe matches the actual =
trace point
> > > > > that is used inside the test. Packet dump toggle is replaced with=
 a compile-
> > > > > time conditional definition.
> > > > >=20
> > > > > 1. http://markmail.org/message/6grq2ygr5nwdwsnb
> > > > >=20
> > > > > Fixes: f4b618360e ("colo-compare: add TCP, UDP, ICMP packet compa=
rison")
> > > > > Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > > > Cc: Cameron Esfahani <dirty@apple.com>
> > > > > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > > > > ---
> > > > >  net/colo-compare.c    | 42 ++++++++++++++++++++++---------------=
-----
> > > > >  net/filter-rewriter.c | 10 ++++++++--
> > > > >  net/trace-events      |  2 --
> > > > >  3 files changed, 30 insertions(+), 24 deletions(-)
> > >=20
> > >=20
> > > > > (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> > > > > {
> > > > > +    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_IP_INF=
O))
> > > > > {
> > > > >          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec=
_ip_dst[20];
> > > > >=20
> > > > >          strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src)); @@ -492=
,12 +494,12
> > > > > @@ sec:
> > > > >          g_queue_push_head(&conn->primary_list, ppkt);
> > > > >          g_queue_push_head(&conn->secondary_list, spkt);
> > > > >=20
> > > > > -        if
> > > > > (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> > > > > {
> > > > > -            qemu_hexdump((char *)ppkt->data, stderr,
> > > > > -                        "colo-compare ppkt", ppkt->size);
> > > > > -            qemu_hexdump((char *)spkt->data, stderr,
> > > > > -                        "colo-compare spkt", spkt->size);
> > > > > -        }
> > > > > +#ifdef DEBUG_COLO_PACKETS
> > > > > +        qemu_hexdump((char *)ppkt->data, stderr,
> > > > > +                     "colo-compare ppkt", ppkt->size);
> > > > > +        qemu_hexdump((char *)spkt->data, stderr,
> > > > > +                     "colo-compare spkt", spkt->size); #endif
> > > > >=20
> > > > >          colo_compare_inconsistency_notify(s);
> > > > >      }
> > > > > @@ -533,12 +535,12 @@ static int colo_packet_compare_udp(Packet *=
spkt,
> > > > > Packet *ppkt)
> > > > >                                      ppkt->size - offset)) {
> > > > >          trace_colo_compare_udp_miscompare("primary pkt size", pp=
kt->size);
> > > > >          trace_colo_compare_udp_miscompare("Secondary pkt size", =
spkt-
> > > > > >size);
> > > > > -        if
> > > > > (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> > > > > {
> > > > > -            qemu_hexdump((char *)ppkt->data, stderr, "colo-compa=
re pri pkt",
> > > > > -                         ppkt->size);
> > > > > -            qemu_hexdump((char *)spkt->data, stderr, "colo-compa=
re sec pkt",
> > > > > -                         spkt->size);
> > > > > -        }
> > > > > +#ifdef DEBUG_COLO_PACKETS
> > > > > +        qemu_hexdump((char *)ppkt->data, stderr, "colo-compare p=
ri pkt",
> > > > > +                     ppkt->size);
> > > > > +        qemu_hexdump((char *)spkt->data, stderr, "colo-compare s=
ec pkt",
> > > > > +                     spkt->size);
> > > > > +#endif
> > > >=20
> > > > Hi Roman,
> > > >=20
> > > > I think change the " trace_event_get_state_backends()" to
> > > > "trace_colo_compare_main("Dump packet hex: ")" is a better choice h=
ere.
> > > > It will keep the original code logic and avoid the problem here.
> > >=20
> > > That may workaround the immediate bug, but this is still a misuse of =
the
> > > tracing code. Use of any trace point should only trigger actions in t=
he
> > > trace infrastructure.
> > >=20
> > > If I'm using dtrace backend to monitor events I don't want to see QEM=
U
> > > dumping stuff to stderr. Anything written to stderr is going to trigg=
er
> > > disk I/O writing to the VM's logfile, and is also liable to trigger r=
ate
> > > limiting which can impact the guest performance.
> > >=20
> >=20
> > Hi Daniel, Chen, Stefan,
> >=20
> > So, what do we want to do about the series? Do we have an agreement? Is
> > the patch okay or I should make a change?
>=20
> I think your current patch here should be merged as is, as it is removing
> the mis-use of the trace infrastructure.

Hi Zhang Chen,
Do you agree?

Thanks,
Stefan

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8qj40ACgkQnKSrs4Gr
c8iXJQgApbDwWL05v1KrYgvjSfne/6oaCcgiutHfGYdbfZIAW4G6vzErJ/nIiCgU
Snt1fExEQmn4Ka5COihuDtcLl5wAUQSftMODEKSTYgUDuIq1bFJHXHxzNMPb/3Uq
etZRvcqbgZOjTVwkKMOU7rEOCFy7B6Xr0BDihXKPfH7zZAIfkbC3dRs+pTJb0g18
5VF6uw4roRwVdrX4BkBK4+iHq0NPVqR0JvhAibNAYRjrCmEyKmCbyvTc35XaAstw
D4pAhnk2EV2GwP8JeiNGkDO8xa+A0Pvf/UxEPgQaC6GKnPIRcFpKSVz6CHuzsWjF
qbM+fPV+iPz7AUA73NAhqS9CDD/iAg==
=YmhW
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--


