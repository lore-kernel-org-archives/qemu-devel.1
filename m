Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34643C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 02:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0186621655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 02:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0186621655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii8Do-0002y0-0H
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 21:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ning.bo9@zte.com.cn>) id 1ii8Cq-0002XB-Fv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 21:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ning.bo9@zte.com.cn>) id 1ii8Co-0006Dy-7g
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 21:39:56 -0500
Received: from mx7.zte.com.cn ([202.103.147.169]:5018 helo=mxct.zte.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ning.bo9@zte.com.cn>) id 1ii8Cn-0005YJ-Rc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 21:39:54 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 884F47E6A7F72D6A751D;
 Fri, 20 Dec 2019 10:39:41 +0800 (CST)
Received: from kjyxapp03.zte.com.cn ([10.30.12.202])
 by mse-fl1.zte.com.cn with SMTP id xBK2cCuB097580;
 Fri, 20 Dec 2019 10:38:12 +0800 (GMT-8)
 (envelope-from ning.bo9@zte.com.cn)
Received: from mapi (kjyxapp05[null]) by mapi (Zmail) with MAPI id mid14;
 Fri, 20 Dec 2019 10:38:12 +0800 (CST)
Date: Fri, 20 Dec 2019 10:38:12 +0800 (CST)
X-Zmail-TransId: 2b075dfc34144d4845c7
X-Mailer: Zmail v1.0
Message-ID: <201912201038127222527@zte.com.cn>
In-Reply-To: <20191219113503.GC1624084@stefanha-x1.localdomain>
References: 20191212110525.GA1141992@stefanha-x1.localdomain,
 20191219113503.GC1624084@stefanha-x1.localdomain
Mime-Version: 1.0
From: <ning.bo9@zte.com.cn>
To: <stefanha@gmail.com>
Subject: =?UTF-8?B?UmU6W1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gdmhvc3QtdnNvY2s6IHJlcG9ydCBRTVAgZXZlbnR3aGVuc2V0cnVubmluZw==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn xBK2cCuB097580
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

PiA+IFRoZXJlIHdpbGwgYmUgYW4gYWRkaXRpb25hbCBwcm9ibGVtIGlmIGRvIHRoaXM6Cj4gPiBX
aG8gZGVjaWRlcyB3aGljaCBwb3J0IHRoZSBgcnVudGltZWAgc2hvdWxkIGxpc3Rlbj8KPiAKPiBM
ZXQgdGhlIGhvc3Qga2VybmVsIGF1dG9tYXRpY2FsbHkgYXNzaWduIGEgcG9ydCB1c2luZyBWTUFE
RFJfUE9SVF9BTlkuCj4gSXQgd29ya3MgbGlrZSB0aGlzOgo+IAo+ICAgc3RydWN0IHNvY2thZGRy
X3ZtIHN2bSA9IHsKPiAgICAgICAuc3ZtX2ZhbWlseSA9IEFGX1ZTT0NLLAo+ICAgICAgIC5zdm1f
cG9ydCA9IFZNQUREUl9QT1JUX0FOWSwKPiAgICAgICAuc3ZtX2NpZCA9IFZNQUREUl9DSURfQU5Z
LAo+ICAgfTsKPiAKPiAgIGludCBmZCA9IHNvY2tldChBRl9WU09DSywgU09DS19TVFJFQU0sIDAp
Owo+ICAgLi4uCj4gICBpZiAoYmluZChmZCwgKGNvbnN0IHN0cnVjdCBzb2NrYWRkciAgKSZzdm0s
IHNpemVvZihzdm0pKSA8IDApIHsKPiAgICAgICAuLi4KPiAgIH0KPiAKPiAgIHNvY2tsZW5fdCBz
b2NrbGVuID0gc2l6ZW9mKHN2bSk7Cj4gICBpZiAoZ2V0c29ja25hbWUoZmQsIChzdHJ1Y3Qgc29j
a2FkZHIgKikmc3ZtLCAmc29ja2xlbikgPCAwKSB7Cj4gICAgICAgLi4uCj4gICB9Cj4gCj4gICBw
cmludGYoImNpZCAldSBwb3J0ICV1XG4iLCBzdm0uc3ZtX2NpZCwgc3ZtLnN2bV9wb3J0KTsKPiAK
PiA+IENvbnNpZGVyIHRoZSB3b3JzdCBjYXNlOiAKPiA+IFRoZSBwb3J0cyBzZWxlY3RlZCBieSB0
d28gYHJ1bnRpbWVgIHJ1bm5pbmcgaW4gcGFyYWxsZWwgYWx3YXlzIGNvbmZsaWN0LCAKPiA+IGFu
ZCB0aGlzIGNhc2UgaXMgdW5hdm9pZGFibGUsIGV2ZW4gaWYgd2UgY2FuIHJlZHVjZSB0aGUgcG9z
c2liaWxpdHkgb2YgCj4gPiBjb25mbGljdHMgdGhyb3VnaCBhbGdvcml0aG1zLgo+ID4gQmVjYXVz
ZSB3ZSBkb24ndCBoYXZlIGEgZGFlbW9uIHRoYXQgY2FuIGFsbG9jYXRlIHVuaXF1ZSBwb3J0IHRv
IGBydW50aW1lYC4KPiAKPiBUaGUga2VybmVsIGFzc2lnbnMgdW5pcXVlIHBvcnRzIGFuZCBvbmx5
IGZhaWxzIGlmIHRoZSBlbnRpcmUgcG9ydAo+IG5hbWVzcGFjZSBpcyBleGhhdXN0ZWQuICBUaGUg
cG9ydCBuYW1lc3BhY2UgaXMgMzItYml0cyBzbyB0aGlzIGlzIG5vdCBhCj4gcmVhbC13b3JsZCBj
b25jZXJuLgo+IAo+IERvZXMgdGhpcyBpbmZvcm1hdGlvbiBjbGFyaWZ5IGhvdyB0aGUgcnVudGlt
ZSBjYW4gY29ubmVjdCB0byB0aGUgZ3Vlc3QKPiBhZ2VudCB3aXRob3V0IGxvb3BzIG9yIGRlbGF5
cz8KClRoYW5rIHlvdSB2ZXJ5IG11Y2guIEkgd2lsbCBkbyBhcyB5b3UgaW5zdHJ1Y3RlZCBhYm92
ZQ==


--=====_003_next=====--

--=====_001_next=====--


