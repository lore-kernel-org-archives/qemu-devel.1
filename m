Received: from eggs.gnu.org ([2001:4830:134:3::10]:60741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diJrq-0008VQ-Th
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diJrn-00077A-7i
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:25:42 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1diJrn-00075N-09
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:25:39 -0400
Received: by mail-wr0-f181.google.com with SMTP id z91so33042466wrc.4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 05:25:38 -0700 (PDT)
References: <20170817024746.5961-1-famz@redhat.com>
	<20170817024746.5961-5-famz@redhat.com>
	<20170817122148.GE5539@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce95864f-1d06-6c58-be2f-141387348e30@redhat.com>
Date: Thu, 17 Aug 2017 14:25:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170817122148.GE5539@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 04/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 17/08/2017 14:21, Stefan Hajnoczi wrote:
>> +        guest = QEMUMachine(binary=os.environ.get("QEMU", "qemu-system-x86_64"),
>> +                            args=args)
>> +        guest._vga = "std"
> _vga is a protected field.  We don't inherit from QEMUMachine so it
> shouldn't be accessed directly.  One option is to add a vga argument to
> the QEMUMachine() constructor.

You can just use "-device VGA" here, since this code is x86-specific.
"-vga none -device VGA" works well, so patch 2 can be dropped.

Paolo
