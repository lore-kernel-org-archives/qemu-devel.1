Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25E7C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7828F212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7828F212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49966 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfN2X-0002lK-IZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hfN0f-0001gU-13
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hfN0c-0004PP-VU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:19:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hfN0b-0004Kj-1S
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:19:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2500F369A0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 11:19:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D91AF60A97;
 Mon, 24 Jun 2019 11:19:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 36B4111386A0; Mon, 24 Jun 2019 13:19:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-5-armbru@redhat.com>
 <6cca5383-fdd4-ab9b-d227-d2de1083d398@redhat.com>
Date: Mon, 24 Jun 2019 13:19:33 +0200
In-Reply-To: <6cca5383-fdd4-ab9b-d227-d2de1083d398@redhat.com> (Paolo
 Bonzini's message of "Thu, 20 Jun 2019 10:38:36 +0200")
Message-ID: <87imsvs01m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 24 Jun 2019 11:19:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: Split qom.json and qdev.json
 off misc.json
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
Cc: kwolf@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 19/06/19 22:10, Markus Armbruster wrote:
>> Move commands device-list-properties, device_add, device-del, and
>> event DEVICE_DELETED from misc.json to new qdev.json.  qdev.json
>> remains uncovered by MAINTAINERS, like the rest of qdev.
>
> qdev should be added to either QOM or machine core.  QOM would be fine
> for me as the (newly,self)-appointed maintainer.

Awesome!  Daniel, Eduardo, any objections?

I figure these are the files to add:

diff --git a/MAINTAINERS b/MAINTAINERS
index 63390eadb5..e2cb1726dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2033,12 +2033,18 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Eduardo Habkost <ehabkost@redhat.com>
 S: Supported
+F: docs/qdev-device-use.txt
+F: hw/core/qdev*
+F: include/hw/qdev*
+F: include/monitor/qdev.h
 F: include/qom/
 X: include/qom/cpu.h
+F: qdev-monitor.c
 F: qom/
 X: qom/cpu.c
 F: tests/check-qom-interface.c
 F: tests/check-qom-proplist.c
+F: tests/test-qdev-global-props.c
 
 QMP
 M: Markus Armbruster <armbru@redhat.com>

