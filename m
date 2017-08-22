Received: from eggs.gnu.org ([2001:4830:134:3::10]:34226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk9i6-000573-Ns
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk9i3-0005Qf-O8
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:59:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dk9i3-0005QQ-H9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:59:11 -0400
References: <20170822044155.2451-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40d04f21-011e-1736-ed62-1d205926d60a@redhat.com>
Date: Tue, 22 Aug 2017 15:58:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170822044155.2451-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/10] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 22/08/2017 06:41, Fam Zheng wrote:
> as it is not easy to automate. (The ideal approach is like the ubuntu.i386
> script, which configures the guest on top of an official released image, fully
> automatically.)

Out of curiosity, why can't the 32-bit test use containers instead?

Paolo
