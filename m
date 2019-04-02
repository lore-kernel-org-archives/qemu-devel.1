Received: from eggs.gnu.org ([209.51.188.92]:44015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBCtY-0005XN-Ui
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBCtY-0004RX-0m
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:27:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190311083234.20841-1-richardw.yang@linux.intel.com>
	<20190312084313.webcenp43tk3yfmm@steredhat>
Date: Tue, 02 Apr 2019 08:27:36 +0200
In-Reply-To: <20190312084313.webcenp43tk3yfmm@steredhat> (Stefano Garzarella's
	message of "Tue, 12 Mar 2019 09:43:13 +0100")
Message-ID: <87tvfghqg7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qom: use object_new_with_type in
 object_new_with_propv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, afaerber@suse.de, qemu-trivial@nongnu.org

Stefano Garzarella <sgarzare@redhat.com> writes:

> On Mon, Mar 11, 2019 at 04:32:34PM +0800, Wei Yang wrote:
>> Function object_new_with_propv already get the Type of the object, so we
>> could leverage object_new_with_type here.
>> 
>> [make check test pass]
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  qom/object.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> LGTM. Just a note for future patches:
> I think that info like "[make check test pass]" should go after the
> three dashes to avoid to store it in the commit message.

Yes.  Whoever applies  should delete this line.

> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Cc: qemu-trivial for merging.
