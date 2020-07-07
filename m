Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C1DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E73206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRof3WvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E73206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslNV-0008ET-Br
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 07:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jslMU-0007hB-0h
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:02:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57438
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jslMS-0001rX-GX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594119723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:openpgp:openpgp;
 bh=1MLm6o6Xg2RNS4OVfM+TbqKzm0RGJmRg9n5H+VfrDLg=;
 b=BRof3WvZ6kRquVnLQGkshm7aMOXh1focfm9dOK94/qs9iYWEJhqd2eT6DEYxbJfZOt3pzr
 A03CywYqbkGJ2JZ/4CZRo+kbWOTBOOpBOCYpIagMraefahaWOek0IbfhISO3FdQF7oNeyM
 0X0OodtSqFydFZJBdTLpEU6HATjSB7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-OmJj5fNHPXCnlbOWInBpwg-1; Tue, 07 Jul 2020 07:02:00 -0400
X-MC-Unique: OmJj5fNHPXCnlbOWInBpwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC95C801E6A;
 Tue,  7 Jul 2020 11:01:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31CDA19D7B;
 Tue,  7 Jul 2020 11:01:56 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>
From: Thomas Huth <thuth@redhat.com>
Subject: hw/intc/xics.c:605: ics_realize: Assertion `ics->xics' failed
Openpgp: preference=signencrypt
Message-ID: <104a1848-4686-0b6f-fb0c-e09e2ffbd031@redhat.com>
Date: Tue, 7 Jul 2020 13:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


 Hi Greg,

I just ran  scripts/device-crash-test and it triggered the assert that
you've added in commit b015a9809427c8 ("xics: Link ICS_PROP_XICS
property to ICSState::xics pointer"):

$ qemu-system-ppc64 -S -M powernv9,accel=tcg -device pnv-psi-POWER8
qemu-system-ppc64: hw/intc/xics.c:605: ics_realize: Assertion
`ics->xics' failed.
Aborted (core dumped)

That's ugly. Could you please have a look how this could be done in a
nicer way? (Maybe set errp and return in that case?)

 Thanks,
  Thomas


