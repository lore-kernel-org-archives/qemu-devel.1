Received: from eggs.gnu.org ([2001:4830:134:3::10]:35692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dAwqn-0000Ky-Rr
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dAwqk-0001Du-Kz
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:10:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dAwqk-0001DL-B9
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:10:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4HB9MBG025433
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 07:10:36 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agb8wt88t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 07:10:36 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 17 May 2017 12:10:33 +0100
Date: Wed, 17 May 2017 13:10:27 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <de319d04-a424-5b88-6ddb-a25b4053aa18@linux.vnet.ibm.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-7-git-send-email-arei.gonglei@huawei.com>
	<520f45d4-33d7-8836-3140-a92ee5d15421@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA278AA0@DGGEMA505-MBS.china.huawei.com>
	<1963bfa1-c0ea-156a-59f7-aed744ca49a3@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29A0B5@DGGEMA505-MBS.china.huawei.com>
	<b7c20d5f-026e-edf1-6703-6b64ceed375f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29B209@DGGEMA505-MBS.china.huawei.com>
	<a8b185ca-4b8d-e913-cfb3-454d61dbce78@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29B2BF@DGGEMA505-MBS.china.huawei.com>
	<de319d04-a424-5b88-6ddb-a25b4053aa18@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170517131027.11bcec97.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC v1 6/9] virtio-crypto: rework
 virtio_crypto_handle_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "Huangweidong
	(C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Luonengjun <luonengjun@huawei.com>, Linqiangmin <linqiangmin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "Wubin
	(H)" <wu.wubin@huawei.com>

On Wed, 17 May 2017 12:33:20 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 05/17/2017 12:13 PM, Gonglei (Arei) wrote:
> >>
> >> On 05/17/2017 11:12 AM, Gonglei (Arei) wrote:
> >>>>>> By the way, I'm having a hard time understing how is the requirement
> >> form
> >>>>>>
> >>>>
> >> http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-260
> >>>>>> 004
> >>>>>> (2.4.4 Message Framing) satisfied by this code. Could you explain this
> >>>>>> to me please?
> >>>>>>
> >>>>> Sorry for my bad English,
> >>>>> I don't know which normative formulation the code violates?
> >>>> I'm not sure it's actually violated, but I'm concerned about the following
> >>>> normative statement: "The device MUST NOT make assumptions about the
> >>>> particular
> >>>> arrangement of descriptors. The device MAY have a reasonable limit of
> >>>> descriptors it will allow in a chain."
> >>>>
> >>>> Please also read the explanatory part I've linked, because the normative
> >>>> statement is pretty abstract.
> >>>>
> >>>> In my understanding, the spec says, that e.g. the virti-crypto device
> >>>> should not fail if a single request is split up into let's say two chunks
> >>>> and transmitted by the means of two top level descriptors.
> >>>>
> >>>> Do you agree with my reading of the spec?
> >>>>
> >>> Yes, I agree. But what's the relationship about the request here?
> >>> We don't assume the request have to use one desc entity, it can
> >>> use scatter-gather list for one request header.
> >>> The device can cover the situation in the QEMU.
> >>>
> >>>> What does the virtio-crypto device do if it encounters such a situation?
> >>>>
> >>> This isn't a problem. Pls see blow code segment:
> >>>
> >>> virtio_crypto_handle_request()
> >>> {...
> >>> if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
> >>>                 != sizeof(req))) {
> >>>     virtio_error(vdev, "virtio-crypto request outhdr too short");
> >>>     return -1;
> >>> }
> >>> iov_discard_front(&out_iov, &out_num, sizeof(req));
> >>> ...
> >>>
> >>
> >> Thats exactly what worries me. I see a call to virtio_error there...
> >>
> >>
> >> void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
> >> {
> >>     va_list ap;
> >>
> >>     va_start(ap, fmt);
> >>     error_vreport(fmt, ap);
> >>     va_end(ap);
> >>
> >>     vdev->broken = true;
> >>
> >>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> >>         virtio_set_status(vdev, vdev->status |
> >> VIRTIO_CONFIG_S_NEEDS_RESET);
> >>         virtio_notify_config(vdev);
> >>     }
> >> }
> >>
> >> This however seems to make the device 'broken'. Or am I missing something?
> >>
> > Yes, if the parse process failed, the device will broke. 
> > But This is a exception scenario IMHO, which is the same situation
> > with other virtio devices. 
> 
> I know that virtio-blk does the same. I'm not sure my reading of the
> spec is correct. Maybe Stefan, Michael or Connie can clarify this
> for us!

The spec says for NEEDS_RESET:

"Indicates that the device has experienced an error from which it can't
recover."

For me, this means:
- If this is something that might happen in the normal course of events
and there's a good recovery path, just recover.
- Else, use virtio_error() and require the driver to recover via reset.

If the driver is sending requests in an unexpected format, I'd use
virtio_error(). The format needs to be properly described, though.

> 
> By the way for virtio-blk the current handling was introduced by
> commit 20ea686a0 (by Greg Kurz), but before we were failing even
> harder.
> 
> Regards,
> Halil
> 
> > 
> > Stefan introduced the virtio_error().
> > 
> > Thanks,
> > -Gonglei
> > 
