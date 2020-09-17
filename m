Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4274FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C918E21D24
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iw7d448i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C918E21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxMa-0008K5-Vi
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIxJG-0005I7-KE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:03:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIxJF-0005Zz-02
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600362179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mo2MqNBsnSdUGZ4o89PbvBJNpPYbOLW5c0subifov0=;
 b=iw7d448iQXEG7IsFcQcrgD5Y+lxD+iewuQYcAuuvhoDWOBwLAvSpo+AgZydefPNUmkhscK
 ibkcAU/4rAbudqGZVKsVzMIj4RwAl6Vga+iCLNyxdhNwvo9HnXyr49A/CQBDyqDFqNIOmr
 3YWq4+xuyUu/T/MWTIyi+yiDEN+zeNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-rMzbCKlTPiitxwYeF3nyjg-1; Thu, 17 Sep 2020 13:02:42 -0400
X-MC-Unique: rMzbCKlTPiitxwYeF3nyjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C58B1107AD64;
 Thu, 17 Sep 2020 17:02:41 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98EF719D6C;
 Thu, 17 Sep 2020 17:02:35 +0000 (UTC)
Message-ID: <2a2f4c3504b5c00018907997f52df211b01d1f99.camel@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
From: Andrea Bolognani <abologna@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 17 Sep 2020 19:02:32 +0200
In-Reply-To: <20200917163545.GN1597829@redhat.com>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
 <9d4363e8-7bb8-8255-9914-6d9bc36cec79@redhat.com>
 <871rj0o1yk.fsf@dusky.pond.sub.org>
 <b679e646f4dd8ebea753892c0cec27e54ba8f407.camel@redhat.com>
 <20200917163545.GN1597829@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=abologna@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-09-17 at 17:35 +0100, Daniel P. Berrangé wrote:
> On Thu, Sep 17, 2020 at 06:07:00PM +0200, Andrea Bolognani wrote:
> > It would be *fantastic* if we could keep the platform support policy
> > used by QEMU and libvirt as aligned as reasonably possible.
> 
> The current QEMU policy was a copy+paste of the same policy I wrote for
> libvirt originally, just adding OpenBSD/NetBSD.
> 
> I've just posted an update for QEMU which matches the latest libvirt
> policy, again just adding the extra BSDs.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06371.html

That's even better than I hoped for! Thank you so much :)

-- 
Andrea Bolognani / Red Hat / Virtualization


