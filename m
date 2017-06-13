Received: from eggs.gnu.org ([2001:4830:134:3::10]:34778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dKs3b-0008Gl-MW
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dKs3W-0005SQ-PI
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:04:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dKs3W-0005SD-Ih
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:04:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id v104so33330104wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 13:04:50 -0700 (PDT)
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<20170608184944.19406-9-mrolnik@gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <a6c4a230-8054-7db4-ee34-871c4740cd77@tuxfamily.org>
Date: Tue, 13 Jun 2017 22:04:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170608184944.19406-9-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v19 08/13] target-avr: instruction
 decoder generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, anichang@protonmail.ch

On 08.06.2017 20:49, Michael Rolnik wrote:
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Message-Id: <1471522070-77598-9-git-send-email-mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/avr/cpugen/CMakeLists.txt           |  38 +++
>  target/avr/cpugen/README.md                |  17 ++
>  target/avr/cpugen/cpu/avr.yaml             | 213 ++++++++++++++
>  target/avr/cpugen/src/CMakeLists.txt       |  62 ++++
>  target/avr/cpugen/src/cpugen.cpp           | 457 +++++++++++++++++++++++++++++
>  target/avr/cpugen/src/utils.cpp            |  26 ++
>  target/avr/cpugen/src/utils.h              |  78 +++++
>  target/avr/cpugen/xsl/decode.c.xsl         | 103 +++++++
>  target/avr/cpugen/xsl/translate-inst.h.xsl | 118 ++++++++
>  target/avr/cpugen/xsl/utils.xsl            | 108 +++++++

CMake ... .cpp files ... .xsl files ... sounds strange ... are you sure
this fits into the QEMU build environment?

 Thomas
