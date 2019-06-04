Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2486C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86BD23426
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86BD23426
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYAoA-0003a8-1r
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 10:53:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYAlz-0002SF-JG
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYAly-0005BJ-6i
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:50:47 -0400
Resent-Date: Tue, 04 Jun 2019 10:50:47 -0400
Resent-Message-Id: <E1hYAly-0005BJ-6i@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hYAlx-00058Z-U8
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:50:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559659776; cv=none; d=zoho.com; s=zohoarc; 
	b=M53TQX+4Y934sx83QLMlo8lCCy2BYZQSCNjtyyLjKi+fCTPYX+BU9AmAmXEKls2lV59St58aRisO7QqcBmBiTjTs2oYqxomNSk+DzPJTtvxo0DWt3BX+uP3LXhfyhw/iercnwAwHSxqV3YvfToR/XGWsRWWQW2V6SfRyF3ymYy8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559659776;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=C0F5Q1xzdJMjZuwKPglmG0RkeTTnynL+ETPY1Ru6KCQ=; 
	b=jhENgCvCRBhD0dt12jpjCvxNZTsmb5dKX0BVVKz/l/quGs9Zx0jHVeRB0W+t2lqFggPP38691IGnckjsEPOc6tD+h5cAlzZccpMRwD9JRoQz7YTfmMKVVUjXLGfAY4y/c0EThOtZh23wUDu7zxh10Kyhmg3BrBdeyynsTvOpU0M=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559659773158641.7043969413718;
	Tue, 4 Jun 2019 07:49:33 -0700 (PDT)
In-Reply-To: <1559653142-31892-1-git-send-email-aleksandar.markovic@rt-rk.com>
Message-ID: <155965977201.32260.4475912972011881290@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Tue, 4 Jun 2019 07:49:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v8 0/3] linux-user: A set of miscellaneous
 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, lvivier@redhat.com, ysu@wavecomp.com,
	qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTU5NjUzMTQyLTMxODkyLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhl
