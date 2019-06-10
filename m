Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683A3C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39127206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39127206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGuw-0004U8-IX
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1haGpd-0000aE-5B
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1haGpW-0003tN-Im
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:43:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1haGpT-0003oK-AB
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:43:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08394308FF2C;
 Mon, 10 Jun 2019 09:42:57 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.ams2.redhat.com [10.36.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F49760BF1;
 Mon, 10 Jun 2019 09:42:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
In-Reply-To: <20190520125313.wiiut3u7mkdedib4@master> (Wei Yang's message of
 "Mon, 20 May 2019 12:53:13 +0000")
References: <20190515121544.4597-1-quintela@redhat.com>
 <20190515121544.4597-6-quintela@redhat.com>
 <20190520125313.wiiut3u7mkdedib4@master>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Mon, 10 Jun 2019 11:42:54 +0200
Message-ID: <87k1dtvkrl.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 10 Jun 2019 09:42:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/8] migration: Add multifd-compress
 parameter
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richard.weiyang@gmail.com> wrote:
> On Wed, May 15, 2019 at 02:15:41PM +0200, Juan Quintela wrote:
>>Signed-off-by: Juan Quintela <quintela@redhat.com>
>>@@ -1821,6 +1826,18 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>         p->has_multifd_channels = true;
>>         visit_type_int(v, param, &p->multifd_channels, &err);
>>         break;
>>+    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
>>+        p->has_multifd_compress = true;
>>+        visit_type_MultifdCompress(v, param, &compress_type, &err);
>>+        if (err) {
>>+            break;
>>+        }
>>+        if (compress_type < 0 || compress_type >= MULTIFD_COMPRESS__MAX) {
>
> A warning during build:
>
> hmp.c:1835:27: warning: comparison of unsigned enum expression < 0 is
> always false [-Wtautological-compare]
>         if (compress_type < 0 || compress_type >= MULTIFD_COMPRESS__MAX) {

Fixed, see Markus reason for dropping this bit.

/me wonders why this didn't failed my compilation ....

Thanks, Juan.

