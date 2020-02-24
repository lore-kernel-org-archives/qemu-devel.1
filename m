Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E6C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E6F20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E6F20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LqW-00015j-Kk
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j6Lps-0000bs-7x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j6Lpq-0004yT-5V
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:04:19 -0500
Resent-Date: Mon, 24 Feb 2020 17:04:19 -0500
Resent-Message-Id: <E1j6Lpq-0004yT-5V@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j6Lpp-0004y5-Gg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:04:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582581835; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X6DNmBXRp22QZcX1SYwmK3BhPQY3vonlon83Ydop9hvy87/EpZl8ShROVLKDsg54Rva1mwgeUOyA2EZZ03+A2lOBJUtD63/jvX/TRyktDIeg8KHRj5H7S3wBnA7rbIwpDxAnoESilpHnZDyNXSVQIQe+8NreGGhFrrllD/LvTuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582581835;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=j0F/ffmsH8qllOFcHhbF9X5wlvIVs+BgOski2/kXMeE=; 
 b=jyy7qMVxGOAeu980+plKqBAzDRTqUdTSiXz2QoP1+7emd1QQDFmVCS4BYICiSBy5pZX2SvZHBouigYBsEH59d8KEz+O6+k5+PkXJB5fBg0JNZ6SM/PqN31W7im/PcgF3RpVl59js2qx4x+ZKqO4cTb/1bfbiBRxISB0VUVyjpHc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158258183419247.451301518750256;
 Mon, 24 Feb 2020 14:03:54 -0800 (PST)
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
Subject: Re: [PATCH v5 00/50] Initial support for multi-process qemu
Message-ID: <158258183125.10132.3242391756831736721@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jag.raman@oracle.com
Date: Mon, 24 Feb 2020 14:03:54 -0800 (PST)
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTgyNTc2MzcyLmdp
dC5qYWcucmFtYW5Ab3JhY2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgc3R1
YnMvc3lzYnVzLm8KICBDQyAgICAgIHN0dWJzL3RwbS5vCgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVy
cm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy9kZXZlbC9pbmRleC5yc3Q6MTM6dG9jdHJlZSBj
b250YWlucyByZWZlcmVuY2UgdG8gbm9uZXhpc3RpbmcgZG9jdW1lbnQgJ211bHRpLXByb2Nlc3Mn
CiAgQ0MgICAgICBzdHVicy90cmFjZS1jb250cm9sLm8KICBDQyAgICAgIHN0dWJzL3V1aWQubwog
IENDICAgICAgc3R1YnMvdm0tc3RvcC5vCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA2MzogZG9jcy9k
ZXZlbC9pbmRleC5odG1sXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVk
IGpvYnMuLi4uCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVk
ZS9tb25pdG9yL3FkZXYuaDo0LAogICAgICAgICAgICAgICAgIGZyb20gL3RtcC9xZW11LXRlc3Qv
c3JjL3N0dWJzL21vbml0b3IuYzoxNDoKL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvaHcvcHJv
eHkvcWVtdS1wcm94eS5oOjEyOjEwOiBmYXRhbCBlcnJvcjogbGludXgva3ZtLmg6IE5vIHN1Y2gg
ZmlsZSBvciBkaXJlY3RvcnkKICNpbmNsdWRlIDxsaW51eC9rdm0uaD4KICAgICAgICAgIF5+fn5+
fn5+fn5+fn4KY29tcGlsYXRpb24gdGVybWluYXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVz
dC9zcmMvcnVsZXMubWFrOjY5OiBzdHVicy9tb25pdG9yLm9dIEVycm9yIDEKVHJhY2ViYWNrICht
b3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIs
IGxpbmUgNjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNl
IENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vz
c0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVs
JywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NGY4Y2Y0YjNjNWQ5NDI1Y2I3Y2UyZTUwOTYyNjAx
YTInLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQn
LCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09Q
VFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NI
T1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9t
ZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAn
LXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWd4NmZ4c2oyL3NyYy9kb2NrZXItc3Jj
LjIwMjAtMDItMjQtMTcuMDAuMTIuMzA3MDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRv
cmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVy
byBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD00ZjhjZjRiM2M1ZDk0MjVjYjdjZTJlNTA5NjI2MDFhMgptYWtlWzFdOiAqKiogW2RvY2tl
ci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC1neDZmeHNqMi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1p
bmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTM0Ljc2OXMKdXNlciAgICAwbTQuNTU4cwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292
ZXIuMTU4MjU3NjM3Mi5naXQuamFnLnJhbWFuQG9yYWNsZS5jb20vdGVzdGluZy5kb2NrZXItbWlu
Z3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

