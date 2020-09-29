Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A42C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09E6207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaxBqxzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09E6207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNG2H-00014e-Fn
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNG13-0000Tm-Oq
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kNG0y-0002ol-WB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:50:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601387395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2EDcwo/GW93AbMsozV3g6GE45QuCtBnpVFWjGfrNe8=;
 b=aaxBqxzbbJS3tQ2Hxif04JMJ1JDAc47mbYiJn9ZV/t+IoDXAB1elYHj4II20krBXHtED2o
 EpEyP46kHqqJHoliEh/gZ16dCPcJvBLi544qCdxciZ0PRt7w8VD8p0YoLhBLRRfz2SUb73
 jTGTzXO42x4ZboAkUGi4ZNbx/EJwe2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-GKrcjiCENNas9fTXcnMJ7w-1; Tue, 29 Sep 2020 09:49:51 -0400
X-MC-Unique: GKrcjiCENNas9fTXcnMJ7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2CB1102121B;
 Tue, 29 Sep 2020 13:49:49 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-167.rdu2.redhat.com [10.10.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87AA978831;
 Tue, 29 Sep 2020 13:49:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id E6207220203; Tue, 29 Sep 2020 09:49:42 -0400 (EDT)
Date: Tue, 29 Sep 2020 09:49:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: virtiofs vs 9p performance(Re: tools/virtiofs: Multi threading
 seems to hurt performance)
Message-ID: <20200929134942.GC220516@redhat.com>
References: <20200918213436.GA3520@redhat.com> <66718708.HdZnNlUTFG@silver>
 <20200929130325.GA220516@redhat.com> <2302525.O3mciSdnpG@silver>
MIME-Version: 1.0
In-Reply-To: <2302525.O3mciSdnpG@silver>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Venegas Munoz, Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 qemu-devel@nongnu.org, "cdupontd@redhat.com" <cdupontd@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Shinde, Archana M" <archana.m.shinde@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 03:28:06PM +0200, Christian Schoenebeck wrote:
> On Dienstag, 29. September 2020 15:03:25 CEST Vivek Goyal wrote:
> > On Sun, Sep 27, 2020 at 02:14:43PM +0200, Christian Schoenebeck wrote:
> > > On Freitag, 25. September 2020 20:51:47 CEST Dr. David Alan Gilbert wrote:
> > > > * Christian Schoenebeck (qemu_oss@crudebyte.com) wrote:
> > > > > On Freitag, 25. September 2020 15:05:38 CEST Dr. David Alan Gilbert 
> wrote:
> > > > > > > > 9p ( mount -t 9p -o trans=virtio kernel /mnt
> > > > > > > > -oversion=9p2000.L,cache=mmap,msize=1048576 ) test: (g=0):
> > > > > > > > rw=randrw,
> > > > > > > 
> > > > > > > Bottleneck ------------------------------^
> > > > > > > 
> > > > > > > By increasing 'msize' you would encounter better 9P I/O results.
> > > > > > 
> > > > > > OK, I thought that was bigger than the default;  what number should
> > > > > > I
> > > > > > use?
> > > > > 
> > > > > It depends on the underlying storage hardware. In other words: you
> > > > > have to
> > > > > try increasing the 'msize' value to a point where you no longer notice
> > > > > a
> > > > > negative performance impact (or almost). Which is fortunately quite
> > > > > easy
> > > > > to test on>
> > > > > 
> > > > > guest like:
> > > > > 	dd if=/dev/zero of=test.dat bs=1G count=12
> > > > > 	time cat test.dat > /dev/null
> > > > > 
> > > > > I would start with an absolute minimum msize of 10MB. I would
> > > > > recommend
> > > > > something around 100MB maybe for a mechanical hard drive. With a PCIe
> > > > > flash
> > > > > you probably would rather pick several hundred MB or even more.
> > > > > 
> > > > > That unpleasant 'msize' issue is a limitation of the 9p protocol:
> > > > > client
> > > > > (guest) must suggest the value of msize on connection to server
> > > > > (host).
> > > > > Server can only lower, but not raise it. And the client in turn
> > > > > obviously
> > > > > cannot see host's storage device(s), so client is unable to pick a
> > > > > good
> > > > > value by itself. So it's a suboptimal handshake issue right now.
> > > > 
> > > > It doesn't seem to be making a vast difference here:
> > > > 
> > > > 
> > > > 
> > > > 9p mount -t 9p -o trans=virtio kernel /mnt
> > > > -oversion=9p2000.L,cache=mmap,msize=104857600
> > > > 
> > > > Run status group 0 (all jobs):
> > > >    READ: bw=62.5MiB/s (65.6MB/s), 62.5MiB/s-62.5MiB/s
> > > >    (65.6MB/s-65.6MB/s),
> > > > 
> > > > io=3070MiB (3219MB), run=49099-49099msec WRITE: bw=20.9MiB/s (21.9MB/s),
> > > > 20.9MiB/s-20.9MiB/s (21.9MB/s-21.9MB/s), io=1026MiB (1076MB),
> > > > run=49099-49099msec
> > > > 
> > > > 9p mount -t 9p -o trans=virtio kernel /mnt
> > > > -oversion=9p2000.L,cache=mmap,msize=1048576000
> > > > 
> > > > Run status group 0 (all jobs):
> > > >    READ: bw=65.2MiB/s (68.3MB/s), 65.2MiB/s-65.2MiB/s
> > > >    (68.3MB/s-68.3MB/s),
> > > > 
> > > > io=3070MiB (3219MB), run=47104-47104msec WRITE: bw=21.8MiB/s (22.8MB/s),
> > > > 21.8MiB/s-21.8MiB/s (22.8MB/s-22.8MB/s), io=1026MiB (1076MB),
> > > > run=47104-47104msec
> > > > 
> > > > 
> > > > Dave
> > > 
> > > Is that benchmark tool honoring 'iounit' to automatically run with max.
> > > I/O
> > > chunk sizes? What's that benchmark tool actually? And do you also see no
> > > improvement with a simple
> > > 
> > > 	time cat largefile.dat > /dev/null
> > 
> > I am assuming that msize only helps with sequential I/O and not random
> > I/O.
> > 
> > Dave is running random read and random write mix and probably that's why
> > he is not seeing any improvement with msize increase.
> > 
> > If we run sequential workload (as "cat largefile.dat"), that should
> > see an improvement with msize increase.
> > 
> > Thanks
> > Vivek
> 
> Depends on what's randomized. If read chunk size is randomized, then yes, you 
> would probably see less performance increase compared to a simple
> 'cat foo.dat'.

We are using "fio" for testing and read chunk size is not being
randomized. chunk size (block size) is fixed at 4K size for these tests.

> 
> If only the read position is randomized, but the read chunk size honors 
> iounit, a.k.a. stat's st_blksize (i.e. reading with the most efficient block 
> size advertised by 9P), then I would assume still seeing a performance 
> increase.

Yes, we are randomizing read position. But there is no notion of looking
at st_blksize. Its fixed at 4K. (notice option --bs=4k in fio
commandline).

> Because seeking is a no/low cost factor in this case. The guest OS 
> seeking does not transmit a 9p message. The offset is rather passed with any 
> Tread message instead:
> https://github.com/chaos/diod/blob/master/protocol.md
> 
> I mean, yes, random seeks reduce I/O performance in general of course, but in 
> direct performance comparison, the difference in overhead of the 9p vs. 
> virtiofs network controller layer is most probably the most relevant aspect if 
> large I/O chunk sizes are used.
> 

Agreed that large I/O chunk size will help with the perfomance numbers.
But idea is to intentonally use smaller I/O chunk size with some of
the tests to measure how efficient communication path is.

Thanks
Vivek


