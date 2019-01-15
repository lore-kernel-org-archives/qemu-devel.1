Received: from eggs.gnu.org ([209.51.188.92]:35297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjIsS-0001OP-6K
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjIsR-0002uZ-Fu
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:11:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjIsR-0002sL-7i
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:11:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BE5A3695F
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 07:11:09 +0000 (UTC)
References: <1545225205-7227-1-git-send-email-thuth@redhat.com>
	<87h8f9efa9.fsf@dusky.pond.sub.org> <20190114180410.GZ4500@habkost.net>
	<20190114130814-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f225360d-8102-ac2e-2b7d-52066348db8f@redhat.com>
Date: Tue, 15 Jan 2019 08:11:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190114130814-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc/ivshmem: Remove deprecated
 "ivshmem" legacy device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On 2019-01-14 19:08, Michael S. Tsirkin wrote:
> On Mon, Jan 14, 2019 at 04:04:10PM -0200, Eduardo Habkost wrote:
>> On Wed, Dec 19, 2018 at 03:56:30PM +0100, Markus Armbruster wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> It's been marked as deprecated in QEMU v2.6.0 already, so really nobody
>>>> should use the legacy "ivshmem" device anymore (but use ivshmem-plain or
>>>> ivshmem-doorbell instead). Time to remove the deprecated device now.
>>>>
>>>> Belatedly also update a mention of the deprecated "ivshmem" in the file
>>>> docs/specs/ivshmem-spec.txt to "ivshmem-doorbell". Missed in commit
>>>> 5400c02b90b ("ivshmem: Split ivshmem-plain, ivshmem-doorbell off ivshmem").
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>> Who should merge this?
> 
> I can do it.

Thanks, but since there is no dedicated maintainer for ivshmem, I've
already put it in my PULL request yesterday.

 Thomas
