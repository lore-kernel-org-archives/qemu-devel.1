Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E875CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D882070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D882070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNt8B-0007Xz-Dd
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNt7L-0006iD-0K
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNt7J-00070P-8z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:30:34 -0400
Resent-Date: Fri, 25 Oct 2019 02:30:34 -0400
Resent-Message-Id: <E1iNt7J-00070P-8z@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNt7J-000706-1A
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571985016; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cX5NB5iFS+gaJwrqQ0dVshzWLzEOBRSHY+1Uu8FHT0Mwjlk6LkNAqoIoDeTnmwfmHRZtZKRZwEs1FRDcRa0x7IKkoL4hpbf5GhxNfPAul6pg4gK5LJf5Pi5ZbuJ5MLNVBfHTGNPAfItY2QXK2nimz5fXRrXEL8VMthsPBjgaVTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571985016;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=azCxEkF5FPPXrvBkyfF1UVi2CemWVTQoli9kvBdoI/4=; 
 b=FINIa9e1KPgE6+/AHl9Uhi2E8cqIb7V6sXJbCNEukviUpifauRVX0QrC02lzlcc6MN8nah7kfx8ZUIbL8oChG+HvxszIMl8klk9ThRHmtcs3f8LnUx3D6lel+fxUBgFH4555L/yuSvClxxuVYConjvS4HpsyikvY0QMTFZXpg34=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571985014307838.2650256655787;
 Thu, 24 Oct 2019 23:30:14 -0700 (PDT)
In-Reply-To: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
Subject: Re: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing to VM
Message-ID: <157198501236.8606.12214821075996433238@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yi.l.liu@intel.com
Date: Thu, 24 Oct 2019 23:30:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com, pbonzini@redhat.com,
 yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcxOTIwNDgzLTMzODItMS1n
aXQtc2VuZC1lbWFpbC15aS5sLmxpdUBpbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFr
ZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0
LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIGh3L3BjaS9wY2lfaG9zdC5vCiAgQ0MgICAgICBody9wY2kvcGNpZS5vCi90bXAvcWVt
dS10ZXN0L3NyYy9ody9wY2ktaG9zdC9kZXNpZ253YXJlLmM6IEluIGZ1bmN0aW9uICdkZXNpZ253
YXJlX3BjaWVfaG9zdF9yZWFsaXplJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3BjaS1ob3N0L2Rl
c2lnbndhcmUuYzo2OTM6MzE6IGVycm9yOiBpbmNvbXBhdGlibGUgdHlwZSBmb3IgYXJndW1lbnQg
MiBvZiAncGNpX3NldHVwX2lvbW11JwogICAgIHBjaV9zZXR1cF9pb21tdShwY2ktPmJ1cywgZGVz
aWdud2FyZV9pb21tdV9vcHMsIHMpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+fn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3Ny
Yy9pbmNsdWRlL2h3L3BjaS9tc2kuaDoyNCwKLS0tCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRl
L2h3L3BjaS9wY2kuaDo0OTU6NTQ6IG5vdGU6IGV4cGVjdGVkICdjb25zdCBQQ0lJT01NVU9wcyAq
JyB7YWthICdjb25zdCBzdHJ1Y3QgUENJSU9NTVVPcHMgKid9IGJ1dCBhcmd1bWVudCBpcyBvZiB0
eXBlICdQQ0lJT01NVU9wcycge2FrYSAnY29uc3Qgc3RydWN0IFBDSUlPTU1VT3BzJ30KIHZvaWQg
cGNpX3NldHVwX2lvbW11KFBDSUJ1cyAqYnVzLCBjb25zdCBQQ0lJT01NVU9wcyAqaW9tbXVfb3Bz
LCB2b2lkICpvcGFxdWUpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+
fn5+fn5+fn5+fn5+fn5efn5+fn5+fn4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVs
ZXMubWFrOjY5OiBody9wY2ktaG9zdC9kZXNpZ253YXJlLm9dIEVycm9yIDEKbWFrZTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxs
IGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8
bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1
YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9j
a2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YzI2Njc5OTI4
YTljNDMyZDk4MzI5NzhhY2Q4MGUyMGInLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcs
ICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUn
LCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUn
LCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1w
L2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hl
Oi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1j
NWlqMnRyaS9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTI1LTAyLjI3LjI3LjE2NTk1Oi92YXIvdG1w
L3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1p
bmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWMyNjY3OTkyOGE5YzQzMmQ5ODMyOTc4YWNkODBl
MjBiCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWM1aWoydHJpL3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDJtNDUu
Njg2cwp1c2VyICAgIDBtNy44NDFzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8xNTcxOTIwNDgzLTMzODItMS1naXQtc2VuZC1lbWFpbC15aS5s
LmxpdUBpbnRlbC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t


