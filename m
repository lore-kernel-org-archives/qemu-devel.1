Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED02BC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86145208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5exo+N7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86145208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJAyQ-0003ak-Fb
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kJAto-00075M-Vm
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kJAte-0004au-Nm
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600414404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=koM960OTR/la+i8q5PBpGM3F/xlQCMbDA69w3ibb4Xo=;
 b=U5exo+N7yPEgbBW/0v22uBmdT9eDmR5YjVpxPQZqTPUGLksVJqUivXvbGomRhwphxbs8JH
 n0V2CABMjR72Bo1RFMRoJyeapyiai/Kdmw9M/G7WUbwv76DzyOBSvRGuixzJ/nDdtaSZF9
 feZx6S68EHkkiVips+nvDbtScb/eZdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-9kuzjN4_MgeR-wroxnDZ9g-1; Fri, 18 Sep 2020 03:33:22 -0400
X-MC-Unique: 9kuzjN4_MgeR-wroxnDZ9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DACC80F040;
 Fri, 18 Sep 2020 07:33:21 +0000 (UTC)
Received: from kaapi (ovpn-112-187.phx2.redhat.com [10.3.112.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBE1560BEC;
 Fri, 18 Sep 2020 07:33:19 +0000 (UTC)
Date: Fri, 18 Sep 2020 13:03:17 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <20200911154055.hnh6wgqpc5pdcyjl@mozz.bu.edu>
Message-ID: <nycvar.YSQ.7.78.906.2009181257280.10832@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <20200911154055.hnh6wgqpc5pdcyjl@mozz.bu.edu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello Alex,

+-- On Fri, 11 Sep 2020, Alexander Bulekov wrote --+
|  * I'm guessing this will be a closed list with some application/vetting
|    procedure for the participants? (Maybe this is what you mean by
|    "moderated" ?)

  Yes.

|  * Will secalert still be subscribed (for managing CVE ID assignments)?

  Yes.

|  * How will the communication be encrypted?
|  * Assuming PGP will be gone,

  Few contacts with PGP keys could be made available for encrypted 
communication.

| will it be possible to make the "This bug is a security vulnerability"
| button work on Launchpad?

  Not sure, will have to check about it.

Thank you. (Sorry, I missed to reply here earlier.)
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


