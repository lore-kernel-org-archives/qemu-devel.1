Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784E1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5C9206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5C9206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZduC-00018P-H9
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZdpg-0000x6-6G
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:09:12 -0400
Resent-Date: Fri, 15 May 2020 13:09:12 -0400
Resent-Message-Id: <E1jZdpg-0000x6-6G@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZdpe-00033U-Di
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:09:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589562518; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZiliowonUhJuTIh7aRVPHxIYSHRQR1us0rTiZ/9WrT5jNNZbbw7bvA6z1EP2jfx56jbLq5o3BeiM0WDqux4HRW7RTjBsqOZxZhAumyHGCw45pm9Ap8f8fgHvieHMqsKm4Sazc5i+kYhquviM2vYircZCJUlLo7QsyKkZEbwpy3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589562518;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=U/IbPdlOQQ1L0fKOqXgcqZXtIozW/ErEF0PkgZuEhmI=; 
 b=SkElamHL0zKkACD/0bYdFCr2nVW4oQWROlJptn5AmBmScu54W4e9Vqbm/7sjXJx+5b67XILFb85ED2/FjM0bv3S9Z2YkgQAhptGaW6J54177TijqUJj4di+AfRI69a4xySj+o8CVO9PdCBZXbQ5MNUEDlpmOXqcQlup4ajjMr1g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589562517163565.0743742151658;
 Fri, 15 May 2020 10:08:37 -0700 (PDT)
Message-ID: <158956251543.7125.7498099153827296814@45ef0f9c86ae>
In-Reply-To: <1589537195-31392-1-git-send-email-ani.sinha@nutanix.com>
Subject: Re: [PATCH] Add a new PIIX option to control global PCI hot-plugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ani.sinha@nutanix.com
Date: Fri, 15 May 2020 10:08:37 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 10:35:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: qemu-devel@nongnu.org
Cc: ani.sinha@nutanix.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, imammedo@redhat.com,
 ani@anisinha.ca, pbonzini@redhat.com, philmd@redhat.com, aurelien@aurel32.net,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg5NTM3MTk1LTMxMzkyLTEt
Z2l0LXNlbmQtZW1haWwtYW5pLnNpbmhhQG51dGFuaXguY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IGZhaWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0
aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBE
b2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0
Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXIt
dGVzdC1taW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
CiAgICAgICAgICAgICAgICAgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9ody9pMzg2
L3BjLmg6NiwKICAgICAgICAgICAgICAgICBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3Bp
L3BpaXg0LmM6MjM6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL3BpaXg0LmM6IEluIGZ1bmN0
aW9uICdwaWl4NF9hY3BpX3N5c3RlbV9ob3RfYWRkX2luaXQnOgovdG1wL3FlbXUtdGVzdC9zcmMv
aHcvYWNwaS9waWl4NC5jOjU5ODo1MDogZXJyb3I6ICdkZXYnIHVuZGVjbGFyZWQgKGZpcnN0IHVz
ZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuICdkaXYnPwogICAgICAgICBxYnVzX3Nl
dF9ob3RwbHVnX2hhbmRsZXIoQlVTKHBjaV9nZXRfYnVzKGRldikpLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fgovdG1wL3FlbXUtdGVzdC9zcmMv
aW5jbHVkZS9xb20vb2JqZWN0Lmg6NTExOjE3OiBub3RlOiBpbiBkZWZpbml0aW9uIG9mIG1hY3Jv
ICdPQkpFQ1QnCi0tLQovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9waWl4NC5jOjU5ODozNDog
bm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdCVVMnCiAgICAgICAgIHFidXNfc2V0X2hvdHBs
dWdfaGFuZGxlcihCVVMocGNpX2dldF9idXMoZGV2KSksCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBefn4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5
OiBody9hY3BpL3BpaXg0Lm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNo
ZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4v
dGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxh
YmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MmEyMTczYzI1MzQyNDZlZmIzYmI2ZDBhZjA3
ZTc0NmMnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmlu
ZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJF
X09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywg
J1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcv
aG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6
JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1jcThtcGIzcS9zcmMvZG9ja2Vy
LXNyYy4yMDIwLTA1LTE1LTEzLjA2LjU5LjU5MDI6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6
ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9u
LXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9MmEyMTczYzI1MzQyNDZlZmIzYmI2ZDBhZjA3ZTc0NmMKbWFrZVsxXTogKioqIFtk
b2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtY3E4bXBiM3Evc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVz
dC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMW0zNi41NTFzCnVzZXIgICAgMG03Ljgy
OXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzE1ODk1MzcxOTUtMzEzOTItMS1naXQtc2VuZC1lbWFpbC1hbmkuc2luaGFAbnV0YW5peC5jb20v
dGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

