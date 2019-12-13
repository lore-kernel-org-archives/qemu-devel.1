Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FEFC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC1122527
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC1122527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iff8V-0007Yf-Ml
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 02:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ning.bo9@zte.com.cn>) id 1iff7j-00070N-4S
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ning.bo9@zte.com.cn>) id 1iff7h-0003Kg-M1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:12:26 -0500
Received: from mx7.zte.com.cn ([202.103.147.169]:41843 helo=mxct.zte.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ning.bo9@zte.com.cn>) id 1iff7h-00032q-AC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:12:25 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 4A152C56BFEA30CD101C;
 Fri, 13 Dec 2019 15:12:13 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
 by mse-fl2.zte.com.cn with SMTP id xBD7BZYr002615;
 Fri, 13 Dec 2019 15:11:55 +0800 (GMT-8)
 (envelope-from ning.bo9@zte.com.cn)
Received: from mapi (kjyxapp07[null]) by mapi (Zmail) with MAPI id mid14;
 Fri, 13 Dec 2019 15:11:54 +0800 (CST)
Date: Fri, 13 Dec 2019 15:11:54 +0800 (CST)
X-Zmail-TransId: 2b095df339baf192d541
X-Mailer: Zmail v1.0
Message-ID: <201912131511549044400@zte.com.cn>
In-Reply-To: <20191212110525.GA1141992@stefanha-x1.localdomain>
References: 20190809134134.GA8594@stefanha-x1.localdomain,
 20191212110525.GA1141992@stefanha-x1.localdomain
Mime-Version: 1.0
From: <ning.bo9@zte.com.cn>
To: <stefanha@gmail.com>
Subject: =?UTF-8?B?UmU6W1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gdmhvc3QtdnNvY2s6IHJlcG9ydCBRTVAgZXZlbnQgd2hlbnNldHJ1bm5pbmc=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn xBD7BZYr002615
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 202.103.147.169
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PiBUaGlzIGNhbiBiZSBkb25lIGVmZmljaWVudGx5IGFzIGZvbGxvd3M6Cj4gMS4ga2F0YS1ydW50
aW1lIGxpc3RlbnMgb24gYSB2c29jayBwb3J0Cj4gMi4ga2F0YS1hZ2VudC1wb3J0PVBPUlQgaXMg
YWRkZWQgdG8gdGhlIGtlcm5lbCBjb21tYW5kLWxpbmUgb3B0aW9ucwo+IDMuIGthdGEtYWdlbnQg
cGFyc2VzIHRoZSBwb3J0IG51bWJlciBhbmQgY29ubmVjdHMgdG8gdGhlIGhvc3QKPiAKPiBUaGlz
IGVsaW1pbmF0ZXMgdGhlIHJlY29ubmVjdGlvbiBhdHRlbXB0cy4KClRoZXJlIHdpbGwgYmUgYW4g
YWRkaXRpb25hbCBwcm9ibGVtIGlmIGRvIHRoaXM6CldobyBkZWNpZGVzIHdoaWNoIHBvcnQgdGhl
IGBydW50aW1lYCBzaG91bGQgbGlzdGVuPwoKQ29uc2lkZXIgdGhlIHdvcnN0IGNhc2U6IApUaGUg
cG9ydHMgc2VsZWN0ZWQgYnkgdHdvIGBydW50aW1lYCBydW5uaW5nIGluIHBhcmFsbGVsIGFsd2F5
cyBjb25mbGljdCwgCmFuZCB0aGlzIGNhc2UgaXMgdW5hdm9pZGFibGUsIGV2ZW4gaWYgd2UgY2Fu
IHJlZHVjZSB0aGUgcG9zc2liaWxpdHkgb2YgY29uZmxpY3RzIHRocm91Z2ggYWxnb3JpdGhtcy4K
QmVjYXVzZSB3ZSBkb24ndCBoYXZlIGEgZGFlbW9uIHRoYXQgY2FuIGFsbG9jYXRlIHVuaXF1ZSBw
b3J0IHRvIGBydW50aW1lYC4KCgo+IFVzZXJzcGFjZSBBUElzIHRvIGF2b2lkIHRoZSAyIHNlY29u
ZCB3YWl0IGFscmVhZHkgZXhpc3Q6Cj4gCj4gMS4gVGhlIFNPX1ZNX1NPQ0tFVFNfQ09OTkVDVF9U
SU1FT1VUIHNvY2tldCBvcHRpb24gY29udHJvbHMgdGhlIGNvbm5lY3QKPiAgICB0aW1lb3V0IGZv
ciB0aGlzIHNvY2tldC4KClllcywgaXQgaGFzIHRoZSBzYW1lIGVmZmVjdAoKPiAyLiBOb24tYmxv
Y2tpbmcgY29ubmVjdCBhbGxvd3MgdGhlIHVzZXJzcGFjZSBwcm9jZXNzIHRvIGRvIG90aGVyIHRo
aW5ncwo+ICAgIHdoaWxlIGEgY29ubmVjdGlvbiBhdHRlbXB0IGlzIGJlaW5nIG1hZGUuCgpJIGRv
bid0IHRoaW5rIHRoZSBgdHVuaW1lYCBoYXMgYW55dGhpbmcgdG8gZG8gZXhjZXB0IHdhaXQgZm9y
IHRoZSByZXNwb25zZSBmcm9tIHRoZSBgYWdlbnRgIGF0IHRoYXQgbW9tZW50CgoKCk5vdyBsZXQg
bWUgc29ydCBvdXQgdGhlIGN1cnJlbnRseSBrbm93biBtZXRob2RzOgoxLiBgcnVudGltZWAgZG9l
cyBub3QgY29ubmVjdCB1bnRpbCBpdCByZWNlaXZlcyB0aGUgcW1wIGV2ZW50IHJlcG9ydGVkIGJ5
IHFlbXUgd2hlbiB0aGUgYGFnZW50YCBvcGVucyB0aGUgdnNvY2sgZGV2aWNlLgogICAgLSBUaGUg
bWV0aG9kIGxvb2tzIGluYXBwcm9wcmlhdGUgbm93LgoyLiBhZGRpbmcgYSBzcGVjaWFsIGNhc2Ug
Zm9yIHZob3N0X3Zzb2NrLmtvLgogICAgLSBBbHNvIGluYXBwcm9wcmlhdGUuCjMuIGNvbm5lY3Qg
dG8gYHJ1bnRpbWVgIGZyb20gYGFnZW50YC4KICAgIC0gYHJ1bnRpbWVgIG1heSBub3QgYmUgYWJs
ZSB0byBjaG9vc2UgdGhlIHJpZ2h0IHBvcnQuCjQuIFVzZSBgU09fVk1fU09DS0VUU19DT05ORUNU
X1RJTUVPVVRgIG9wdGlvbi4KICAgIC0gVGhlIGVmZmVjdCBpcyBzaW1pbGFyIHRvIG1ldGhvZCAy
LCBubyBuZWVkIHRvIG1vZGlmeSB0aGUga2VybmVsIG1vZHVsZSBjb2RlLgoKSSBoYXZlIGFuIGFk
ZGl0aW9uYWwgcXVlc3Rpb246CklmIHVzZWluZyBtZXRob2QgNCwgd2hlbiBgcnVudGltZWAgY2Fs
bHMgY29ubmVjdCB1c2UgTk9OQkxPQ0sgb3B0aW9uIHdpdGggdmVyeSBzaG9ydCB0aW1lb3V0IGlu
IGFuIGluZmluaXRlIGxvb3AsIHRoZSBrZXJuZWwgbWF5YmUgZnJlcXVlbnRseSBjcmVhdGVzIHRp
bWVycy4gSXMgdGhlcmUgYW55IG90aGVyIHNpZGUgZWZmZWN0cz8=


