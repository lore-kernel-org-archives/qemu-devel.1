Received: from eggs.gnu.org ([2001:4830:134:3::10]:40585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fniAS-0005EP-Va
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fniAP-0000YT-1O
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:27:44 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fniAO-0000YL-PY
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:27:40 -0400
Received: by mail-ed1-x543.google.com with SMTP id e6-v6so2636676edr.2
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 03:27:40 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<e165d2c3-814d-e8b5-3691-af0225ee981d@redhat.com>
	<581443fd-c054-06ad-94d6-7285b2713cd6@gmail.com>
	<af774599-c03a-c839-5190-1e1809d1216b@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <7f377177-f813-e9b9-5299-aa7031a10f96@gmail.com>
Date: Thu, 9 Aug 2018 12:27:37 +0200
MIME-Version: 1.0
In-Reply-To: <af774599-c03a-c839-5190-1e1809d1216b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 00/34] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 08/09/2018 11:44 AM, Paolo Bonzini wrote:
> On 09/08/2018 11:20, Emanuele wrote:
>> Why this? Shouldn't it be:
>>
>> if (g_strcmp0(old_path, path)) {
>>          qtest_end(); /* handles global_qtest = NULL */
>>          g_free(old_path); /* handles NULL */
>>          old_path = path;
>>          global_qtest = qtest_start(path);
>> } else ....
> Yes, of course.  Though I'd have thought that my version has "just" a
> memory leak.  Even better, this could call qos_invalidate_command_line.
>
> Can you post the fixes to a separate commit on github?
https://github.com/esposem/qemu/commit/4389e83522c06ce7001382284153d59105692061

I also added g_free(old_path); in qos-test main function, since last 
old_path is not free'd.
This commit is part of qgraph-v3, where I am also applying Laurent's 
suggestions.

Emanuele
