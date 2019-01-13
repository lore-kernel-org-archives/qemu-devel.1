Received: from eggs.gnu.org ([209.51.188.92]:54014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gihsR-0002qu-FW
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 10:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gihsQ-00016Z-Hz
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 10:40:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gihsQ-00015F-BT
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 10:40:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so6528338wmi.4
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 07:40:40 -0800 (PST)
References: <154724210898.37.4367801081630939892@2d170d368aaa>
	<834ad86b-27d1-ce01-91dc-a5c939061ce9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14d1bd7f-caa5-ded6-21f4-b9fa6c0e03a7@redhat.com>
Date: Sun, 13 Jan 2019 16:40:37 +0100
MIME-Version: 1.0
In-Reply-To: <834ad86b-27d1-ce01-91dc-a5c939061ce9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] contrib/gitdm: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, fam@euphon.net
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org, qemu-devel@nongnu.org

On 11/01/19 23:39, Philippe Mathieu-Daudé wrote:
> On 1/11/19 10:28 PM, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20190111155555.8270-1-philmd@redhat.com/
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
>>
>> Message-id: 20190111155555.8270-1-philmd@redhat.com
>> Type: series
>> Subject: [Qemu-devel] [PATCH] contrib/gitdm: Fix a typo
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>> git config --local diff.algorithm histogram
>> ./scripts/checkpatch.pl --mailback --color=always base..
> I suppose Paolo expected his PR to land to upgrade patchew, and patchew
> is still processing from an old queue?
> 

Yeah, patchew was still processing tags that didn't have my PR applied.

Anyhow, I'll hijack this to note that now:

1) The test script for checkpatch is now much simple, compare
https://patchew.org/QEMU/20190103085638.17600-1-philmd@redhat.com/ (old)
to https://patchew.org/QEMU/20190109110144.18633-1-stefanha@redhat.com/
(new).  Improvement of "cut and paste" ability was a nice side effect of
the new TAP-based "make check", and this goes in the same direction.

2) Patchew is showing colored output---for now only for checkpatch. :)
More precisely, output is captured from a PTY, via script(1).  This
turned out to be a bit more tricky than I expected (script doesn't like
having its stdin redirected from /dev/null), but it's fixed now.

3) I bumped the tester from -j8 to -j14, hoping that the queue will be
smaller, and temporarily deployed a second tester on my own workstation.
 This in turn caused some issues because pulling a git repo with 12000
tags is not for the faint of heart, but everything should be running
normally now and future deployments will optimize this (check
https://patchew.org/Patchew/ to see the issues).

Paolo
