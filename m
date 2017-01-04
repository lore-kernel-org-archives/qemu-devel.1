Received: from eggs.gnu.org ([2001:4830:134:3::10]:53852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cOfS4-0007Q2-Fw
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 01:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cOfRz-0001tM-L2
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 01:53:36 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cOfRz-0001t5-EP
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 01:53:31 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so74318174wjc.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 22:53:31 -0800 (PST)
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
	<5540064c-613c-c0df-ae69-d41d45b4501d@freebsd.org>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <ad4e7809-93e9-b5fa-a6a2-763fa8f1c97a@tuxfamily.org>
Date: Wed, 4 Jan 2017 07:53:28 +0100
MIME-Version: 1.0
In-Reply-To: <5540064c-613c-c0df-ae69-d41d45b4501d@freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Bruno <sbruno@freebsd.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Fabien Chouteau <chouteau@adacore.com>

On 03.01.2017 18:11, Sean Bruno wrote:
> 
> 
> On 01/03/17 09:18, Sean Bruno wrote:
>>
>> I'm pondering where to start with getting FreeBSD's bsd-user code into
>> shape so it could actually be reviewed and accepted now that its sort of
>> working again (signal handling fixed finally).
>>
>> I almost feel like the existing code should be purged, except that it
>> gives a good history (and this seems lazy to me).
>>
>> As a first pass, I guess, I'd like to at least make i386 user run on
>> x86_64.  What would you folks like to see in a first pass?
>>
>> sean
>>
>> ref: https://github.com/seanbruno/qemu-bsd-user/tree/bsd-user
>>
> 
> Primitive example of what I think I should base my patchset on.  Its
> invasive and large.
> 
> https://github.com/seanbruno/qemu-bsd-user/tree/merge1
> 
> That branch, is all the bsd-user changes that are pending in one large
> "splat".  It excludes the new architectures (arm, aarch64, mips, mips64)
> that we are actively using.  i386-bsd-user when compiled statically on
> x86_64 will run a static (rescue) sh ... so, I think that's good.
> x86_64 running on x86_64 just blows up.
> 
> As for sparc/sparc64 ... I'm tempted to delete them as nobody in freebsd
> is actively maintaining them nor do we have any expectation that they
> will work someday.

It's broken ... nobody maintains it ... and we've got too many
unmaintained bit-rotten files in the QEMU tree, so IMHO just go ahead
and send a patch to remove the bsud-user sparc support. If anybody ever
needs it again, they can revert the commit or simply submit a patch with
the fixed code.

 Thomas