--=====_003_next=====--

--=====_001_next=====
Content-Type: application/octet-stream;
	name="=?UTF-8?B?c2lnbmF0dXJlLmFzYw==?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
Content-ID: <signature.asc>

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFFekJBRUJDQUFkRmlFRWhwV292OVA1
Zk5xc05YZGFuS1NyczRHcmM4Z0ZBbDN5SHZVQUNna1FuS1NyczRHcg0KYzhqZzVnZ0FxYUlRQVMy
WjgxbFRJaTRiczQ3NXJhcXVUbDNTVXpjKzZUOHljaVAvWHMxU2I3dFZkSHgzV3dGcQ0KdjFlcWVm
RUtyTk5wZGpVbmNPS29IUmE0dU1RWkpTbFZhSkNzRW1IVUtCR09RUGkraEo4WDBRNTcvdzRoRVlR
Ng0KYlhyVlBsd0ZLMXZCelBQVHIxdzRxS2JLSUp5cUNZcmpoeFV4cjJLZVZyMXE4anB2ZHhuWFRJ
TFRMV1UxSkNOUw0KRmgxbDY5Q1RNMFJqdFJpVzRtYnNrTnNwTkNsdVM1c3EzS0cwUE1DQlcrVnFQ
TlA5clhMNkMzcXBJd00xUlk5cA0KWFRyVU5TUzR3cVJOWGwyVWcvUHQ1MlZ3cjRZQUFlenN5QytK
T0NVWmJDM252elIvQzJMNGkxcC9ITFZ2T3VESQ0KOW5zRXF0cjFDajd4QnVDS3E5S0NUZlMyanBD
c1RnPT0NCj0wUU5ODQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg0=


--=====_001_next=====--


