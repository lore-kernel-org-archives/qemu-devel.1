Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC44C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B98206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXw1KKSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B98206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJpF-0001VU-5d
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiJmI-0007on-S2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:33:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59671
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiJmH-00021b-Tm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591630412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u+Sz2iNYLmIKMlaL7wFI9YZW1wJpMs34FgDrsOviy4A=;
 b=FXw1KKSU4jmj+/FxkBC6dGeeliPv9b2bokMghMmDJKr68Mp8DM6fUZyILIatswEVp4Q9Yg
 lpaWpLV/AQ/zEziQA9vR4eHWyDdq1XYHs21HMdF22PyjGKd+f10IprZvgdIX4n+FQbwO91
 M+EklCCAXYnut9Ca5tZpqgBpqb4UdrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-REV3M9xINUuEZh8jJ1xYvg-1; Mon, 08 Jun 2020 11:33:30 -0400
X-MC-Unique: REV3M9xINUuEZh8jJ1xYvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F27F9835B41;
 Mon,  8 Jun 2020 15:33:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-244.ams2.redhat.com [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8441D768C1;
 Mon,  8 Jun 2020 15:33:28 +0000 (UTC)
Date: Mon, 8 Jun 2020 17:33:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 00/16] python: add mypy support to python/qemu
Message-ID: <20200608153327.GD6419@linux.fritz.box>
References: <20200604202236.25039-1-jsnow@redhat.com>
 <20200605092630.GE5869@linux.fritz.box>
 <502e4f4d-6770-61a7-1496-9cb244f9ddd3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <502e4f4d-6770-61a7-1496-9cb244f9ddd3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.06.2020 um 17:19 hat John Snow geschrieben:
> 
> 
> On 6/5/20 5:26 AM, Kevin Wolf wrote:
> > Am 04.06.2020 um 22:22 hat John Snow geschrieben:
> >> Based-on: 20200604195252.20739-1-jsnow@redhat.com
> >>
> >> This series is extracted from my larger series that attempted to bundle
> >> our python module as an installable module. These fixes don't require that,
> >> so they are being sent first as I think there's less up for debate in here.
> >>
> >> This requires my "refactor shutdown" patch as a pre-requisite.
> > 
> > You didn't like my previous R-b? Here's a new one. :-)
> > 
> > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > 
> 
> I felt like I should address the feedback, and though I could have
> applied the R-B to patches I didn't change, it was ... faster to just
> re-send it.
> 
> Serious question: How do you apply people's R-Bs to your patches? At the
> moment, it's pretty manually intensive for me. I use stgit and I pop all
> of the patches off (stg pop -n 100), and then one-at-a-time I `stg push;
> stg edit` and copy-paste the R-B into it.
> 
> It's easier when I'm just pulling other people's patches from the ML,
> the patches tool handles it for me. It's updating my own patches that's
> a drag and prone to error.

It's a manual process for me, too. Just that I don't use stgit, but
'git rebase -i'.

Kevin


