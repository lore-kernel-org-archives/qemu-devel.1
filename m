Received: from eggs.gnu.org ([2001:4830:134:3::10]:56541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLYBM-0000cV-Eu
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLYBI-0002fT-5y
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:08:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fLYBI-0002fM-0p
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:08:12 -0400
References: <20180523064941.26016.74274.stgit@pasha-VirtualBox>
	<20180523065022.26016.90099.stgit@pasha-VirtualBox>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64f610ca-9a07-9926-a202-70b143457100@redhat.com>
Date: Wed, 23 May 2018 13:08:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180523065022.26016.90099.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/19] migration: introduce icount field
 for snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

On 05/23/2018 01:50 AM, Pavel Dovgalyuk wrote:
> Saving icount as a parameters of the snapshot allows navigation between
> them in the execution replay scenario.
> This information can be used for finding a specific snapshot for rewinding
> the recorded execution to the specific moment of the time.
> E.g., 'reverse step' action needs to load the nearest snapshot which is
> prior to the current moment of time .
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> --
> 
> v2:
>   - made icount in SnapshotInfo optional (suggested by Eric Blake)
> ---

> +++ b/qapi/block-core.json
> @@ -25,13 +25,16 @@
>   #
>   # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
>   #
> +# @icount: current instruction count for execution record/replay (since 2.13)

Except now we have moved to calling the next release 3.0 ;)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
