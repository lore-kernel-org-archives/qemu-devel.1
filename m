Received: from eggs.gnu.org ([2001:4830:134:3::10]:34972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1eu19H-0007Z2-BP
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1eu19G-0004nG-Ko
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:24:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180308161309.GF2769@stefanha-x1.localdomain>
References: <20180307162958.11232-1-nia.alarie@gmail.com>
	<20180308161309.GF2769@stefanha-x1.localdomain>
From: nee <nia.alarie@gmail.com>
Date: Thu, 8 Mar 2018 19:24:16 +0000
Message-ID: <CA+k8WDqtvk_TToBSh6BUeyOQzxospxqKF2xOosRAMkDoZhK1=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] s390x/virtio: Convert virtio-ccw from
 *_exit to *_unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, borntraeger@de.ibm.com, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On Thu, Mar 8, 2018 at 4:13 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Wed, Mar 07, 2018 at 04:29:58PM +0000, Nia Alarie wrote:
>> @@ -760,12 +760,12 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
>>      if (sch) {
>>          css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
>>          g_free(sch);
>> +        ccw_dev->sch = NULL;
>
> This change is unrelated to the topic of the patch and not mentioned in
> the commit description.  I think it was probably made for consistency,
> rather than a bug fix or functional change.  That's a valid reason too
> but please mention secondary changes like this in future patches so
> reviewers know why you made them.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Indeed, this was done for consistency (but also, it feels like a good
practice to follow). Thanks for the review.
