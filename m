Received: from eggs.gnu.org ([2001:4830:134:3::10]:45343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.ml@steffen-goertz.de>) id 1fI7Qj-0000IQ-Fd
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu.ml@steffen-goertz.de>) id 1fI7Qe-0005xA-LQ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:57:57 -0400
Received: from steffen-goertz.de ([88.198.119.201]:50954)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.ml@steffen-goertz.de>) id 1fI7Qe-0005vp-Ew
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:57:52 -0400
References: <1525936711-24538-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1525936711-24538-3-git-send-email-suhang16@mails.ucas.ac.cn>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <qemu.ml@steffen-goertz.de>
Message-ID: <deae818d-7405-f46e-5535-9a603d98ac41@steffen-goertz.de>
Date: Mon, 14 May 2018 08:57:48 +0200
MIME-Version: 1.0
In-Reply-To: <1525936711-24538-3-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 2/2] Add QTest testcase for the Intel
 Hexadecimal Object File Loader.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@gmail.com, darcysail@gmail.com
Cc: qemu-devel@nongnu.org

On 10.05.2018 09:18, Su Hang wrote:

Hi,
this will be my first comment on devel as part of my GSoC participation
this year.

> +
> +    QTestState *s = qtest_startf(
> +        "-M versatilepb -m 128M -nographic -kernel ../tests/hex-loader-check-data/test.hex");
> +

The test binary "text.hex" is not being copied to out-of-tree builds at
the moment and the test run will therefore fail.
The acpi tests also use a fixture (acpi-test-data) which is being copied
to the out-of-tree build in ./configure:L7181 .
This might also be an option for your test.
