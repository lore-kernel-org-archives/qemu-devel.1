Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E9C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2A5206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2A5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYUF-0006oY-VQ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iIYKR-0001j6-3R
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iIYKP-0002jS-Kq
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:03 -0400
Resent-Date: Thu, 10 Oct 2019 09:18:03 -0400
Resent-Message-Id: <E1iIYKP-0002jS-Kq@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iIYKP-0002gj-C1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570713471; cv=none; d=zoho.com; s=zohoarc; 
 b=LaVaFhhkwdYOXSOox7ap4OTnntxVYGYm20ZYRNhQWcQ7iy1y1vx94+c/i3AwLMQorxe32S6Nh9cuEi0Ftcok4QAl0KCrRntGrMgq1sn6DItwZbfdnhau7CynKiz3LKQPm6ZfNL4yek3rEJtjacgM/yT4AbDbJnhUxVrfSxpXiz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570713471;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=g0WLVrpjr28wYIDj0dy/VdaNm7YZl8R4X3gNfVKUioI=; 
 b=m6WXT9KvMM/mhcTLFWJsszhn2EkNYvpTm0JzMhM7Cy+fB6ejhGZBwfTNwk+X1FHIkS3gbdTojlvowxF/B6yqDIR8I5VhnNhYc4rFnQY6R8Kr0SJpxyV8qhIDNLivk5VBGCWCYBdgBlA5wqdA/Ns4sHgzYCKqfB4HSDApOWy1fMw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570713470373499.9981036643038;
 Thu, 10 Oct 2019 06:17:50 -0700 (PDT)
In-Reply-To: <1570709475-32073-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
Subject: Re: [PATCH v3] virtio-net: prevent offloads reset on migration
Message-ID: <157071346912.7138.18171128967446470529@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mikhail.sennikovskii@cloud.ionos.com
Date: Thu, 10 Oct 2019 06:17:50 -0700 (PDT)
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
Cc: mst@redhat.com, jasowang@redhat.com, dgilbert@redhat.com,
 qemu-devel@nongnu.org, mikhail.sennikovskii@cloud.ionos.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcwNzA5NDc1LTMyMDczLTIt
