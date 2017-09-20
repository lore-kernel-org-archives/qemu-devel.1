Received: from eggs.gnu.org ([2001:4830:134:3::10]:34382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duf0E-0001V0-IE
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dueyv-0001qo-Ph
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:25:22 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:49805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dueyt-0001kq-7z
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:24:00 -0400
Received: by mail-wr0-x22f.google.com with SMTP id u96so2159053wrb.6
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:23:58 -0700 (PDT)
References: <20170915150849.23557-1-peter.maydell@linaro.org>
	<CAKmqyKPEtdXp2Dn2a2FuL-f_WVaRDEaY_3_=h=2kVobFm4z4QA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAKmqyKPEtdXp2Dn2a2FuL-f_WVaRDEaY_3_=h=2kVobFm4z4QA@mail.gmail.com>
Date: Wed, 20 Sep 2017 10:36:56 +0100
Message-ID: <87zi9pd83r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Remove out of date
 ARM ARM section references in A64 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>


Alistair Francis <alistair23@gmail.com> writes:

> On Fri, Sep 15, 2017 at 8:08 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> In the A64 decoder, we have a lot of references to section numbers
>> from version A.a of the v8A ARM ARM (DDI0487). This version of the
>> document is now long obsolete (we are currently on revision B.a),
>> and various intervening versions renumbered all the sections.
>>
>> The most recent B.a version of the document doesn't assign
>> section numbers at all to the individual instruction classes
>> in the way that the various A.x versions did. The simplest thing
>> to do is just to delete all the out of date C.x.x references.
>>
<snip>
>>
>> -/* C3.6.2 TBL/TBX
>> +/* BL/TBX
>
> I don't know how I noticed this, but it looks like you are missing a T.

Good catch!

--
Alex Bennée