IGRldGFpbHMgYmVsb3cuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMg
VGVzdGluZyBzY3JpcHQgd2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0
aAojIEhFQUQgcG9pbnRpbmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGll
ZCBvbiB0b3Agb2YgImJhc2UiCiMgYnJhbmNoCnNldCAtZQpDQz0kSE9NRS9iaW4vY2MKSU5TVEFM
TD0kUFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZApta2RpciAtcCAkQlVJTEQgJElOU1RBTEwK
U1JDPSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmlndXJlIC0tY2M9JENDIC0tcHJlZml4PSRJTlNU
QUxMCm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJlbGlhYmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVj
ayAtajQgVj0xCm1ha2UgaW5zdGFsbAoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hv
CmVjaG8gIj09PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
CiAgQ0MgICAgICBhYXJjaDY0X2JlLWxpbnV4LXVzZXIvbGludXgtdXNlci9zeXNjYWxsLm8KICBD
QyAgICAgIGFscGhhLWxpbnV4LXVzZXIvdGNnL3RjZy1vcC1ndmVjLm8KL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLWFxbjNsb3lzL3NyYy9saW51eC11c2VyL3N5c2NhbGwuYzogSW4gZnVuY3Rp
b24g4oCYZG9fc2V0c29ja29wdOKAmToKL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWFxbjNs
b3lzL3NyYy9saW51eC11c2VyL3N5c2NhbGwuYzoyMDA1OjE0OiBlcnJvcjog4oCYQUxHX1NFVF9L
RVnigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAyMDA1IHwgICAg
ICAgICBjYXNlIEFMR19TRVRfS0VZOgogICAgICB8ICAgICAgICAgICAgICBefn5+fn5+fn5+fgov
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYXFuM2xveXMvc3JjL2xpbnV4LXVzZXIvc3lzY2Fs
bC5jOjIwMDU6MTQ6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVk
IG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCi92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC1hcW4zbG95cy9zcmMvbGludXgtdXNlci9zeXNjYWxsLmM6MjAyMToxNDog
ZXJyb3I6IOKAmEFMR19TRVRfQUVBRF9BVVRIU0laReKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2Ug
aW4gdGhpcyBmdW5jdGlvbikKIDIwMjEgfCAgICAgICAgIGNhc2UgQUxHX1NFVF9BRUFEX0FVVEhT
SVpFOgogICAgICB8ICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn4KbWFrZVsxXTog
KioqIFsvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYXFuM2xveXMvc3JjL3J1bGVzLm1hazo2
OTogbGludXgtdXNlci9zeXNjYWxsLm9dIEVycm9yIDEKLS0tCiAgQ0MgICAgICBhbHBoYS1saW51
eC11c2VyL2xpbnV4LXVzZXIvbWFpbi5vCiAgQ0MgICAgICBhbHBoYS1saW51eC11c2VyL2xpbnV4
LXVzZXIvc3lzY2FsbC5vCi92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1hcW4zbG95cy9zcmMv
bGludXgtdXNlci9zeXNjYWxsLmM6IEluIGZ1bmN0aW9uIOKAmGRvX3NldHNvY2tvcHTigJk6Ci92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1hcW4zbG95cy9zcmMvbGludXgtdXNlci9zeXNjYWxs
LmM6MjAwNToxNDogZXJyb3I6IOKAmEFMR19TRVRfS0VZ4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVz
ZSBpbiB0aGlzIGZ1bmN0aW9uKQogMjAwNSB8ICAgICAgICAgY2FzZSBBTEdfU0VUX0tFWToKICAg
ICAgfCAgICAgICAgICAgICAgXn5+fn5+fn5+fn4KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LWFxbjNsb3lzL3NyYy9saW51eC11c2VyL3N5c2NhbGwuYzoyMDA1OjE0OiBub3RlOiBlYWNoIHVu
ZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rp
b24gaXQgYXBwZWFycyBpbgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYXFuM2xveXMvc3Jj
L2xpbnV4LXVzZXIvc3lzY2FsbC5jOjIwMjE6MTQ6IGVycm9yOiDigJhBTEdfU0VUX0FFQURfQVVU
SFNJWkXigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAyMDIxIHwg
ICAgICAgICBjYXNlIEFMR19TRVRfQUVBRF9BVVRIU0laRToKICAgICAgfCAgICAgICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+Cm1ha2VbMV06ICoqKiBbL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLWFxbjNsb3lzL3NyYy9ydWxlcy5tYWs6Njk6IGxpbnV4LXVzZXIvc3lzY2FsbC5vXSBF
cnJvciAxCi0tLQogIENDICAgICAgYWFyY2g2NC1saW51eC11c2VyL2xpbnV4LXVzZXIvc3lzY2Fs
bC5vCiAgQ0MgICAgICBhYXJjaDY0LWxpbnV4LXVzZXIvbGludXgtdXNlci9zdHJhY2UubwovdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYXFuM2xveXMvc3JjL2xpbnV4LXVzZXIvc3lzY2FsbC5j
OiBJbiBmdW5jdGlvbiDigJhkb19zZXRzb2Nrb3B04oCZOgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtYXFuM2xveXMvc3JjL2xpbnV4LXVzZXIvc3lzY2FsbC5jOjIwMDU6MTQ6IGVycm9yOiDi
gJhBTEdfU0VUX0tFWeKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikK
IDIwMDUgfCAgICAgICAgIGNhc2UgQUxHX1NFVF9LRVk6CiAgICAgIHwgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1hcW4zbG95cy9zcmMvbGludXgt
dXNlci9zeXNjYWxsLmM6MjAwNToxNDogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIg
aXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWFxbjNsb3lzL3NyYy9saW51eC11c2VyL3N5c2NhbGwu
YzoyMDIxOjE0OiBlcnJvcjog4oCYQUxHX1NFVF9BRUFEX0FVVEhTSVpF4oCZIHVuZGVjbGFyZWQg
KGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogMjAyMSB8ICAgICAgICAgY2FzZSBBTEdfU0VU
X0FFQURfQVVUSFNJWkU6CiAgICAgIHwgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fgptYWtlWzFdOiAqKiogWy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1hcW4zbG95cy9zcmMv
cnVsZXMubWFrOjY5OiBsaW51eC11c2VyL3N5c2NhbGwub10gRXJyb3IgMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU1OTY1MzE0Mi0zMTg5
Mi0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tL3Rlc3Rpbmcu
czM5MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


