Received: from eggs.gnu.org ([2001:4830:134:3::10]:43932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOOko-00077P-5E
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOOkj-0000dQ-OJ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:36:06 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:33401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOOkj-0000dF-JE
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:36:01 -0400
Received: by mail-qt0-x229.google.com with SMTP id u12so34578999qth.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:36:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-8-f4bug@amsat.org> <87efuctkbw.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bd9c08ba-80d2-eee9-e2ce-070077e5f9aa@amsat.org>
Date: Fri, 23 Jun 2017 10:35:57 -0300
MIME-Version: 1.0
In-Reply-To: <87efuctkbw.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/21] travis: update sudo-enabled
 Trusty images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 06/22/2017 06:58 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> see https://blog.travis-ci.com/2017-06-19-trusty-updates-2017-Q2
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> The way I read that blog post is group: edge is for testing things still
> work but you probably don't want to merge that into your master branch.
> Otherwise we'll automatically be running the bleeding edge.

Ok I misunderstood this part, good you noticed.

Travis team posted a new entry after which is clearer:
https://blog.travis-ci.com/2017-06-21-trusty-updates-2017-Q2-launch

I'm now using "group: deprecated-2017Q2" instead of "edge".
