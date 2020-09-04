Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF8CC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8931206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8931206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE976-0002Fr-0b
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 06:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kE96Y-0001lz-Vx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:38:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kE96W-0005WS-Qj
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:38:02 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-HW1k0ufHONOHycTfcHB7Ag-1; Fri, 04 Sep 2020 06:37:57 -0400
X-MC-Unique: HW1k0ufHONOHycTfcHB7Ag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB99718A2257;
 Fri,  4 Sep 2020 10:37:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-114.ams2.redhat.com [10.36.112.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E5E678B34;
 Fri,  4 Sep 2020 10:37:55 +0000 (UTC)
Date: Fri, 4 Sep 2020 12:37:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] iotests: Remove 030 from the auto group
Message-ID: <20200904103754.GC6237@linux.fritz.box>
References: <20200904055701.462482-1-thuth@redhat.com>
 <20200904082513.GA6237@linux.fritz.box>
 <51e03521-f0b7-bf29-1ab8-9025f2f4ce94@redhat.com>
MIME-Version: 1.0
In-Reply-To: <51e03521-f0b7-bf29-1ab8-9025f2f4ce94@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.09.2020 um 12:14 hat Thomas Huth geschrieben:
> On 04/09/2020 10.25, Kevin Wolf wrote:
> > Am 04.09.2020 um 07:57 hat Thomas Huth geschrieben:
> >> Test 030 is still occasionally failing in the CI ... so for the
> >> time being, let's disable it in the "auto" group. We can add it
> >> back once it got more stable.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > I would rather just disable this one test function as 030 is a pretty
> > important one that tends to catch bugs.
> 
> Ok, ... should it always get disabled, or shall we try to come up with
> some magic checks so that it only gets disabled in the CI pipelines (...
> though I don't have a clue how to check for Peter's merge test
> environment...)?

Maybe we can detect whether we're run as part of the "auto" group and
skip the test then (as in QMPTestCase.case_skip)?

Kevin


