Received: from eggs.gnu.org ([2001:4830:134:3::10]:60108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT25W-0001Lf-5s
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT25T-0004Om-PA
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:52:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cT25T-0004Nx-J6
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:52:19 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-13-git-send-email-peterx@redhat.com>
	<397afe71-b4cd-ba48-6d76-a7b27e1128f9@redhat.com>
	<20170116074359.GD30108@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8efe289b-e26a-60bc-51ae-582beff069fb@redhat.com>
Date: Mon, 16 Jan 2017 15:52:10 +0800
MIME-Version: 1.0
In-Reply-To: <20170116074359.GD30108@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 12/14] intel_iommu: do replay when
 context invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com



On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 15:43, Peter Xu wrote:
> On Mon, Jan 16, 2017 at 01:53:54PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
>>> Before this one we only invalidate context cache when we receive cont=
ext
>>> entry invalidations. However it's possible that the invalidation also
>>> contains a domain switch (only if cache-mode is enabled for vIOMMU).
>> So let's check for CM before replaying?
> When CM is not set, there should have no device needs
> IOMMU_NOTIFIER_MAP notifies. So IMHO it won't hurt if we replay here
> (so the notifier_list will only contain UNMAP notifiers at most, and
> sending UNMAP to those devices should not affect them at all).
>
> If we check CM before replay, it'll be faster when guest change iommu
> domain for a specific device. But after all this kind of operation is
> extremely rare, while if we check CM bit, we have a "assumption" in
> the code that MAP is depending on CM. In that case, to make the codes
> cleaner, I'd slightly prefer not check it here. How do you think?

Ok, I think maybe it's better to add a comment here.

Thanks

>
> Thanks,
>
> -- peterx
>
