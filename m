Received: from eggs.gnu.org ([209.51.188.92]:33543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpFL6-0006yt-4C
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpFL3-0007W5-0m
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:37:18 -0500
Resent-Message-Id: <E1gpFL3-0007W5-0m@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gpFL2-0007NZ-NX
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:37:16 -0500
Message-ID: <154895261143.22189.11786728197087299981@ebba9967afc0>
In-Reply-To: <20190116113751.17177-1-alex.kanavin@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 31 Jan 2019 08:36:52 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] egl-helpers.h: do not depend on X11 Window
 type, use EGLNativeWindowType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.kanavin@gmail.com
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExNjExMzc1MS4xNzE3
Ny0xLWFsZXgua2FuYXZpbkBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGVnbC1oZWxwZXJz
Lmg6IGRvIG5vdCBkZXBlbmQgb24gWDExIFdpbmRvdyB0eXBlLCB1c2UgRUdMTmF0aXZlV2luZG93
VHlwZQpNZXNzYWdlLWlkOiAyMDE5MDExNjExMzc1MS4xNzE3Ny0xLWFsZXgua2FuYXZpbkBnbWFp
bC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwplOWIyODRhIGVnbC1oZWxw
ZXJzLmg6IGRvIG5vdCBkZXBlbmQgb24gWDExIFdpbmRvdyB0eXBlLCB1c2UgRUdMTmF0aXZlV2lu
ZG93VHlwZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0
ZXJzCiM1NzogRklMRTogdWkvZ3RrLWVnbC5jOjU3OgorICAgIHZjLT5nZnguZXN1cmZhY2UgPSBx
ZW11X2VnbF9pbml0X3N1cmZhY2VfeDExKHZjLT5nZnguZWN0eCwgKEVHTE5hdGl2ZVdpbmRvd1R5
cGUpeDExX3dpbmRvdyk7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDMyIGxpbmVzIGNo
ZWNrZWQKCkNvbW1pdCBlOWIyODRhOTZjNWQgKGVnbC1oZWxwZXJzLmg6IGRvIG5vdCBkZXBlbmQg
b24gWDExIFdpbmRvdyB0eXBlLCB1c2UgRUdMTmF0aXZlV2luZG93VHlwZSkgaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTAxMTYxMTM3NTEuMTcxNzctMS1hbGV4LmthbmF2aW5AZ21haWwuY29tL3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
