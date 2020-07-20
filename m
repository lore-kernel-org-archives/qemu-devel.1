Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C122064B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="R5VCQGG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C122064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxTWv-0003b9-M0
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jxTVo-0002sJ-3i
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:59:13 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:42556 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jxTVm-0007wV-Do
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:59:11 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 748384C84C;
 Mon, 20 Jul 2020 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1595242747;
 x=1597057148; bh=CesAn/u6Dzc73WiC2gk9hk/UrT90ZXR2/hl3uK8pUZ8=; b=
 R5VCQGG1iJmz/ayzCXyEctdA4oqkSHFild7r/vfTikewTQp4GY4jy/eLmBSD4UWl
 klkwPAoQwYagr3A63iwFN5/vsjRf/+lHGOi2eNrjeQ+hbZH9I42OwIn+g3StqmQD
 h4TWrL8ohuTQzyKugjtpr9DqQUK95LNhJ4vbKPfaYTs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_Qh4R8RmZ-N; Mon, 20 Jul 2020 13:59:07 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id EB893412CD;
 Mon, 20 Jul 2020 13:59:06 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 20
 Jul 2020 13:59:06 +0300
Date: Mon, 20 Jul 2020 13:59:06 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v2 4/4] net/colo: Match is-enabled probe to tracepoint
Message-ID: <20200720105906.GB73320@SPB-NB-133.local>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-5-r.bolshakov@yadro.com>
 <3f6bcf74d3c348f9b7744305a6343a79@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f6bcf74d3c348f9b7744305a6343a79@intel.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 06:50:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 18, 2020 at 05:58:56PM +0000, Zhang, Chen wrote:
> > -----Original Message-----
> > From: Roman Bolshakov <r.bolshakov@yadro.com>
> > Sent: Friday, July 17, 2020 5:35 PM
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
> I think change the " trace_event_get_state_backends()" to "trace_colo_compare_main("Dump packet hex: ")" is a better choice here.
> It will keep the original code logic and avoid the problem here.
> 

Hi Chen,

Do you mean to use another is-enabled probe?
e.g. change from
"if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))"
to
"if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MAIN))"

Thanks,
Roman

