Received: from eggs.gnu.org ([2001:4830:134:3::10]:34990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQi8-0001Ly-8u
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQi7-0005Mm-ED
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:42:40 -0400
References: <20180322161226.29796-1-lvivier@redhat.com>
	<087177af-cc0b-c8b7-ce50-98f1f9cada68@msgid.tls.msk.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ed567e7-3e24-812a-f54e-c94e89b96d98@redhat.com>
Date: Fri, 23 Mar 2018 12:42:26 -0500
MIME-Version: 1.0
In-Reply-To: <087177af-cc0b-c8b7-ce50-98f1f9cada68@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] coccinelle: re-run scripts from
 scripts/coccinelle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 03/23/2018 07:37 AM, Michael Tokarev wrote:
> 22.03.2018 19:12, Laurent Vivier wrote:
>> I've re-run some scripts from the coccinelle directory,
>> and they have found some problems.
>>
>> This series fixes them.
>>
>> Laurent Vivier (4):
>>    error: Strip trailing '\n' from error string arguments (again again)
>>    error: Remove NULL checks on error_propagate() calls
>>    qdict: remove useless cast
>>    Remove unnecessary variables for function return value
> 
> I've applied patches 1-3, but the 4th patch is a bit.. interesting.
> As has already been said, it touches auto-generated files, which is
> sort of fine, but it _also_ removes comments, which - I think - is
> quite a bit wrong.

1-3 are also candidates for going through my qapi tree (I will probably 
do another pull request Monday or Tuesday), if that beats your trivial 
tree.  But if not, for 1-3, you can add:
Acked-by: Eric Blake <eblake@redhat.com>

> 
> I can apply just selected hunks, but.. hmm..

v2 of patch 4 is better, and the trivial tree may indeed be a better 
place for patch 4 since it doesn't really touch anything qapi-related.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
