Received: from eggs.gnu.org ([209.51.188.92]:57217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0inQ-0007ZY-0w
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0inP-00041q-Ax
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:17:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h0inP-0003z7-4C
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:17:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190301154051.23317-1-armbru@redhat.com>
	<20190301154051.23317-2-armbru@redhat.com>
	<af1fb55b-cb3d-f3d4-2edc-7ce23c54ed36@redhat.com>
Date: Mon, 04 Mar 2019 09:17:50 +0100
In-Reply-To: <af1fb55b-cb3d-f3d4-2edc-7ce23c54ed36@redhat.com> (Eric Blake's
	message of "Fri, 1 Mar 2019 09:45:18 -0600")
Message-ID: <87bm2rcatt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/7] tests/qapi-schema: Make test-qapi.py
 print arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, quintela@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 3/1/19 9:40 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Sparse on the why, but I can guess - you intend for the rest of the
> series to fix the bug where we don't generate arrays in the same module
> as their underlying type when their only use is in a different module,
> but to prove that works you need them listed in dump output.

Could amend like this:

    tests/qapi-schema: Make test-qapi.py print arrays

    The next few commits mess with array types, and having the changes
    exposed in output of test-qapi.py will be useful.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
