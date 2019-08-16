Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B120C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 18:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4E22077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 18:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kM/MXhgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4E22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hygt0-0008Ce-3D
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 14:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hygq4-0007ei-Pk
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hygq3-0001hZ-FM
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:20:36 -0400
Received: from mout.web.de ([212.227.15.3]:44659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hygq3-0001gL-3X
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565979610;
 bh=JDfhIzb9J58E6cI38r2EQYf4Qz2YFCr2E3z843HDURM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=kM/MXhgbQcgQddhlCO/giTHsurhkVL8ycXbE8Q9Rqr0h7+GJm8214l6jM0eXKovCq
 9SUbcI0wJ3sdZY5Z4Pg9Zm8o1dIdAkKlXBy53VtiUy9Ionq0k0jfPTHzNPaYAX7HLR
 kNyMHu3KOvH6E6lfnWYhwf3RDtmUhPI1fGcrOTv0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.77]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lal0y-1iiitl2vWK-00kRhq; Fri, 16
 Aug 2019 20:20:09 +0200
Date: Fri, 16 Aug 2019 20:20:07 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <20190816202007.5577756b@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D780621F1B6@shsmsx102.ccr.corp.intel.com>
References: <20190815200815.2cffc21b@luklap> <20190815185737.GC2883@work-vm>
 <20190815214804.69e4334f@luklap>
 <9CFF81C0F6B98A43A459C9EDAD400D780621F1B6@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CnRsyoIO+p5p335u4c2tF5FAk3MCscL1Qp879B9yn110jEJKX7Q
 f9hpN//VRK4IJUuv8wOou/ZDlUzAOU1KMg4zmWH5WvAiub2eZryYoEAXNZE9O6iT2jNQ8xq
 vjb92DW45w5xTCeeCvZU0gY7R9EMH+Fc6s1jsrX5uAqpZkTh7UnsavBhDBEy5rhyfiejsNr
 57+dd6Ypv+pRRX45cl4mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7KIcbYGv3+0=:C7hZXYjHh4viqBwUoYdzE1
 D7NE0uQ6h0VIBJWRzEVxs2THpmezwXqO9vNtbHikBDJq0XzLfivprnbQV8+bFzUSD1ErE6aAl
 ylYzPQeatIm8t7Pf/AZPJt/26lmqwd7xqSGplvNINwyDY+KA90I7RoDxj6h8oZpvwzNwelpBv
 tlk2pY7tT/D1jX6a8I7GKeOtSirPhA7z101w0niCuFqddE03DU0QphoWGDuWnt1Rins4YanTn
 Ypb66Unc7p+zKKKk7VEzuNw8ksXOu3AKtCEyCFi8a+ALuzx8IQQ6Heq31bltnCZWKzFgpl2lq
 +EXA2dY4VWrygzYQVYK+4CqCceXsBOW2xJsndTK3WDhHtVnHMfxx4FW1YN9BFfOTjLjrlIq4J
 dvhMGTXbKoKZSM1F2H8pl5gdWv4Krl+Ukkb6Kc0jQR2sdRXOPiE4J5sfuf3syldvWeE5rYE+3
 NL3mv3SGD2fv/MSmfTdc2bUz7cisTnZS9MkRHHSr6lmR48ceA6FM7gp/hjQVP6fyYEvq6riLu
 JiJW+69R/Gjpx36mGFXcn5YO43ngOQma/LCE41JYPDQy6xeCl7tPsQXAGZh87pCywkUCNcsxs
 WGtuQvqAFBxYmKZHwPa4yEdr14zWRyQtXPuDFlReE5UPyMUfZYWeoXzsZFzGDTu18BabLxCEZ
 hXxhZMA9k/BvVJKq7V3u5SH5vryme9EkXqjzOcZc5GcXsDOcNNBD/NwgTz+v3aFsOG2yEqok1
 LjQI301Rfsoi0SBx0AZ1C9/4BhDjP+NdxO5uGeQOu0tcjzsQIxAvDBqmD4wWG6TqhjGVBgp3b
 i5cDcSL4z99zizdVyf9d+OWblgVAEOE46UUb0r6+TKZoSafChihcE6Vm5xDiB46CxevH4XgCg
 D39boeEl0p6GDYm9F6N4tO+1N6hia0o6dyznV2kBVeTlpw1LoEz7E1gLUBR6X1hbH/EnmRZnz
 WFmRJgqnf5PUlpat7Czvh0jqs0Y1ycRLidasRF9t39n1iYrQgWpOoGfxC05K01Dt4rPKrugq8
 FfvZR+w7NvyHXi3U/nxDfntlPx/4bvTv21iHi6EU1vptQThh1/7+wPR9S4lx3/vco6QEkRut4
 YUkh8XAvV6gFReBpIcwqsfIdUz5RQ+tj1Pi0TzOOA4Wm9e7wK6fTKzkN5XQ2kPw/Wq4q3XnlN
 EUewPMNzjf0lKPCJcceF4flDut2eAwVXDf1ytoMcaUS9+B3g==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.3
