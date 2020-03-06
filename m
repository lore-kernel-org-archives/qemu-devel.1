Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA0EC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739692070E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXA8+2fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739692070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADtn-0004DQ-LQ
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jADsy-0003JL-TB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jADsx-0006Bi-IQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jADsx-000623-9F
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583504610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bO2tXMfJ1MzluQ6CZRnU+79g2shKoPT8CuNmFX8X+mw=;
 b=TXA8+2fRtVmoBaxP7AaPKIiVJvbpneXRGqFJh0d3M7tj+oSEbcq2l3OrmaujaTo4yfuP5w
 l0cvIdujMlOymoJb8D/7CR/v2qDMREFXwr68yXp0w27F5qCbEB/p84cNxp1gnlJE4WcXrp
 hj06R142SmpNjiNH7dPIqtOgLeG/kUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-CZuv6eWrPkq7OyvPTOK3kw-1; Fri, 06 Mar 2020 09:23:27 -0500
X-MC-Unique: CZuv6eWrPkq7OyvPTOK3kw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E600800D5A;
 Fri,  6 Mar 2020 14:23:25 +0000 (UTC)
Received: from localhost (unknown [10.36.118.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4208519C6A;
 Fri,  6 Mar 2020 14:23:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Block patches
Date: Fri,  6 Mar 2020 14:23:15 +0000
Message-Id: <20200306142318.1435372-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBlZjlmOGZjYmVjNjI3NjQxNDkyMWRj
ZDA0MjU3NTEyOWE2MzMxYTJkOgoKICBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdyZW1v
dGVzL3N0ZWZhbmJlcmdlci90YWdzL3B1bGwtdHBtLTIwMjAtMDMtMDQtMicgaW50byBzdGFnaW5n
ICgyMDIwLTAzLTA1IDE5OjM5OjQ3ICswMDAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJl
cG9zaXRvcnkgYXQ6CgogIGh0dHBzOi8vZ2l0aHViLmNvbS9zdGVmYW5oYS9xZW11LmdpdCB0YWdz
L2Jsb2NrLXB1bGwtcmVxdWVzdAoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDFmNDBh
Y2U3YjU2MzRmOTM4MDFjODQ3NGI5ZWI3N2ZlMmUwMDI4OWM6CgogIHRlc3RzOiBGaXggYSBidWcg
d2l0aCBjb3VudCB2YXJpYWJsZXMgKDIwMjAtMDMtMDYgMTA6MzU6MTUgKzAwMDApCgotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
ClB1bGwgcmVxdWVzdAoKVGhlc2UgcGF0Y2hlcyB3b3VsZCBoYXZlIGdvbmUgdGhyb3VnaCBUaG9t
YXMgSHV0aCBidXQgaGUgaXMgYXdheSBvbiBsZWF2ZS4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCkFsZXhhbmRlciBCdWxl
a292ICgyKToKICBmdXp6OiBmaXggc3R5bGUvdHlwb3MgaW4gbGlua2VyLXNjcmlwdCBjb21tZW50
cwogIHF0ZXN0OiBmaXggZnV6emVyLXJlbGF0ZWQgODAtY2hhciBsaW1pdCB2aW9sYXRpb25zCgpU
aWFuamlhIFpoYW5nICgxKToKICB0ZXN0czogRml4IGEgYnVnIHdpdGggY291bnQgdmFyaWFibGVz
CgogcXRlc3QuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArKy0KIHRlc3RzL3F0ZXN0L2Z1
enovZm9ya19mdXp6LmxkIHwgMTYgKysrKysrKysrKy0tLS0tLQogdGVzdHMvcXRlc3QvZnV6ei9x
b3NfZnV6ei5jICAgfCAgNSArKysrLQogdGVzdHMvdGVzdC1yY3UtbGlzdC5jICAgICAgICAgfCAg
MiArLQogNCBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoK
LS0gCjIuMjQuMQoK


