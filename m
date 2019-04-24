Received: from eggs.gnu.org ([209.51.188.92]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJEVV-0006e3-Ap
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJEUk-0000Gy-DE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:47:16 -0400
References: <20190416184624.15397-1-dan.streetman@canonical.com>
	<20190416184624.15397-2-dan.streetman@canonical.com>
	<9f3dac2a-15fe-8463-6aee-f6916b8d5e1c@redhat.com>
	<CAOZ2QJO5-V4xydkVxKTC-1qnhqhUEMck04D=6+PFkhP9Z9+vmA@mail.gmail.com>
	<ec53494d-99fc-d7b2-987d-ccd79ee47652@redhat.com>
	<CAOZ2QJMKO8_8ygcycNf7xVWYWE8GX1PAk7hePB9D8Q5XCq1=yA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ade59025-3c49-b9f9-673b-8d9c397037d2@redhat.com>
Date: Wed, 24 Apr 2019 17:46:55 +0800
MIME-Version: 1.0
In-Reply-To: <CAOZ2QJMKO8_8ygcycNf7xVWYWE8GX1PAk7hePB9D8Q5XCq1=yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] add VirtIONet vhost_stopped flag to
 prevent multiple stops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Streetman <dan.streetman@canonical.com>
Cc: =?UTF-8?Q?marcandre=2elureau=40redhat=2ecom_=3e=3e_Marc-Andr=c3=a9_Lurea?= =?UTF-8?Q?u?= <marcandre.lureau@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


On 2019/4/23 =E4=B8=8B=E5=8D=884:49, Dan Streetman wrote:
>> I think so if net_vhost_user_event() was called in main thread (it cal=
ls
>> qemu_get_current_aio_context()).
> ok, I'll check that, thanks!
>
> I think my other patch, to remove the vhost_user_stop() call
> completely from the net_vhost_user_event() handler for
> CHR_EVENT_CLOSED, is still relevant; do you have thoughts on that?
>

I think that patch makes sense.

Thanks
