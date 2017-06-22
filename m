Received: from eggs.gnu.org ([2001:4830:134:3::10]:57578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dO5Vp-0005gA-5T
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dO5Vk-0001MT-Qd
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:03:21 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com> (Greg
	Kurz's message of "Thu, 22 Jun 2017 18:42:55 +0200")
References: <149814756006.27338.8723356702388175951.stgit@bahia>
	<CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
	<20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com>
Reply-To: quintela@redhat.com
Date: Thu, 22 Jun 2017 19:03:13 +0200
Message-ID: <87injo6jla.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Greg Kurz <groug@kaod.org> wrote:
> On Thu, 22 Jun 2017 17:14:08 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 22 June 2017 at 17:06, Greg Kurz <groug@kaod.org> wrote:
>> > Function types cannot reside in the same sorted list as opaque types since
>> > they may depend on a type which would be defined later.
>> >
>> > Of course, the same problem could arise if a function type depends on
>> > another function type with greater alphabetical order. Hopefully we
>> > don't have that at this time.  
>> 
>> The other approach would be to put function types somewhere
>> else and leave typedefs.h for the simple 'opaque types
>> for structures' that it was started as.
>> 
>> For instance we have include/qemu/fprintf-fn.h as a precedent.
>> 
>
> Indeed, and I'm not quite sure why Juan decided to put these types into
> typedefs.h instead of a dedicated header file in include/migration... is
> it only because it was the quickest fix ?

All other typedefs were defined there.  I can create a different include
file, but I think that is "overengineering", no?  They are typedefs,
just not of structs.  But I agree that they are the only ones.

Later, Juan.
