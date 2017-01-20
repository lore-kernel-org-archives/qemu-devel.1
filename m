Received: from eggs.gnu.org ([2001:4830:134:3::10]:46517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTrv-0005sk-6M
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTru-0001zM-Ct
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:44:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUTru-0001yy-6F
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:44:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-3-git-send-email-mst@redhat.com>
	<e41f19d3-0a9f-49cf-3f73-bc88b706f38b@redhat.com>
Date: Fri, 20 Jan 2017 08:44:15 +0100
In-Reply-To: <e41f19d3-0a9f-49cf-3f73-bc88b706f38b@redhat.com> (Eric Blake's
	message of "Thu, 19 Jan 2017 15:26:55 -0600")
Message-ID: <87shoe2n1s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/4] compiler: rework BUG_ON using a
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 01/19/2017 03:07 PM, Michael S. Tsirkin wrote:
>> There are theoretical concerns that some compilers might not trigger
>> build failures on attempts to define an array of size -1 and make it a
>> variable sized array instead.
>
> Rather, the concern is that if someone changes code so that the 'x' of
> QEMU_BUILD_BUG_ON(x) is no longer a compile time constant, we want a
> compile-time failure rather than a runtime variable-sized array that may
> or may not crash.

>> Let rewrite using a struct with a negative
>> bit field size instead as there are no dynamic bit field sizes.  This is
>> similar to what Linux does.
>> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  include/qemu/compiler.h | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>
> I don't know if you want to tweak the commit wording, but I'm okay with
> the patch itself.

For what it's worth, I'd prefer a rewording.
