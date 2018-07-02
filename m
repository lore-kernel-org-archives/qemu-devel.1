Received: from eggs.gnu.org ([2001:4830:134:3::10]:42577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5bw-0000mD-8I
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5bv-0005kJ-7A
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:39:48 -0400
References: <20180702191458.28741-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1e3a0cc-ad90-0786-483b-71d2bcef2cf8@redhat.com>
Date: Mon, 2 Jul 2018 15:39:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180702191458.28741-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] test NBD bitmap export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org

On 07/02/2018 02:14 PM, Eric Blake wrote:
> This is a less hacky version of my first attempt:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05993.html
> 
> The worst part of the hack (taking a semicolon-separated list of
> requests to hand the server) is completely dropped, the member
> field is renamed to reflect what it is doing, and I've added an
> iotests to help us in regression testing.
> 
> I'd REALLY like to send a pull request before soft freeze (tomorrow
> morning is approaching fast!) that includes these patches, so that
> qemu 3.0 at least has experimental access to all the pieces needed
> for playing with incremental backups.
> 
> Eric Blake (2):
>    nbd/client: Add x-dirty-bitmap to query bitmap from server
>    iotests: New test 223 for exporting dirty bitmap over NBD

For patchew (maybe? does patchew run iotests?)

Based-on: 
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06747.html
nbd/server: Fix dirty bitmap logic regression

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
