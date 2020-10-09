Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6A2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A118F22281
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azn0lafQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A118F22281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyCQ-0001YA-Jr
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyB2-0008UX-Iq
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyB0-0002om-HC
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=66X3Bs8TO4TtKOzhACQ2+6zs+nPFhtdV8G/Z6qaRdAI=;
 b=azn0lafQPJY1OuFkSKxqUc/M3YMqCj6JO3ryRhd/7UZzrVDek/lx6FuFcNOZn20mWb9xw7
 DPHqFBE7m/bDG21PIDKNvoF4gzh17GI4Rs37bXrfkRhEj9C1akD+A1PxiZ+eKPuxRGDR7h
 E7LSTlfaNBlPyQkgvPvZEz/49Q+Hws8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-oskHAv82OPakopEFRIIP1w-1; Fri, 09 Oct 2020 15:35:35 -0400
X-MC-Unique: oskHAv82OPakopEFRIIP1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A423186DD2B;
 Fri,  9 Oct 2020 19:35:34 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE17A76642;
 Fri,  9 Oct 2020 19:35:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 00/30] Block patches
Date: Fri,  9 Oct 2020 20:34:59 +0100
Message-Id: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA0OTdkNDE1ZDc2YjlmNTlmY2FlMjdm
MjJkZjFjYTJjM2ZhNGRmNjRlOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvcG1heWRlbGwvdGFncy9wdWxsLXRhcmdldC1hcm0tMjAyMDEwMDgtMScgaW50byBzdGFn
aW5nICgyMDIwLTEwLTA4IDIxOjQxOjIwICswMTAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBH
aXQgcmVwb3NpdG9yeSBhdDoNCg0KICBodHRwczovL2dpdGxhYi5jb20vc3RlZmFuaGEvcWVtdS5n
aXQgdGFncy9ibG9jay1wdWxsLXJlcXVlc3QNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIGU5NjljN2IwNDVjOTAzNjhiYzNhNWRiMzQ3OWU3MGI2ZjBlY2I4Mjg6DQoNCiAgaW90ZXN0
czogYWRkIGNvbW1pdCB0b3AtPmJhc2UgY2FzZXMgdG8gMjc0ICgyMDIwLTEwLTA5IDE0OjMyOjI0
ICswMTAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpQdWxsIHJlcXVlc3QNCg0KVGhpcyBwdWxsIHJlcXVlc3QgaW5j
bHVkZXMgdGhlIHZob3N0LXVzZXItYmxrIHNlcnZlciBieSBDb2lieSBYdSwgdGhlIGJsb2NrDQpj
b3JvdXRpbmUgY29kZSBnZW5lcmF0b3IgYnkgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSwg
bnZtZSBibG9jayBkcml2ZXINCnN0YXRpc3RpY3MgYnkgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6ks
IGFuZCBjbGVhbnVwcy9maXhlcy9hZGRpdGlvbnMgdG8gdGhlDQp2aG9zdC11c2VyLWJsayBzZXJ2
ZXIgYnkgbWUuDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQ29pYnkgWHUgKDcpOg0KICBsaWJ2aG9zdC11c2VyOiBB
bGxvdyB2dV9tZXNzYWdlX3JlYWQgdG8gYmUgcmVwbGFjZWQNCiAgbGlidmhvc3QtdXNlcjogcmVt
b3ZlIHdhdGNoIGZvciBraWNrX2ZkIHdoZW4gZGUtaW5pdGlhbGl6ZSB2dS1kZXYNCiAgdXRpbC92
aG9zdC11c2VyLXNlcnZlcjogZ2VuZXJpYyB2aG9zdCB1c2VyIHNlcnZlcg0KICBibG9jazogbW92
ZSBsb2dpY2FsIGJsb2NrIHNpemUgY2hlY2sgZnVuY3Rpb24gdG8gYSBjb21tb24gdXRpbGl0eQ0K
ICAgIGZ1bmN0aW9uDQogIGJsb2NrL2V4cG9ydDogdmhvc3QtdXNlciBibG9jayBkZXZpY2UgYmFj
a2VuZCBzZXJ2ZXINCiAgdGVzdDogbmV3IHFUZXN0IGNhc2UgdG8gdGVzdCB0aGUgdmhvc3QtdXNl
ci1ibGstc2VydmVyDQogIE1BSU5UQUlORVJTOiBBZGQgdmhvc3QtdXNlciBibG9jayBkZXZpY2Ug
YmFja2VuZCBzZXJ2ZXIgbWFpbnRhaW5lcg0KDQpQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSAoMSk6
DQogIGJsb2NrL252bWU6IEFkZCBkcml2ZXIgc3RhdGlzdGljcyBmb3IgYWNjZXNzIGFsaWdubWVu
dCBhbmQgaHcgZXJyb3JzDQoNClN0ZWZhbiBIYWpub2N6aSAoMTcpOg0KICB1dGlsL3Zob3N0LXVz
ZXItc2VydmVyOiBzL2ZpbGVkcy9maWVsZHMvIHR5cG8gZml4DQogIHV0aWwvdmhvc3QtdXNlci1z
ZXJ2ZXI6IGRyb3AgdW5uZWNlc3NhcnkgUU9NIGNhc3QNCiAgdXRpbC92aG9zdC11c2VyLXNlcnZl
cjogZHJvcCB1bm5lY2Vzc2FyeSB3YXRjaCBkZWxldGlvbg0KICBibG9jay9leHBvcnQ6IGNvbnNv
bGlkYXRlIHJlcXVlc3Qgc3RydWN0cyBpbnRvIFZ1QmxvY2tSZXENCiAgdXRpbC92aG9zdC11c2Vy
LXNlcnZlcjogZHJvcCB1bnVzZWQgRGV2aWNlUGFuaWNOb3RpZmllcg0KICB1dGlsL3Zob3N0LXVz
ZXItc2VydmVyOiBmaXggbWVtb3J5IGxlYWsgaW4gdnVfbWVzc2FnZV9yZWFkKCkNCiAgdXRpbC92
aG9zdC11c2VyLXNlcnZlcjogY2hlY2sgRU9GIHdoZW4gcmVhZGluZyBwYXlsb2FkDQogIHV0aWwv
dmhvc3QtdXNlci1zZXJ2ZXI6IHJld29yayB2dV9jbGllbnRfdHJpcCgpIGNvcm91dGluZSBsaWZl
Y3ljbGUNCiAgYmxvY2svZXhwb3J0OiByZXBvcnQgZmx1c2ggZXJyb3JzDQogIGJsb2NrL2V4cG9y
dDogY29udmVydCB2aG9zdC11c2VyLWJsayBzZXJ2ZXIgdG8gYmxvY2sgZXhwb3J0IEFQSQ0KICB1
dGlsL3Zob3N0LXVzZXItc2VydmVyOiBtb3ZlIGhlYWRlciB0byBpbmNsdWRlLw0KICB1dGlsL3Zo
b3N0LXVzZXItc2VydmVyOiB1c2Ugc3RhdGljIGxpYnJhcnkgaW4gbWVzb24uYnVpbGQNCiAgcWVt
dS1zdG9yYWdlLWRhZW1vbjogYXZvaWQgY29tcGlsaW5nIGJsb2NrZGV2X3NzIHR3aWNlDQogIGJs
b2NrOiBtb3ZlIGJsb2NrIGV4cG9ydHMgdG8gbGliYmxvY2tkZXYNCiAgYmxvY2svZXhwb3J0OiBh
ZGQgaW90aHJlYWQgYW5kIGZpeGVkLWlvdGhyZWFkIG9wdGlvbnMNCiAgYmxvY2svZXhwb3J0OiBh
ZGQgdmhvc3QtdXNlci1ibGsgbXVsdGktcXVldWUgc3VwcG9ydA0KICB0ZXN0cy9xdGVzdDogYWRk
IG11bHRpLXF1ZXVlIHRlc3QgY2FzZSB0byB2aG9zdC11c2VyLWJsay10ZXN0DQoNClZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgKDUpOg0KICBibG9jay9pbzogZml4IGJkcnZfY29fYmxvY2tf
c3RhdHVzX2Fib3ZlDQogIGJsb2NrL2lvOiBiZHJ2X2NvbW1vbl9ibG9ja19zdGF0dXNfYWJvdmU6
IHN1cHBvcnQgaW5jbHVkZV9iYXNlDQogIGJsb2NrL2lvOiBiZHJ2X2NvbW1vbl9ibG9ja19zdGF0
dXNfYWJvdmU6IHN1cHBvcnQgYnMgPT0gYmFzZQ0KICBibG9jay9pbzogZml4IGJkcnZfaXNfYWxs
b2NhdGVkX2Fib3ZlDQogIGlvdGVzdHM6IGFkZCBjb21taXQgdG9wLT5iYXNlIGNhc2VzIHRvIDI3
NA0KDQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsN
CiBxYXBpL2Jsb2NrLWNvcmUuanNvbiAgICAgICAgICAgICAgICAgICAgICAgfCAgMjQgKy0NCiBx
YXBpL2Jsb2NrLWV4cG9ydC5qc29uICAgICAgICAgICAgICAgICAgICAgfCAgMzYgKy0NCiBibG9j
ay9jb3JvdXRpbmVzLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KIGJsb2NrL2V4
cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuaCAgICAgICB8ICAxOSArDQogY29udHJpYi9saWJ2
aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuaCAgICAgIHwgIDIxICsNCiBpbmNsdWRlL3FlbXUvdmhv
c3QtdXNlci1zZXJ2ZXIuaCAgICAgICAgICAgfCAgNjUgKysNCiB0ZXN0cy9xdGVzdC9saWJxb3Mv
bGlicXRlc3QuaCAgICAgICAgICAgICAgfCAgMTcgKw0KIHRlc3RzL3F0ZXN0L2xpYnFvcy92aG9z
dC11c2VyLWJsay5oICAgICAgICB8ICA0OCArKw0KIHV0aWwvYmxvY2staGVscGVycy5oICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxOSArDQogYmxvY2svZXhwb3J0L2V4cG9ydC5jICAgICAgICAg
ICAgICAgICAgICAgIHwgIDM3ICstDQogYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZl
ci5jICAgICAgIHwgNDMxICsrKysrKysrKysrDQogYmxvY2svaW8uYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTMyICsrLS0NCiBibG9jay9udm1lLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMjcgKw0KIGJsb2NrL3Fjb3cyLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAxNiArLQ0KIGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2Vy
LWdsaWIuYyB8ICAgMiArLQ0KIGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMg
ICAgICB8ICAxNSArLQ0KIGh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLXN5c3RlbS5jICAgICAgICAg
ICB8ICAzMSArLQ0KIG5iZC9zZXJ2ZXIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMiAtDQogcWVtdS1uYmQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIx
ICstDQogc29mdG1tdS92bC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsN
CiBzdHVicy9ibGstZXhwLWNsb3NlLWFsbC5jICAgICAgICAgICAgICAgICAgfCAgIDcgKw0KIHRl
c3RzL3F0ZXN0L2xpYnFvcy92aG9zdC11c2VyLWJsay5jICAgICAgICB8IDEyOSArKysrDQogdGVz
dHMvcXRlc3QvbGlicXRlc3QuYyAgICAgICAgICAgICAgICAgICAgIHwgIDM2ICstDQogdGVzdHMv
cXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5jICAgICAgICAgIHwgODIyICsrKysrKysrKysrKysr
KysrKysrKw0KIHRlc3RzL3Zob3N0LXVzZXItYnJpZGdlLmMgICAgICAgICAgICAgICAgICB8ICAg
MiArDQogdG9vbHMvdmlydGlvZnNkL2Z1c2VfdmlydGlvLmMgICAgICAgICAgICAgIHwgICA0ICst
DQogdXRpbC9ibG9jay1oZWxwZXJzLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDQ2ICsrDQog
dXRpbC92aG9zdC11c2VyLXNlcnZlci5jICAgICAgICAgICAgICAgICAgIHwgNDQ2ICsrKysrKysr
KysrDQogYmxvY2svZXhwb3J0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgIHwgICAzICst
DQogY29udHJpYi9saWJ2aG9zdC11c2VyL21lc29uLmJ1aWxkICAgICAgICAgIHwgICAxICsNCiBt
ZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjIgKy0NCiBuYmQv
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KIHN0b3JhZ2Ut
ZGFlbW9uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICB8ICAgMyArLQ0KIHN0dWJzL21lc29u
LmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogdGVzdHMvcWVtdS1pb3Rl
c3RzLzI3NCAgICAgICAgICAgICAgICAgICAgIHwgIDIwICsNCiB0ZXN0cy9xZW11LWlvdGVzdHMv
Mjc0Lm91dCAgICAgICAgICAgICAgICAgfCAgNjggKysNCiB0ZXN0cy9xdGVzdC9saWJxb3MvbWVz
b24uYnVpbGQgICAgICAgICAgICAgfCAgIDEgKw0KIHRlc3RzL3F0ZXN0L21lc29uLmJ1aWxkICAg
ICAgICAgICAgICAgICAgICB8ICAgNCArLQ0KIHV0aWwvbWVzb24uYnVpbGQgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNCArDQogNDAgZmlsZXMgY2hhbmdlZCwgMjQ3NiBpbnNlcnRpb25z
KCspLCAxMjQgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGJsb2NrL2V4cG9ydC92
aG9zdC11c2VyLWJsay1zZXJ2ZXIuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3FlbXUv
dmhvc3QtdXNlci1zZXJ2ZXIuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9saWJx
b3Mvdmhvc3QtdXNlci1ibGsuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB1dGlsL2Jsb2NrLWhlbHBl
cnMuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2Vy
dmVyLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgc3R1YnMvYmxrLWV4cC1jbG9zZS1hbGwuYw0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9saWJxb3Mvdmhvc3QtdXNlci1ibGsuYw0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdXRpbC9ibG9jay1oZWxwZXJzLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dXRpbC92aG9zdC11c2VyLXNlcnZlci5jDQoNCi0tIA0KMi4yNi4yDQoNCg==


