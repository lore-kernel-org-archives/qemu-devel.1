Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476AAC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F48206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F48206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHoRS-0003IT-8Q
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 08:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jHoQE-0001ts-56
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jHoQC-000600-QM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:49:14 -0400
Resent-Date: Fri, 27 Mar 2020 08:49:14 -0400
Resent-Message-Id: <E1jHoQC-000600-QM@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jHoQC-0005xB-H1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:49:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585313345; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=P7UpwBWSp2Ek0DlN3nim5BLx0SFMD0WehCiTR96HPgm+Icsg5B6rd+Ml0gqMRM9ZWzT2sWubE370tepCszFx7n1KVOsdGDE7Y9meYH2fUicr8JT5wHz4H+SDHBMQCVNIZL7+QROfpWAPzNgWXV4HxMRJX99e0vd+7ioNCUlFTPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585313345;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=I+Inte0WlAVaItb3HXxRZ28NzojKl5pDNaQ+hWEk/CU=; 
 b=TNUon5X8NxbLWPMvZBzUr9/+JGWlC8PwNG99jGwI4ivg5ighmxpCrJmBjo/NO+j5gRaDo4CygtyRsa6Ebh47KfNl3fZpOgLWO6dOPKdautJRQUvBlBv8l83nXELg8UU5lHjN3ilc/IUEp5aDU809w788e0iKkMxrVl+khkgLFb0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585313344386694.5867135750976;
 Fri, 27 Mar 2020 05:49:04 -0700 (PDT)
In-Reply-To: <20200327121111.1530-1-kraxel@redhat.com>
Subject: Re: [PATCH 0/6] acpi: i386 tweaks
Message-ID: <158531334306.31566.8317858781379992985@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Fri, 27 Mar 2020 05:49:04 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Reply-To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyNzEyMTExMS4xNTMw
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKYWNwaS10ZXN0OiBXYXJuaW5nISBE
U0RUIGJpbmFyeSBmaWxlIG1pc21hdGNoLiBBY3R1YWwgW2FtbDovdG1wL2FtbC1JNzQ2SDBdLCBF
eHBlY3RlZCBbYW1sOnRlc3RzL2RhdGEvYWNwaS9wYy9EU0RUXS4KU2VlIHNvdXJjZSBmaWxlIHRl
c3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYyBmb3IgaW5zdHJ1Y3Rpb25zIG9uIGhvdyB0byB1
cGRhdGUgZXhwZWN0ZWQgZmlsZXMuCnRvIHNlZSBBU0wgZGlmZiBiZXR3ZWVuIG1pc21hdGNoZWQg
ZmlsZXMgaW5zdGFsbCBJQVNMLCByZWJ1aWxkIFFFTVUgZnJvbSBzY3JhdGNoIGFuZCByZS1ydW4g
dGVzdHMgd2l0aCBWPTEgZW52aXJvbm1lbnQgdmFyaWFibGUgc2V0KioKRVJST1I6L3RtcC9xZW11
LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzo0OTE6dGVzdF9hY3BpX2Fz
bDogYXNzZXJ0aW9uIGZhaWxlZDogKGFsbF90YWJsZXNfbWF0Y2gpCkVSUk9SIC0gQmFpbCBvdXQh
IEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6
NDkxOnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6IChhbGxfdGFibGVzX21hdGNoKQpt
YWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMzAKICBURVNU
ICAgIGlvdGVzdC1xY293MjogMDMxCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD1kNGMwNmUxZGNkNmY0NGI0YmNmOTIyMWYyOWE1MzEwZicsICctdScsICcxMDAxJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUn
LCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11
LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLTNjemY0N3ltL3NyYy9kb2NrZXItc3JjLjIwMjAtMDMtMjctMDguMzUuMDAu
MTU3MDU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11
L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZp
bHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWQ0YzA2ZTFkY2Q2ZjQ0
YjRiY2Y5MjIxZjI5YTUzMTBmCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtl
WzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTNjemY0
N3ltL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3Ig
MgoKcmVhbCAgICAxNG0zLjQwOHMKdXNlciAgICAwbTguNzc1cwoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMjcxMjExMTEuMTUzMC0x
LWtyYXhlbEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

