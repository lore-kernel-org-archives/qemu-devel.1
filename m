Received: from eggs.gnu.org ([209.51.188.92]:50168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hH9R1-0003HQ-HV
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hH9Qz-0000qA-Od
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:58:47 -0400
Resent-Message-Id: <E1hH9Qz-0000qA-Od@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hH9Qy-0000om-FW
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:58:45 -0400
In-Reply-To: <1555601350-4176-1-git-send-email-mateja.marjanovic@rt-rk.com>
Message-ID: <155560307223.24.4258448109214289536@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 18 Apr 2019 08:57:53 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v9 0/6] target/mips: Optimize MSA
 interleave instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mateja.marjanovic@rt-rk.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, arikalo@wavecomp.com, richard.henderson@linaro.org, philmd@redhat.com, amarkovic@wavecomp.com, aurelien@aurel32.net

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTU1NjAxMzUwLTQxNzYtMS1n
aXQtc2VuZC1lbWFpbC1tYXRlamEubWFyamFub3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhpcyBz
ZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBm
aW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBo
YXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2Fs
bHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2Nr
ZXItdGVzdC1taW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKU3VibW9kdWxlICdkdGMnIChodHRwczovL2dpdC5xZW11Lm9yZy9naXQv
ZHRjLmdpdCkgcmVnaXN0ZXJlZCBmb3IgcGF0aCAnZHRjJwpDbG9uaW5nIGludG8gJ2R0YycuLi4K
cmVtb3RlOiBDb3VudGluZyBvYmplY3RzOiA0OTMwLCBkb25lLiAgICAgICAgCmVycm9yOiBSUEMg
ZmFpbGVkOyByZXN1bHQ9MTgsIEhUVFAgY29kZSA9IDIwMApmYXRhbDogVGhlIHJlbW90ZSBlbmQg
aHVuZyB1cCB1bmV4cGVjdGVkbHkKZmF0YWw6IHByb3RvY29sIGVycm9yOiBiYWQgcGFjayBoZWFk
ZXIKQ2xvbmUgb2YgJ2h0dHBzOi8vZ2l0LnFlbXUub3JnL2dpdC9kdGMuZ2l0JyBpbnRvIHN1Ym1v
ZHVsZSBwYXRoICdkdGMnIGZhaWxlZApmYWlsZWQgdG8gaW5pdCBzdWJtb2R1bGUgZHRjCiAgQ09Q
WSAgICBSVU5ORVIKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzE1NTU2MDEzNTAtNDE3Ni0xLWdpdC1zZW5kLWVtYWlsLW1hdGVqYS5tYXJqYW5v
dmljQHJ0LXJrLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=
