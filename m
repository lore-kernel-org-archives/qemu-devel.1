Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A2EC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F99206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="J3shwv4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F99206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLPVB-0004hm-RX
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 07:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1jLPUB-0003xx-4O
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 07:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1jLPU9-0007ye-UR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 07:00:11 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:13930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1jLPU6-0007uq-Iv; Mon, 06 Apr 2020 07:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1586170806;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4hx5mGuHDzA5+dvvT4cVCkiCfX8ylquIvcCMnoby8o8=;
 b=J3shwv4w00jIQjY4SlH08E/oSbbPe6XavngeZ/6aB0YeDkUpb7lM0Tba
 +Btng43Zg8jJkHDzsxhED+RBJ3uSwXsCr+5qzyuN5xh8uZ3Z2TBHeNyym
 FuPzIO9sRgga+x6CZDdxkqSOcpWxeKvHoNf1UFDQQncASP6I7F1m2C+5g M=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: vzlJoJoPAWg3TfMFYrWLraz7UQzkYEFdlGGQmtyLH3Nt97LUS2ei0GJtf75z6whm2zpnCVqbKg
 IBJDVMR9rghkcT7KNpbYdfbCNOK97ABA+rihv4x55SWwFLeutrij99+YxiPQCXwL88XhjP8Bka
 0D8doIQw2ZfOrEey/y+p/kNmNQM0aHstCNclMfWLi5rBTmOoCBOMcZP0BaXycD0eDG5UqDdJNP
 rw35MtUdb7UYmSffiu/kglPgSDxVq2F1tl1nOEpblMtLp1NEnwWM6FMJuL4PGsKc9sAC5VfsT6
 +YM=
X-SBRS: 2.7
X-MesageID: 15547921
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,350,1580792400"; d="scan'208";a="15547921"
Date: Mon, 6 Apr 2020 11:59:54 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: <paul@xen.org>
Subject: Re: [PATCH for-5.0] xen-block: Fix double qlist remove
Message-ID: <20200406105954.GT4088@perard.uk.xensource.com>
References: <20200402130819.1216125-1-anthony.perard@citrix.com>
 <001801d608fa$d3f0d3f0$7bd27bd0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <001801d608fa$d3f0d3f0$7bd27bd0$@xen.org>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.168
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
Cc: 'Kevin Wolf' <kwolf@redhat.com>,
 'Stefano Stabellini' <sstabellini@kernel.org>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, 'Max Reitz' <mreitz@redhat.com>,
 'Stefan Hajnoczi' <stefanha@redhat.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 03:27:22PM +0100, Paul Durrant wrote:
> > -----Original Message-----
> > From: Anthony PERARD <anthony.perard@citrix.com>
> > Sent: 02 April 2020 14:08
> > To: qemu-devel@nongnu.org
> > Cc: qemu-stable@nongnu.org; Anthony PERARD <anthony.perard@citrix.com>; Stefano Stabellini
> > <sstabellini@kernel.org>; Paul Durrant <paul@xen.org>; Stefan Hajnoczi <stefanha@redhat.com>; Kevin
> > Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; xen-devel@lists.xenproject.org; qemu-
> > block@nongnu.org
> > Subject: [PATCH for-5.0] xen-block: Fix double qlist remove
> > 
> > Commit a31ca6801c02 ("qemu/queue.h: clear linked list pointers on
> > remove") revealed that a request was removed twice from a list, once
> > in xen_block_finish_request() and a second time in
> > xen_block_release_request() when both function are called from
> > xen_block_complete_aio(). But also, the `requests_inflight' counter is
> > decreased twice, and thus became negative.
> > 
> > This is a bug that was introduced in bfd0d6366043, where a `finished'
> > list was removed.
> > 
> > This patch simply re-add the `finish' parameter of
> > xen_block_release_request() so that we can distinguish when we need to
> > remove a request from the inflight list and when not.
> > 
> > Fixes: bfd0d6366043 ("xen-block: improve response latency")
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> It looks to me like it would just be more straightforward to simply drop the QLIST_REMOVE and requests_inflight-- from
> xen_block_release_request() and simply insist that xen_block_finish_request() is called in all cases (which I think means adding one
> extra call to it in xen_block_handle_requests()).

I'm thinking of going further than that. I've notice another bug, in
case of error in xen_block_do_aio(), xen_block_finish_request() is
called without ever calling send_response() or release_request(). I
think that mean a leak of request.

So, I'm thinking of creating a function that would do finish_request(),
send_response(), release_request(), has I believe those operations needs
to be done together anyway.

I'll rework the patch.

-- 
Anthony PERARD

