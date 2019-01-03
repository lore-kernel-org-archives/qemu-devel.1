Received: from eggs.gnu.org ([208.118.235.92]:36225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf0pB-0001Ui-4J
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf0p7-0006GJ-Sq
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:06:05 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf0p5-0006A4-KF
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:06:01 -0500
Received: by mail-wm1-f49.google.com with SMTP id y139so28775253wmc.5
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 03:05:57 -0800 (PST)
References: <ddc7219f-98c3-28be-084f-64606452e49b@suse.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e51bd6dc-e135-b66a-189d-8b79bc5f7e49@redhat.com>
Date: Thu, 3 Jan 2019 12:05:54 +0100
MIME-Version: 1.0
In-Reply-To: <ddc7219f-98c3-28be-084f-64606452e49b@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Can I have someone's feedback on [bug 1809075]
 Concurrency bug on keyboard events: capslock LED messing up keycode streams
 causes character misses at guest kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gao Zhiyuan <zgao@suse.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Cc'ing Marc-André & Gerd.

On 12/19/18 10:31 AM, Gao Zhiyuan wrote:
> Hi everyone.
> 
> Can I please have someone's feedback on this bug?
> https://bugs.launchpad.net/qemu/+bug/1809075
> Briefly, guest OS loses characters sent to it via vnc. And I spot the
> bug in relation to ps2 driver.
> 
> I'm thinking of possible fixes and I might want to use a memory barrier.
> But I would really like to have some suggestion from a qemu developer
> first. For example, can we brutally drop capslock LED key events in ps2
> queue?
> 
> It is actually relevant to openQA, an automated QA tool for openSUSE.
> And this bug blocks a few test cases for us.
> 
> Thank you in advance!
> 
> Kind regards,
> Gao Zhiyuan
> 
