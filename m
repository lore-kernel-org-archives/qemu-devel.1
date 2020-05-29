Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F84C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EB020723
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iePDnu/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EB020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jebpL-0001UN-VB
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jebo1-0000c3-35
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:00:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58267
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jebnz-0005el-K9
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590746397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tCdRBIazJXO9RLeds6qPsGkqALbL+c3z6d8Q7cV0L7w=;
 b=iePDnu/uNxEPMDLfiZ7VylvVv/C98M9IjTN8YvH762+tyaA1KhyWMO6ymWxL38PufdQnx0
 kL5rScao1L4NHRrLkDfKVPVZa++wOVxTqMaHUnOW/3Xbbt8dhMiiHPiJzsPEucFt1ehKSu
 ZLktm8gWprLrakDkkL41QA6OZTuA/jQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-Vugk-v7BPmSw9b6Kz9bz3w-1; Fri, 29 May 2020 05:59:51 -0400
X-MC-Unique: Vugk-v7BPmSw9b6Kz9bz3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24BAA107ACCA;
 Fri, 29 May 2020 09:59:50 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0AA77D8F2;
 Fri, 29 May 2020 09:59:47 +0000 (UTC)
Date: Fri, 29 May 2020 10:59:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v7 00/14] LUKS: encryption slot management using amend
 interface
Message-ID: <20200529095944.GC2755532@redhat.com>
References: <20200518122041.10694-1-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200518122041.10694-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 03:20:27PM +0300, Maxim Levitsky wrote:
> Hi!
> Here is the updated series of my patches, incorporating all the feedback I received.
> 
> This implements the API interface that we agreed upon except that I merged the
> LUKSKeyslotActive/LUKSKeyslotInactive union into a struct because otherwise
> I need nested unions which are not supported currently by QAPI parser.
> This didn't change the API and thus once support for nested unions is there,
> it can always be implemented in backward compatible way.
> 
> I hope that this series will finally be considered for merging, since I am somewhat running
> out of time to finish this task.
> 
> Patches are strictly divided by topic to 3 groups, and each group depends on former groups.
> 
> * Patches 1,2 implement qcrypto generic amend interface, including definition
>   of structs used in crypto.json and implement this in luks crypto driver
>   Nothing is exposed to the user at this stage
> 
> * Patches 3-9 use the code from patches 1,2 to implement qemu-img amend based encryption slot management
>   for luks and for qcow2, and add a bunch of iotests to cover that.
> 
> * Patches 10-13 add x-blockdev-amend (I'll drop the -x prefix if you like), and wire it
>   to luks and qcow2 driver to implement qmp based encryption slot management also using
>   the code from patches 1,2, and also add a bunch of iotests to cover this.
> 
> Tested with -raw,-qcow2,-nbd and -luks iotests and 'make check'
> 
> Changes from V4:
>   * Addresed feedback on patch 2 from Daniel (thanks!)
>   * Gave real numbers to the tests
>   * Updated the copyright in amend.c to RedHat
>   * Rebased and adjusted the python iotests to latest changes in iotest infrastructure
> 
> Changes from V5:
>   * Updated all QMP docs to state that all added QMP features are since 5.1
>   * Rebased to latest master
> 
> Changes from V6:
>   * Addressed most of the review feedback from Max Reitz
>   * Rebased on latest qemu master

It needs another rebase as there's some conflicts now.

In any case, all the patches have my R-B already, and I don't have
any further comments to add.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


