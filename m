Received: from eggs.gnu.org ([209.51.188.92]:54061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDTSo-0000we-NT
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDTSm-0003Zc-N8
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:33:26 -0400
Resent-Message-Id: <E1hDTSm-0003Zc-N8@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDTSj-0003Ux-DJ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:33:22 -0400
Message-ID: <155472676351.12882.17823375506809746100@76452e4e88f2>
In-Reply-To: <20190408122816.595-1-ghorges@xiyoulinux.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 8 Apr 2019 05:32:44 -0700 (PDT)
Subject: Re: [Qemu-devel] Wshadow in qemu/linux-user/syscall.c:Changed some
 variable names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ghorges@xiyoulinux.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwODEyMjgxNi41OTUt
MS1naG9yZ2VzQHhpeW91bGludXgub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDQwODEyMjgxNi41OTUtMS1naG9yZ2VzQHhp
eW91bGludXgub3JnClN1YmplY3Q6IFtRZW11LWRldmVsXSBXc2hhZG93IGluIHFlbXUvbGludXgt
dXNlci9zeXNjYWxsLmM6Q2hhbmdlZCBzb21lIHZhcmlhYmxlIG5hbWVzClR5cGU6IHNlcmllcwoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2Ug
PiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIx
ZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5
MDQwODEyMjgxNi41OTUtMS1naG9yZ2VzQHhpeW91bGludXgub3JnIC0+IHBhdGNoZXcvMjAxOTA0
MDgxMjI4MTYuNTk1LTEtZ2hvcmdlc0B4aXlvdWxpbnV4Lm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCmM1OWVkOWNjN2IgV3NoYWRvdyBpbiBxZW11L2xpbnV4LXVzZXIvc3lzY2Fs
bC5jOkNoYW5nZWQgc29tZSB2YXJpYWJsZSBuYW1lcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJS
T1I6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCAxNjAgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGM1OWVkOWNjN2JhMyAoV3NoYWRvdyBp
biBxZW11L2xpbnV4LXVzZXIvc3lzY2FsbC5jOkNoYW5nZWQgc29tZSB2YXJpYWJsZSBuYW1lcykg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MDgxMjI4MTYuNTk1LTEtZ2hvcmdlc0B4aXlvdWxp
bnV4Lm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