Z2l0LXNlbmQtZW1haWwtbWlraGFpbC5zZW5uaWtvdnNraWlAY2xvdWQuaW9ub3MuY29tLwoKCgpI
aSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0
LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93
LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVj
ZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhw
b3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRp
bWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9ody9pMzg2L2FjcGktYnVp
bGQubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvbW9uaXRvci9taXNjLm8KL3RtcC9xZW11LXRl
c3Qvc3JjL2h3L25ldC92aXJ0aW8tbmV0LmM6IEluIGZ1bmN0aW9uICd2aXJ0aW9fbmV0X3NldF9m
ZWF0dXJlcyc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9uZXQvdmlydGlvLW5ldC5jOjc4MDoyOTog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdydW5zdGF0ZV9jaGVjayc7
IGRpZCB5b3UgbWVhbiAndHlwZV9jaGVjayc/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRl
Y2xhcmF0aW9uXQogICAgIGlmIChuLT5oYXNfdm5ldF9oZHIgJiYgIXJ1bnN0YXRlX2NoZWNrKFJV
Tl9TVEFURV9JTk1JR1JBVEUpKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+
fn5+fn5+fn4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlX2NoZWNrCi90bXAvcWVt
dS10ZXN0L3NyYy9ody9uZXQvdmlydGlvLW5ldC5jOjc4MDoyOTogZXJyb3I6IG5lc3RlZCBleHRl
cm4gZGVjbGFyYXRpb24gb2YgJ3J1bnN0YXRlX2NoZWNrJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJu
c10KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC92aXJ0aW8tbmV0LmM6NzgwOjQ0OiBlcnJvcjog
J1JVTl9TVEFURV9JTk1JR1JBVEUnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0
aW9uKTsgZGlkIHlvdSBtZWFuICdSWF9TVEFURV9fTUFYJz8KICAgICBpZiAobi0+aGFzX3ZuZXRf
aGRyICYmICFydW5zdGF0ZV9jaGVjayhSVU5fU1RBVEVfSU5NSUdSQVRFKSkgewogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn4KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSWF9TVEFURV9fTUFYCi90
bXAvcWVtdS10ZXN0L3NyYy9ody9uZXQvdmlydGlvLW5ldC5jOjc4MDo0NDogbm90ZTogZWFjaCB1
bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0
aW9uIGl0IGFwcGVhcnMgaW4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJv
cnMKICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9pbnB1dC9weGEyeHhfa2V5cGFkLm8KbWFr
ZVsxXTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9uZXQvdmlydGlv
LW5ldC5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9xYXBpL3FhcGktaW50cm9zcGVjdC5vCiAgQ0Mg
ICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvaW5wdXQvdHNjMjEweC5vCi0tLQogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L2h3L2FybS9mc2wtaW14NnVsLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1t
dS9ody9hcm0vbWNpbXg2dWwtZXZrLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC92aXJ0aW8t
bmV0LmM6IEluIGZ1bmN0aW9uICd2aXJ0aW9fbmV0X3NldF9mZWF0dXJlcyc6Ci90bXAvcWVtdS10
ZXN0L3NyYy9ody9uZXQvdmlydGlvLW5ldC5jOjc4MDoyOTogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uICdydW5zdGF0ZV9jaGVjayc7IGRpZCB5b3UgbWVhbiAndHlwZV9j
aGVjayc/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgIGlmIChu
LT5oYXNfdm5ldF9oZHIgJiYgIXJ1bnN0YXRlX2NoZWNrKFJVTl9TVEFURV9JTk1JR1JBVEUpKSB7
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn4KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB0eXBlX2NoZWNrCi90bXAvcWVtdS10ZXN0L3NyYy9ody9uZXQvdmly
dGlvLW5ldC5jOjc4MDoyOTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2YgJ3J1
bnN0YXRlX2NoZWNrJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L25ldC92aXJ0aW8tbmV0LmM6NzgwOjQ0OiBlcnJvcjogJ1JVTl9TVEFURV9JTk1JR1JBVEUn
IHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuICdS
WF9TVEFURV9fTUFYJz8KICAgICBpZiAobi0+aGFzX3ZuZXRfaGRyICYmICFydW5zdGF0ZV9jaGVj
ayhSVU5fU1RBVEVfSU5NSUdSQVRFKSkgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBSWF9TVEFURV9fTUFYCi90bXAvcWVtdS10ZXN0L3NyYy9ody9u
ZXQvdmlydGlvLW5ldC5jOjc4MDo0NDogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIg
aXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KY2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFsvdG1w
L3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9uZXQvdmlydGlvLW5ldC5vXSBFcnJvciAx
Cm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICBh
YXJjaDY0LXNvZnRtbXUvaHcvYXJtL25yZjUxX3NvYy5vCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDgy
OiB4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmlu
aXNoZWQgam9icy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZTo0ODI6IGFhcmNoNjQtc29mdG1tdS9h
bGxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4v
dGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8bW9kdWxlPgogICAgc3lzLmV4
aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQp
CnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAn
ZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MTNmMzFh
MjNjZGFhNDNmYWIxMjY0MjgxMDI5NTQwNTMnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9w
dCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAn
LWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAn
LWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIv
dG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2Fj
aGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LThpNGk2azhqL3NyYy9kb2NrZXItc3JjLjIwMTktMTAtMTAtMDkuMTUuMzYuMjI1ODI6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
bWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MTNmMzFhMjNjZGFhNDNmYWIxMjY0MjgxMDI5
NTQwNTMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOGk0aTZrOGovc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm0x
My44MTNzCnVzZXIgICAgMG04LjQ4N3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NzA3MDk0NzUtMzIwNzMtMi1naXQtc2VuZC1lbWFpbC1t
aWtoYWlsLnNlbm5pa292c2tpaUBjbG91ZC5pb25vcy5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dA
ZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


