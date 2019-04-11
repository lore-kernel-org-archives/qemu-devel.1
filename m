Received: from eggs.gnu.org ([209.51.188.92]:36506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfyC-0000kA-Ar
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfyB-0003tw-CN
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:06:48 -0400
References: <20190311083234.20841-1-richardw.yang@linux.intel.com>
	<20190312084313.webcenp43tk3yfmm@steredhat>
	<87tvfghqg7.fsf@dusky.pond.sub.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <51367507-2b5a-151d-af0f-5404448bbdad@vivier.eu>
Date: Thu, 11 Apr 2019 22:01:28 +0200
MIME-Version: 1.0
In-Reply-To: <87tvfghqg7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] qom: use
 object_new_with_type in object_new_with_propv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-trivial@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>, afaerber@suse.de, qemu-devel@nongnu.org

On 02/04/2019 08:27, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
>> On Mon, Mar 11, 2019 at 04:32:34PM +0800, Wei Yang wrote:
>>> Function object_new_with_propv already get the Type of the object, so we
>>> could leverage object_new_with_type here.
>>>
>>> [make check test pass]
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> ---
>>>  qom/object.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> LGTM. Just a note for future patches:
>> I think that info like "[make check test pass]" should go after the
>> three dashes to avoid to store it in the commit message.
> 
> Yes.  Whoever applies  should delete this line.
> 
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Cc: qemu-trivial for merging.
> 

Applied to my trivial-patches branch with updated commit message.

Thanks,
Laurent
