Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDCC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A1F21D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3cixnAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A1F21D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8m3-00087m-5L
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kI8W9-0003ns-69
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kI8W7-0004qI-Cs
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3H9erQR8dgW35In8uN6bN1E9Jj9iq2UQgolUErEXlTY=;
 b=K3cixnAbxvWn8QGhAzNBDSdSb5MUgDDc87utyID/m1IrUW5FzX4kTQ5OxaYI+FgxPHSn/k
 9r8zzZDHFZBy9jffP148vc/nAwR25Wm5rc4MH578eABlWJr2HvK2hmw1pZ1ZdKT24flHTh
 E7KvVyAdkGk2xVqW7x5PAdA8NNVP30A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-aN_St2WqMQONL_QfMu4Ddg-1; Tue, 15 Sep 2020 06:48:52 -0400
X-MC-Unique: aN_St2WqMQONL_QfMu4Ddg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C93B464087;
 Tue, 15 Sep 2020 10:48:51 +0000 (UTC)
Received: from kaapi (ovpn-116-229.sin2.redhat.com [10.67.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E532C19C4F;
 Tue, 15 Sep 2020 10:48:49 +0000 (UTC)
Date: Tue, 15 Sep 2020 16:18:47 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <20200914101517.GD579094@stefanha-x1.localdomain>
Message-ID: <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: peter.maydell@linaro.org,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello,

+-- On Fri, 11 Sep 2020, Peter Maydell wrote --+
| Way way back, the idea of a qemu-security list was proposed, and it was 
| decided against because there wasn't a clear way that people could send 
| encrypted mail to the security team if it was just a mailing list. So that's 
| why we have the "handful of individual contacts" approach. Is that still 
| something people care about ?

* So far issue reports have mostly been unencrypted.

* All issue reports may not need encryption.

* If someone still wants to send an encrypted report, few contacts with their 
  GPG keys could be made available, as is available now.


+-- On Mon, 14 Sep 2020, Stefan Hajnoczi wrote --+
| On Fri, Sep 11, 2020 at 04:51:49PM +0100, Peter Maydell wrote:
| > want it to be a larger grouping than that and maybe also want to use it as 
| > a mechanism for informing downstream distros etc about QEMU security 
| > issues, which is to say you're proposing an overhaul and change to our 
| > security process, not merely "we'd like to create a mailing list" ?
| 
| Yes, please discuss the reasons for wanting a mailing list:
| 
| Is the goal to involve more people in triaging CVEs in a timely manner?

  This will be welcome for fix patches.

| Is the goal to include new people who have recently asked to participate?

  We've not received such request yet.

| Is the goal to use an easier workflow than manually sending encrypted
| email to a handful of people?

* Current proposal is more for enabling communities and downstream distros to 
  know about the issues as and when they are reported. Ie. heads-up mechanism.

  Just to note, we've not received any request for such notifications.

* If maintainers are on this list, that could help with the triage and fix 
  patches.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


