Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A84C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D52A20936
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYGn1n7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D52A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVrg7-0007Eh-VV
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 03:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVreF-0005BY-2D
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVreD-0004pa-9J
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603438680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8PuWox3XX6zDSwQWRGF9akXxav1eCqVrj36JDDs94w=;
 b=CYGn1n7mrI63DeUK/yvh54XBd8N6rKvtM7w6jf12hdjX2dRTk2bSAGXntCv1H4kImo8Fj5
 fmjvxMShH5HY6zdPc+mxLxNCBu4oPqu5MdEDPU9BWUwNlHk5wQKibPjkjMw+XKUzp/omj7
 MbcHT8uS4SfHT/xTy0UFSJciq8jdZ8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-M04m7KkxMqC9XLxiluVFCA-1; Fri, 23 Oct 2020 03:37:58 -0400
X-MC-Unique: M04m7KkxMqC9XLxiluVFCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6809A1006CAC;
 Fri, 23 Oct 2020 07:37:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC1B81C922;
 Fri, 23 Oct 2020 07:37:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 010D4204A6; Fri, 23 Oct 2020 09:37:52 +0200 (CEST)
Date: Fri, 23 Oct 2020 09:37:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
Message-ID: <20201023073752.2cbmfw7gcn6wpqqy@sirius.home.kraxel.org>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
 <9f6c63c6-599b-ac15-42e2-b9c1991fc7ee@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9f6c63c6-599b-ac15-42e2-b9c1991fc7ee@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> For clarification, I'm assuming the set of committers is rather small,
> and not the same as the set of subsystem maintainers who send pull
> requests for a committer to then merge in.

Yes.

> Does this proposal mean that
> pull requests would have to switch to gitlab merge requests,

I mirror my stuff to gitlab/github anyway, for CI coverage.  Increases
the chance that errors are catched by CI not Peter.  With that already
in place the step to do a gitlab pull req is pretty small.

Nevertheless that is a separate discussion.
Can gitlab properly handle signed tags btw?

> > Of course this is just starting a discussion, so I'm not even proposing
> > a date for the switch.
> 
> I'm hoping that as part of the consideration that we make sure that
> command line tooling can still drive everything; there is a difference
> between requiring a web page to initiate a merge request, vs. proper
> command line tooling one to leave the web page as an optional part of
> the workflow for only those who want it.

Gitlab has a JSON API, scripts/ci/gitlab-pipeline-status uses that for
example.  I'm pretty sure there are gitlab cli tools using that API ...

take care,
  Gerd


