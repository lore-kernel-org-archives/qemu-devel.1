Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082A8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C69206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+XM38LS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C69206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmu0-0007Bc-1z
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kUmsZ-0006DX-FD
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kUmsW-0003t1-5V
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603182016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yFXBnLm9likZm7SefUKXIT7uJWLG+i0VxLwszH0IVY=;
 b=X+XM38LS2mCp90I4qzS4Cx4KOa4Wpfp6lkyETMgTLbjmvoBz2ZjL3EpTHxmQB+RlMKtY3m
 0rGUOxnm3VTVbM2uWUKIBJDNWjx5fOwhEmviFKD4KiM6792EYm4fu9ZXCYAPYlcW9AbMTl
 du6v1tJ+oycxdDEgNc042oUFq0MR17U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-4gbvhug4OHybinghAfIX3Q-1; Tue, 20 Oct 2020 04:20:13 -0400
X-MC-Unique: 4gbvhug4OHybinghAfIX3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E75A41084D73;
 Tue, 20 Oct 2020 08:20:11 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-115-23.ams2.redhat.com [10.36.115.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC2AB21E93;
 Tue, 20 Oct 2020 08:20:10 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 491903E047D; Tue, 20 Oct 2020 10:20:09 +0200 (CEST)
Date: Tue, 20 Oct 2020 10:20:09 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: Plans to bring QMP 'x-blockdev-reopen' out of experimental?
Message-ID: <20201020082009.GG600839@paraplu>
References: <20201006091001.GA64583@paraplu>
 <w51mu0ifbuf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w51mu0ifbuf.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kchamart@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 05:56:56PM +0200, Alberto Garcia wrote:
> On Tue 06 Oct 2020 11:10:01 AM CEST, Kashyap Chamarthy wrote:
> > Hi, folks
> >
> > If this was already discussed on the list, please point me to the
> > thread.  I took a quick look at my local archives, I didn't find any,
> > besides patches to tests.
> 
> I think this is the last time that I was discussed:
> 
>    https://lists.gnu.org/archive/html/qemu-block/2020-02/msg00558.html
> 
> And this one in particular:
> 
>    https://lists.gnu.org/archive/html/qemu-block/2020-02/msg00601.html
> 
> But Kevin fixed this one month later:
> 
>    https://lists.gnu.org/archive/html/qemu-block/2020-03/msg00266.html

Ah, thanks for these URLs, Berto.  My bad, I didn't find it in my local
archives because of the way I organized my mail filters; I recently
cleared the 'qemu-block' maildir, so these didn't show up.

-- 
/kashyap


