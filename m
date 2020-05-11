Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8076C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A549E206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A549E206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCnf-0005j7-Ot
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYCm7-0004hw-Qf
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:03:35 -0400
Resent-Date: Mon, 11 May 2020 14:03:35 -0400
Resent-Message-Id: <E1jYCm7-0004hw-Qf@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYCm6-00015L-3Q
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:03:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589220199; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gyhfELcGtIwYcnrY+N1xXokWNIHkfYxM3+RjjyEtPD5K/UyjXy1l3EjeU/s/zEnXxA6LqpPKFrzArP2sRYLKdyHrD3MQS35vLatKfzekxPGwqMBvwtEY8b8TEFoe6YzCABQZHfQTAoA/2+TN/sDnHlO4X55Bhabf5tJW7yofv0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589220199;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9kNkXkEfpW1s3FbedToxC0jJmaeK2yubekkoApAOUUk=; 
 b=TEWMFDlXRmsmeSa+q6MN0+QoHzMAXuw1ztuhAaixXoZOBAV0aeO4deLWOaevgtfo68W9iT+yOmj4iTEAXQ2ojMeItiDYzYs92V5mRKwhz4GMZohN9ViKe9wYV8xFdnBedIcXLqlzuywDJWR++YyMCDatK5pEirTjmo8DuKASW/0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589220197984719.7258101779075;
 Mon, 11 May 2020 11:03:17 -0700 (PDT)
Message-ID: <158922019623.26583.11463412279323664563@45ef0f9c86ae>
In-Reply-To: <20200511160951.8733-1-mlevitsk@redhat.com>
Subject: Re: [PATCH v2 0/7] RFC/WIP: Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mlevitsk@redhat.com
Date: Mon, 11 May 2020 11:03:17 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 14:03:32
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
Cc: fam@euphon.net, berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, mlevitsk@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxMTE2MDk1MS44NzMz
LTEtbWxldml0c2tAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgaW90ZXN0LXFj
b3cyOiAxMTEKICBURVNUICAgIGlvdGVzdC1xY293MjogMTE0CioqCkVSUk9SOi90bXAvcWVtdS10
ZXN0L3NyYy9xb20vb2JqZWN0LmM6MTEyNDpvYmplY3RfdW5yZWY6IGFzc2VydGlvbiBmYWlsZWQ6
IChvYmotPnJlZiA+IDApCkJyb2tlbiBwaXBlCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVz
dC9saWJxdGVzdC5jOjE3NToga2lsbF9xZW11KCkgZGV0ZWN0ZWQgUUVNVSBkZWF0aCBmcm9tIHNp
Z25hbCA2IChBYm9ydGVkKSAoY29yZSBkdW1wZWQpCkVSUk9SIC0gdG9vIGZldyB0ZXN0cyBydW4g
KGV4cGVjdGVkIDYsIGdvdCA1KQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LWFhcmNoNjRdIEVycm9y
IDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAgIGlv
dGVzdC1xY293MjogMTE3CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDEyMAotLS0KICAgIHJhaXNl
IENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vz
c0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVs
JywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZjRiYjdkMjFjNDM4NDYzNGEzMjJjMmY1Y2QzOGIx
YmYnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQn
LCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09Q
VFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NI
T1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hv
bWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdDk3anlvd2gvc3JjL2RvY2tlci1z
cmMuMjAyMC0wNS0xMS0xMy40OC4xNi44NTYxOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNl
bnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24t
emVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFu
Y2UudXVpZD1mNGJiN2QyMWM0Mzg0NjM0YTMyMmMyZjVjZDM4YjFiZgptYWtlWzFdOiAqKiogW2Rv
Y2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC10OTdqeW93aC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0
LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTVtMC4xMzVzCnVzZXIgICAgMG04LjYy
NXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwNTExMTYwOTUxLjg3MzMtMS1tbGV2aXRza0ByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2Vy
LXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

