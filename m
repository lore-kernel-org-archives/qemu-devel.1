Received: from eggs.gnu.org ([2001:4830:134:3::10]:52717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnSS7-0003ai-Gj
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnSS1-0005q0-Ui
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:36:23 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnSS1-0005pm-P9
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:36:17 -0400
Received: by mail-qk0-x241.google.com with SMTP id a77so127516qkb.1
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 09:36:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170831112210.19921-1-famz@redhat.com>
	<20170831112210.19921-4-famz@redhat.com>
	<20170831161835.GQ17315@redhat.com>
	<5f9a3540-2c90-5ded-9581-d1098070f40e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f59ff98-f5cb-b185-bca1-657ed6e2f807@amsat.org>
Date: Thu, 31 Aug 2017 13:36:13 -0300
MIME-Version: 1.0
In-Reply-To: <5f9a3540-2c90-5ded-9581-d1098070f40e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 08/31/2017 01:21 PM, Eric Blake wrote:
> On 08/31/2017 11:18 AM, Daniel P. Berrange wrote:
>>
>> 'qcow' (v1) was also passing last time I checked, though it is
>> waaaaaay slow to run compared to qcow2, so I'd understand if you
>> were reluctant to turn that on due to speed
> 
> Even './check -qcow -g quick' might be nicer than nothing, but that is
> also slooooooow

What about having a daily job running it on /master? Better than running 
it once before each release :)
