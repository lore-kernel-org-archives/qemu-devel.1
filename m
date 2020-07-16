Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75924C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E61120775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hc4WDYyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E61120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw06l-0003uz-G3
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jw05t-0002sm-IF
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:22:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jw05q-0007pd-UC
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594891338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qoxxvHNTj11wlpkzVWJfa1bbQmlw5rIUKC7FEM6JH8g=;
 b=hc4WDYyAsnfRls2YIZOvrNiqUPpn0AIjq5BOXIMfM1AFem9OAkeiXW7kc8Vya8aMrMj1x2
 uXhxYJZsOatSJJNbt9D14ULp481xLvzMw+kbNr0Jnv0MEVLIvohiah+b0Bnfn6LDThYpTo
 +aaH/YprYp4/dvd+RfeYmS5rCETNeq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-msN8ZJ8iPc-FD8nVL3kzHQ-1; Thu, 16 Jul 2020 05:22:16 -0400
X-MC-Unique: msN8ZJ8iPc-FD8nVL3kzHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C702100CCC1;
 Thu, 16 Jul 2020 09:22:14 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 110B478A5B;
 Thu, 16 Jul 2020 09:21:58 +0000 (UTC)
Date: Thu, 16 Jul 2020 14:51:55 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
In-Reply-To: <20200716083654.GA227735@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2007161428570.950384@xnncv>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
 <20200714095233.GC25187@redhat.com>
 <20200714060916-mutt-send-email-mst@kernel.org>
 <CAFEAcA_ca4JN655GW=eGyjrjDmiv0EktaZZ7RMghO5rBwm9tGQ@mail.gmail.com>
 <20200714064921-mutt-send-email-mst@kernel.org>
 <nycvar.YSQ.7.78.906.2007141723140.6870@xnncv>
 <20200716085543.7082f047.cohuck@redhat.com>
 <20200716083654.GA227735@redhat.com>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.78.906.2007161433180.950384@xnncv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463810047-1053341357-1594890038=:950384"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-1053341357-1594890038=:950384
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <nycvar.YSQ.7.78.906.2007161433181.950384@xnncv>

+-- On Thu, 16 Jul 2020, Daniel P. Berrangé wrote --+
| > Failing to start (with a message that explains why) if one of the command 
| > line options is not covered by a specified security policy is not 
| > unreasonable (after all, we fail to start for other cases of incompatible 
| > command line options as well.)

  Yes, that's right.

| > However, we also need to cover dynamically-added devices. Aborting seems 
| > very bad there, just failing to add the device seems like what we'd want.
| 
| Yep, aborting is simply not an option for the inner code. It all has to 
| propagate to a proper Error **errp object. The ultimate entry-point at the 
| CLI vs QMP then decides whether to turn the error into an abort or feed back 
| to the client app.

  True, handling dynamic devices is tricky.

Though it seems kind of uniform workflow to check for '--security' flag at 
options parsing OR while handling dynamic devices at run time; It is a huge 
task to cover all options/use-cases for all QEMU emulators across various 
architectures.

* If this approach is reasonable, I'll try to make an initial patch towards 
  it.

* We'd still need to figure out similar way for compile time option, to 
  exclude building insecure features at build time.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1053341357-1594890038=:950384--


