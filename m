Received: from eggs.gnu.org ([2001:4830:134:3::10]:52593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1fDRak-0005qc-Nc
	for qemu-devel@nongnu.org; Tue, 01 May 2018 05:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1fDRag-0005rM-Nr
	for qemu-devel@nongnu.org; Tue, 01 May 2018 05:28:58 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:45202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rafaelkioji@gmail.com>)
	id 1fDRag-0005qu-GP
	for qemu-devel@nongnu.org; Tue, 01 May 2018 05:28:54 -0400
Received: by mail-pf0-x22f.google.com with SMTP id c10so8772654pfi.12
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 02:28:54 -0700 (PDT)
Received: from [143.89.131.93] (eepc93.ee.ust.hk. [143.89.131.93])
	by smtp.googlemail.com with ESMTPSA id
	p6sm14604794pfg.157.2018.05.01.02.28.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 May 2018 02:28:51 -0700 (PDT)
From: Rafael Kioji <rafaelkioji@gmail.com>
Message-ID: <1fa7369f-9c6d-73c6-77e1-7911a9538d82@gmail.com>
Date: Tue, 1 May 2018 17:28:44 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] Translation block identification.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Dear all,

During translation how can I identify what is the basic block of the 
guest code? I wanted to know whether the block being translated is the 
beginning of a function and get its name.

My current approach involves looking up the symbol associated with the 
first PC of the translation block. But no symbol is ever found. What I 
did was to add the following code in the function "translator_loop" at 
"accel/tcg/translator.c":

     printf("sym: %lu %s\n", tb->pc, lookup_symbol(tb->pc));

The function lookup_symbol is defined in the file "./disas.c". I am 
compiling my application with symbols (-g). My target arch is ARM.

Thanks!


Kind regards,
Rafael
