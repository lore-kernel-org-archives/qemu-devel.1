Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C61C35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5EC92085B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOuh0p4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EC92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOSW-0000nE-Fz
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOORB-0000HG-Kv
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOOR7-0007tU-QV
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601658096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gr0+grffT9N1gIOOJ4Wdrp/6bXjlIQO9d+hnIQbr4mg=;
 b=hOuh0p4BBpGwVhgRf5P7pllPVOEZ8f/aKVmkU7NGMFPxFy4mN+o00FDXyJYVkIZaaEoyXF
 T/mRzG0MgYMdsMb4Xa4ZNmX8Yt6PgtSlrNMHAG1RdWTo9Sa4H7ElTRo3rQq5OchO7ySb/h
 OITl84OLSpwStromxywewrg/34FTiwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-8A-bp1jxNXWAU1IAr0qlpQ-1; Fri, 02 Oct 2020 13:01:32 -0400
X-MC-Unique: 8A-bp1jxNXWAU1IAr0qlpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B511188C127
 for <qemu-devel@nongnu.org>; Fri,  2 Oct 2020 17:01:31 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E65F178803;
 Fri,  2 Oct 2020 17:01:30 +0000 (UTC)
Date: Fri, 2 Oct 2020 13:01:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL v8 00/86] Misc QEMU patches for 2020-09-24
Message-ID: <20201002170130.GC7303@habkost.net>
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <a0b8e23a-cccb-3c5d-dbf7-f489c0d95f93@redhat.com>
 <5c9a0783-f7ea-7872-f5f4-44ba9e65a1b2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5c9a0783-f7ea-7872-f5f4-44ba9e65a1b2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Michal =?utf-8?B?UHLDrXZvem7DrWs=?= <mprivozn@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 06:27:35PM +0200, Paolo Bonzini wrote:
> On 02/10/20 17:58, Michal Prívozník wrote:
> >>
> > 
> > cd442a45db60a1a72fcf980c24bd1227f13f8a87 is the first bad commit
> > 
> > Sorry for noticing this earlier, but is this known? The build starts
> > failing for me after this commit:
> > 
> > /usr/bin/sphinx-build -Dversion=5.1.50 -Drelease= -W
> > -Ddepfile=docs/devel.d -Ddepfile_stamp=docs/devel.stamp -b html -d
> > /home/zippy/work/qemu/qemu.git/build/docs/devel.p
> > /home/zippy/work/qemu/qemu.git/docs/devel
> > /home/zippy/work/qemu/qemu.git/build/docs/devel
> > Running Sphinx v3.2.1
> > building [mo]: targets for 0 po files that are out of date
> > building [html]: targets for 20 source files that are out of date
> > updating environment: [new config] 20 added, 0 changed, 0 removed
> > reading sources... [100%] testing
> 
> No, this is new.  It works with older versions of Sphinx (I have 2.2.2
> despite being on Fedora 32 which is pretty recent).
> 
> For now Sphinx 3 is not supported by kerneldoc, we probably should apply
> a patch like
> 
> https://www.spinics.net/lists/linux-doc/msg83277.html

Weird, because we don't use the cdomain extension, and the patch
above only disables the cdomain extension.

In either case, supporting only Sphinx 2.x by now sounds
reasonable.  virtualenv+pip makes it simple to install and run a
specific Sphinx version, for people who really need it.

-- 
Eduardo


