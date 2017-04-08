Received: from eggs.gnu.org ([2001:4830:134:3::10]:46060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jason.vas.dias@gmail.com>) id 1cwrll-0007o9-Ra
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 10:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jason.vas.dias@gmail.com>) id 1cwrll-0006oc-6v
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 10:55:17 -0400
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:34687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jason.vas.dias@gmail.com>)
	id 1cwrll-0006oW-28
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 10:55:17 -0400
Received: by mail-ua0-x233.google.com with SMTP id u103so8662660uau.1
	for <qemu-devel@nongnu.org>; Sat, 08 Apr 2017 07:55:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALyZvKwUk9iO3m-HGR48CqH2+=WhDk1eXpcPGCGJ5-TBAt5=KQ@mail.gmail.com>
References: <CALyZvKyt=dddquvi4exc1vcJ0w=mN4qBb032RWmfER_VDW8hGA@mail.gmail.com>
	<CALyZvKwUk9iO3m-HGR48CqH2+=WhDk1eXpcPGCGJ5-TBAt5=KQ@mail.gmail.com>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Sat, 8 Apr 2017 14:55:15 +0000
Message-ID: <CALyZvKyJRL3=CZzZMp3BtgkezSFnKXBi=O_WPaGG53K5JkK6_g@mail.gmail.com>
Content-Type: multipart/mixed; boundary=f403045f89d0160d52054ca8eee2
Subject: Re: [Qemu-devel] v2.8.1 configure / build fails - just to let you
 know :
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

--f403045f89d0160d52054ca8eee2
Content-Type: text/plain; charset=UTF-8

Patch attached - removes '-c' from $CPP invocation in
  pc-bios/optionrom/Makefile
- $CPP was 'cpp' in my environment.
Maybe you should use $CC or $CXX with '-e' flag ? -
then no warning (error) would occur for '-c' .

--f403045f89d0160d52054ca8eee2
Content-Type: application/octet-stream; name="qemu-v2.8.1-cpp_no-c.patch"
Content-Disposition: attachment; filename="qemu-v2.8.1-cpp_no-c.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtLWdpdCBhL3BjLWJpb3Mvb3B0aW9ucm9tL01ha2VmaWxlIGIvcGMtYmlvcy9vcHRpb25y
b20vTWFrZWZpbGUKaW5kZXggZmE1M2Q5ZS4uZjg5NGQ1ZCAxMDA2NDQKLS0tIGEvcGMtYmlvcy9v
cHRpb25yb20vTWFrZWZpbGUKKysrIGIvcGMtYmlvcy9vcHRpb25yb20vTWFrZWZpbGUKQEAgLTQz
LDcgKzQzLDcgQEAgYnVpbGQtYWxsOiBtdWx0aWJvb3QuYmluIGxpbnV4Ym9vdC5iaW4gbGludXhi
b290X2RtYS5iaW4ga3ZtdmFwaWMuYmluCiAKIAogJS5vOiAlLlMKLQkkKGNhbGwgcXVpZXQtY29t
bWFuZCwkKENQUCkgJChRRU1VX0lOQ0xVREVTKSAkKFFFTVVfREdGTEFHUykgLWMgLW8gLSAkPCB8
ICQoQVMpICQoQVNGTEFHUykgLW8gJEAsIkFTIiwiJChUQVJHRVRfRElSKSRAIikKKwkkKGNhbGwg
cXVpZXQtY29tbWFuZCwkKENQUCkgJChRRU1VX0lOQ0xVREVTKSAkKFFFTVVfREdGTEFHUykgLW8g
LSAkPCB8ICQoQVMpICQoQVNGTEFHUykgLW8gJEAsIkFTIiwiJChUQVJHRVRfRElSKSRAIikKIAog
JS5pbWc6ICUubwogCSQoY2FsbCBxdWlldC1jb21tYW5kLCQoTEQpICQoTERGTEFHU19OT1BJRSkg
LW0gJChMRF9JMzg2X0VNVUxBVElPTikgLVQgJChTUkNfUEFUSCkvcGMtYmlvcy9vcHRpb25yb20v
ZmxhdC5sZHMgLXMgLW8gJEAgJDwsIkJVSUxEIiwiJChUQVJHRVRfRElSKSRAIikK
--f403045f89d0160d52054ca8eee2--
