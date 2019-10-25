Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1C1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474A221929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474A221929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNszz-0007Hb-EX
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNszA-0005ti-Bt
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNsz8-0004Hh-Kt
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:22:07 -0400
Resent-Date: Fri, 25 Oct 2019 02:22:07 -0400
Resent-Message-Id: <E1iNsz8-0004Hh-Kt@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNsz7-0004Gv-Pd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:22:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571984498; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lMsL5aURGeoF+OIMigFruL5I4cyrZ0Rv9qKsuemNLxyRYnBjfcETu6Dh8fRg5TDtPhzDxjsB4sf2vc2S6wbvmiaRKYYASbk52EEXGC8pTCYOgg8pOoLXgfbuUj9J94XuMvXOd1YtNcThrH1+AHHp4Sdwt75/K+dKiTi2v7lB2mk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571984498;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=21Kty8O781Lb+S9ZG+maCGjc2+figRrW3+QIcQJStYo=; 
 b=Qc730j4brNN8s6TOYu+E/TRwONX8zX50RmSNeVrXmspuIosI/EmO9NZ8V9I5R56Qgk/ubMgwX+7XWNRmRYIYP0DbX7PpGh3QLSJwj2aEidBiJZNdNO5roDSNrlY8uO+HHYrJFmpLnZVmVPI7YsbBGkUfqwWcvcodx2f5NAllWwM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571984496849216.40821625631452;
 Thu, 24 Oct 2019 23:21:36 -0700 (PDT)
In-Reply-To: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
Subject: Re: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing to VM
Message-ID: <157198449500.8606.5481357465414698106@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yi.l.liu@intel.com
Date: Thu, 24 Oct 2019 23:21:36 -0700 (PDT)
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
bGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50
b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hP
V19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IGh3L3BjaS9wY2lfaG9zdC5vCiAgQ0MgICAgICBody9wY2kvcGNpZS5vCi90bXAvcWVtdS10ZXN0
L3NyYy9ody9wY2ktaG9zdC9kZXNpZ253YXJlLmM6IEluIGZ1bmN0aW9uICdkZXNpZ253YXJlX3Bj
aWVfaG9zdF9yZWFsaXplJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3BjaS1ob3N0L2Rlc2lnbndh
cmUuYzo2OTM6NTogZXJyb3I6IGluY29tcGF0aWJsZSB0eXBlIGZvciBhcmd1bWVudCAyIG9mICdw
Y2lfc2V0dXBfaW9tbXUnCiAgICAgcGNpX3NldHVwX2lvbW11KHBjaS0+YnVzLCBkZXNpZ253YXJl
X2lvbW11X29wcywgcyk7CiAgICAgXgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRl
c3Qvc3JjL2luY2x1ZGUvaHcvcGNpL21zaS5oOjI0OjAsCi0tLQovdG1wL3FlbXUtdGVzdC9zcmMv
aW5jbHVkZS9ody9wY2kvcGNpLmg6NDk1OjY6IG5vdGU6IGV4cGVjdGVkICdjb25zdCBzdHJ1Y3Qg
UENJSU9NTVVPcHMgKicgYnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUgJ1BDSUlPTU1VT3BzJwogdm9p
ZCBwY2lfc2V0dXBfaW9tbXUoUENJQnVzICpidXMsIGNvbnN0IFBDSUlPTU1VT3BzICppb21tdV9v
cHMsIHZvaWQgKm9wYXF1ZSk7CiAgICAgIF4KbWFrZTogKioqIFtody9wY2ktaG9zdC9kZXNpZ253
YXJlLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2Vy
L2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFBy
b2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBD
b21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9MDkyYzBmOTc1MGU2NDU0NzgwZGNlYWQ0MzZlNmJjMmMnLCAnLXUn
LCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScs
ICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEn
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1paDN6aHpzMy9zcmMvZG9ja2VyLXNyYy4yMDE5LTEw
LTI1LTAyLjE4LjI2LjMyMDU4Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0w
OTJjMGY5NzUwZTY0NTQ3ODBkY2VhZDQzNmU2YmMyYwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1paDN6aHpzMy9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNl
bnRvczddIEVycm9yIDIKCnJlYWwgICAgM204Ljc4M3MKdXNlciAgICAwbTguMDkzcwoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3MTkyMDQ4
My0zMzgyLTEtZ2l0LXNlbmQtZW1haWwteWkubC5saXVAaW50ZWwuY29tL3Rlc3RpbmcuZG9ja2Vy
LXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


