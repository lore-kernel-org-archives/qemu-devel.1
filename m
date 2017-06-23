Received: from eggs.gnu.org ([2001:4830:134:3::10]:45821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOTYc-0003QY-TE
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOTYY-0002jS-03
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:43:50 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:35037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOTYX-0002jB-Sc
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:43:45 -0400
Received: by mail-qk0-x22f.google.com with SMTP id 16so42445745qkg.2
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 11:43:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-2-f4bug@amsat.org> <87h8z8tkhi.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f3a1a10-b9ca-5ce4-ef02-3c2411bd53eb@amsat.org>
Date: Fri, 23 Jun 2017 15:43:41 -0300
MIME-Version: 1.0
In-Reply-To: <87h8z8tkhi.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/21] tests: add missing dependency to
 build QTEST_QEMU_BINARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 06/22/2017 06:55 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> This allow a one liner from fresh repository clone, i.e.:
>>
>>    ./configure && make -j check-qtest-aarch64
> 
> TIL -j doesn't need a number and GNU Make has a -l option ;-)

Also since 2.8 (2016) git fetch has -j option, but Travis is using a 
release version 1.8 (from the git-core PPA)

on my debian/unstable git version 2.13.1 I can do:

  $ git submodule update --init --recursive --depth 1 -j ${PARALLEL_JOBS}
