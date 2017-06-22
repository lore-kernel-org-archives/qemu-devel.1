Received: from eggs.gnu.org ([2001:4830:134:3::10]:33982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO5oO-00033X-7W
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO5oN-0000sT-7W
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:22:32 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dO5oN-0000sA-1K
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:22:31 -0400
Received: by mail-wr0-x232.google.com with SMTP id r103so32370980wrb.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 10:22:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87injo6jla.fsf@secure.mitica>
References: <149814756006.27338.8723356702388175951.stgit@bahia>
	<CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
	<20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com>
	<87injo6jla.fsf@secure.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 18:22:09 +0100
Message-ID: <CAFEAcA-g-=AkH3t8jOTFY_9zA6ECS57-3MS=cHPb+Q6sePzNsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Separate function types from opaque types
 in include/qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 22 June 2017 at 18:03, Juan Quintela <quintela@redhat.com> wrote:
> Greg Kurz <groug@kaod.org> wrote:
>> On Thu, 22 Jun 2017 17:14:08 +0100
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>>> On 22 June 2017 at 17:06, Greg Kurz <groug@kaod.org> wrote:
>>> > Function types cannot reside in the same sorted list as opaque types since
>>> > they may depend on a type which would be defined later.
>>> >
>>> > Of course, the same problem could arise if a function type depends on
>>> > another function type with greater alphabetical order. Hopefully we
>>> > don't have that at this time.
>>>
>>> The other approach would be to put function types somewhere
>>> else and leave typedefs.h for the simple 'opaque types
>>> for structures' that it was started as.
>>>
>>> For instance we have include/qemu/fprintf-fn.h as a precedent.
>>>
>>
>> Indeed, and I'm not quite sure why Juan decided to put these types into
>> typedefs.h instead of a dedicated header file in include/migration... is
>> it only because it was the quickest fix ?
>
> All other typedefs were defined there.  I can create a different include
> file, but I think that is "overengineering", no?  They are typedefs,
> just not of structs.  But I agree that they are the only ones.

Well, the comment in the file says "opaque types so that device init
declarations don't have to pull in all the real definitions", whereas
the ones you've added aren't opaque types, they are the real
definitions. They're also only used by a very small subset of .c
files, whereas typedefs.h goes everywhere.

thanks
-- PMM
