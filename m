Received: from eggs.gnu.org ([2001:4830:134:3::10]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckvR5-0004Gu-Dd
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckvR2-0001l5-9k
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:24:35 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ckvR2-0001kk-1n
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:24:32 -0500
Received: by mail-wr0-x22f.google.com with SMTP id g10so120369103wrg.2
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 08:24:31 -0800 (PST)
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
	<87k282im0q.fsf@linaro.org>
	<6515bcf7-e3cd-21b4-746b-c386b1296d88@genode-labs.com>
	<87innmii02.fsf@linaro.org>
	<d208c3f0-2e57-0b54-f18f-b5e27d698e28@genode-labs.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d208c3f0-2e57-0b54-f18f-b5e27d698e28@genode-labs.com>
Date: Mon, 06 Mar 2017 16:24:37 +0000
Message-ID: <87h936ida2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, fred.konrad@greensocs.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com


Alexander Boettcher <alexander.boettcher@genode-labs.com> writes:

> Hi,
<snip>
>
> Sometimes Qemu just succeeds if the timing is well, will see.
>
> But this is not the point of this issue atm.

I've sent a patch that works as Richard suggested. However your test
image seems to run into other issues. I have tested it on my known good
x86 image and it works.

However my knowledge of x86's interrupt architecture is fairly minimal
so I'm looking for testing/feedback on the patch.

>
> Alex.


--
Alex Bennée
