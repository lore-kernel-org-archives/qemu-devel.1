Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2CB20684
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYIGCDra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2CB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxswD-0006JN-Eg
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxsvW-0005tm-BS
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:07:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24748
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxsvU-0000XJ-Ce
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595340443;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EUbbsUqChOX1WGI6qBsYhiiD7PAFWYMM4cQGQTuCQ4=;
 b=JYIGCDraTmbOuYHtYjldo6Bb2ia3gmVtWshcg2E/JLukg7s2sD+r/D/TUfIhVgSHV+7+2e
 J7Wdzfe8xyXc2GiZ/eX8TT+S1mdtIwbqrOVKiMvA0DjPFO8Y5zdGE5IT+2HF30m4xellNA
 oqzqhRMif4gUh5yrzHkCTR2CLe6Xpz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-A-m6P0tEPy-s9u_KAo0wvQ-1; Tue, 21 Jul 2020 10:07:07 -0400
X-MC-Unique: A-m6P0tEPy-s9u_KAo0wvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2923215DA0;
 Tue, 21 Jul 2020 14:07:06 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF86861983;
 Tue, 21 Jul 2020 14:07:00 +0000 (UTC)
Date: Tue, 21 Jul 2020 15:06:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v2 4/4] net/colo: Match is-enabled probe to tracepoint
Message-ID: <20200721140657.GI843362@redhat.com>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-5-r.bolshakov@yadro.com>
 <3f6bcf74d3c348f9b7744305a6343a79@intel.com>
MIME-Version: 1.0
In-Reply-To: <3f6bcf74d3c348f9b7744305a6343a79@intel.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 18, 2020 at 05:58:56PM +0000, Zhang, Chen wrote:
> 
> 
> > -----Original Message-----
> > From: Roman Bolshakov <r.bolshakov@yadro.com>
> > Sent: Friday, July 17, 2020 5:35 PM
> > To: qemu-devel@nongnu.org
> > Cc: Daniel P. Berrangé <berrange@redhat.com>; Stefan Hajnoczi
> > <stefanha@redhat.com>; Cameron Esfahani <dirty@apple.com>; Roman
> > Bolshakov <r.bolshakov@yadro.com>; Philippe Mathieu-Daudé
> > <philmd@redhat.com>; Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>
> > Subject: [PATCH v2 4/4] net/colo: Match is-enabled probe to tracepoint
> > 
> > Build of QEMU with dtrace fails on macOS:
> > 
> >   LINK    x86_64-softmmu/qemu-system-x86_64
> > error: probe colo_compare_miscompare doesn't exist
> > error: Could not register probes
> > ld: error creating dtrace DOF section for architecture x86_64
> > 
> > The reason of the error is explained by Adam Leventhal [1]:
> > 
> >   Note that is-enabled probes don't have the stability magic so I'm not
> >   sure how things would work if only is-enabled probes were used.
> > 
> > net/colo code uses is-enabled probes to determine if other probes should be
> > used but colo_compare_miscompare itself is not used explicitly.
> > Linker doesn't include the symbol and build fails.
> > 
> > The issue can be resolved if is-enabled probe matches the actual trace point
> > that is used inside the test. Packet dump toggle is replaced with a compile-
> > time conditional definition.
> > 
> > 1. http://markmail.org/message/6grq2ygr5nwdwsnb
> > 
> > Fixes: f4b618360e ("colo-compare: add TCP, UDP, ICMP packet comparison")
> > Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Cc: Cameron Esfahani <dirty@apple.com>
> > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > ---
> >  net/colo-compare.c    | 42 ++++++++++++++++++++++--------------------
> >  net/filter-rewriter.c | 10 ++++++++--
> >  net/trace-events      |  2 --
> >  3 files changed, 30 insertions(+), 24 deletions(-)


> > (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> > {
> > +    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_IP_INFO))
> > {
> >          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
> > 
> >          strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src)); @@ -492,12 +494,12
> > @@ sec:
> >          g_queue_push_head(&conn->primary_list, ppkt);
> >          g_queue_push_head(&conn->secondary_list, spkt);
> > 
> > -        if
> > (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> > {
> > -            qemu_hexdump((char *)ppkt->data, stderr,
> > -                        "colo-compare ppkt", ppkt->size);
> > -            qemu_hexdump((char *)spkt->data, stderr,
> > -                        "colo-compare spkt", spkt->size);
> > -        }
> > +#ifdef DEBUG_COLO_PACKETS
> > +        qemu_hexdump((char *)ppkt->data, stderr,
> > +                     "colo-compare ppkt", ppkt->size);
> > +        qemu_hexdump((char *)spkt->data, stderr,
> > +                     "colo-compare spkt", spkt->size); #endif
> > 
> >          colo_compare_inconsistency_notify(s);
> >      }
> > @@ -533,12 +535,12 @@ static int colo_packet_compare_udp(Packet *spkt,
> > Packet *ppkt)
> >                                      ppkt->size - offset)) {
> >          trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
> >          trace_colo_compare_udp_miscompare("Secondary pkt size", spkt-
> > >size);
> > -        if
> > (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> > {
> > -            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
> > -                         ppkt->size);
> > -            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
> > -                         spkt->size);
> > -        }
> > +#ifdef DEBUG_COLO_PACKETS
> > +        qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
> > +                     ppkt->size);
> > +        qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
> > +                     spkt->size);
> > +#endif
> 
> Hi Roman,
> 
> I think change the " trace_event_get_state_backends()" to
> "trace_colo_compare_main("Dump packet hex: ")" is a better choice here.
> It will keep the original code logic and avoid the problem here.

That may workaround the immediate bug, but this is still a misuse of the
tracing code. Use of any trace point should only trigger actions in the
trace infrastructure.

If I'm using dtrace backend to monitor events I don't want to see QEMU
dumping stuff to stderr. Anything written to stderr is going to trigger
disk I/O writing to the VM's logfile, and is also liable to trigger rate
limiting which can impact the guest performance.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


