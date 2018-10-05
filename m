Received: from eggs.gnu.org ([2001:4830:134:3::10]:45083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g8Yeb-0003Uf-Bn
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 18:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g8YeY-0002Yi-8I
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 18:33:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g8YeY-0002Yb-3q
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 18:32:58 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so11847785iob.8
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 15:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181005135052.GA4113@lpt>
	<CAMxuvawF+5=GyP70FNzS3zWfoe7Ca667hMKqmjWkhCe_bNCCMg@mail.gmail.com>
	<20181005155850.vci6pt27rumdlq6t@sirius.home.kraxel.org>
In-Reply-To: <20181005155850.vci6pt27rumdlq6t@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 6 Oct 2018 02:32:45 +0400
Message-ID: <CAMxuvazsSRvwRpDH=MR4kEnQCJgcv3FOb+hn-rdfKO3Gtpy4sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hoffmann, Gerd" <kraxel@redhat.com>
Cc: =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Kaplansky,
	Victor" <victork@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, libvir-list <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Felipe Franciosi <felipe@nutanix.com>, "Liu, Changpeng" <changpeng.liu@intel.com>

Hi

On Fri, Oct 5, 2018 at 7:59 PM Hoffmann, Gerd <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > For example, "virgl" support may not be implemented. This
> > --print-capabilities is a simple way to check what the backend
> > implements.
>
> What is the expected behavior in case virgl is implemented by the
> backend, but not available (due to lack of 3d hardware in the host for
> example) ?

I would say either it fails at runtime, or the backend doesn't announce it.

Would you want something else?
