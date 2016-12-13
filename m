Received: from eggs.gnu.org ([2001:4830:134:3::10]:41403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGhUK-0004U8-Fb
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGhUG-0006TK-Dk
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:27:00 -0500
Received: from mail-wj0-f171.google.com ([209.85.210.171]:36766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cGhUG-0006Sl-6N
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:26:56 -0500
Received: by mail-wj0-f171.google.com with SMTP id tk12so92360373wjb.3
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 23:26:56 -0800 (PST)
References: <87lgvm1dvz.fsf@gmail.com>
	<CAFEAcA9qiEK+Z3TBFxebTjqdm-4TeeZLQm2uewMHQUsmtCvL=g@mail.gmail.com>
	<CAJhHMCAvd0+PNFF-PfMVP2aSpN2V9B7XbV59qh-FaXtLGemQmg@mail.gmail.com>
	<87k2b5tlyy.fsf@linaro.org>
	<CAJhHMCA4G6E1BLAoPWha84Phw0JVnD9_6qSJEc+ftew7TWS8vQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJhHMCA4G6E1BLAoPWha84Phw0JVnD9_6qSJEc+ftew7TWS8vQ@mail.gmail.com>
Date: Tue, 13 Dec 2016 07:25:53 +0000
Message-ID: <87inqothmm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] aarch64-linux-user compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Pranith Kumar <bobby.prani@gmail.com> writes:

> Hi Alex,
>
> On Mon, Dec 12, 2016 at 6:39 AM, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Sounds like it. How did you ensure you had your QEMU build dependencies
>> installed on your system?
>>
>
> I did:
>
> $ sudo apt-get build-dep qemu
>
> to get all the build dependencies. I must have recently installed
> oss4-dev through some other package which overwrote soundcard.h. It
> was working fine earlier.

  aptitude why oss4-dev

Might tell you what happened. Anyway glad it's fixed now.

--
Alex Bennée
