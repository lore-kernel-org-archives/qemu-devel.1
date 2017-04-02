Received: from eggs.gnu.org ([2001:4830:134:3::10]:42669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cuZ3h-00046p-LY
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 02:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cuZ3e-0003H8-Bd
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 02:32:17 -0400
Resent-Message-Id: <E1cuZ3e-0003H8-Bd@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cuZ3e-0003Fg-2n
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 02:32:14 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <149111470613.12252.13311810453461053943@6c512846dbc7>
In-Reply-To: <1490970671-20560-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 1 Apr 2017 23:31:46 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] disas/cris.c: Avoid unintentional sign
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, edgar.iglesias@gmail.com, patches@linaro.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMTQ5
MDk3MDY3MS0yMDU2MC0xLWdpdC1zZW5kLWVtYWlsLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZwpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBkaXNhcy9jcmlzLmM6IEF2b2lkIHVuaW50ZW50
aW9uYWwgc2lnbiBleHRlbnNpb24KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUg
JEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKIyBVc2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0Uu
LikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRv
dGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93
ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAt
OyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEp
KQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcg
YnJhbmNoICd0ZXN0JwoxYWI0NTI5IGRpc2FzL2NyaXMuYzogQXZvaWQgdW5pbnRlbnRpb25hbCBz
aWduIGV4dGVuc2lvbgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiBk
aXNhcy9jcmlzLmM6IEF2b2lkIHVuaW50ZW50aW9uYWwgc2lnbiBleHRlbnNpb24uLi4KRVJST1I6
IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMjQ6IEZJTEU6IGRpc2FzL2NyaXMu
YzoyMDUxOgorXkkgICAgaW50MzJfdCBudW1iZXI7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3Vs
ZCBuZXZlciB1c2UgdGFicwojMzM6IEZJTEU6IGRpc2FzL2NyaXMuYzoyMjkzOgorXkleSV5JaW50
MzJfdCBudW1iZXI7JAoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNiBsaW5lcyBjaGVj
a2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
