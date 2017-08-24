Received: from eggs.gnu.org ([2001:4830:134:3::10]:48057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dkxWJ-0004qn-PQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dkxWG-0001YD-KN
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:10:23 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:35192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dkxWG-0001Xg-FF
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:10:20 -0400
Received: by mail-io0-x22c.google.com with SMTP id k22so1329436iod.2
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 12:10:19 -0700 (PDT)
Received: from [192.168.0.7] (d199-74-164-53.col.wideopenwest.com.
	[74.199.53.164])
	by smtp.gmail.com with ESMTPSA id l5sm1425177itl.40.2017.08.24.12.10.16
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 24 Aug 2017 12:10:16 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 24 Aug 2017 15:10:15 -0400
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
In-Reply-To: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
Message-Id: <74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
Subject: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think 'make test' is an abandoned testing option for QEMU so this =
report might be unimportant. Here is my results for running 'make test':

$ make test
make -C tests/tcg test
  LINK    test_path
Undefined symbols for architecture x86_64:
  "_buffer_is_zero", referenced from:
      _qemu_iovec_is_zero in test_path.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see =
invocation)
make[1]: *** [test_path] Error 1
make: *** [test] Error 2
