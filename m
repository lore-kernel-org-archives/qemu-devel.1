Received: from eggs.gnu.org ([2001:4830:134:3::10]:48796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fVfay-0001RS-7P
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fVfat-0007Xa-AI
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:04:32 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fVfat-0007X1-4l
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:04:27 -0400
Received: by mail-it0-f65.google.com with SMTP id a3-v6so407540itd.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:04:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619064334.a2f6yv7yyiwlyqsk@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-25-marcandre.lureau@redhat.com>
	<20180619064334.a2f6yv7yyiwlyqsk@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Jun 2018 18:04:25 +0200
Message-ID: <CAMxuvaxmprDW2bEzEJB38cqV5eRT=jBaMav9EJnMG5e6SNr-Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 24/26] virtio-gpu: split virtio-gpu,
 introduce virtio-gpu-base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>

Hi

On Tue, Jun 19, 2018 at 8:43 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Mon, Jun 18, 2018 at 06:17:27PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Add a base class that is common to virtio-gpu and vhost-user-gpu
>> devices.
>
> More verbose commit message please.  What functionality is common and
> handled by the new (abstract?) base class?  (same for patch #25).

Would that level of details be enough?

The VirtIOGPUBase base class provides common functionalities necessary
for both virtio-gpu and vhost-user-gpu:
- common configuration (max-outputs, initial resolution, flags)
- virtio device initialization, including queue setup
- device pre-conditions checks (iommu)
- migration blocker
- virtio device callbacks
- hooking up to qemu display subsystem
- a few common helper functions to reset the device, retrieve display
informations
- a class callback to unblock the rendering (for GL updates)

What is left to the virtio-gpu subdevice to take care of, in short,
are all the virtio queues handling, command processing and migration.

thanks
