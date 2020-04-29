Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B7C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 23:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0C42082E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 23:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0C42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTw02-0008CA-0U
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 19:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTvzF-0007S2-7Y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 19:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTvz2-0003JF-RO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 19:19:28 -0400
Resent-Date: Wed, 29 Apr 2020 19:19:28 -0400
Resent-Message-Id: <E1jTvz2-0003JF-RO@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTvz2-0003E2-Ag
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 19:19:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588202348; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PFovw2AP6GtZjZkVM1UStqywj4ieCq9t1GUl0EpzcZp+8yvcSbIdJS3iBC11JWnUFt/DIaE8T2MTVZ1whyZ41bzW7BlEdw2dj+SI29y+Lv6kHBN/D70XBi7cCv37AUuW8H/fHQCdZsv97uFRWAaHw0GcJ793/ISm5TLlDAMY3Ro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588202348;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=0gzj+YLfoyOhEK1hCdgwQUGBjYwr7ZxuWThLK6dAXqI=; 
 b=krBKtYlb6VIyr8AhcppGp5vwNZEF9ep/wSJ5jql1r/k/ssomQS6CbMtLOZpudTBVVMa+ShIokpiHi0DFlwpT0MV5gwmnbztKIdXve4mh6MPITvKM0C3uifa52PVc8ZWVwZz+u3k4klWjc1bI4dMAH6OLnNf3Ihvs7QkYdf3vr+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588202346995116.59013015750645;
 Wed, 29 Apr 2020 16:19:06 -0700 (PDT)
Message-ID: <158820234560.4471.4940281077114413592@45ef0f9c86ae>
In-Reply-To: <20200429173352.29442-1-philmd@redhat.com>
Subject: Re: [RFC PATCH 0/1] hw/audio: Make 'soundhw' command line option a
 QOM interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Wed, 29 Apr 2020 16:19:06 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 18:33:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyOTE3MzM1Mi4yOTQ0
Mi0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWlt
YWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgTElOSyAgICBhYXJj
aDY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0tYWFyY2g2NHcuZXhlCi4uL2h3L2F1ZGlvL3NvdW5kaHcu
bzogSW4gZnVuY3Rpb24gYHNvdW5kaHdfY3JlYXRlX2VudHJ5JzoKL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L2F1ZGlvL3NvdW5kaHcuYzoxMzY6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGlzYV9jcmVh
dGVfc2ltcGxlJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFr
ZVsxXTogKioqIFtNYWtlZmlsZToyMDg6IHFlbXUtc3lzdGVtLWFhcmNoNjR3LmV4ZV0gRXJyb3Ig
MQptYWtlOiAqKiogW01ha2VmaWxlOjUyNzogYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpt
YWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIEdFTiAgICAgeDg2XzY0
LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0LmV4ZQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNh
bGwgbGFzdCk6Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkK
c3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdk
b2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0zZGEwYzlk
ODNhMjI0NjcwYjE5YTBkNDdlMjI3YWY1NycsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0
JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICct
ZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICct
ZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90
bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2Fj
aGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LV9mcWh1bGR5L3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMjktMTkuMTYuMjEuMjc0OTk6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
bWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9M2RhMGM5ZDgzYTIyNDY3MGIxOWEwZDQ3ZTIy
N2FmNTcKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtX2ZxaHVsZHkvc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm00
NC42MDlzCnVzZXIgICAgMG03Ljg5OHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI5MTczMzUyLjI5NDQyLTEtcGhpbG1kQHJlZGhh
dC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

