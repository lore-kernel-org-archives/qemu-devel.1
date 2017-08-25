Received: from eggs.gnu.org ([2001:4830:134:3::10]:55538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlBRH-0003MG-Bn
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlBRE-0005E3-8c
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:02:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dlBRE-0005DL-1w
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:02:04 -0400
References: <20170822044155.2451-1-famz@redhat.com>
	<8805ba9c-a509-ed81-70e3-16b33bb1135c@redhat.com>
	<20170825092549.GH11465@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b3a24c0b-a339-7599-62ed-2d6601ec3da5@redhat.com>
Date: Fri, 25 Aug 2017 12:01:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170825092549.GH11465@lemon.lan>
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
To: Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 25/08/2017 11:25, Fam Zheng wrote:
>> I'm no expert in ansible, but I can give it that a try if you fancy the
>> idea.
>>
> I have no objection if you want to give it a try. However it is basically a
> separate problem, and I don't think this series would depend on that. The reason
> is that setting up guest ssh is not part of the "build env setup" task, but is
> the trickiest part here. 

Indeed, and worse this is also needed for ansible.  So it's a
chicken-and-egg problem.

Paolo