Subject: Re: [Qemu-devel] [PATCH v2 0/3] colo: Add support for continious
 replication
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
Cc: Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Aug 2019 01:51:20 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub [mailto:lukasstraub2@web.de]
> > Sent: Friday, August 16, 2019 3:48 AM
> > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: qemu-devel <qemu-devel@nongnu.org>; Zhang, Chen
> > <chen.zhang@intel.com>; Jason Wang <jasowang@redhat.com>; Xie
> > Changlong <xiechanglong.d@gmail.com>; Wen Congyang
> > <wencongyang2@huawei.com>
> > Subject: Re: [Qemu-devel] [PATCH v2 0/3] colo: Add support for contini=
ous
> > replication
> >
> > On Thu, 15 Aug 2019 19:57:37 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >
> > > * Lukas Straub (lukasstraub2@web.de) wrote:
> > > > Hello Everyone,
> > > > These Patches add support for continious replication to colo.
> > > > Please review.
> > >
> > >
> > > OK, for those who haven't followed COLO for so long; 'continuous
> > > replication' is when after the first primary fails, you can promote
> > > the original secondary to a new primary and start replicating again;
> > >
> > > i.e. current COLO gives you
> > >
> > > p<->s
> > >     <primary fails>
> > >     s
> > >
> > > with your patches you can do
> > >
> > >     s becomes p2
> > >     p2<->s2
> > >
> > > and you're back to being resilient again.
> > >
> > > Which is great; because that was always an important missing piece.
> > >
> > > Do you have some test scripts/setup for this - it would be great to
> > > automate some testing.
> >
> > My Plan is to write a Pacemaker Resource Agent[1] for qemu-colo and th=
en do
> > some long-term testing in my small cluster here. Writing standalone te=
sts using
> > that Resource Agent should be easy, it just needs to be provided with =
the right
> > arguments and environment Variables.
>
> Thanks Dave's explanation.
> It looks good for me and I will test this series in my side.
>
> Another question: Is "Pacemaker Resource Agent[1] "  like a heartbeat mo=
dule?

It's a bit more than that. Pacemaker itself is an Cluster Resource Manager=
, you can think of it like sysvinit but for clusters. It controls where in=
 the cluster Resources run, what state (master/slave) and what to do in ca=
se of a Node or Resource failure. Now Resources can be anything like SQL-S=
erver, Webserver, VM, etc. and Pacemaker itself doesn't directly control t=
hem, that's the Job of the Resource Agents. So a Resource Agent is like an=
 init-script, but cluster-aware with more actions like start, stop, monito=
r, promote (to master) or migrate-to.

> I have wrote an internal heartbeat module running on Qemu, it make COLO =
can detect fail and trigger failover automatically, no need external APP t=
o call the QMP command "x-colo-lost-heartbeat". If you need it, I can send=
 a RFC version recently.

Cool, this should be faster to failover than with Pacemaker.
What is the plan with cases like Primary-failover, which need to issue mul=
tiple commands?

> Thanks
> Zhang Chen
> >
> > Regards,
> > Lukas Straub
> >
> > [1] https://github.com/ClusterLabs/resource-agents/blob/master/doc/dev=
-guides/ra-dev-guide.asc#what-is-a-resource-agent


