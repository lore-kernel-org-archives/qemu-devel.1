Received: from eggs.gnu.org ([2001:4830:134:3::10]:33669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyx93-0000UQ-UE
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 05:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyx92-0001lz-FG
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 05:03:57 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:33196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cyx92-0001lf-4U
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 05:03:56 -0400
Received: by mail-lf0-x22c.google.com with SMTP id h125so39856250lfe.0
	for <qemu-devel@nongnu.org>; Fri, 14 Apr 2017 02:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20170411101002.28451-1-maxime.coquelin@redhat.com>
	<20170411101002.28451-2-maxime.coquelin@redhat.com>
	<CAJ+F1CL8kK0XcMwueX8+kbDF=aVhBiRJ66gGoUNcUOmk=Yg7og@mail.gmail.com>
	<7dfc220c-b22b-bd7d-53af-caf49275b66c@redhat.com>
In-Reply-To: <7dfc220c-b22b-bd7d-53af-caf49275b66c@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 14 Apr 2017 09:03:43 +0000
Message-ID: <CAJ+F1C+SX0vqpAmyesgoyiWf1Fqncd6FaP2PemeUSHQq+GYLTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/2] spec/vhost-user: Introduce secondary
 channel for slave initiated requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, peterx@redhat.com, yuanhan.liu@linux.intel.com, virtio-comment@lists.oasis-open.org, qemu-devel@nongnu.org

Hi

On Tue, Apr 11, 2017 at 5:53 PM Maxime Coquelin <maxime.coquelin@redhat.com=
>
wrote:

> Hi Marc-Andr=C3=A9,
>
> On 04/11/2017 03:06 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Apr 11, 2017 at 12:10 PM Maxime Coquelin
> > <maxime.coquelin@redhat.com <mailto:maxime.coquelin@redhat.com>> wrote:
> >
> >     This vhost-user specification update aims at enabling the
> >     slave to send requests to the master using a dedicated socket
> >     created by the master.
> >
> >     It can be used for example when the slave implements a device
> >     IOTLB to send cache miss requests to the master.
> >
> >     The message types list is updated with an "Initiator" field to
> >     indicate for each type whether the master and/or slave can
> >     initiate the request.
> >
> >     Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com
> >     <mailto:maxime.coquelin@redhat.com>>
> >
> >
> > This is very similar to a patch I proposed for shutdown slave initiated
> > requests:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.html
>
> Indeed, thanks for pointing this out, I wasn't aware of your series.
>
> I find your proposal of having dedicated messages types
> (VHOST_USER_SLAVE_*) cleaner.
>
> ok


> Are you ok if I handover your patch, and replace
> VHOST_USER_SET_SLAVE_FD to VHOST_USER_SET_SLAVE_REQ_FD?
>

They are very similar, I suggest you update your patch with the best of
both.

I suppose you came to the same conclusion with me that trying to make the
communication both ways on the same fd would be quite difficult, although
it's a bit strange that the qemu implementation forces the design of the
protocol in some direction.
--=20
Marc-Andr=C3=A9 Lureau
