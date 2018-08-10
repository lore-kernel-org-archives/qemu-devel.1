Received: from eggs.gnu.org ([2001:4830:134:3::10]:44577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fo4qV-0001QR-Ve
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fo4qR-0001lH-1N
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:40:40 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fo4qQ-0001k9-Q6
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:40:34 -0400
Received: by mail-ed1-x543.google.com with SMTP id h4-v6so4540579edi.6
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 03:40:34 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<e165d2c3-814d-e8b5-3691-af0225ee981d@redhat.com>
	<581443fd-c054-06ad-94d6-7285b2713cd6@gmail.com>
	<af774599-c03a-c839-5190-1e1809d1216b@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <3f1ebb49-0a35-1073-2ae9-a76aed8c9082@gmail.com>
Date: Fri, 10 Aug 2018 12:40:31 +0200
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
Paolo, did you have a chance to test the fixes? I tried, it seems to be 
working fine.
About valgrind, it only detects an "invalide read of size 8" in 
blk-hotplug test (tests/virtio-blk-test.c), but I don't know why is it 
doing this.
For the rest, there shouldn't be any memory leak.

Should I rebase them in the proper commits? I am ready to submit patch v3.

Emanuele
